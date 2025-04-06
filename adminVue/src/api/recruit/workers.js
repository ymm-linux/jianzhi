import request  from '../request'
import { defineComponent } from 'vue'

// 查询在岗人员列表
export function listWorkers(query) {
  return request({
    url: '/recruit/salaries/listWorkers',
    method: 'get',
    params: query
  })
}
