package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.util.Date;

/**
 * 推荐记录表 flower_recommend_record
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerRecommendRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 推荐记录ID */
    private Long id;

    /** 客户ID */
    private Long customerId;

    /** 鲜花ID */
    private Long flowerId;

    /** 推荐理由 */
    private String recommendReason;

    /** 推荐类型 1-节日推荐 2-偏好推荐 3-热销推荐 4-新品推荐 5-搭配推荐 */
    private Integer recommendType;

    /** 是否接受 1-接受 0-拒绝 */
    private Integer isAccepted;

    /** 接受时间 */
    private Date acceptanceTime;

    /** 备注 */
    private String remark;

    public FlowerRecommendRecord() {
    }

    public FlowerRecommendRecord(Long id) {
        this.id = id;
    }
}