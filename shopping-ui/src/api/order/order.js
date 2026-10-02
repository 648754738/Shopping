import request from '@/utils/request'

// 查询订单管理列表
export function listOrder(query) {
  return request({
    url: '/order/order/list',
    method: 'get',
    params: query
  })
}

// 查询订单管理详细
export function getOrder(id) {
  return request({
    url: '/order/order/' + id,
    method: 'get'
  })
}

// 新增订单管理
export function addOrder(data) {
  return request({
    url: '/order/order',
    method: 'post',
    data: data
  })
}

// 修改订单管理
export function updateOrder(data) {
  return request({
    url: '/order/order',
    method: 'put',
    data: data
  })
}

// 删除订单管理
export function delOrder(id) {
  return request({
    url: '/order/order/' + id,
    method: 'delete'
  })
}

// 处理订单支付成功
export function handleOrderPaymentSuccess(id) {
  return request({
    url: '/order/order/paymentSuccess/' + id,
    method: 'post'
  })
}

// 处理订单完成
export function handleOrderCompletion(id) {
  return request({
    url: '/order/order/complete/' + id,
    method: 'post'
  })
}