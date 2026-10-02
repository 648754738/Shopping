package com.shop.app.mapper;

import java.util.List;
import com.shop.app.domain.FlowerOrderDetail;
import org.springframework.stereotype.Repository;

/**
 * 订单明细Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerOrderDetailMapper 
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
     * 删除订单明细
     * 
     * @param id 订单明细ID
     * @return 结果
     */
    public int deleteFlowerOrderDetailById(Long id);

    /**
     * 批量删除订单明细
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerOrderDetailByIds(Long[] ids);
    
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