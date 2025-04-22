import request  from './request'

//managerLogin
export function managerLogin(mobile, password){
    return request({url: '/manager/login', method: 'post', params:{mobile, password}})
}

//managerUpdate
export function managerUpdate(oldPassword, newPassword){
    return request({url: '/manager/password/update', method: 'post', params:{oldPassword, newPassword}})
}

//listCompany
export function listCompany(){
    return request({url: '/manager/Company/list', method: 'get'})
}

//delCompany
export function delCompany(id){
    return request({url: `/manager/company/${id}/del`, method: 'post'})
}

//updateCompany
export function updateCompany(company){
    const data = company
    return request({url: `/manager/company/update`, method: 'post', data})
}

//updateUser
export function updateUser(user){
    const data = user
    return request({url: `/manager/user/update`, method: 'post', data})
}

//listUser
export function listUser(){
    return request({url: '/manager/User/list', method: 'get'})
}

//listResume
export function listResume(){
    return request({url: '/manager/resume/list', method: 'get'})
}

//updateCategory
export function updateCategory(secondCategoryName, id){
    const data = {
        secondCategoryName
    }
    return request({url: '/manager/category/'+id+'/update', method:'post', data})
}

//delCategory
export function delCategory(id){
    return request({url: '/manager/category/'+id+'/del', method: 'get'})
}

//listCategory
export function listCategory(){
    return request({url: '/manager/category/list', method:'get'})
}

//createCategory
export function createCategory(firstCategoryName, secondCategoryName,description){
    return request({url: '/manager/category/create', method:'post',params: {firstCategoryName, secondCategoryName, description}})
}

//updateEducation
export function updateEducation(id, name, level){
    const data = {
        id,
        name,
        level
    }
    return request({url: '/manager/education/update', method:'post', data})
}

//delEducation
export function delEducation(id){
    const data={
        id
    }
    return request({url: '/manager/education/del', method: 'post', data})
}

//listEducation
export function listEducation(){
    return request({url: '/manager/education/list', method:'get'})
}

//createEducation
export function createEducation(name, level){
    const data = {
        name,
        level
    }
    return request({url: '/manager/education/create', method:'post', data})
}

//createFriendUrl
export function createFriendUrl(name, url){
    const data = {
        url,
        name
    }
    return request({url: '/manager/friendUrl/create', method:'post', data: data})
}

//delFriendUrl
export function delFriendUrl(id){
    return request({url: '/manager/friendUrl/'+id+'/del', method: 'post'})
}

//updateFriendUrl
export function updateFriendUrl(id, name, url){
    const data = {
        url,
        name
    }
    return request({url: '/manager/friendUrl/'+id+'/update', method: 'post', data: data})
}

//listFriendUrl
export function listFriendUrl(){
    return request({url: '/manager/friendUrl/list', method: 'get'})
}

//delUser
export function delUser(id){
    return request({url: '/manager/user/'+id+'/del', method: 'post'})
}

// 更新岗位信息
export function updatePosition(position) {
  return request({
    url: '/manager/position/update',
    method: 'post',
    data: position
  })
}

// 删除岗位
export function delPosition(id) {
  return request({
    url: `/manager/position/${id}/del`,
    method: 'post'
  })
}

// 获取岗位列表
export function listPosition() {
  return request({
    url: '/manager/position/list',
    method: 'get'
  })
}

//listApplication
export function listApplication(){
    return request({url: '/manager/application/list', method: 'get'})
}

//delApplication
export function delApplication(id){
    return request({url: `/manager/application/${id}/del`, method:'post'})
}

// 岗位审核
export function auditPosition(positionId) {
  return request({
    url: '/position/audit',
    method: 'post',
    data: { positionId }
  })
}

// 提交入职登记
export function submitEmployment(data) {
  return request({
    url: '/employment/submit',
    method: 'post',
    data
  })
}

// 获取入职登记列表
export function listEmployment() {
  return request({
    url: '/employment/list',
    method: 'get'
  })
}

// 审核入职登记
export function auditEmployment(data) {
  return request({
    url: '/employment/audit',
    method: 'post',
    data
  })
}

// 存档入职记录
export function archiveEmployment(applicationId) {
  return request({
    url: '/employment/archive',
    method: 'post',
    data: { applicationId }
  })
}

// 发布岗位
export function publishPosition(positionId) {
  return request({
    url: '/position/publish',
    method: 'post',
    data: { positionId }
  })
}

// 下架岗位
export function unpublishPosition(positionId) {
  return request({
    url: '/position/unpublish',
    method: 'post',
    data: { positionId }
  })
}

// 提交发布岗位
export function submitPosition(positionId) {
  return request({
    url: '/position/submit',
    method: 'post',
    data: { positionId }
  })
}

// 拒绝岗位
export function rejectPosition(positionId) {
  return request({
    url: '/position/reject',
    method: 'post',
    data: { positionId }
  })
}

// 更新入职登记
export function updateOnboardingRuzhi(application){
  return request({url: '/application/updateOnboardingRuzhi', method: 'post', data: application})
}
// 更新入职登记审核状态
export function updateOnboardingShenhe(application){
  return request({url: '/application/updateOnboardingShenhe', method: 'post', data: application})
}