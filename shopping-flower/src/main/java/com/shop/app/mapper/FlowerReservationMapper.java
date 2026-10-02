package com.shop.app.mapper;

import com.shop.app.domain.FlowerReservation;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * 预定Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerReservationMapper 
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
     * 删除预定
     * 
     * @param id 预定ID
     * @return 结果
     */
    public int deleteFlowerReservationById(Long id);

    /**
     * 批量删除预定
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerReservationByIds(Long[] ids);
    
    /**
     * 统计近七日预定数据
     * 
     * @return 预定统计数据
     */
    public List<Map<String, Object>> selectSevenDaysReservationData();
    
    /**
     * 根据日期范围查询预定数据
     * 
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 预定数据列表
     */
    public List<FlowerReservation> selectReservationByDateRange(LocalDate startDate, LocalDate endDate);
    
    /**
     * 统计近七日预定人数
     * 
     * @return 预定人数统计数据
     */
    public List<Map<String, Object>> selectSevenDaysReservationCustomerCount();
    
    /**
     * 根据订单ID查找关联的预定
     * 
     * @param orderId 订单ID
     * @return 预定信息
     */
    public List<FlowerReservation> selectFlowerReservationByOrderId(Long orderId);
}