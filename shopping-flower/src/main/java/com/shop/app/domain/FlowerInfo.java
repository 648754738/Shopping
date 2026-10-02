package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.math.BigDecimal;

/**
 * 鲜花信息表 flower_info
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 鲜花ID */
    private Long id;

    /** 鲜花名称 */
    private String flowerName;

    /** 分类ID */
    private Long categoryId;

    /** 分类名称 */
    private String categoryName;

    /** 鲜花描述 */
    private String flowerDesc;

    /** 价格 */
    private BigDecimal price;

    /** 市场价 */
    private BigDecimal marketPrice;

    /** 成本价 */
    private BigDecimal costPrice;

    /** 图片URL列表(JSON格式) */
    private String imageUrls;

    /** 二维码URL */
    private String qrCodeUrl;

    /** 库存数量 */
    private Integer stock;

    /** 销售数量 */
    private Integer salesCount;

    /** 状态 1-上架 0-下架 */
    private Integer status;

    /** 备注 */
    private String remark;

    /** 用于接收单个图片地址 */
    private transient String imageUrl;

    public FlowerInfo() {
    }

    public FlowerInfo(Long id) {
        this.id = id;
    }
    
    // 用于接收上传的图片文件
    private transient MultipartFile[] imageFiles;
    
    // 用于接收二维码内容
    private transient String qrCodeContent;
}