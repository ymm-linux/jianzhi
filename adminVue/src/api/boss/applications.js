import request  from '../request'

// 查询岗位申请列表
export function listApplications(query) {
  return request({
    url: '/boss/applications/list',
    method: 'get',
    params: query
  })
}

// 查询岗位申请详细
export function getApplications(applyId) {
  return request({
    url: '/boss/applications/' + applyId,
    method: 'get'
  })
}

// 新增岗位申请
export function addApplications(data) {
  return request({
    url: '/boss/applications',
    method: 'post',
    data: data
  })
}

// 修改岗位申请
export function updateApplications(data) {
  return request({
    url: '/boss/applications',
    method: 'put',
    data: data
  })
}

// 删除岗位申请
export function delApplications(applyId) {
  return request({
    url: '/boss/applications/' + applyId,
    method: 'delete'
  })
}
