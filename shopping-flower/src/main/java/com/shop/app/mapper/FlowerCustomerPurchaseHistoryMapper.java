package com.shop.app.mapper;

import java.util.List;
import com.shop.app.domain.FlowerCustomerPurchaseHistory;
import org.springframework.stereotype.Repository;

/**
 * 客户购买历史Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerCustomerPurchaseHistoryMapper 
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
     * 删除客户购买历史
     * 
     * @param id 客户购买历史ID
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryById(Long id);

    /**
     * 批量删除客户购买历史
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryByIds(Long[] ids);
    
    /**
     * 根据订单ID删除客户购买历史
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryByOrderId(Long orderId);
    
    /**
     * 批量根据订单ID删除客户购买历史
     * 
     * @param orderIds 订单ID数组
     * @return 结果
     */
    public int deleteFlowerCustomerPurchaseHistoryByOrderIds(Long[] orderIds);
}