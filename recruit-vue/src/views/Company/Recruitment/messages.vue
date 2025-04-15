<template>
  <div class="app-container chat-app">
    <!-- 顶部标题栏 -->
    <div class="chat-header">
    1111
      <h2>{{ userType === 'company' ? '企业招聘咨询' : '求职咨询' }}</h2>
    </div>

    <div class="chat-layout">
      <!-- 左侧联系人列表 -->
      <div class="contact-panel">
        <div class="contact-header">
          <el-input
            v-model="searchQuery"
            placeholder="搜索联系人..."
            prefix-icon="el-icon-search"
            clearable>
          </el-input>
        </div>
        
        <!-- 联系人列表 -->
        <div class="contact-list">
          <div 
            v-for="contact in filteredContacts"
            :key="contact.id"
            class="contact-item"
            :class="{'active': activeContact === contact.id}"
            @click="handleContactSelect(contact)">
            <el-avatar :src="contact.avatar || defaultAvatar" size="medium"></el-avatar>
            <div class="contact-info">
              <div class="contact-name-row">
                <span class="contact-name">{{ contact.name }}</span>
                <span class="resume-status" :class="contact.resumeStatus">
                  {{ getResumeStatusText(contact.resumeStatus) }}
                </span>
              </div>
              <span class="contact-lastmsg">{{ contact.lastMessage || '暂无消息' }}</span>
            </div>
            <div class="contact-meta">
              <span class="contact-time">{{ contact.lastTime }}</span>
              <el-badge v-if="contact.unreadCount" :value="contact.unreadCount" class="unread-badge"/>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧聊天区域 -->
      <div class="chat-panel" v-if="activeContact">
        <div class="chat-header">
          <div class="chat-title">
            <el-avatar :src="currentContact.avatar || defaultAvatar" size="medium"></el-avatar>
            <div class="chat-user-info">
              <h3>{{ currentContact.name }}</h3>
              <div class="resume-info" v-if="currentContact.resumeTitle">
                <span>应聘职位: {{ currentContact.resumeTitle }}</span>
                <el-tag size="small" :type="getResumeStatusType(currentContact.resumeStatus)">
                  {{ getResumeStatusText(currentContact.resumeStatus) }}
                </el-tag>
              </div>
            </div>
          </div>
          <div class="chat-actions">
            <el-button 
              v-if="userType === 'company'"
              size="small" 
              type="primary"
              @click="handleResumeAction">
              {{ getActionButtonText() }}
            </el-button>
          </div>
        </div>
        
        <!-- 消息列表 -->
        <div class="message-panel" ref="messagePanel">
          <div class="message-date-divider" v-if="messagesList.length">
            {{ formatDate(messagesList[0].sendTime) }}
          </div>
          <div 
            v-for="(msg, index) in messagesList" 
            :key="msg.id"
            class="message-bubble"
            :class="{'is-me': msg.senderId === currentUserId}">
            <div class="message-content">
              <div class="message-text">{{ msg.content }}</div>
              <div class="message-time">{{ formatTime(msg.sendTime) }}</div>
            </div>
          </div>
        </div>

        <!-- 输入框区域 -->
        <div class="input-panel">
          <el-input
            v-model="newMessage"
            type="textarea"
            :rows="3"
            resize="none"
            placeholder="输入消息..."
            @keyup.enter.native.ctrl="sendMessage">
          </el-input>
          <div class="input-actions">
            <span class="input-tip">Ctrl + Enter 发送</span>
            <el-button type="primary" @click="sendMessage">发送</el-button>
          </div>
        </div>
      </div>
      
      <!-- 未选择联系人时的提示 -->
      <div v-else class="no-contact">
        <el-empty description="请选择联系人开始聊天"></el-empty>
      </div>
    </div>
  </div>
</template>

<script>
import { getMessages, sendMessage,listContacts,markAsRead } from "@/api/messages";

export default {
  data() {
    return {
      // 原有数据
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      messagesList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        senderId: null,
        receiverId: null,
        content: null,
        readFlag: null,
        sendTime: null,
        readTime: null
      },
      form: {},
      rules: {
        senderId: [
          { required: true, message: "发送者ID不能为空", trigger: "blur" }
        ],
        receiverId: [
          { required: true, message: "接收者ID不能为空", trigger: "blur" }
        ],
        content: [
          { required: true, message: "消息内容不能为空", trigger: "blur" }
        ],
        sendTime: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
      },
      newMessage: "", // 新消息内容
      currentUserId: 1, // 当前用户ID（根据实际业务获取）
      pollingInterval: null, // 轮询定时器
      userList: [ // 模拟用户列表
        { id: 1, name: "用户A" },
        { id: 2, name: "用户B" },
        { id: 3, name: "用户C" }
      ],
      activeContact: "1", // 当前选中的联系人ID
      currentContactName: "用户A", // 当前联系人名称
      defaultAvatar: require('@/assets/default-avatar.png'),
      searchQuery: '',
      currentContact: null,
    };
  },
  created() {
    this.initUserData();
    this.getContacts();
    this.getList();
    this.startPolling();
  },
  computed: {
    filteredContacts() {
      if (!this.searchQuery) return this.userList;
      const query = this.searchQuery.toLowerCase();
      return this.userList.filter(contact => 
        contact.name.toLowerCase().includes(query) ||
        (contact.resumeTitle && contact.resumeTitle.toLowerCase().includes(query))
      );
    }
  },
  methods: {
    // 初始化用户数据
    initUserData() {
      const user = JSON.parse(sessionStorage.getItem('user'));
      const hr = JSON.parse(sessionStorage.getItem('hr'));
      this.userType = hr ? 'company' : 'student';
      this.currentUserId = hr ? hr.id : user.id;
    },
    
    // 获取联系人列表
    getContacts() {
      listContacts(this.currentUserId, this.userType).then(res => {
        this.userList = res.data;
        if (this.userList.length > 0) {
          this.activeContact = this.userList[0].id;
          this.currentContactName = this.userList[0].name;
        }
      });
    },

    // 获取消息列表（修改为双向查询）
    getList() {
      getMessages({
        senderId: this.currentUserId,
        receiverId: this.activeContact
      }).then(res => {
        this.messagesList = res.rows;
        this.scrollToBottom();
      });
    },

    // 发送消息
    sendMessage() {
      if (!this.newMessage.trim()) return;
      
      const message = {
        senderId: this.currentUserId,
        receiverId: this.activeContact,
        content: this.newMessage,
        sendTime: new Date(),
        readFlag: false,
        senderType: this.userType,
        receiverType: this.userType === 'student' ? 'company' : 'student'
      };

      sendMessage(message).then(() => {
        this.messagesList.push(message);
        this.newMessage = '';
        this.scrollToBottom();
      });
    },

    // 滚动到底部
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$el.querySelector('.chat-messages');
        container.scrollTop = container.scrollHeight;
      });
    },
    /** 切换联系人 */
    handleContactSelect(contact) {
      this.currentContact = contact;
      this.activeContact = contact.id;
      this.getList();
      // 标记消息为已读
      if (contact.unreadCount > 0) {
        markAsRead({
          senderId: contact.id,
          receiverId: this.currentUserId
        });
      }
    },
    // 原有方法保持不变
    getList() {
      this.loading = true;
      listMessages({
        ...this.queryParams,
        senderId: this.currentUserId,
        receiverId: this.activeContact
      }).then(response => {
        this.messagesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    reset() {
      this.form = {
        id: null,
        senderId: null,
        receiverId: null,
        content: null,
        readFlag: null,
        sendTime: null,
        readTime: null
      };
      this.resetForm("form");
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加在线交流";
    },
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getMessages(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改在线交流";
      });
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateMessages(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMessages(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除在线交流编号为"' + ids + '"的数据项？').then(function() {
        return delMessages(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    handleExport() {
      this.download('recruit/messages/export', {
        ...this.queryParams
      }, `messages_${new Date().getTime()}.xlsx`)
    },
    getResumeStatusText(status) {
      const statusMap = {
        'pending': '待处理',
        'reviewing': '审核中',
        'accepted': '已通过',
        'rejected': '已拒绝'
      };
      return statusMap[status] || '未知状态';
    },
    getResumeStatusType(status) {
      const typeMap = {
        'pending': 'info',
        'reviewing': 'warning',
        'accepted': 'success',
        'rejected': 'danger'
      };
      return typeMap[status] || 'info';
    },
    getActionButtonText() {
      const status = this.currentContact.resumeStatus;
      const actionMap = {
        'pending': '开始处理',
        'reviewing': '完成审核',
        'accepted': '查看简历',
        'rejected': '重新审核'
      };
      return actionMap[status] || '处理简历';
    },
    handleResumeAction() {
      // 根据不同状态处理简历相关操作
      const status = this.currentContact.resumeStatus;
      // ... 实现具体的简历处理逻辑
    }
  }
};
</script>

<style lang="scss" scoped>
.chat-app {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: #f5f7fa;
}

.chat-header {
  padding: 15px 20px;
  background: #409EFF;
  color: white;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  
  h2 {
    margin: 0;
    font-size: 18px;
  }
}

.chat-layout {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.contact-panel {
  width: 280px;
  border-right: 1px solid #e6e6e6;
  background: white;
  display: flex;
  flex-direction: column;
}

.contact-header {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
}

.contact-list {
  flex: 1;
  overflow-y: auto;
}

.contact-item {
  display: flex;
  padding: 12px 15px;
  cursor: pointer;
  transition: background 0.3s;
  border-bottom: 1px solid #f0f0f0;
  
  &:hover {
    background: #f5f7fa;
  }
  
  &.active {
    background: #e6f7ff;
  }
}

.contact-info {
  flex: 1;
  margin-left: 12px;
  overflow: hidden;
  
  .contact-name {
    display: block;
    font-weight: 500;
    margin-bottom: 4px;
  }
  
  .contact-lastmsg {
    font-size: 12px;
    color: #999;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
  }
}

.contact-meta {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  
  .contact-time {
    font-size: 12px;
    color: #999;
    margin-bottom: 4px;
  }
}

.chat-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  background: #f0f2f5;
}

.message-panel {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  background: #f0f2f5;
}

.message-bubble {
  max-width: 60%;
  margin-bottom: 15px;
  padding: 10px 15px;
  border-radius: 18px;
  background: white;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  
  &.is-me {
    margin-left: auto;
    background: #409EFF;
    color: white;
    
    .message-time {
      color: rgba(255, 255, 255, 0.7);
    }
  }
}

.message-content {
  margin-bottom: 5px;
}

.message-time {
  font-size: 12px;
  color: #999;
  text-align: right;
}

.input-panel {
  padding: 15px;
  border-top: 1px solid #e6e6e6;
  background: white;
  
  .input-actions {
    margin-top: 10px;
    text-align: right;
  }
}

.online-status {
  font-size: 12px;
  color: #67C23A;
  margin-left: 8px;
}

.unread-badge {
  margin-top: 4px;
}

.resume-status {
  font-size: 12px;
  padding: 2px 6px;
  border-radius: 10px;
  
  &.pending { color: #909399; }
  &.reviewing { color: #E6A23C; }
  &.accepted { color: #67C23A; }
  &.rejected { color: #F56C6C; }
}

.chat-user-info {
  margin-left: 12px;
  
  .resume-info {
    font-size: 12px;
    color: #666;
    margin-top: 4px;
    
    .el-tag {
      margin-left: 8px;
    }
  }
}

.message-date-divider {
  text-align: center;
  margin: 20px 0;
  color: #909399;
  font-size: 12px;
  
  &::before,
  &::after {
    content: '';
    display: inline-block;
    width: 40px;
    height: 1px;
    background: #DCDFE6;
    margin: 0 8px;
    vertical-align: middle;
  }
}

.input-tip {
  color: #909399;
  font-size: 12px;
}

.no-contact {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
}
</style>
