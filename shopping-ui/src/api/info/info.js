import request from '@/utils/request'

// 查询鲜花信息列表
export function listInfo(query) {
  return request({
    url: '/info/info/listDTO',
    method: 'get',
    params: query
  })
}

// 查询鲜花信息详细
export function getInfo(id) {
  return request({
    url: '/info/info/getDTO/' + id,
    method: 'get'
  })
}

// 新增鲜花信息
export function addInfo(data) {
  return request({
    url: '/info/info',
    method: 'post',
    data: data
  })
}

// 修改鲜花信息
export function updateInfo(data) {
  return request({
    url: '/info/info',
    method: 'put',
    data: data
  })
}

// 删除鲜花信息
export function delInfo(id) {
  return request({
    url: '/info/info/' + id,
    method: 'delete'
  })
}

// 上传鲜花图片
export function uploadFlowerImages(id, data) {
  return request({
    url: '/info/info/uploadImages/' + id,
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

// 设置鲜花图片地址
export function updateFlowerImageUrl(data) {
  return request({
    url: '/info/info/updateImageUrl',
    method: 'put',
    data: data
  })
}
