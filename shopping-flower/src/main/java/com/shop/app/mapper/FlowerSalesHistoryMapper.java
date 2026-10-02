package com.shop.app.mapper;

import com.shop.app.domain.FlowerSalesHistory;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 销售历史Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerSalesHistoryMapper 
{
    /**
     * 查询销售历史
     * 
     * @param id 销售历史ID
     * @return 销售历史
     */
    public FlowerSalesHistory selectFlowerSalesHistoryById(Long id);

    /**
     * 查询销售历史列表
     * 
     * @param flowerSalesHistory 销售历史
     * @return 销售历史集合
     */
    public List<FlowerSalesHistory> selectFlowerSalesHistoryList(FlowerSalesHistory flowerSalesHistory);

    /**
     * 新增销售历史
     * 
     * @param flowerSalesHistory 销售历史
     * @return 结果
     */
    public int insertFlowerSalesHistory(FlowerSalesHistory flowerSalesHistory);

    /**
     * 修改销售历史
     * 
     * @param flowerSalesHistory 销售历史
     * @return 结果
     */
    public int updateFlowerSalesHistory(FlowerSalesHistory flowerSalesHistory);

    /**
     * 删除销售历史
     * 
     * @param id 销售历史ID
     * @return 结果
     */
    public int deleteFlowerSalesHistoryById(Long id);

    /**
     * 批量删除销售历史
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerSalesHistoryByIds(Long[] ids);
    
    /**
     * 根据订单ID删除销售历史
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int deleteFlowerSalesHistoryByOrderId(Long orderId);
    
    /**
     * 批量根据订单ID删除销售历史
     * 
     * @param orderIds 订单ID数组
     * @return 结果
     */
    public int deleteFlowerSalesHistoryByOrderIds(Long[] orderIds);
    
    /**
     * 统计近七日销售数据
     * 
     * @return 销售统计数据
     */
    public List<Map<String, Object>> selectSevenDaysSalesData();
    
    /**
     * 根据日期范围查询销售数据
     * 
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 销售数据列表
     */
    public List<FlowerSalesHistory> selectSalesHistoryByDateRange(LocalDate startDate, LocalDate endDate);
    
    /**
     * 统计支付方式分布数据
     * 
     * @return 支付方式分布数据
     */
    public List<Map<String, Object>> selectPaymentMethodDistribution();
    
    /**
     * 统计年销售额数据
     * 
     * @return 年销售额统计数据
     */
    public List<Map<String, Object>> selectYearlySalesData();
    
    /**
     * 统计季度销售额数据
     * 
     * @return 季度销售额统计数据
     */
    public List<Map<String, Object>> selectQuarterlySalesData();
    
    /**
     * 统计月销售额数据
     * 
     * @return 月销售额统计数据
     */
    public List<Map<String, Object>> selectMonthlySalesData();
    
    /**
     * 统计天销售额数据
     * 
     * @return 天销售额统计数据
     */
    public List<Map<String, Object>> selectDailySalesData();
}