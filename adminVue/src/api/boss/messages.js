import request from '@/utils/request'

// 查询在线交流列表
export function listMessages(query) {
  return request({
    url: '/boss/messages/list',
    method: 'get',
    params: query
  })
}

// 查询在线交流详细
export function getMessages(id) {
  return request({
    url: '/boss/messages/' + id,
    method: 'get'
  })
}

// 新增在线交流
export function addMessages(data) {
  return request({
    url: '/boss/messages',
    method: 'post',
    data: data
  })
}

// 修改在线交流
export function updateMessages(data) {
  return request({
    url: '/boss/messages',
    method: 'put',
    data: data
  })
}

// 删除在线交流
export function delMessages(id) {
  return request({
    url: '/boss/messages/' + id,
    method: 'delete'
  })
}
