import request from './request'

// 查询工时薪资列表-根据登录用户
export function listSalariesByUser(query) {
  return request({
    url: '/recruit/salaries/listSalariesByUser',
    method: 'get',
    params: query
  })
}

// 查询工时薪资列表-根据HR
export function listSalariesByHr(query) {
  return request({
    url: '/recruit/salaries/listSalariesByHr',
    method: 'get',
    params: query
  })
}

// 查询佣金
export function listCommissionByHr(query) {
  return request({
    url: '/recruit/salaries/listCommissionByHr',
    method: 'get',
    params: query
  })
}

// 查询工时薪资列表
export function listSalaries(query) {
  return request({
    url: '/recruit/salaries/list',
    method: 'get',
    params: query
  })
}

// 查询在岗人员列表
export function listWorkers(query) {
  return request({
    url: '/recruit/salaries/listWorkers',
    method: 'get',
    params: query
  })
}

// 查询佣金
export function listCommission(query) {
  return request({
    url: '/recruit/salaries/listCommission',
    method: 'get',
    params: query
  })
}


// 查询工时薪资详细
export function getSalaries(id) {
  return request({
    url: '/recruit/salaries/' + id,
    method: 'get'
  })
}

// 新增工时薪资
export function addSalaries(data) {
  return request({
    url: '/recruit/salaries',
    method: 'post',
    data: data
  })
}

// 修改工时薪资
export function updateSalaries(data) {
  return request({
    url: '/recruit/salaries',
    method: 'put',
    data: data
  })
}

// 删除工时薪资
export function delSalaries(id) {
  return request({
    url: '/recruit/salaries/' + id,
    method: 'delete'
  })
}

