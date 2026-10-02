package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerCustomerPurchaseHistoryMapper;
import com.shop.app.domain.FlowerCustomerPurchaseHistory;
import com.shop.app.service.IFlowerCustomerPurchaseHistoryService;

/**
 * 客户购买历史Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerCustomerPurchaseHistoryServiceImpl implements IFlowerCustomerPurchaseHistoryService 
{
    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;

    /**
     * 查询客户购买历史
     * 
     * @param id 客户购买历史ID
     * @return 客户购买历史
     */
    @Override
    public FlowerCustomerPurchaseHistory selectFlowerCustomerPurchaseHistoryById(Long id)
    {
        return flowerCustomerPurchaseHistoryMapper.selectFlowerCustomerPurchaseHistoryById(id);
    }

    /**
     * 查询客户购买历史列表
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 客户购买历史
     */
    @Override
    public List<FlowerCustomerPurchaseHistory> selectFlowerCustomerPurchaseHistoryList(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        return flowerCustomerPurchaseHistoryMapper.selectFlowerCustomerPurchaseHistoryList(flowerCustomerPurchaseHistory);
    }

    /**
     * 新增客户购买历史
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 结果
     */
    @Override
    public int insertFlowerCustomerPurchaseHistory(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        return flowerCustomerPurchaseHistoryMapper.insertFlowerCustomerPurchaseHistory(flowerCustomerPurchaseHistory);
    }

    /**
     * 修改客户购买历史
     * 
     * @param flowerCustomerPurchaseHistory 客户购买历史
     * @return 结果
     */
    @Override
    public int updateFlowerCustomerPurchaseHistory(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        return flowerCustomerPurchaseHistoryMapper.updateFlowerCustomerPurchaseHistory(flowerCustomerPurchaseHistory);
    }

    /**
     * 批量删除客户购买历史
     * 
     * @param ids 需要删除的客户购买历史ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCustomerPurchaseHistoryByIds(Long[] ids)
    {
        return flowerCustomerPurchaseHistoryMapper.deleteFlowerCustomerPurchaseHistoryByIds(ids);
    }

    /**
     * 删除客户购买历史信息
     * 
     * @param id 客户购买历史ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCustomerPurchaseHistoryById(Long id)
    {
        return flowerCustomerPurchaseHistoryMapper.deleteFlowerCustomerPurchaseHistoryById(id);
    }
}