<template>
  <div class="app-container message-container">
    <div class="message-layout">
      <!-- 左侧联系人列表 -->
      <div class="contact-list">
        <div class="search-box">
          <el-input
            placeholder="搜索联系人"
            prefix-icon="el-icon-search"
            v-model="searchText"
            clearable
          />
        </div>
        <el-scrollbar class="contact-scrollbar">
          <div
            class="contact-item"
            v-for="contact in filteredContacts"
            :key="contact.id"
            :class="{ active: activeContact === contact.id }"
            @click="selectContact(contact)"
          >
            <el-avatar :size="40" :src="contact.avatar" />
            <div class="contact-info">
              <div class="contact-name">{{ contact.name }}</div>
              <div class="contact-lastmsg">{{ contact.lastMsg }}</div>
            </div>
          </div>
        </el-scrollbar>
      </div>

      <!-- 右侧消息窗口 -->
      <div class="message-window">
        <div class="message-header">
          <div v-if="activeContact" class="header-info">
            <el-avatar :size="40" :src="currentContact.avatar" />
            <span class="contact-name">{{ currentContact.name }}</span>
          </div>
        </div>
        
        <el-scrollbar class="message-scrollbar" ref="messageScrollbar">
          <div class="message-content">
            <div
              v-for="(msg, index) in messages"
              :key="index"
              :class="['message-bubble', msg.sender === 'me' ? 'me' : 'other']"
            >
              <div class="message-text">{{ msg.content }}</div>
              <div class="message-time">{{ msg.time }}</div>
            </div>
          </div>
        </el-scrollbar>

        <div class="message-input">
          <el-input
            type="textarea"
            :rows="3"
            placeholder="输入消息..."
            v-model="newMessage"
            @keyup.enter.native="sendMessage"
          />
          <div class="input-actions">
            <el-button type="primary" @click="sendMessage">发送</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { listContacts, getMessages, sendMessage, markAsRead } from "@/api/recruit/messages";

export default {
  name: "MessageCenter",
  data() {
    return {
      searchText: "",
      contacts: [],
      activeContact: null,
      currentContact: {},
      messages: [],
      newMessage: "",
      socket: null,
      unreadCount: 0
    };
  },
  computed: {
    filteredContacts() {
      return this.contacts.filter(contact =>
        contact.name.toLowerCase().includes(this.searchText.toLowerCase())
      );
    }
  },
  created() {
    this.loadContacts();
  },
  mounted() {
    this.initWebSocket();
  },
  beforeDestroy() {
    if (this.socket) {
      this.socket.close();
    }
  },
  methods: {
    async loadContacts() {
      const response = await listContacts();
      this.contacts = response.data;
      if (this.contacts.length > 0) {
        this.selectContact(this.contacts[0]);
      }
    },
    initWebSocket() {
      const wsUrl = `ws://your-api-domain.com/ws/messages?userId=${this.$store.state.user.id}`;
      this.socket = new WebSocket(wsUrl);
      
      this.socket.onmessage = (e) => {
        const message = JSON.parse(e.data);
        if (message.sender === this.activeContact) {
          this.messages.push({
            content: message.content,
            time: new Date().toLocaleTimeString(),
            sender: 'other'
          });
          this.$nextTick(() => {
            this.scrollToBottom();
          });
        } else {
          this.unreadCount++;
        }
      };
    },
    async selectContact(contact) {
      this.activeContact = contact.id;
      this.currentContact = contact;
      const response = await getMessages(contact.id);
      this.messages = response.data;
      
      // 标记为已读
      const unreadIds = this.messages
        .filter(msg => msg.sender === 'other' && !msg.read)
        .map(msg => msg.id);
      if (unreadIds.length > 0) {
        await markAsRead(unreadIds);
      }
      
      this.$nextTick(() => {
        this.scrollToBottom();
      });
    },
    async sendMessage() {
      if (!this.newMessage.trim()) return;
      
      const msg = {
        content: this.newMessage,
        time: new Date().toLocaleTimeString(),
        sender: "me"
      };
      
      this.messages.push(msg);
      this.newMessage = "";
      
      await sendMessage({
        contactId: this.activeContact,
        content: msg.content
      });
      
      this.$nextTick(() => {
        this.scrollToBottom();
      });
    },
    scrollToBottom() {
      const scrollbar = this.$refs.messageScrollbar;
      if (scrollbar) {
        scrollbar.wrap.scrollTop = scrollbar.wrap.scrollHeight;
      }
    }
  }
};
</script>

<style scoped>
.message-container {
  height: calc(100vh - 84px);
  padding: 0;
}

.message-layout {
  display: flex;
  height: 100%;
}

.contact-list {
  width: 280px;
  border-right: 1px solid #e6e6e6;
  display: flex;
  flex-direction: column;
}

.search-box {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
}

.contact-scrollbar {
  flex: 1;
  height: 0;
}

.contact-item {
  display: flex;
  padding: 12px 15px;
  cursor: pointer;
  align-items: center;
  border-bottom: 1px solid #f5f5f5;
}

.contact-item:hover, .contact-item.active {
  background-color: #f5f7fa;
}

.contact-info {
  margin-left: 12px;
  flex: 1;
  overflow: hidden;
}

.contact-name {
  font-weight: 500;
  margin-bottom: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.contact-lastmsg {
  font-size: 12px;
  color: #999;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.message-window {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.message-header {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  align-items: center;
}

.header-info {
  display: flex;
  align-items: center;
}

.header-info .contact-name {
  margin-left: 10px;
  font-size: 16px;
}

.message-scrollbar {
  flex: 1;
  height: 0;
  padding: 15px;
}

.message-content {
  min-height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

.message-bubble {
  max-width: 70%;
  margin-bottom: 15px;
  padding: 10px 15px;
  border-radius: 5px;
  position: relative;
}

.message-bubble.me {
  align-self: flex-end;
  background-color: #409eff;
  color: white;
}

.message-bubble.other {
  align-self: flex-start;
  background-color: #f5f5f5;
  color: #333;
}

.message-time {
  font-size: 12px;
  margin-top: 5px;
  text-align: right;
  color: inherit;
  opacity: 0.7;
}

.message-input {
  padding: 15px;
  border-top: 1px solid #e6e6e6;
}

.input-actions {
  margin-top: 10px;
  text-align: right;
}
</style>
