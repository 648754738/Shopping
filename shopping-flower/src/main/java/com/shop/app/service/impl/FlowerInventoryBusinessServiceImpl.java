package com.shop.app.service.impl;

import com.shop.app.domain.FlowerInventory;
import com.shop.app.service.IFlowerInventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * 库存业务逻辑处理
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
@Service
public class FlowerInventoryBusinessServiceImpl {
    
    @Autowired
    private IFlowerInventoryService flowerInventoryService;

    /**
     * 增加库存
     * 
     * @param flowerId 鲜花ID
     * @param quantity 增加数量
     * @param remark 备注
     * @return 结果
     */
    public int increaseInventory(Long flowerId, Integer quantity, String remark) {
        // 查询现有库存
        List<FlowerInventory> inventoryList = flowerInventoryService.selectFlowerInventoryList(
            new FlowerInventory() {{
                setFlowerId(flowerId);
            }}
        );
        
        FlowerInventory inventory;
        if (inventoryList.isEmpty()) {
            // 如果不存在库存记录，则创建新的
            inventory = new FlowerInventory();
            inventory.setFlowerId(flowerId);
            inventory.setQuantity(quantity);
            inventory.setReservedQuantity(0);
            inventory.setAvailableQuantity(quantity);
            inventory.setWarningThreshold(10);
            inventory.setLastRestockTime(new Date());
            inventory.setRemark(remark);
            return flowerInventoryService.insertFlowerInventory(inventory);
        } else {
            // 更新现有库存
            inventory = inventoryList.get(0);
            inventory.setQuantity(inventory.getQuantity() + quantity);
            inventory.setAvailableQuantity(inventory.getAvailableQuantity() + quantity);
            inventory.setLastRestockTime(new Date());
            
            if (remark != null && !remark.isEmpty()) {
                String currentRemark = inventory.getRemark() != null ? inventory.getRemark() : "";
                inventory.setRemark(currentRemark + " " + remark);
            }
            
            return flowerInventoryService.updateFlowerInventory(inventory);
        }
    }

    /**
     * 减少库存（直接扣减，不占用）
     * 
     * @param flowerId 鲜花ID
     * @param quantity 减少数量
     * @param remark 备注
     * @return 结果
     */
    public int decreaseInventory(Long flowerId, Integer quantity, String remark) {
        // 查询现有库存
        List<FlowerInventory> inventoryList = flowerInventoryService.selectFlowerInventoryList(
            new FlowerInventory() {{
                setFlowerId(flowerId);
            }}
        );
        
        if (inventoryList.isEmpty()) {
            throw new RuntimeException("库存记录不存在");
        }
        
        FlowerInventory inventory = inventoryList.get(0);
        
        // 检查库存是否充足
        if (inventory.getAvailableQuantity() < quantity) {
            throw new RuntimeException("库存不足，无法完成扣减操作");
        }
        
        // 扣减库存
        inventory.setQuantity(inventory.getQuantity() - quantity);
        inventory.setAvailableQuantity(inventory.getAvailableQuantity() - quantity);
        
        if (remark != null && !remark.isEmpty()) {
            String currentRemark = inventory.getRemark() != null ? inventory.getRemark() : "";
            inventory.setRemark(currentRemark + " " + remark);
        }
        
        return flowerInventoryService.updateFlowerInventory(inventory);
    }

    /**
     * 占用库存（预定时使用）
     * 
     * @param flowerId 鲜花ID
     * @param quantity 占用数量
     * @param remark 备注
     * @return 结果
     */
    public int reserveInventory(Long flowerId, Integer quantity, String remark) {
        // 查询现有库存
        List<FlowerInventory> inventoryList = flowerInventoryService.selectFlowerInventoryList(
            new FlowerInventory() {{
                setFlowerId(flowerId);
            }}
        );
        
        if (inventoryList.isEmpty()) {
            throw new RuntimeException("库存记录不存在");
        }
        
        FlowerInventory inventory = inventoryList.get(0);
        
        // 检查库存是否充足
        if (inventory.getAvailableQuantity() < quantity) {
            throw new RuntimeException("库存不足，无法完成预定操作");
        }
        
        // 占用库存
        inventory.setReservedQuantity(inventory.getReservedQuantity() + quantity);
        inventory.setAvailableQuantity(inventory.getAvailableQuantity() - quantity);
        
        if (remark != null && !remark.isEmpty()) {
            String currentRemark = inventory.getRemark() != null ? inventory.getRemark() : "";
            inventory.setRemark(currentRemark + " " + remark);
        }
        
        return flowerInventoryService.updateFlowerInventory(inventory);
    }

    /**
     * 释放占用库存（取消预定或释放库存时使用）
     * 
     * @param flowerId 鲜花ID
     * @param quantity 释放数量
     * @param remark 备注
     * @return 结果
     */
    public int releaseReservedInventory(Long flowerId, Integer quantity, String remark) {
        // 查询现有库存
        List<FlowerInventory> inventoryList = flowerInventoryService.selectFlowerInventoryList(
            new FlowerInventory() {{
                setFlowerId(flowerId);
            }}
        );
        
        if (inventoryList.isEmpty()) {
            throw new RuntimeException("库存记录不存在");
        }
        
        FlowerInventory inventory = inventoryList.get(0);
        
        // 检查占用库存是否充足
        if (inventory.getReservedQuantity() < quantity) {
            throw new RuntimeException("占用库存不足，无法完成释放操作");
        }
        
        // 释放占用库存
        inventory.setReservedQuantity(inventory.getReservedQuantity() - quantity);
        inventory.setAvailableQuantity(inventory.getAvailableQuantity() + quantity);
        
        if (remark != null && !remark.isEmpty()) {
            String currentRemark = inventory.getRemark() != null ? inventory.getRemark() : "";
            inventory.setRemark(currentRemark + " " + remark);
        }
        
        return flowerInventoryService.updateFlowerInventory(inventory);
    }

    /**
     * 扣减占用库存（确认预定或销售时使用）
     * 
     * @param flowerId 鲜花ID
     * @param quantity 扣减数量
     * @param remark 备注
     * @return 结果
     */
    public int deductReservedInventory(Long flowerId, Integer quantity, String remark) {
        // 查询现有库存
        List<FlowerInventory> inventoryList = flowerInventoryService.selectFlowerInventoryList(
            new FlowerInventory() {{
                setFlowerId(flowerId);
            }}
        );
        
        if (inventoryList.isEmpty()) {
            throw new RuntimeException("库存记录不存在");
        }
        
        FlowerInventory inventory = inventoryList.get(0);
        
        // 检查占用库存是否充足
        if (inventory.getReservedQuantity() < quantity) {
            throw new RuntimeException("占用库存不足，无法完成扣减操作");
        }
        
        // 扣减占用库存和总库存
        inventory.setQuantity(inventory.getQuantity() - quantity);
        inventory.setReservedQuantity(inventory.getReservedQuantity() - quantity);
        // availableQuantity保持不变，因为这部分库存已经在占用中
        
        if (remark != null && !remark.isEmpty()) {
            String currentRemark = inventory.getRemark() != null ? inventory.getRemark() : "";
            inventory.setRemark(currentRemark + " " + remark);
        }
        
        return flowerInventoryService.updateFlowerInventory(inventory);
    }
}