import request  from '../request'

// 查询公告管理列表
export function listNotice(query) {
  return request({
    url: '/recruit/notice/list',
    method: 'get',
    params: query
  })
}


// 查询公告管理详细
export function getNotice(noticeId) {
  return request({
    url: '/recruit/notice/' + noticeId,
    method: 'get'
  })
}

// 获取最后一条公告信息
export function getLastNotice(query) {
  return request({
    url: '/recruit/notice/getLastNotice' ,
    method: 'get',
    params: query
  })
}

// 新增公告管理
export function addNotice(data) {
  return request({
    url: '/recruit/notice/add',
    method: 'post',
    data: data
  })
}

// 修改公告管理
export function updateNotice(data) {
  return request({
    url: '/recruit/notice/edit',
    method: 'post',
    data: data
  })
}

// 删除公告管理

export function delNotice(id){
    return request({url: `/recruit/notice/${id}/del`, method:'post'})
}
