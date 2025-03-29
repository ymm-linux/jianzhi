import request from '@/utils/request'

// 查询工时薪资列表
export function listSalaries(query) {
  return request({
    url: '/boss/salaries/list',
    method: 'get',
    params: query
  })
}

// 查询工时薪资详细
export function getSalaries(id) {
  return request({
    url: '/boss/salaries/' + id,
    method: 'get'
  })
}

// 新增工时薪资
export function addSalaries(data) {
  return request({
    url: '/boss/salaries',
    method: 'post',
    data: data
  })
}

// 修改工时薪资
export function updateSalaries(data) {
  return request({
    url: '/boss/salaries',
    method: 'put',
    data: data
  })
}

// 删除工时薪资
export function delSalaries(id) {
  return request({
    url: '/boss/salaries/' + id,
    method: 'delete'
  })
}
