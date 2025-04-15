import request  from './request'

// 查询投诉与反馈列表
export function listFeedbacks(query) {
  return request({
    url: '/recruit/feedbacks/listFeedbacks',
    method: 'get',
    params: query
  })
}

// 查询投诉与反馈列表
export function listFeedbacksByHr(query) {
  return request({
    url: '/recruit/feedbacks/listFeedbacksByHr',
    method: 'get',
    params: query
  })
}

// 查询投诉与反馈列表
export function listFeedbacksByUser(query) {
  return request({
    url: '/recruit/feedbacks/listFeedbacksByUser',
    method: 'get',
    params: query
  })
}

// 查询投诉与反馈详细
export function getFeedbacks(id) {
  return request({
    url: '/recruit/feedbacks/' + id,
    method: 'get'
  })
}

// 新增投诉与反馈-企业投诉
export function addFeedbacksByHr(data) {
  return request({
    url: '/recruit/feedbacks/addFeedbacksByHr',
    method: 'post',
    data: data
  })
}

// 新增投诉与反馈-学生投诉
export function addFeedbacksByUser(data) {
  return request({
    url: '/recruit/feedbacks/addFeedbacksByUser',
    method: 'post',
    data: data
  })
}

// 修改投诉与反馈
export function updateFeedbacks(data) {
  return request({
    url: '/recruit/feedbacks/updateFeedbacks',
    method: 'post',
    data: data
  })
}

// 删除投诉与反馈
export function delFeedbacks(data) {
  return request({
    url: '/recruit/feedbacks/delFeedbacks',
    method: 'post',
    data: data
  })
}
