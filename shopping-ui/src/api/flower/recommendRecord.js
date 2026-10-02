import request from '@/utils/request'

// 查询推荐记录列表
export function listRecommendRecord(query) {
  return request({
    url: '/flower/recommendRecord/list',
    method: 'get',
    params: query
  })
}

// 查询指定客户的推荐记录
export function listCustomerRecommendRecord(customerId) {
  return request({
    url: '/flower/recommendRecord/list',
    method: 'get',
    params: { customerId: customerId }
  })
}

// 获取推荐记录详细信息
export function getRecommendRecord(id) {
  return request({
    url: '/flower/recommendRecord/' + id,
    method: 'get'
  })
}

// 新增推荐记录
export function addRecommendRecord(data) {
  return request({
    url: '/flower/recommendRecord',
    method: 'post',
    data: data
  })
}

// 修改推荐记录
export function updateRecommendRecord(data) {
  return request({
    url: '/flower/recommendRecord',
    method: 'put',
    data: data
  })
}

// 删除推荐记录
export function delRecommendRecord(id) {
  return request({
    url: '/flower/recommendRecord/' + id,
    method: 'delete'
  })
}