package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerSalesHistory;

/**
 * 销售历史Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerSalesHistoryService 
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
     * 批量删除销售历史
     * 
     * @param ids 需要删除的销售历史ID
     * @return 结果
     */
    public int deleteFlowerSalesHistoryByIds(Long[] ids);

    /**
     * 删除销售历史信息
     * 
     * @param id 销售历史ID
     * @return 结果
     */
    public int deleteFlowerSalesHistoryById(Long id);
}