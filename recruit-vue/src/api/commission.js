// commision.js
import request from './request';

// 静态数据
const staticCommissionData = [
  { positionName: '前端开发', positionCount: 10, totalCommission: 5000 },
  { positionName: '后端开发', positionCount: 8, totalCommission: 4500 },
  { positionName: 'UI设计', positionCount: 5, totalCommission: 3000 },
  { positionName: '测试工程师', positionCount: 6, totalCommission: 3500 },
];

// 获取数据（统一方法）
export function getCommissionData(useStatic = true) {
  if (useStatic) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({ data: staticCommissionData });
      }, 500); // 模拟延迟
    });
  } else {
    return request({
      url: '/api/commision/data', // 假设这是后端接口地址
      method: 'get',
    });
  }
}
