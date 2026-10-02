package com.shop.app.domain;

import com.shop.app.common.annotation.Excel;
import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 鲜花分类表 flower_category
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerCategory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 分类ID */
    private Long id;
    /** 分类名称 */
    @Excel(name = "分类名称")
    private String categoryName;

    /** 分类描述 */
    @Excel(name = "分类描述")
    private String categoryDesc;

    /** 排序 */
    @Excel(name = "排序")
    private Long sortOrder;

    /** 状态 1-正常 0-禁用 */
    @Excel(name = "状态")
    private Integer status;

}