package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerOrderDetail;

/**
 * 订单明细Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerOrderDetailService 
{
    /**
     * 查询订单明细
     * 
     * @param id 订单明细ID
     * @return 订单明细
     */
    public FlowerOrderDetail selectFlowerOrderDetailById(Long id);

    /**
     * 查询订单明细列表
     * 
     * @param flowerOrderDetail 订单明细
     * @return 订单明细集合
     */
    public List<FlowerOrderDetail> selectFlowerOrderDetailList(FlowerOrderDetail flowerOrderDetail);

    /**
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细集合
     */
    public List<FlowerOrderDetail> selectFlowerOrderDetailListByOrderId(Long orderId);

    /**
     * 新增订单明细
     * 
     * @param flowerOrderDetail 订单明细
     * @return 结果
     */
    public int insertFlowerOrderDetail(FlowerOrderDetail flowerOrderDetail);

    /**
     * 修改订单明细
     * 
     * @param flowerOrderDetail 订单明细
     * @return 结果
     */
    public int updateFlowerOrderDetail(FlowerOrderDetail flowerOrderDetail);

    /**
     * 批量删除订单明细
     * 
     * @param ids 需要删除的订单明细ID
     * @return 结果
     */
    public int deleteFlowerOrderDetailByIds(Long[] ids);

    /**
     * 删除订单明细信息
     * 
     * @param id 订单明细ID
     * @return 结果
     */
    public int deleteFlowerOrderDetailById(Long id);
    
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