package com.shop.app.dto;

import com.shop.app.domain.FlowerCustomer;
import com.shop.app.domain.FlowerInfo;
import lombok.Data;

import java.util.List;

/**
 * 预定初始化数据DTO
 * 用于前端下拉列表数据初始化
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
@Data
public class ReservationInitDataDTO {
    
    /**
     * 客户列表
     */
    private List<FlowerCustomer> customerList;
    
    /**
     * 鲜花列表
     */
    private List<FlowerInfo> flowerList;
    
    /**
     * 预定状态选项
     */
    private List<DictItem> reservationStatusOptions;
    
    /**
     * 支付方式选项
     */
    private List<DictItem> paymentMethodOptions;
    
    @Data
    public static class DictItem {
        private Integer value;
        private String label;
        
        public DictItem() {}
        
        public DictItem(Integer value, String label) {
            this.value = value;
            this.label = label;
        }
    }
}