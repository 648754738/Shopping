package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;

/**
 * 订单明细表 flower_order_detail
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerOrderDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 明细ID */
    private Long id;

    /** 订单ID */
    private Long orderId;

    /** 鲜花ID */
    private Long flowerId;

    /** 购买数量 */
    private Integer quantity;

    /** 单价 */
    private BigDecimal unitPrice;

    /** 总价 */
    private BigDecimal totalPrice;

    /** 备注 */
    private String remark;

    public FlowerOrderDetail() {
    }

    public FlowerOrderDetail(Long id) {
        this.id = id;
    }
}