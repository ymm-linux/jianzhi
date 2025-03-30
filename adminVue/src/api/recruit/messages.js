import request from '@/utils/request'

// 获取联系人列表
export function listContacts() {
  return request({
    url: '/recruit/messages/contacts',
    method: 'get'
  })
}

// 获取与特定联系人的消息记录
export function getMessages(contactId) {
  return request({
    url: '/recruit/messages/history',
    method: 'get',
    params: {
      contactId
    }
  })
}

// 发送消息
export function sendMessage(data) {
  return request({
    url: '/recruit/messages/send',
    method: 'post',
    data: data
  })
}

// 标记消息为已读
export function markAsRead(messageIds) {
  return request({
    url: '/recruit/messages/read',
    method: 'post',
    data: {
      ids: messageIds
    }
  })
}
