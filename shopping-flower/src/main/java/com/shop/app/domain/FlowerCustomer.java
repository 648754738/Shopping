package com.shop.app.domain;

import com.shop.app.common.core.domain.BaseEntity;
import lombok.Data;
import java.util.Date;

/**
 * 客户信息表 flower_customer
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Data
public class FlowerCustomer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 客户ID */
    private Long id;

    /** 客户姓名 */
    private String customerName;

    /** 联系电话 */
    private String phone;

    /** 邮箱 */
    private String email;

    /** 地址 */
    private String address;

    /** 生日 */
    private Date birthday;

    /** 性别 1-男 0-女 */
    private Integer gender;

    /** 客户偏好（JSON格式存储） */
    private String preference;

    /** 客户等级 1-普通 2-银卡 3-金卡 4-钻石 */
    private Integer level;

    /** 积分 */
    private Integer points;

    /** 状态 1-正常 0-禁用 */
    private Integer status;

    /** 备注 */
    private String remark;

    public FlowerCustomer() {
    }

    public FlowerCustomer(Long id) {
        this.id = id;
    }
}