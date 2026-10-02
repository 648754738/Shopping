import request from '@/utils/request'

// 查询客户详细信息
export function getCustomer(id) {
  return request({
    url: '/customer/customer/' + id,
    method: 'get'
  })
}