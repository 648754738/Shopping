import request from '@/utils/request'

// 查询订单明细列表
export function listOrderDetail(query) {
  return request({
    url: '/order/orderDetail/list',
    method: 'get',
    params: query
  })
}

// 查询订单明细详细
export function getOrderDetail(id) {
  return request({
    url: '/order/orderDetail/' + id,
    method: 'get'
  })
}

// 新增订单明细
export function addOrderDetail(data) {
  return request({
    url: '/order/orderDetail',
    method: 'post',
    data: data
  })
}

// 修改订单明细
export function updateOrderDetail(data) {
  return request({
    url: '/order/orderDetail',
    method: 'put',
    data: data
  })
}

// 删除订单明细
export function delOrderDetail(id) {
  return request({
    url: '/order/orderDetail/' + id,
    method: 'delete'
  })
}