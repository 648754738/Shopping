import request from '@/utils/request'

// 查询鲜花分类列表
export function listCategory(query) {
  return request({
    url: '/category/category/list',
    method: 'get',
    params: query
  })
}

// 查询鲜花分类详细
export function getCategory(id) {
  return request({
    url: '/category/category/' + id,
    method: 'get'
  })
}

// 新增鲜花分类
export function addCategory(data) {
  return request({
    url: '/category/category',
    method: 'post',
    data: data
  })
}

// 修改鲜花分类
export function updateCategory(data) {
  return request({
    url: '/category/category',
    method: 'put',
    data: data
  })
}

// 删除鲜花分类
export function delCategory(id) {
  return request({
    url: '/category/category/' + id,
    method: 'delete'
  })
}
