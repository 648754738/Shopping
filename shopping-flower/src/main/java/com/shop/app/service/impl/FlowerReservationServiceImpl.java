package com.shop.app.service.impl;

import com.shop.app.domain.FlowerReservation;
import com.shop.app.mapper.FlowerReservationMapper;
import com.shop.app.service.IFlowerReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * 预定Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerReservationServiceImpl implements IFlowerReservationService 
{
    @Autowired
    private FlowerReservationMapper flowerReservationMapper;

    /**
     * 查询预定
     * 
     * @param id 预定ID
     * @return 预定
     */
    @Override
    public FlowerReservation selectFlowerReservationById(Long id)
    {
        return flowerReservationMapper.selectFlowerReservationById(id);
    }

    /**
     * 查询预定列表
     * 
     * @param flowerReservation 预定
     * @return 预定
     */
    @Override
    public List<FlowerReservation> selectFlowerReservationList(FlowerReservation flowerReservation)
    {
        return flowerReservationMapper.selectFlowerReservationList(flowerReservation);
    }

    /**
     * 新增预定
     * 
     * @param flowerReservation 预定
     * @return 结果
     */
    @Override
    public int insertFlowerReservation(FlowerReservation flowerReservation)
    {
        // 自动计算总金额
        if (flowerReservation.getUnitPrice() != null && flowerReservation.getQuantity() != null) {
            BigDecimal totalAmount = flowerReservation.getUnitPrice().multiply(new BigDecimal(flowerReservation.getQuantity()));
            flowerReservation.setTotalAmount(totalAmount);
        }
        return flowerReservationMapper.insertFlowerReservation(flowerReservation);
    }

    /**
     * 修改预定
     * 
     * @param flowerReservation 预定
     * @return 结果
     */
    @Override
    public int updateFlowerReservation(FlowerReservation flowerReservation)
    {
        // 自动计算总金额
        if (flowerReservation.getUnitPrice() != null && flowerReservation.getQuantity() != null) {
            BigDecimal totalAmount = flowerReservation.getUnitPrice().multiply(new BigDecimal(flowerReservation.getQuantity()));
            flowerReservation.setTotalAmount(totalAmount);
        }
        return flowerReservationMapper.updateFlowerReservation(flowerReservation);
    }

    /**
     * 批量删除预定
     * 
     * @param ids 需要删除的预定ID
     * @return 结果
     */
    @Override
    public int deleteFlowerReservationByIds(Long[] ids)
    {
        return flowerReservationMapper.deleteFlowerReservationByIds(ids);
    }

    /**
     * 删除预定信息
     * 
     * @param id 预定ID
     * @return 结果
     */
    @Override
    public int deleteFlowerReservationById(Long id)
    {
        return flowerReservationMapper.deleteFlowerReservationById(id);
    }
    
    /**
     * 根据订单ID查找关联的预定
     * 
     * @param orderId 订单ID
     * @return 预定列表
     */
    @Override
    public List<FlowerReservation> selectFlowerReservationByOrderId(Long orderId) {
        return flowerReservationMapper.selectFlowerReservationByOrderId(orderId);
    }
}