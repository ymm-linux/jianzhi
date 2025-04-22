<template>
  <div id="postResume">
    <el-button v-show="checking || chatting" @click="handleBack" type="primary">返回</el-button>
    <el-table v-show="!checking && !chatting" :data="jobList" stripe style="width: 100%">
      <el-table-column prop="applicationId" label="ID" width="100">
      </el-table-column>
      <el-table-column label="投递状态" width="110">
        <template slot-scope="scope">
          {{ scope.row.applicationState | stateFilter }}
        </template>
      </el-table-column>
      <el-table-column label="投递时间" width="100">
        <template slot-scope="scope">
          {{ scope.row.recentTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column prop="positionId" label="岗位编号" width="100">
      </el-table-column>
      <el-table-column prop="reply" label="答复"> </el-table-column>
      <el-table-column label="面试时间" width="120">
        <template slot-scope="scope">
          {{ scope.row.interviewTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column label="面试结果" width="120">
        <template slot-scope="scope">
          {{ scope.row.interviewResult | interviewResult }}
        </template>
      </el-table-column>
      <el-table-column label="面试评价" width="120">
            <template slot-scope="scope">
              {{ scope.row.interview }}
            </template>
          </el-table-column>
      <el-table-column label="入职时间" width="120">
        <template slot-scope="scope">
          {{ scope.row.workTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column label="薪资类型" width="120">
        <template slot-scope="scope">
          {{ scope.row.salaryType | salaryTypeFilter }}
        </template>
      </el-table-column>
      <el-table-column prop="salary" label="薪资" width="120">
        <template slot-scope="scope">
          {{ scope.row.salary }}元
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="400">
        <template slot-scope="scope">
          <el-button @click="checkMsg(scope.row)" type="primary" size="mini">
            查看投递信息
          </el-button>
          <el-button @click="openChat(scope.row)" type="success" size="mini">
            在线交流
          </el-button>
          <el-button @click="deal(scope.row, false)" type="primary" size="mini">
            接受简历
          </el-button>
          <el-button @click="deal(scope.row, true)" type="danger" size="mini">
            拒绝
          </el-button>
          <!-- 新增面试评价按钮 -->
          <el-button @click="handleOnboarding(scope.row)" type="warning" size="mini" class="action-btn"
            >
            面试评价
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div v-show="checking" style="display: disabled; justify-content: center; align-items: center">
      <div style="border: 1px solid #bfbfbf; width: 70%; margin: 40px">
        <el-form ref="userForm" :model="userForm" label-width="120px">
          <el-form-item> </el-form-item>
          <el-form-item>
            <el-col :span="6" :offset="6">

            </el-col>
          </el-form-item>
          <el-form-item label="基本信息">
            <el-row></el-row>
            <el-row>
              <el-col :span="12" class="item-title">姓名:</el-col>
              <el-col :span="12">{{ userForm.nickname }}</el-col>
              <el-col :span="12" class="item-title">性别:</el-col>
              <el-col :span="12">{{ userForm.gender ? '男' : '女' }}</el-col>
              <el-col :span="12" class="item-title">联系电话:</el-col>
              <el-col :span="12">{{ userForm.mobile }}</el-col>
              <el-col :span="12" class="item-title">邮箱地址:</el-col>
              <el-col :span="12">{{ userForm.email }}</el-col>
              <el-col :span="12" class="item-title">出生年份:</el-col>
              <el-col :span="12">{{ userForm.birthYear }}(年)</el-col>
              <el-col :span="12" class="item-title">毕业院校:</el-col>
              <el-col :span="12">{{ userForm.graduation }}</el-col>
              <el-col :span="12" class="item-title">学历:</el-col>
              <el-col :span="12">{{ userForm.eduDegree }}</el-col>
              <el-col :span="12" class="item-title">毕业年份:</el-col>
              <el-col :span="12">{{ userForm.graduateYear }}</el-col>
              <el-col :span="12" class="item-title">专业:</el-col>
              <el-col :span="12">{{ userForm.major }}</el-col>
            </el-row>
          </el-form-item>
          <el-form-item label="工作期望">
            <el-row></el-row>
            <el-row>
              <el-col :span="12" class="item-title">期望薪资:</el-col>
              <el-col :span="12">{{ userForm.dirDesire }}</el-col>
              <el-col :span="12" class="item-title">期望岗位:</el-col>
              <el-col :span="12">{{ resumeform.jobDesire }}</el-col>
              <el-col :span="12" class="item-title">工作城市:</el-col>
              <el-col :span="12">{{ userForm.province }} {{ userForm.city }}</el-col>
            </el-row>
          </el-form-item>
        </el-form>
        <el-form ref="resumeform" :model="resumeform" label-width="120px">
          <el-form-item label="工作技能和证书">
            <el-row></el-row>
            <el-row>
              <el-col :span="12" class="item-title">证书:</el-col>
              <el-col :span="12">{{ resumeform.certificate }}</el-col>
              <el-col :span="12" class="item-title">技能:</el-col>
              <el-col :span="12">{{ resumeform.ability }}</el-col>
              <el-col :span="24" class="item-title">获得荣誉与奖励:</el-col>
              <el-col :span="24">
                <el-row v-for="(item, index) in honor" :key="index">
                  <el-row>
                    <el-col :span="8">{{ item.time }}</el-col>
                    <el-col :span="8">{{ item.reword }}</el-col>
                    <el-col :span="8">{{ item.level }}</el-col>
                  </el-row>
                </el-row>
              </el-col>
            </el-row>
          </el-form-item>
          <el-form-item label="工作经验和履历">
            <el-row></el-row>
            <el-row>
              <el-col :span="24" class="item-title">实习经验:</el-col>
              <el-col :span="24">{{ resumeform.internshipExperience }}</el-col>
              <el-col :span="24" class="item-title">工作经历:</el-col>
              <el-col :span="24">
                <el-row v-for="(item, index) in work" :key="index">
                  <el-row>
                    <el-col :span="8">{{ item.time[0] }}至{{ item.time[1] }}</el-col>
                    <el-col :span="8">{{ item.company }}</el-col>
                    <el-col :span="8">{{ item.job }}</el-col>
                    <el-col :span="4">责任描述:</el-col>
                    <el-col :span="20">{{ item.description }}</el-col>
                  </el-row>
                </el-row>
              </el-col>
              <el-col :span="24" class="item-title">项目经验:</el-col>
              <el-col :span="24">
                <el-row v-for="(item, index) in project" :key="index">
                  <el-row>
                    <el-col :span="12">{{ item.time[0] }}至{{ item.time[1] }}</el-col>
                    <el-col :span="12">{{ item.job }}</el-col>
                    <el-col :span="4">项目描述:</el-col>
                    <el-col :span="20">{{ item.project }}</el-col>
                    <el-col :span="4">责任描述:</el-col>
                    <el-col :span="20">{{ item.description }}</el-col>
                  </el-row>
                </el-row>
              </el-col>
              <el-col :span="24" class="item-title">自我评价:</el-col>
              <el-col :span="24">{{ resumeform.selfAssessment }}</el-col>
            </el-row>
          </el-form-item>
        </el-form>
      </div>
    </div>
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
      </div>

      <div class="message-panel" ref="messagePanel">
        <div v-for="msg in messagesList" :key="msg.id" class="message-bubble"
          :class="{ 'is-me': msg.senderId === currentUserId }">
          <el-avatar :size="30" :src="getAvatarUrl(msg)" class="message-avatar">
          </el-avatar>
          <div class="message-content">
            <div class="message-text">{{ msg.content }}</div>
            <div class="message-time">{{ formatTime(msg.sendTime) }}</div>
          </div>
        </div>
      </div>

      <div class="input-panel">
        <el-input v-model="newMessage" type="textarea" :rows="3" resize="none" placeholder="输入消息..."
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
    <el-dialog title="面试评价" :visible.sync="onboardingDialogVisible" width="50%" :close-on-click-modal="false">
      <el-form ref="onboardingForm" :model="onboardingForm" label-width="120px" :rules="onboardingRules">
        <el-form-item label="面试时间" prop="interviewTime">
        <el-date-picker 
          v-model="onboardingForm.interviewTime" 
          type="datetime" 
          placeholder="请选择面试时间"
          value-format="yyyy-MM-dd HH:mm:ss"
          style="width: 100%">
        </el-date-picker>
      </el-form-item>

      <!-- 新增面试结果字段 -->
      <el-form-item label="面试结果" prop="interviewResult">
        <el-select 
          v-model="onboardingForm.interviewResult" 
          placeholder="请选择面试结果" 
          style="width: 100%">
          <el-option label="通过" value="通过"></el-option>
          <el-option label="未通过" value="未通过"></el-option>
          <el-option label="待定" value="待定"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="面试评价" prop="interview">
        <el-input v-model="onboardingForm.interview" placeholder="请输入面试评价"></el-input>
      </el-form-item>
    </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="onboardingDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitOnboarding" :loading="submitting">
          确 定
        </el-button>
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
  submitOnboarding
} from '@/api/hr'

export default {
  name: 'postResume',
  // filters: {
  //   // 新增面试结果过滤器
  //   interviewResult(value) {
  //     const map = { '通过': '通过', '未通过': '未通过','待定': '待定' }
  //     return map[value] || '未知状态'
  //   },
  //   salaryTypeFilter(vaule){
  //     const map = { '日薪': '日薪', '月薪': '月薪', '年薪': '年薪', '待定': '待定' }
  //     return map[value] || '未知'
  //   }
  // },
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
      // 新增面试评价相关数据
      onboardingDialogVisible: false,
      onboardingForm: {
        applicationId: '',
        interviewTime: '',  // 新增
        interviewResult: '',  // 新增
        interview: '',
        workTime: '',
        salaryType: '',
        salary: 0
      },
      salaryTypeOptions: [
        { value: '日薪', label: '日薪' },
        { value: '月薪', label: '月薪' },
        { value: '年薪', label: '年薪' },
        { value: '项目制', label: '项目制' },
        { value: '待定', label: '待定' },
      ],
      onboardingRules: {
        interviewTime: [
          { required: true, message: '请选择面试时间', trigger: 'blur' }
        ],
        interviewResult: [
          { required: true, message: '请选择面试结果', trigger: 'change' }
        ],
        interview: [
          { required: true, message: '请填写面试评价', trigger: 'blur' }
        ],
        workTime: [
          { required: true, message: '请选择入职时间', trigger: 'blur' }
        ],
        salaryType: [
          { required: true, message: '请选择薪资类型', trigger: 'change' }
        ],
        salary: [
          { required: true, message: '请输入薪资', trigger: 'blur' },
          { type: 'number', min: 0, message: '薪资不能为负数', trigger: 'blur' }
        ]
      },
      submitting: false,
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
   resetOnboardingForm() {
      this.onboardingForm = {
        applicationId: '',
        interviewTime: '',
        interviewResult: '',
        interview: '',
        workTime: '',
        salaryType: '',
        salary: 0
      };
    },
    handleOnboarding(row) {
      // 重置表单数据
      this.resetOnboardingForm();
      
      // 设置新的数据，确保从行数据中获取正确的值
      this.onboardingForm = {
        applicationId: row.applicationId,
        interviewTime: row.interviewTime || '',
        interviewResult: row.interviewResult || '',
        interview: row.interview || ''
      };

      // 重置表单验证状态
      this.$nextTick(() => {
        if (this.$refs.onboardingForm) {
          this.$refs.onboardingForm.clearValidate(); // 使用clearValidate而不是resetFields
        }
      });

      this.onboardingDialogVisible = true;
    },
    // 新增提交方法
    submitOnboarding() {
      this.$refs.onboardingForm.validate(valid => {
        if (valid) {
          this.submitting = true;

          // 准备提交数据，确保格式正确
          const formData = {
            applicationId: this.onboardingForm.applicationId,
            interviewTime: this.onboardingForm.interviewTime,
            interviewResult: this.onboardingForm.interviewResult,
            interview: this.onboardingForm.interview
          };

           this.$refs.onboardingForm?.resetFields();

          // 调用API方法
          submitOnboarding(formData)
            .then(() => {
              this.$message.success('面试评价提交成功');
              this.onboardingDialogVisible = false;
              this.resetOnboardingForm();// 重置表单
              this.getList(); // 刷新列表数据
            })
            .catch(error => {
              console.error('提交失败:', error);
              this.$message.error(error.response?.data?.message || '提交失败');
            })
            .finally(() => {
              this.submitting = false;
            });
        }
      });
    }
    ,
    initUserData() {
      const hr = JSON.parse(sessionStorage.getItem('hr'))
      this.currentUserId = hr.hrId
      this.currentUser = hr
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
    getAvatarUser(userForm) {
      return `http://localhost:8084/api/user/${userForm.userId}`;
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

      console.log('sendMessage:', message)
      console.log('this.currentChat:', this.currentChat)

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


/* 新增弹窗表单样式 */
::v-deep .el-dialog__body {
  padding: 20px 30px;
}

::v-deep .el-form-item {
  margin-bottom: 22px;
}

.item-title {
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
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
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

  /* 面试评价按钮的特殊状态 */
  .el-button--warning:disabled {
    opacity: 0.6;
    /* 禁用时降低透明度 */
    cursor: not-allowed;
    /* 禁用鼠标指针 */
  }

  /* 调整操作列宽度（可选） */
  .el-table-column--fixed-right {
    width: 480px !important;
    /* 根据按钮数量适当增加 */
  }

  .action-btn {
    margin: 5x;
    /* 上边距4px，左右边距2px */
    padding: 7px 10px;
    /* 内边距保持与在线交流按钮一致 */
    font-size: 12px;
    /* 字体大小 */
    min-width: 70px;
    /* 最小宽度避免文字换行 */
  }
}
</style>
