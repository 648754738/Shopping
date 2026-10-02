import request from '@/utils/request'

// 查询鲜花详细信息
export function getFlower(id) {
  return request({
    url: '/info/info/' + id,
    method: 'get'
  })
}