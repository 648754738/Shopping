package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerOrder;

/**
 * 订单Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerOrderService 
{
    /**
     * 查询订单
     * 
     * @param id 订单ID
     * @return 订单
     */
    public FlowerOrder selectFlowerOrderById(Long id);

    /**
     * 查询订单列表
     * 
     * @param flowerOrder 订单
     * @return 订单集合
     */
    public List<FlowerOrder> selectFlowerOrderList(FlowerOrder flowerOrder);

    /**
     * 新增订单
     * 
     * @param flowerOrder 订单
     * @return 结果
     */
    public int insertFlowerOrder(FlowerOrder flowerOrder);

    /**
     * 修改订单
     * 
     * @param flowerOrder 订单
     * @return 结果
     */
    public int updateFlowerOrder(FlowerOrder flowerOrder);

    /**
     * 批量删除订单
     * 
     * @param ids 需要删除的订单ID
     * @return 结果
     */
    public int deleteFlowerOrderByIds(Long[] ids);

    /**
     * 删除订单信息
     * 
     * @param id 订单ID
     * @return 结果
     */
    public int deleteFlowerOrderById(Long id);
}