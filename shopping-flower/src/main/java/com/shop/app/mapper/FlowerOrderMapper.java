package com.shop.app.mapper;

import com.shop.app.domain.FlowerOrder;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 订单Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerOrderMapper 
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
     * 删除订单
     * 
     * @param id 订单ID
     * @return 结果
     */
    public int deleteFlowerOrderById(Long id);

    /**
     * 批量删除订单
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerOrderByIds(Long[] ids);
    
    /**
     * 根据订单ID删除订单明细
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int deleteFlowerOrderDetailByOrderId(Long orderId);
    
    /**
     * 批量根据订单ID删除订单明细
     * 
     * @param orderIds 订单ID数组
     * @return 结果
     */
    public int deleteFlowerOrderDetailByOrderIds(Long[] orderIds);
}