package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerSalesHistoryMapper;
import com.shop.app.domain.FlowerSalesHistory;
import com.shop.app.service.IFlowerSalesHistoryService;

/**
 * 销售历史Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerSalesHistoryServiceImpl implements IFlowerSalesHistoryService 
{
    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;

    /**
     * 查询销售历史
     * 
     * @param id 销售历史ID
     * @return 销售历史
     */
    @Override
    public FlowerSalesHistory selectFlowerSalesHistoryById(Long id)
    {
        return flowerSalesHistoryMapper.selectFlowerSalesHistoryById(id);
    }

    /**
     * 查询销售历史列表
     * 
     * @param flowerSalesHistory 销售历史
     * @return 销售历史
     */
    @Override
    public List<FlowerSalesHistory> selectFlowerSalesHistoryList(FlowerSalesHistory flowerSalesHistory)
    {
        return flowerSalesHistoryMapper.selectFlowerSalesHistoryList(flowerSalesHistory);
    }

    /**
     * 新增销售历史
     * 
     * @param flowerSalesHistory 销售历史
     * @return 结果
     */
    @Override
    public int insertFlowerSalesHistory(FlowerSalesHistory flowerSalesHistory)
    {
        return flowerSalesHistoryMapper.insertFlowerSalesHistory(flowerSalesHistory);
    }

    /**
     * 修改销售历史
     * 
     * @param flowerSalesHistory 销售历史
     * @return 结果
     */
    @Override
    public int updateFlowerSalesHistory(FlowerSalesHistory flowerSalesHistory)
    {
        return flowerSalesHistoryMapper.updateFlowerSalesHistory(flowerSalesHistory);
    }

    /**
     * 批量删除销售历史
     * 
     * @param ids 需要删除的销售历史ID
     * @return 结果
     */
    @Override
    public int deleteFlowerSalesHistoryByIds(Long[] ids)
    {
        return flowerSalesHistoryMapper.deleteFlowerSalesHistoryByIds(ids);
    }

    /**
     * 删除销售历史信息
     * 
     * @param id 销售历史ID
     * @return 结果
     */
    @Override
    public int deleteFlowerSalesHistoryById(Long id)
    {
        return flowerSalesHistoryMapper.deleteFlowerSalesHistoryById(id);
    }
}