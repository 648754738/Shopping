import request from '@/utils/request'

// 获取近七日销售数据
// 用于分析销售金额和数量的变化趋势
export function getSevenDaysSalesData() {
  return request({
    url: '/data/analysis/sales/sevenDays',
    method: 'get'
  })
}

// 获取客户类型分布数据
// 用于分析不同等级客户的占比情况
export function getCustomerTypeDistribution() {
  return request({
    url: '/data/analysis/customer/typeDistribution',
    method: 'get'
  })
}

// 获取推荐鲜花词云数据
// 用于分析被推荐最多的鲜花品种
export function getRecommendWordCloudData() {
  return request({
    url: '/data/analysis/recommend/wordCloud',
    method: 'get'
  })
}

// 获取近七日预定鲜花数据
// 用于分析预定数量的变化趋势
export function getSevenDaysReservationData() {
  return request({
    url: '/data/analysis/reservation/sevenDays',
    method: 'get'
  })
}

// 获取近七日预定人数数据
// 用于分析预定人数的变化趋势
export function getSevenDaysReservationCustomerCount() {
  return request({
    url: '/data/analysis/reservation/customerCount',
    method: 'get'
  })
}

// 获取支付方式分布数据
// 用于分析不同支付方式的使用情况
export function getPaymentMethodDistribution() {
  return request({
    url: '/data/analysis/payment/methodDistribution',
    method: 'get'
  })
}

// 获取年销售额数据
// 用于分析年度销售金额和数量的变化趋势
export function getYearlySalesData() {
  return request({
    url: '/data/analysis/sales/yearly',
    method: 'get'
  })
}

// 获取季度销售额数据
// 用于分析季度销售金额和数量的变化趋势
export function getQuarterlySalesData() {
  return request({
    url: '/data/analysis/sales/quarterly',
    method: 'get'
  })
}

// 获取月销售额数据
// 用于分析月度销售金额和数量的变化趋势
export function getMonthlySalesData() {
  return request({
    url: '/data/analysis/sales/monthly',
    method: 'get'
  })
}

// 获取天销售额数据
// 用于分析每日销售金额和数量的变化趋势
export function getDailySalesData() {
  return request({
    url: '/data/analysis/sales/daily',
    method: 'get'
  })
}