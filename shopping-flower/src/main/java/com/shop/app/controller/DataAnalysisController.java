package com.shop.app.controller;

import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.domain.*;
import com.shop.app.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * 数据分析Controller
 *
 * @author ruoyi
 * @date 2025-09-10
 */
@RestController
@RequestMapping("/data/analysis")
public class DataAnalysisController extends BaseController {

    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;

    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;

    @Autowired
    private FlowerRecommendRecordMapper flowerRecommendRecordMapper;

    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;

    @Autowired
    private FlowerReservationMapper flowerReservationMapper;

    /**
     * 获取近七日销售数据
     * 分析销售金额和数量的变化趋势
     */
    @GetMapping("/sales/sevenDays")
    public AjaxResult getSevenDaysSalesData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取近七日销售数据
        List<Map<String, Object>> salesDataList = flowerSalesHistoryMapper.selectSevenDaysSalesData();

        // 获取近7天日期
        List<String> dates = new ArrayList<>();
        List<BigDecimal> salesAmounts = new ArrayList<>();
        List<Integer> salesCounts = new ArrayList<>();

        LocalDate today = LocalDate.now();
        Map<LocalDate, Map<String, Object>> salesDataMap = new HashMap<>();
        
        // 将查询结果转换为Map便于查找
        for (Map<String, Object> data : salesDataList) {
            // 处理日期字段
            Object dateObj = data.get("date");
            LocalDate localDate = null;
            if (dateObj instanceof java.sql.Date) {
                localDate = ((java.sql.Date) dateObj).toLocalDate();
            } else if (dateObj instanceof java.util.Date) {
                localDate = ((java.util.Date) dateObj).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
            } else if (dateObj instanceof LocalDate) {
                localDate = (LocalDate) dateObj;
            }
            
            if (localDate != null) {
                salesDataMap.put(localDate, data);
            }
        }

        // 生成近7天日期列表并填充数据
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            dates.add(date.format(DateTimeFormatter.ofPattern("MM-dd")));

            Map<String, Object> data = salesDataMap.get(date);
            if (data != null) {
                // 处理总金额
                Object totalAmountObj = data.get("totalAmount");
                BigDecimal totalAmount = BigDecimal.ZERO;
                if (totalAmountObj instanceof BigDecimal) {
                    totalAmount = (BigDecimal) totalAmountObj;
                } else if (totalAmountObj instanceof Number) {
                    totalAmount = new BigDecimal(totalAmountObj.toString());
                } else if (totalAmountObj != null) {
                    try {
                        totalAmount = new BigDecimal(totalAmountObj.toString());
                    } catch (NumberFormatException e) {
                        totalAmount = BigDecimal.ZERO;
                    }
                }
                salesAmounts.add(totalAmount);

                // 处理数量
                Object quantityObj = data.get("quantity");
                int quantity = 0;
                if (quantityObj instanceof Number) {
                    quantity = ((Number) quantityObj).intValue();
                } else if (quantityObj != null) {
                    try {
                        quantity = Integer.parseInt(quantityObj.toString());
                    } catch (NumberFormatException e) {
                        quantity = 0;
                    }
                }
                salesCounts.add(quantity);
            } else {
                salesAmounts.add(BigDecimal.ZERO);
                salesCounts.add(0);
            }
        }

        result.put("dates", dates);
        result.put("salesAmounts", salesAmounts);
        result.put("salesCounts", salesCounts);

        return AjaxResult.success(result);
    }

    /**
     * 获取客户类型分布数据
     * 分析不同等级客户的占比情况
     */
    @GetMapping("/customer/typeDistribution")
    public AjaxResult getCustomerTypeDistribution() {
        Map<String, Object> result = new HashMap<>();

        // 查询所有客户
        List<FlowerCustomer> customers = flowerCustomerMapper.selectFlowerCustomerList(new FlowerCustomer());

        // 统计各等级客户数量
        Map<String, Integer> typeDistribution = new HashMap<>();
        typeDistribution.put("普通客户", 0);
        typeDistribution.put("银卡客户", 0);
        typeDistribution.put("金卡客户", 0);
        typeDistribution.put("钻石客户", 0);

        for (FlowerCustomer customer : customers) {
            // 根据客户等级分类统计
            switch (customer.getLevel() != null ? customer.getLevel() : 1) {
                case 1:
                    typeDistribution.put("普通客户", typeDistribution.get("普通客户") + 1);
                    break;
                case 2:
                    typeDistribution.put("银卡客户", typeDistribution.get("银卡客户") + 1);
                    break;
                case 3:
                    typeDistribution.put("金卡客户", typeDistribution.get("金卡客户") + 1);
                    break;
                case 4:
                    typeDistribution.put("钻石客户", typeDistribution.get("钻石客户") + 1);
                    break;
                default:
                    typeDistribution.put("普通客户", typeDistribution.get("普通客户") + 1);
                    break;
            }
        }

        result.put("types", new ArrayList<>(typeDistribution.keySet()));
        result.put("counts", new ArrayList<>(typeDistribution.values()));

        return AjaxResult.success(result);
    }

    /**
     * 获取推荐鲜花词云数据
     * 分析被推荐最多的鲜花品种
     */
    @GetMapping("/recommend/wordCloud")
    public AjaxResult getRecommendWordCloudData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取推荐词云数据
        List<Map<String, Object>> wordCloudData = flowerRecommendRecordMapper.selectRecommendWordCloudData();

        result.put("wordCloudData", wordCloudData);

        return AjaxResult.success(result);
    }

    /**
     * 获取近七日预定鲜花数据
     * 分析预定数量的变化趋势
     */
    @GetMapping("/reservation/sevenDays")
    public AjaxResult getSevenDaysReservationData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取近七日预定数据
        List<Map<String, Object>> reservationDataList = flowerReservationMapper.selectSevenDaysReservationData();

        // 获取近7天日期
        List<String> dates = new ArrayList<>();
        List<Integer> reservationCounts = new ArrayList<>();

        LocalDate today = LocalDate.now();
        Map<LocalDate, Map<String, Object>> reservationDataMap = new HashMap<>();
        
        // 将查询结果转换为Map便于查找
        for (Map<String, Object> data : reservationDataList) {
            // 处理日期字段
            Object dateObj = data.get("date");
            LocalDate localDate = null;
            if (dateObj instanceof java.sql.Date) {
                localDate = ((java.sql.Date) dateObj).toLocalDate();
            } else if (dateObj instanceof java.util.Date) {
                localDate = ((java.util.Date) dateObj).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
            } else if (dateObj instanceof LocalDate) {
                localDate = (LocalDate) dateObj;
            }
            
            if (localDate != null) {
                reservationDataMap.put(localDate, data);
            }
        }

        // 生成近7天日期列表并填充数据
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            dates.add(date.format(DateTimeFormatter.ofPattern("MM-dd")));

            Map<String, Object> data = reservationDataMap.get(date);
            if (data != null) {
                // 处理数量
                Object quantityObj = data.get("quantity");
                int quantity = 0;
                if (quantityObj instanceof Number) {
                    quantity = ((Number) quantityObj).intValue();
                } else if (quantityObj != null) {
                    try {
                        quantity = Integer.parseInt(quantityObj.toString());
                    } catch (NumberFormatException e) {
                        quantity = 0;
                    }
                }
                reservationCounts.add(quantity);
            } else {
                reservationCounts.add(0);
            }
        }

        result.put("dates", dates);
        result.put("reservationCounts", reservationCounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取近七日预定人数数据
     * 分析预定人数的变化趋势
     */
    @GetMapping("/reservation/customerCount")
    public AjaxResult getSevenDaysReservationCustomerCount() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取近七日预定人数数据
        List<Map<String, Object>> reservationCustomerDataList = flowerReservationMapper.selectSevenDaysReservationCustomerCount();

        // 获取近7天日期
        List<String> dates = new ArrayList<>();
        List<Integer> customerCounts = new ArrayList<>();

        LocalDate today = LocalDate.now();
        Map<LocalDate, Map<String, Object>> reservationCustomerDataMap = new HashMap<>();
        
        // 将查询结果转换为Map便于查找
        for (Map<String, Object> data : reservationCustomerDataList) {
            // 处理日期字段
            Object dateObj = data.get("date");
            LocalDate localDate = null;
            if (dateObj instanceof java.sql.Date) {
                localDate = ((java.sql.Date) dateObj).toLocalDate();
            } else if (dateObj instanceof java.util.Date) {
                localDate = ((java.util.Date) dateObj).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
            } else if (dateObj instanceof LocalDate) {
                localDate = (LocalDate) dateObj;
            }
            
            if (localDate != null) {
                reservationCustomerDataMap.put(localDate, data);
            }
        }

        // 生成近7天日期列表并填充数据
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            dates.add(date.format(DateTimeFormatter.ofPattern("MM-dd")));

            Map<String, Object> data = reservationCustomerDataMap.get(date);
            if (data != null) {
                // 处理预定人数
                Object customerCountObj = data.get("customerCount");
                int customerCount = 0;
                if (customerCountObj instanceof Number) {
                    customerCount = ((Number) customerCountObj).intValue();
                } else if (customerCountObj != null) {
                    try {
                        customerCount = Integer.parseInt(customerCountObj.toString());
                    } catch (NumberFormatException e) {
                        customerCount = 0;
                    }
                }
                customerCounts.add(customerCount);
            } else {
                customerCounts.add(0);
            }
        }

        result.put("dates", dates);
        result.put("customerCounts", customerCounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取支付方式分布数据
     * 分析不同支付方式的使用情况
     */
    @GetMapping("/payment/methodDistribution")
    public AjaxResult getPaymentMethodDistribution() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取支付方式分布数据
        List<Map<String, Object>> paymentDataList = flowerSalesHistoryMapper.selectPaymentMethodDistribution();

        // 处理支付方式数据
        List<String> methods = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();
        List<BigDecimal> amounts = new ArrayList<>();

        for (Map<String, Object> data : paymentDataList) {
            // 处理支付方式
            Object methodObj = data.get("paymentMethod");
            String method = "未知";
            if (methodObj instanceof Number) {
                int methodCode = ((Number) methodObj).intValue();
                switch (methodCode) {
                    case 1:
                        method = "微信支付";
                        break;
                    case 2:
                        method = "支付宝";
                        break;
                    case 3:
                        method = "银行卡";
                        break;
                    case 4:
                        method = "现金支付";
                        break;
                    default:
                        method = "其他方式(" + methodCode + ")";
                        break;
                }
            } else if (methodObj != null) {
                // 如果是字符串类型，直接使用
                method = methodObj.toString();
            }
            methods.add(method);

            // 处理数量
            Object countObj = data.get("count");
            int count = 0;
            if (countObj instanceof Number) {
                count = ((Number) countObj).intValue();
            }
            counts.add(count);

            // 处理金额
            Object amountObj = data.get("totalAmount");
            BigDecimal amount = BigDecimal.ZERO;
            if (amountObj instanceof BigDecimal) {
                amount = (BigDecimal) amountObj;
            } else if (amountObj instanceof Number) {
                amount = new BigDecimal(amountObj.toString());
            }
            amounts.add(amount);
        }

        result.put("methods", methods);
        result.put("counts", counts);
        result.put("amounts", amounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取年销售额数据
     * 分析年度销售金额和数量的变化趋势
     */
    @GetMapping("/sales/yearly")
    public AjaxResult getYearlySalesData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取年销售额数据
        List<Map<String, Object>> salesDataList = flowerSalesHistoryMapper.selectYearlySalesData();

        // 处理年销售额数据
        List<String> dates = new ArrayList<>();
        List<BigDecimal> salesAmounts = new ArrayList<>();
        List<Integer> salesCounts = new ArrayList<>();

        for (Map<String, Object> data : salesDataList) {
            // 处理年份
            Object dateObj = data.get("date");
            if (dateObj != null) {
                dates.add(dateObj.toString());
            } else {
                dates.add("未知");
            }

            // 处理总金额
            Object totalAmountObj = data.get("totalAmount");
            BigDecimal totalAmount = BigDecimal.ZERO;
            if (totalAmountObj instanceof BigDecimal) {
                totalAmount = (BigDecimal) totalAmountObj;
            } else if (totalAmountObj instanceof Number) {
                totalAmount = new BigDecimal(totalAmountObj.toString());
            } else if (totalAmountObj != null) {
                try {
                    totalAmount = new BigDecimal(totalAmountObj.toString());
                } catch (NumberFormatException e) {
                    totalAmount = BigDecimal.ZERO;
                }
            }
            salesAmounts.add(totalAmount);

            // 处理数量
            Object quantityObj = data.get("quantity");
            int quantity = 0;
            if (quantityObj instanceof Number) {
                quantity = ((Number) quantityObj).intValue();
            } else if (quantityObj != null) {
                try {
                    quantity = Integer.parseInt(quantityObj.toString());
                } catch (NumberFormatException e) {
                    quantity = 0;
                }
            }
            salesCounts.add(quantity);
        }

        result.put("dates", dates);
        result.put("salesAmounts", salesAmounts);
        result.put("salesCounts", salesCounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取季度销售额数据
     * 分析季度销售金额和数量的变化趋势
     */
    @GetMapping("/sales/quarterly")
    public AjaxResult getQuarterlySalesData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取季度销售额数据
        List<Map<String, Object>> salesDataList = flowerSalesHistoryMapper.selectQuarterlySalesData();

        // 处理季度销售额数据
        List<String> dates = new ArrayList<>();
        List<BigDecimal> salesAmounts = new ArrayList<>();
        List<Integer> salesCounts = new ArrayList<>();

        for (Map<String, Object> data : salesDataList) {
            // 处理季度
            Object dateObj = data.get("date");
            if (dateObj != null) {
                dates.add(dateObj.toString());
            } else {
                dates.add("未知");
            }

            // 处理总金额
            Object totalAmountObj = data.get("totalAmount");
            BigDecimal totalAmount = BigDecimal.ZERO;
            if (totalAmountObj instanceof BigDecimal) {
                totalAmount = (BigDecimal) totalAmountObj;
            } else if (totalAmountObj instanceof Number) {
                totalAmount = new BigDecimal(totalAmountObj.toString());
            } else if (totalAmountObj != null) {
                try {
                    totalAmount = new BigDecimal(totalAmountObj.toString());
                } catch (NumberFormatException e) {
                    totalAmount = BigDecimal.ZERO;
                }
            }
            salesAmounts.add(totalAmount);

            // 处理数量
            Object quantityObj = data.get("quantity");
            int quantity = 0;
            if (quantityObj instanceof Number) {
                quantity = ((Number) quantityObj).intValue();
            } else if (quantityObj != null) {
                try {
                    quantity = Integer.parseInt(quantityObj.toString());
                } catch (NumberFormatException e) {
                    quantity = 0;
                }
            }
            salesCounts.add(quantity);
        }

        result.put("dates", dates);
        result.put("salesAmounts", salesAmounts);
        result.put("salesCounts", salesCounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取月销售额数据
     * 分析月度销售金额和数量的变化趋势
     */
    @GetMapping("/sales/monthly")
    public AjaxResult getMonthlySalesData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取月销售额数据
        List<Map<String, Object>> salesDataList = flowerSalesHistoryMapper.selectMonthlySalesData();

        // 处理月销售额数据
        List<String> dates = new ArrayList<>();
        List<BigDecimal> salesAmounts = new ArrayList<>();
        List<Integer> salesCounts = new ArrayList<>();

        for (Map<String, Object> data : salesDataList) {
            // 处理月份
            Object dateObj = data.get("date");
            if (dateObj != null) {
                dates.add(dateObj.toString());
            } else {
                dates.add("未知");
            }

            // 处理总金额
            Object totalAmountObj = data.get("totalAmount");
            BigDecimal totalAmount = BigDecimal.ZERO;
            if (totalAmountObj instanceof BigDecimal) {
                totalAmount = (BigDecimal) totalAmountObj;
            } else if (totalAmountObj instanceof Number) {
                totalAmount = new BigDecimal(totalAmountObj.toString());
            } else if (totalAmountObj != null) {
                try {
                    totalAmount = new BigDecimal(totalAmountObj.toString());
                } catch (NumberFormatException e) {
                    totalAmount = BigDecimal.ZERO;
                }
            }
            salesAmounts.add(totalAmount);

            // 处理数量
            Object quantityObj = data.get("quantity");
            int quantity = 0;
            if (quantityObj instanceof Number) {
                quantity = ((Number) quantityObj).intValue();
            } else if (quantityObj != null) {
                try {
                    quantity = Integer.parseInt(quantityObj.toString());
                } catch (NumberFormatException e) {
                    quantity = 0;
                }
            }
            salesCounts.add(quantity);
        }

        result.put("dates", dates);
        result.put("salesAmounts", salesAmounts);
        result.put("salesCounts", salesCounts);

        return AjaxResult.success(result);
    }
    
    /**
     * 获取天销售额数据
     * 分析每日销售金额和数量的变化趋势
     */
    @GetMapping("/sales/daily")
    public AjaxResult getDailySalesData() {
        Map<String, Object> result = new HashMap<>();

        // 使用优化的数据库查询方法获取天销售额数据
        List<Map<String, Object>> salesDataList = flowerSalesHistoryMapper.selectDailySalesData();

        // 获取近30天日期
        List<String> dates = new ArrayList<>();
        List<BigDecimal> salesAmounts = new ArrayList<>();
        List<Integer> salesCounts = new ArrayList<>();

        LocalDate today = LocalDate.now();
        Map<LocalDate, Map<String, Object>> salesDataMap = new HashMap<>();
        
        // 将查询结果转换为Map便于查找
        for (Map<String, Object> data : salesDataList) {
            // 处理日期字段
            Object dateObj = data.get("date");
            LocalDate localDate = null;
            if (dateObj instanceof java.sql.Date) {
                localDate = ((java.sql.Date) dateObj).toLocalDate();
            } else if (dateObj instanceof java.util.Date) {
                localDate = ((java.util.Date) dateObj).toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
            } else if (dateObj instanceof LocalDate) {
                localDate = (LocalDate) dateObj;
            }
            
            if (localDate != null) {
                salesDataMap.put(localDate, data);
            }
        }

        // 生成近30天日期列表并填充数据
        for (int i = 29; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            dates.add(date.format(DateTimeFormatter.ofPattern("MM-dd")));

            Map<String, Object> data = salesDataMap.get(date);
            if (data != null) {
                // 处理总金额
                Object totalAmountObj = data.get("totalAmount");
                BigDecimal totalAmount = BigDecimal.ZERO;
                if (totalAmountObj instanceof BigDecimal) {
                    totalAmount = (BigDecimal) totalAmountObj;
                } else if (totalAmountObj instanceof Number) {
                    totalAmount = new BigDecimal(totalAmountObj.toString());
                } else if (totalAmountObj != null) {
                    try {
                        totalAmount = new BigDecimal(totalAmountObj.toString());
                    } catch (NumberFormatException e) {
                        totalAmount = BigDecimal.ZERO;
                    }
                }
                salesAmounts.add(totalAmount);

                // 处理数量
                Object quantityObj = data.get("quantity");
                int quantity = 0;
                if (quantityObj instanceof Number) {
                    quantity = ((Number) quantityObj).intValue();
                } else if (quantityObj != null) {
                    try {
                        quantity = Integer.parseInt(quantityObj.toString());
                    } catch (NumberFormatException e) {
                        quantity = 0;
                    }
                }
                salesCounts.add(quantity);
            } else {
                salesAmounts.add(BigDecimal.ZERO);
                salesCounts.add(0);
            }
        }

        result.put("dates", dates);
        result.put("salesAmounts", salesAmounts);
        result.put("salesCounts", salesCounts);

        return AjaxResult.success(result);
    }
}