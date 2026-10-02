package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerCustomerPurchaseHistory;

/**
 * 客户购买历史Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerCustomerPurchaseHistoryService 
{
    /**
     * 查询客户购买历史
     * 
     * @param id 客户购买历史ID
     * @return 客户购买历史
     */
    public FlowerCustomerPurchaseHistory selectFlowerCustomerPurchaseHistoryById(Long id);

    /**
     * 查询客户购买历史列表
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 客户购买历史集合
     */
    public List<FlowerCustomerPurchaseHistory> selectFlowerCustomerPurchaseHistoryList(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory);

    /**
     * 新增客户购买历史
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 结果
     */
    public int insertFlowerCustomerPurchaseHistory(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory);

    /**
     * 修改客户购买历史
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 结果
     */
    public int updateFlowerCustomerPurchaseHistory(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory);

    /**
     * 批量删除客户购买历史
     * 
     * @param ids 需要删除的客户购买历史ID
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryByIds(Long[] ids);

    /**
     * 删除客户购买历史信息
     * 
     * @param id 客户购买历史ID
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryById(Long id);
}