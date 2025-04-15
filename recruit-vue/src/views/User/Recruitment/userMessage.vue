<template>
  <div id="postResume">
    <el-button v-show="checking || chatting" @click="handleBack" type="primary">返回</el-button>

    <div v-show="chatting" class="chat-container">
      <div class="chat-header">
          <div class="chat-title">
            <el-avatar
              :size="40"
              :src="'http://localhost:8084/api/user/' + userForm.avatar">
            </el-avatar>
            <div class="chat-info">
              <h3>{{ currentChat.userName }}</h3>
              <div class="resume-info" v-if="currentChat.resumeTitle">
                <span>应聘职位: {{ currentChat.resumeTitle }}</span>
              </div>
            </div>
          </div>
        </div>
      
      <div class="message-panel" ref="messagePanel">
        <div v-for="msg in messagesList" 
             :key="msg.id"
             class="message-bubble"
             :class="{'is-me': msg.senderId === currentUserId}">
          <el-avatar
            :size="30"
            :src="'http://localhost:8084/api/user/qiye'"
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
    <el-dialog title="回复" :visible.sync="dialogVisible" width="30%" center>
      <el-input type="textarea" :rows="2" v-model="reply" />
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="save()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getMessages, sendMessage, markAsRead } from "@/api/messages";
import {
  receiveApplication,
  allowApplication,
  refuseApplication,
  getApplicMsg,
} from '@/api/hr'

export default {
  name: 'postResume',
  data() {
    return {
      row: {},
      type: '',
      reply: '',
      delivers: [],
      jobList: [],
      checking: false,
      showResume: false,
      userForm: {
        avatar: 'default',
        nickname: '',
        email: '',
        gender: 0,
        birthYear: 0,
        graduation: '',
        eduDegree: '',
        graduateYear: 2019,
        major: '',
        dirDesire: 0,
        province: '',
        city: '',
      },
      resumeform: {},
      options: [
        {
          value: 0,
          label: '女',
        },
        {
          value: 1,
          label: '男',
        },
      ],
      dialogVisible: false,
      chatting: false,
      currentChat: {},
      messagesList: [],
      newMessage: '',
      currentUser: {},
      currentUserId: '',
      currentUserAvatar: '',
      pollingTimer: null,
    }
  },
  created() {
    this.getList()
    this.initUserData()
  },
  computed: {
    honor() {
      if (
        this.resumeform.honour === '' ||
        this.resumeform.honour === undefined ||
        this.resumeform.honour === null
      ) {
        return []
      } else {
        return JSON.parse(this.resumeform.honour)
      }
    },
    work() {
      if (
        this.resumeform.workExperience === '' ||
        this.resumeform.workExperience === undefined ||
        this.resumeform.workExperience === null
      ) {
        return []
      } else {
        return JSON.parse(this.resumeform.workExperience)
      }
    },
    project() {
      if (
        this.resumeform.projectExperience === '' ||
        this.resumeform.projectExperience === undefined ||
        this.resumeform.projectExperience === null
      ) {
        return []
      } else {
        return JSON.parse(this.resumeform.projectExperience)
      }
    },
  },
  methods: {
    initUserData() {
      const hr = JSON.parse(sessionStorage.getItem('hr'))
      this.currentUserId = hr.hrId
      this.currentUser = hr
    },
    handleBack() {
      if (this.chatting) {
        this.stopMessagePolling()
        this.chatting = false
      } else if (this.checking) {
        this.checking = false
      }
      this.currentChat = {}
      this.messagesList = []
      this.newMessage = ''
    },
    deal(row, type) {
      this.row = row
      this.type = type
      this.dialogVisible = true
    },
    save() {
      this.dialogVisible = false
      this.row.reply = this.reply
      if (this.type) {
        refuseApplication(this.row).then((res) => {
          if (res.data) {
            this.$message.success('处理成功')
            this.getList()
          }
        })
      } else {
        allowApplication(this.row).then((res) => {
          if (res.data) {
            this.$message.success('处理成功')
            this.getList()
          }
        })
      }
    },
    checkMsg(row) {
      this.checking = true
      this.showResume = true
      getApplicMsg(row).then((res) => {
        this.userForm = res.data.user
        this.resumeform = res.data.resume
      })
    },
    openChat(row) {
      getApplicMsg(row).then((res) => {
        this.chatting = true
        this.checking = false
        this.currentChat = {
          userId: res.data.user.userId,
          userName: res.data.user.nickname,
          userAvatar: res.data.user.avatar,
          resumeTitle: row.positionName
        }
        this.getMessages()
        this.startMessagePolling()
      })
    },
    getMessages() {

     const message = {
            senderId: this.currentUserId,
            receiverId: this.currentChat.userId,
            content: this.newMessage.trim(),
            senderType: 'company',
            receiverType: 'student'
      }
      getMessages(message).then(res => {
        if (res.data) {
          this.messagesList = res.data
          this.scrollToBottom()
          const unreadMessages = this.messagesList
            .filter(msg => !msg.readFlag && msg.senderId !== this.currentUserId)
            .map(msg => msg.id)
          
          if (unreadMessages.length > 0) {
            this.markMessagesAsRead(unreadMessages)
          }
        }
      })
    },
    sendMessage() {
      if (!this.newMessage.trim()) return
      
      const message = {
        senderId: this.currentUserId,
        receiverId: this.currentChat.userId,
        content: this.newMessage.trim(),
        senderType: 'company',
        receiverType: 'student'
      }

      console.log('sendMessage:',message)
      console.log('this.currentChat:',this.currentChat)

      sendMessage(message).then(res => {
        if (res.data) {
          this.messagesList.push(res.data)
          this.newMessage = ''
          this.scrollToBottom()
        }
      }).catch(error => {
        this.$message.error('发送失败，请重试')
      })
    },
    markMessagesAsRead(messageIds) {
      markAsRead(messageIds).then(() => {
        this.messagesList = this.messagesList.map(msg => {
          if (messageIds.includes(msg.id)) {
            return { ...msg, readFlag: true }
          }
          return msg
        })
      })
    },
    startMessagePolling() {
      this.pollingTimer = setInterval(() => {
        if (this.chatting) {
          this.getMessages()
        }
      }, 3000)
    },
    stopMessagePolling() {
      if (this.pollingTimer) {
        clearInterval(this.pollingTimer)
        this.pollingTimer = null
      }
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.messagePanel
        if (container) {
          container.scrollTop = container.scrollHeight
        }
      })
    },
    formatTime(time) {
      return new Date(time).toLocaleString()
    },
    getList() {
      this.jobList = []
      receiveApplication().then((res) => {
        this.jobList = res.data
      })
    },
  },
  filters: {
    stateFilter(state) {
      if (state === 1) return '已接受'
      if (state === 2) return '已拒绝'
      return '未处理'
    },
  },
  beforeDestroy() {
    this.stopMessagePolling()
  }
}
</script>

<style lang="scss" scoped>
#postResume {
  overflow: auto;
}
.item-title{
  color: #ff6000;
}
.chat-container {
  height: 600px;
  width: 60%;
  margin: 20px auto;
  display: flex;
  flex-direction: column;
  background: #f5f7fa;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}

.chat-header {
  padding: 15px 20px;
  background: white;
  border-bottom: 1px solid #e6e6e6;

  .chat-title {
    display: flex;
    align-items: center;

    .chat-info {
      margin-left: 12px;
      
      h3 {
        margin: 0;
        font-size: 16px;
      }

      .resume-info {
        font-size: 12px;
        color: #666;
        margin-top: 4px;
      }
    }
  }
}

.message-panel {
  flex: 1;
  padding: 20px;
  background: #f0f2f5;
  overflow-y: auto;

  &::-webkit-scrollbar {
    width: 0;
    background: transparent;
  }
  
  scrollbar-width: none;
  
  -ms-overflow-style: none;
}

.message-bubble {
  display: flex;
  align-items: flex-start;
  max-width: 70%;
  margin-bottom: 15px;
  
  &.is-me {
    flex-direction: row-reverse;
    margin-left: auto;
    
    .message-content {
      margin-right: 8px;
      margin-left: 0;
      background: #409EFF;
      color: white;
      
      .message-time {
        color: rgba(255, 255, 255, 0.7);
      }
    }
  }

  .message-avatar {
    flex-shrink: 0;
  }

  .message-content {
    margin-left: 8px;
    padding: 10px 15px;
    border-radius: 4px;
    background: white;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);

    .message-text {
      margin-bottom: 5px;
    }
    
    .message-time {
      font-size: 12px;
      color: #999;
      text-align: right;
    }
  }
}

.input-panel {
  padding: 15px;
  background: white;
  border-top: 1px solid #e6e6e6;
  
  .el-textarea {
    max-height: 80px;
  }
  
  .input-actions {
    margin-top: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .input-tip {
    color: #909399;
    font-size: 12px;
  }
}
</style>
