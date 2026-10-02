package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 客户购买历史表 flower_customer_purchase_history
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerCustomerPurchaseHistory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 购买历史ID */
    private Long id;

    /** 客户ID */
    private Long customerId;

    /** 鲜花ID */
    private Long flowerId;

    /** 订单ID */
    private Long orderId;

    /** 购买数量 */
    private Integer quantity;

    /** 单价 */
    private BigDecimal unitPrice;

    /** 总金额 */
    private BigDecimal totalAmount;

    /** 购买日期 */
    private Date purchaseDate;

    /** 购买时间 */
    private Date purchaseTime;

    /** 分类ID */
    private Long categoryId;

    /** 是否匹配客户偏好 1-匹配 0-不匹配 */
    private Integer preferenceMatch;

    /** 备注 */
    private String remark;
}