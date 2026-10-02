package com.shop.app.mapper;

import java.util.List;
import com.shop.app.domain.FlowerInventory;
import org.springframework.stereotype.Repository;

/**
 * 库存Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerInventoryMapper 
{
    /**
     * 查询库存
     * 
     * @param id 库存ID
     * @return 库存
     */
    public FlowerInventory selectFlowerInventoryById(Long id);

    /**
     * 查询库存列表
     * 
     * @param flowerInventory 库存
     * @return 库存集合
     */
    public List<FlowerInventory> selectFlowerInventoryList(FlowerInventory flowerInventory);

    /**
     * 新增库存
     * 
     * @param flowerInventory 库存
     * @return 结果
     */
    public int insertFlowerInventory(FlowerInventory flowerInventory);

    /**
     * 修改库存
     * 
     * @param flowerInventory 库存
     * @return 结果
     */
    public int updateFlowerInventory(FlowerInventory flowerInventory);

    /**
     * 删除库存
     * 
     * @param id 库存ID
     * @return 结果
     */
    public int deleteFlowerInventoryById(Long id);

    /**
     * 批量删除库存
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerInventoryByIds(Long[] ids);
}