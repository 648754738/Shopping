package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 预定表 flower_reservation
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerReservation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 预定ID */
    private Long id;

    /** 预定编号 */
    private String reservationNo;

    /** 客户ID */
    private Long customerId;

    /** 鲜花ID */
    private Long flowerId;

    /** 预定数量 */
    private Integer quantity;

    /** 单价 */
    private BigDecimal unitPrice;

    /** 总金额 */
    private BigDecimal totalAmount;

    /** 预定日期 */
    private Date reservationDate;

    /** 配送时间 */
    private Date deliveryTime;

    /** 预定状态 1-待确认 2-已确认 3-已完成 4-已取消 */
    private Integer reservationStatus;

    /** 联系人 */
    private String contactPerson;

    /** 联系电话 */
    private String contactPhone;

    /** 配送地址 */
    private String deliveryAddress;

    /** 预定二维码URL */
    private String qrCodeUrl;

    /** 备注 */
    private String remark;
    
    // 以下为关联信息字段，用于页面显示
    /** 客户姓名 */
    private String customerName;
    
    /** 鲜花名称 */
    private String flowerName;
    
    /** 客户电话 */
    private String customerPhone;

    public FlowerReservation() {
    }

    public FlowerReservation(Long id) {
        this.id = id;
    }
}