package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerReservation;

/**
 * 预定Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerReservationService 
{
    /**
     * 查询预定
     * 
     * @param id 预定ID
     * @return 预定
     */
    public FlowerReservation selectFlowerReservationById(Long id);

    /**
     * 查询预定列表
     * 
     * @param flowerReservation 预定
     * @return 预定集合
     */
    public List<FlowerReservation> selectFlowerReservationList(FlowerReservation flowerReservation);

    /**
     * 新增预定
     * 
     * @param flowerReservation 预定
     * @return 结果
     */
    public int insertFlowerReservation(FlowerReservation flowerReservation);

    /**
     * 修改预定
     * 
     * @param flowerReservation 预定
     * @return 结果
     */
    public int updateFlowerReservation(FlowerReservation flowerReservation);

    /**
     * 批量删除预定
     * 
     * @param ids 需要删除的预定ID
     * @return 结果
     */
    public int deleteFlowerReservationByIds(Long[] ids);

    /**
     * 删除预定信息
     * 
     * @param id 预定ID
     * @return 结果
     */
    public int deleteFlowerReservationById(Long id);
    
    /**
     * 根据订单ID查找关联的预定
     * 
     * @param orderId 订单ID
     * @return 预定列表
     */
    public List<FlowerReservation> selectFlowerReservationByOrderId(Long orderId);
}