import request from '@/utils/request'

// 查询企业岗位招聘列表
export function listRecruitment(query) {
  return request({
    url: '/boss/recruitment/list',
    method: 'get',
    params: query
  })
}

// 查询企业岗位招聘详细
export function getRecruitment(positionId) {
  return request({
    url: '/boss/recruitment/' + positionId,
    method: 'get'
  })
}

// 新增企业岗位招聘
export function addRecruitment(data) {
  return request({
    url: '/boss/recruitment',
    method: 'post',
    data: data
  })
}

// 修改企业岗位招聘
export function updateRecruitment(data) {
  return request({
    url: '/boss/recruitment',
    method: 'put',
    data: data
  })
}

// 删除企业岗位招聘
export function delRecruitment(positionId) {
  return request({
    url: '/boss/recruitment/' + positionId,
    method: 'delete'
  })
}
