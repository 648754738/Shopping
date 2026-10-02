package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerInventoryMapper;
import com.shop.app.domain.FlowerInventory;
import com.shop.app.service.IFlowerInventoryService;

/**
 * 库存Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerInventoryServiceImpl implements IFlowerInventoryService 
{
    @Autowired
    private FlowerInventoryMapper flowerInventoryMapper;

    /**
     * 查询库存
     * 
     * @param id 库存ID
     * @return 库存
     */
    @Override
    public FlowerInventory selectFlowerInventoryById(Long id)
    {
        return flowerInventoryMapper.selectFlowerInventoryById(id);
    }

    /**
     * 查询库存列表
     * 
     * @param flowerInventory 库存
     * @return 库存
     */
    @Override
    public List<FlowerInventory> selectFlowerInventoryList(FlowerInventory flowerInventory)
    {
        return flowerInventoryMapper.selectFlowerInventoryList(flowerInventory);
    }

    /**
     * 新增库存
     * 
     * @param flowerInventory 库存
     * @return 结果
     */
    @Override
    public int insertFlowerInventory(FlowerInventory flowerInventory)
    {
        // 初始化默认值
        if (flowerInventory.getReservedQuantity() == null) {
            flowerInventory.setReservedQuantity(0);
        }
        if (flowerInventory.getAvailableQuantity() == null) {
            flowerInventory.setAvailableQuantity(flowerInventory.getQuantity() != null ? flowerInventory.getQuantity() : 0);
        }
        if (flowerInventory.getWarningThreshold() == null) {
            flowerInventory.setWarningThreshold(10); // 默认阈值为10
        }
        return flowerInventoryMapper.insertFlowerInventory(flowerInventory);
    }

    /**
     * 修改库存
     * 
     * @param flowerInventory 库存
     * @return 结果
     */
    @Override
    public int updateFlowerInventory(FlowerInventory flowerInventory)
    {
        // 自动计算可用数量
        if (flowerInventory.getQuantity() != null && flowerInventory.getReservedQuantity() != null) {
            flowerInventory.setAvailableQuantity(flowerInventory.getQuantity() - flowerInventory.getReservedQuantity());
        }
        return flowerInventoryMapper.updateFlowerInventory(flowerInventory);
    }

    /**
     * 批量删除库存
     * 
     * @param ids 需要删除的库存ID
     * @return 结果
     */
    @Override
    public int deleteFlowerInventoryByIds(Long[] ids)
    {
        return flowerInventoryMapper.deleteFlowerInventoryByIds(ids);
    }

    /**
     * 删除库存信息
     * 
     * @param id 库存ID
     * @return 结果
     */
    @Override
    public int deleteFlowerInventoryById(Long id)
    {
        return flowerInventoryMapper.deleteFlowerInventoryById(id);
    }
}