<template>
  <main>
    <div id="applications">
      <div class="dynamic">
        <div v-show="appList.length===0" class="empty-tip">暂无数据</div>
        <div class="notNull" v-for="job in appList" :key="job.applicationId">
          <header>
            <h3>{{job.title}}</h3>
            <p style="color:red">{{job.salaryDown}}~{{job.salaryUp}}（元/月）</p>
          </header>
          <article>
            {{job.requirement}}
          </article>
          <footer>
            <i style="justify-content:center" class="el-icon-thumb" v-show="job.statePub===2" @click="getDetail(job)">查看详情</i>
            <i style="justify-content:center" v-show="job.statePub!==2"></i>
            <div style="justify-content:flex-end;color:red;" v-if="job.statePub===3">
              <i style="font-size:26px;" class="el-icon-error"></i>
              已下架
            </div>
            <div style="justify-content:flex-end;color:green;" v-if="job.applicationState===1&&job.statePub===2">
              <i style="font-size:26px;" class="el-icon-success"></i>
              已通过
            </div>
            <div style="justify-content:flex-end;color:red;" v-if="job.applicationState===2&&job.statePub===2">
              <i style="font-size:26px;" class="el-icon-error"></i>
              未通过
            </div>
            <div style="justify-content:flex-end;color:blue;" v-if="job.applicationState===0&&job.statePub===2">
              <i style="font-size:26px;" class="el-icon-question"></i>
              请等待
            </div>
            
            <div >
                  <!-- 添加入职登记按钮，仅在面试通过时显示 -->
              <el-button
                type="warning"
                size="mini"
                @click="handleOnboarding(job)"
                v-if="job.applicationState===1 && job.statePub===2"
                :disabled="job.registerStatus === '登记已审核'">
                {{ 
                  !job.registerStatus || job.registerStatus === '未登记' ? '入职登记' : 
                  job.registerStatus === '登记待审核' ? '重新登记' : 
                  '查看登记'
                }}
              </el-button>
              
              <!-- 添加在线交流按钮 -->
              <el-button
                type="primary"
                size="mini"
                @click="openChat(job)"
                v-if="job.statePub===2"
              >
                在线交流
              </el-button>
          
            </div>
            
          </footer>
          <el-row v-if="job.reply" class="job-reply">
            <el-col :span="4">
              人事回复：
            </el-col>
            <el-col :span="20">
              {{job.reply}}
            </el-col>
          </el-row>
        </div>
      </div>
    </div>

    <!-- 聊天窗口 -->
    <div v-show="chatting" class="chat-container">
      <div class="chat-header">
        <div class="chat-title">
          <div class="chat-info">
            <h3>{{ currentChat.userName }}</h3>
            <div class="resume-info" v-if="currentChat.resumeTitle">
              <span>应聘职位: {{ currentChat.resumeTitle }}</span>
            </div>
          </div>
        </div>
        <el-button @click="closeChat" type="text" style="float: right;">关闭</el-button>
      </div>

      <div class="message-panel" ref="messagePanel">
        <div v-for="msg in messagesList"
             :key="`${msg.id}-${msg.sendTime}-${msg.senderId}`"
             class="message-bubble"
             :class="{'is-me': msg.senderId === currentUserId}">
          <el-avatar
            :size="30"
            :src="getAvatarUrl(msg)"
            class="message-avatar">
          </el-avatar>
          <div class="message-content">
            <div class="message-text">{{ msg.content }}</div>
            <div class="message-time">{{ formatTime(msg.sendTime) }}</div>
          </div>
        </div>
      </div>

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

    <!-- 入职登记对话框 -->
    <el-dialog 
      :title="`入职登记${onboardingForm.registerStatus === '登记已审核' ? '(已审核)' : ''}`" 
      :visible.sync="onboardingDialogVisible" 
      width="600px"
    >
      <el-form :model="onboardingForm" :rules="onboardingRules" ref="onboardingForm" label-width="120px">
        <el-input v-model="onboardingForm.applicationId" type="hidden"></el-input>
        <el-form-item label="岗位名称">
          <el-input v-model="onboardingForm.positionTitle" :readonly="onboardingForm.registerStatus === '登记已审核'"></el-input>
        </el-form-item>
        <el-form-item label="联系人">
          <el-input v-model="onboardingForm.lxr" :readonly="onboardingForm.registerStatus === '登记已审核'"></el-input>
        </el-form-item>
        <el-form-item label="联系人电话">
          <el-input v-model="onboardingForm.lxrdh" :readonly="onboardingForm.registerStatus === '登记已审核'"></el-input>
        </el-form-item>
        <el-form-item label="紧急联系人">
          <el-input v-model="onboardingForm.jjlxr" :readonly="onboardingForm.registerStatus === '登记已审核'"></el-input>
        </el-form-item>
        <el-form-item label="紧急联系人电话">
          <el-input v-model="onboardingForm.jjlxrdh" :readonly="onboardingForm.registerStatus === '登记已审核'"></el-input>
        </el-form-item>
        <el-form-item label="薪资类型">
          <el-select 
            v-model="onboardingForm.salaryType" 
            :disabled="onboardingForm.registerStatus === '登记已审核'"
            placeholder="请选择薪资类型">
            <el-option label="时薪" value="时薪"></el-option>
            <el-option label="日薪" value="日薪"></el-option>
            <el-option label="月薪" value="月薪"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="薪资">
          <el-input-number 
            v-model="onboardingForm.salary" 
            :disabled="onboardingForm.registerStatus === '登记已审核'"
            :min="0" 
            :step="1000"></el-input-number>
        </el-form-item>
        <el-form-item label="入职时间">
          <el-date-picker
            v-model="onboardingForm.workTime"
            type="date"
            value-format="yyyy-MM-dd"
            :disabled="onboardingForm.registerStatus === '登记已审核'"
            placeholder="选择入职时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="onboardingDialogVisible = false">关 闭</el-button>
        <el-button 
          type="primary" 
          @click="submitOnboarding"
          v-if="onboardingForm.registerStatus !== '登记已审核'">
          确 定
        </el-button>
      </div>
    </el-dialog>
  </main>
</template>

<script>
import { listApp,updateOnboardingRuzhi } from "@/api/user";
import { getMessages, sendMessage, markAsRead } from "@/api/messages";

export default {
  name: "myConcern",
  data() {
    return {
      appList: [],
      resume: JSON.parse(sessionStorage.getItem('resume')),
      chatting: false, // 是否显示聊天窗口
      currentChat: {}, // 当前聊天对象
      messagesList: [], // 消息列表
      newMessage: '', // 新消息内容
      currentUserId: '', // 当前用户ID
      currentUserAvatar: '', // 当前用户头像
      pollingTimer: null, // 轮询定时器
      onboardingDialogVisible: false,
      onboardingForm: {
        applicationId: '',
        positionTitle: '',
        lxr: '',
        lxrdh: '',
        jjlxr: '',
        jjlxrdh: '',
        salary: 0,
        salaryType: '',
        workTime: ''
      },
      onboardingRules: {
        jjlxr: [
          { required: true, message: '请输入紧急联系人姓名', trigger: 'blur' }
        ],
        jjlxrdh: [
          { required: true, message: '请输入联系电话', trigger: 'blur' },
          { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
        ],
        salary: [
          { required: true, message: '请输入薪资', trigger: 'blur' }
        ],
        workTime: [
          { required: true, message: '请选择入职时间', trigger: 'change' }
        ]
      },
      submitting: false
    };
  },
  created() {
    this.getData();
    this.initUserData();
  },
  methods: {
    getData() {
      listApp(this.resume.resumeId).then(res => {
        this.appList = res.data;
      });
    },
    getDetail(job) {
      localStorage.setItem('job', JSON.stringify(job));
      this.$router.push('/user/position');
    },
    initUserData() {
      const user = JSON.parse(sessionStorage.getItem('user'));
      this.currentUserId = user.userId;
      this.currentUserAvatar = user.avatar;
    },
    getAvatarUrl(msg) {
      if (msg.senderType === 'company') {
        // 企业头像路径
        return 'http://localhost:8084/api/user/qiye';
      } else {
        // 学生头像路径，使用 msg.senderId
        return `http://localhost:8084/api/user/${msg.senderId}`;
      }
    },
    openChat(job) {
      this.chatting = true;
      this.currentChat = {
        userId: job.hrIdPub, // HR 的 ID
        userName: job.hrName, // HR 的名字
        userAvatar: job.hrAvatar, // HR 的头像
        resumeTitle: job.title, // 职位标题
      };
      this.getMessages();
      this.startMessagePolling();
    },
    closeChat() {
      this.chatting = false;
      this.currentChat = {};
      this.messagesList = [];
      this.newMessage = '';
      this.stopMessagePolling();
    },
    getMessages() {
      getMessages({
        senderId: this.currentUserId,
        receiverId: this.currentChat.userId,
        senderType: 'student',
        receiverType: 'company',
      }).then(res => {
        if (res.data) {
          this.messagesList = res.data;
          this.scrollToBottom();
          const unreadMessages = this.messagesList
            .filter(msg => !msg.readFlag && msg.senderId !== this.currentUserId)
            .map(msg => msg.id);

          if (unreadMessages.length > 0) {
            this.markMessagesAsRead(unreadMessages);
          }
        }
      });
    },
    sendMessage() {
      if (!this.newMessage.trim()) return;

      const message = {
        senderId: this.currentUserId,
        receiverId: this.currentChat.userId,
        content: this.newMessage.trim(),
        senderType: 'student',
        receiverType: 'company',
      };

      sendMessage(message).then(res => {
        if (res.data) {
          this.messagesList.push(res.data);
          this.newMessage = '';
          this.scrollToBottom();
        }
      }).catch(error => {
        this.$message.error('发送失败，请重试');
      });
    },
    markMessagesAsRead(messageIds) {
      markAsRead(messageIds).then(() => {
        this.messagesList = this.messagesList.map(msg => {
          if (messageIds.includes(msg.id)) {
            return { ...msg, readFlag: true };
          }
          return msg;
        });
      });
    },
    startMessagePolling() {
      this.pollingTimer = setInterval(() => {
        if (this.chatting) {
          this.getMessages();
        }
      }, 3000);
    },
    stopMessagePolling() {
      if (this.pollingTimer) {
        clearInterval(this.pollingTimer);
        this.pollingTimer = null;
      }
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.messagePanel;
        if (container) {
          container.scrollTop = container.scrollHeight;
        }
      });
    },
    formatTime(time) {
      return new Date(time).toLocaleString();
    },
    handleOnboarding(job) {
      console.log('job:',job);
      this.onboardingForm = {
        applicationId: job.applicationId,
        positionTitle: job.title || '',
        lxr: job.lxr || '',
        lxrdh: job.lxrdh || '',
        jjlxr: job.jjlxr || '',
        jjlxrdh: job.jjlxrdh || '',
        salary: job.salary || 0,
        salaryType: job.salaryType || '',
        workTime: job.workTime ? new Date(job.workTime) : ''
      };
      this.onboardingDialogVisible = true;
    },
    submitOnboarding() {
      this.$refs.onboardingForm.validate((valid) => {
        if (valid) {
          const onboardingData = {
            applicationId: this.onboardingForm.applicationId,
            jjlxr: this.onboardingForm.jjlxr,
            jjlxrdh: this.onboardingForm.jjlxrdh,
            salaryType: this.onboardingForm.salaryType,
            salary: this.onboardingForm.salary,
            workTime: this.onboardingForm.workTime
          };
          updateOnboardingRuzhi(onboardingData)
            .then(res => {
              this.$message({
                type: 'success',
                message: '入职登记提交成功，等待管理员审核'
              });
              this.getData(); // 刷新列表
              this.onboardingDialogVisible = false;
            })
            .catch(error => {
              console.log('提交报错:',error);
              this.$message.error('提交失败');
            });
        }
      });
    }
  }
};
</script>

<style lang="stylus" scoped>
fontColor=rgb(109,109,109)
.job-reply
  margin-top 5px
  font-size 14px
  color #ff6000
.empty-tip
  width 100%
  height 200px
  display flex
  justify-content center
  align-items center
  font-size 30px
  color #bc9c9c
#applications{
  width: 70%;
  margin-top: 30px;
  margin-bottom: 30px;
  min-height: 300px;
  margin-left: 15%;
  display: flex;
  box-shadow: 0 2px 4px #e0e0e0;
}
#noBody
  display flex
  justify-content center
  align-items center
  color fontColor
.isNull
  box-shadow 0 0 1px gray
  width 100%
  height 120px
  display flex
  flex-direction column
  justify-content center
  align-items center
  color fontColor
  &:hover
    box-shadow 0 0 2px gray
.dynamic
  width 100%
  margin 10px
  box-sizing border-box
  padding 10px
.notNull
  box-sizing border-box
  margin-bottom 15px
  padding 10px
  width 100%
  display flex
  box-shadow 0 0 1px gray
  flex-direction column
  justify-content space-between
  word-break break-all
  &:hover
    box-shadow 0 0 2px gray
  & header
    width 100%
    display flex
    justify-content space-between
  & article
    margin-top 10px
    font-size 14px
    width 100%
    color fontColor
  & footer
    width 100%
    height 24px
    display flex
    align-items flex-end
    justify-content space-between
    & i
      width 80px
      cursor pointer
      display flex

.chat-container {
  position: fixed;
  right: 20px;
  bottom: 20px;
  width: 400px;
  height: 500px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  z-index: 1000;
}

.chat-header {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.message-panel {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
  background: #f5f7fa;
}

.message-bubble {
  display: flex;
  margin-bottom: 10px;
}

.message-bubble.is-me {
  justify-content: flex-end;
}

.message-content {
  max-width: 70%;
  padding: 10px;
  border-radius: 8px;
  background: #fff;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.message-bubble.is-me .message-content {
  background: #409EFF;
  color: #fff;
}

.input-panel {
  padding: 10px;
  border-top: 1px solid #e6e6e6;
}

.input-actions {
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.el-button--warning {
  background-color: #e6a23c;
  border-color: #e6a23c;
  color: #fff;
}

</style>
