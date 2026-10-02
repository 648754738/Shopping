import request from '@/utils/request'

// 获取首页统计数据
export function getDashboardStatistics() {
  return request({
    url: '/dashboard/statistics',
    method: 'get'
  })
}

// 触发推荐算法生成推荐数据
export function generateRecommendations() {
  return request({
    url: '/dashboard/generateRecommendations',
    method: 'post'
  })
}