package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 销售历史记录表 flower_sales_history
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerSalesHistory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 销售历史ID */
    private Long id;

    /** 订单ID */
    private Long orderId;

    /** 鲜花ID */
    private Long flowerId;

    /** 客户ID */
    private Long customerId;

    /** 销售数量 */
    private Integer quantity;

    /** 单价 */
    private BigDecimal unitPrice;

    /** 总金额 */
    private BigDecimal totalAmount;

    /** 销售日期 */
    private Date saleDate;

    /** 销售时间 */
    private Date saleTime;

    /** 支付方式 1-微信 2-支付宝 3-银行卡 4-现金 */
    private Integer paymentMethod;

    /** 销售人员 */
    private String salesperson;

    /** 备注 */
    private String remark;

    public FlowerSalesHistory() {
    }

    public FlowerSalesHistory(Long id) {
        this.id = id;
    }
}