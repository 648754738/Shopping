import request from '@/utils/request'

// 查询预定管理列表
export function listReservation(query) {
  return request({
    url: '/reservation/reservation/list',
    method: 'get',
    params: query
  })
}

// 查询预定管理详细
export function getReservation(id) {
  return request({
    url: '/reservation/reservation/' + id,
    method: 'get'
  })
}

// 新增预定管理
export function addReservation(data) {
  return request({
    url: '/reservation/reservation',
    method: 'post',
    data: data
  })
}

// 修改预定管理
export function updateReservation(data) {
  return request({
    url: '/reservation/reservation',
    method: 'put',
    data: data
  })
}

// 删除预定管理
export function delReservation(id) {
  return request({
    url: '/reservation/reservation/' + id,
    method: 'delete'
  })
}

// 获取预定初始化数据
export function getReservationInitData() {
  return request({
    url: '/reservation/reservation/initData',
    method: 'get'
  })
}

// 处理预定支付成功
export function handleReservationPaymentSuccess(id) {
  return request({
    url: '/reservation/reservation/paymentSuccess/' + id,
    method: 'post'
  })
}