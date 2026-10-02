package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.util.Date;

/**
 * 库存表 flower_inventory
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerInventory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 库存ID */
    private Long id;

    /** 鲜花ID */
    private Long flowerId;

    /** 库存数量 */
    private Integer quantity;

    /** 预定占用数量 */
    private Integer reservedQuantity;

    /** 可用数量 */
    private Integer availableQuantity;

    /** 预警阈值 */
    private Integer warningThreshold;

    /** 最近补货时间 */
    private Date lastRestockTime;

    /** 备注 */
    private String remark;
    
    /** 鲜花名称 */
    private String flowerName;

    public FlowerInventory() {
    }

    public FlowerInventory(Long id) {
        this.id = id;
    }
    
    /**
     * 检查是否需要库存预警
     * @return true-需要预警，false-不需要预警
     */
    public boolean needWarning() {
        if (warningThreshold == null) {
            warningThreshold = 10; // 默认阈值为10
        }
        return availableQuantity != null && availableQuantity <= warningThreshold;
    }
    
    /**
     * 检查库存是否充足
     * @param requiredQuantity 需要的数量
     * @return true-充足，false-不足
     */
    public boolean isSufficient(Integer requiredQuantity) {
        return availableQuantity != null && requiredQuantity != null && availableQuantity >= requiredQuantity;
    }
}