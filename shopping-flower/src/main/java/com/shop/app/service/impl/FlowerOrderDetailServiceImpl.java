package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerOrderDetailMapper;
import com.shop.app.domain.FlowerOrderDetail;
import com.shop.app.service.IFlowerOrderDetailService;

/**
 * 订单明细Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerOrderDetailServiceImpl implements IFlowerOrderDetailService 
{
    @Autowired
    private FlowerOrderDetailMapper flowerOrderDetailMapper;

    /**
     * 查询订单明细
     * 
     * @param id 订单明细ID
     * @return 订单明细
     */
    @Override
    public FlowerOrderDetail selectFlowerOrderDetailById(Long id)
    {
        return flowerOrderDetailMapper.selectFlowerOrderDetailById(id);
    }

    /**
     * 查询订单明细列表
     * 
     * @param flowerOrderDetail 订单明细
     * @return 订单明细
     */
    @Override
    public List<FlowerOrderDetail> selectFlowerOrderDetailList(FlowerOrderDetail flowerOrderDetail)
    {
        return flowerOrderDetailMapper.selectFlowerOrderDetailList(flowerOrderDetail);
    }

    /**
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细集合
     */
    @Override
    public List<FlowerOrderDetail> selectFlowerOrderDetailListByOrderId(Long orderId)
    {
        FlowerOrderDetail orderDetail = new FlowerOrderDetail();
        orderDetail.setOrderId(orderId);
        return flowerOrderDetailMapper.selectFlowerOrderDetailList(orderDetail);
    }

    /**
     * 新增订单明细
     * 
     * @param flowerOrderDetail 订单明细
     * @return 结果
     */
    @Override
    public int insertFlowerOrderDetail(FlowerOrderDetail flowerOrderDetail)
    {
        return flowerOrderDetailMapper.insertFlowerOrderDetail(flowerOrderDetail);
    }

    /**
     * 修改订单明细
     * 
     * @param flowerOrderDetail 订单明细
     * @return 结果
     */
    @Override
    public int updateFlowerOrderDetail(FlowerOrderDetail flowerOrderDetail)
    {
        return flowerOrderDetailMapper.updateFlowerOrderDetail(flowerOrderDetail);
    }

    /**
     * 批量删除订单明细
     * 
     * @param ids 需要删除的订单明细ID
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderDetailByIds(Long[] ids)
    {
        return flowerOrderDetailMapper.deleteFlowerOrderDetailByIds(ids);
    }

    /**
     * 删除订单明细信息
     * 
     * @param id 订单明细ID
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderDetailById(Long id)
    {
        return flowerOrderDetailMapper.deleteFlowerOrderDetailById(id);
    }
    
    /**
     * 根据订单ID删除订单明细
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderDetailByOrderId(Long orderId)
    {
        return flowerOrderDetailMapper.deleteFlowerOrderDetailByOrderId(orderId);
    }
    
    /**
     * 批量根据订单ID删除订单明细
     * 
     * @param orderIds 订单ID数组
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderDetailByOrderIds(Long[] orderIds)
    {
        return flowerOrderDetailMapper.deleteFlowerOrderDetailByOrderIds(orderIds);
    }
}