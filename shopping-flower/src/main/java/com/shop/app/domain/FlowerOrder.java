package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单表 flower_order
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单ID */
    private Long id;

    /** 订单编号 */
    private String orderNo;

    /** 客户ID */
    private Long customerId;

    /** 订单类型 1-普通订单 2-预定订单 */
    private Integer orderType;

    /** 订单金额 */
    private BigDecimal orderAmount;

    /** 优惠金额 */
    private BigDecimal discountAmount;

    /** 实际支付金额 */
    private BigDecimal actualAmount;

    /** 订单状态 1-待付款 2-已付款 3-已发货 4-已完成 5-已取消 */
    private Integer orderStatus;

    /** 支付方式 1-微信 2-支付宝 3-银行卡 4-现金 */
    private Integer paymentMethod;

    /** 收货人姓名 */
    private String receiverName;

    /** 收货人电话 */
    private String receiverPhone;

    /** 收货地址 */
    private String receiverAddress;

    /** 发货时间 */
    private Date deliveryTime;

    /** 收货时间 */
    private Date receiveTime;

    /** 订单二维码URL */
    private String qrCodeUrl;

    /** 备注 */
    private String remark;

    public FlowerOrder() {
    }

    public FlowerOrder(Long id) {
        this.id = id;
    }
}