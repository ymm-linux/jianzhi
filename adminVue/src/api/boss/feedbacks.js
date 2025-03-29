import request from '@/utils/request'

// 查询投诉与反馈列表
export function listFeedbacks(query) {
  return request({
    url: '/boss/feedbacks/list',
    method: 'get',
    params: query
  })
}

// 查询投诉与反馈详细
export function getFeedbacks(id) {
  return request({
    url: '/boss/feedbacks/' + id,
    method: 'get'
  })
}

// 新增投诉与反馈
export function addFeedbacks(data) {
  return request({
    url: '/boss/feedbacks',
    method: 'post',
    data: data
  })
}

// 修改投诉与反馈
export function updateFeedbacks(data) {
  return request({
    url: '/boss/feedbacks',
    method: 'put',
    data: data
  })
}

// 删除投诉与反馈
export function delFeedbacks(id) {
  return request({
    url: '/boss/feedbacks/' + id,
    method: 'delete'
  })
}
