package com.shop.app.service;

import java.util.List;

/**
 * 推荐算法服务接口
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
public interface IFlowerRecommendationService {
    
    /**
     * 为指定客户生成个性化推荐
     * 
     * @param customerId 客户ID
     */
    void generatePersonalizedRecommendationsForCustomer(Long customerId);
    
    /**
     * 为所有客户生成并插入推荐数据
     */
    void generateAndInsertRecommendations();
}