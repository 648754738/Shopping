import request from '@/utils/request'

// 查询库存列表
export function listInventory(query) {
  return request({
    url: '/flower/inventory/list',
    method: 'get',
    params: query
  })
}

// 查询库存详细
export function getInventory(id) {
  return request({
    url: '/flower/inventory/' + id,
    method: 'get'
  })
}

// 新增库存
export function addInventory(data) {
  return request({
    url: '/flower/inventory',
    method: 'post',
    data: data
  })
}

// 修改库存
export function updateInventory(data) {
  return request({
    url: '/flower/inventory',
    method: 'put',
    data: data
  })
}

// 删除库存
export function delInventory(id) {
  return request({
    url: '/flower/inventory/' + id,
    method: 'delete'
  })
}

// 导出库存
export function exportInventory(query) {
  return request({
    url: '/flower/inventory/export',
    method: 'get',
    params: query,
    responseType: 'blob'
  })
}