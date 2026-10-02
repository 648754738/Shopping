package com.shop.app.service.impl;

import com.shop.app.domain.FlowerRecommendRecord;
import com.shop.app.domain.FlowerSalesHistory;
import com.shop.app.domain.FlowerReservation;
import com.shop.app.mapper.FlowerRecommendRecordMapper;
import com.shop.app.mapper.FlowerSalesHistoryMapper;
import com.shop.app.mapper.FlowerInfoMapper;
import com.shop.app.mapper.FlowerCustomerMapper;
import com.shop.app.mapper.FlowerReservationMapper;
import com.shop.app.service.IFlowerRecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 推荐算法服务实现类
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
@Service
public class FlowerRecommendationServiceImpl implements IFlowerRecommendationService {

    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;

    @Autowired
    private FlowerRecommendRecordMapper flowerRecommendRecordMapper;

    @Autowired
    private FlowerInfoMapper flowerInfoMapper;

    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;
    
    @Autowired
    private FlowerReservationMapper flowerReservationMapper;

    /**
     * 为所有客户生成并插入推荐数据
     */
    @Override
    public void generateAndInsertRecommendations() {
        try {
            // 1. 查询所有客户
            List<com.shop.app.domain.FlowerCustomer> allCustomers = flowerCustomerMapper.selectFlowerCustomerList(new com.shop.app.domain.FlowerCustomer());
            
            // 2. 为每个客户生成个性化推荐
            for (com.shop.app.domain.FlowerCustomer customer : allCustomers) {
                try {
                    generatePersonalizedRecommendationsForCustomer(customer.getId());
                    // 添加短暂延迟以避免数据库压力过大
                    Thread.sleep(10);
                } catch (Exception e) {
                    System.err.println("为客户生成推荐失败: 客户ID=" + customer.getId() + ", 错误=" + e.getMessage());
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("生成推荐数据失败: " + e.getMessage());
        }
    }

    /**
     * 为指定客户生成个性化推荐
     * 
     * @param customerId 客户ID
     */
    @Override
    public void generatePersonalizedRecommendationsForCustomer(Long customerId) {
        try {
            // 1. 查询指定客户的销售历史记录
            FlowerSalesHistory querySales = new FlowerSalesHistory();
            querySales.setCustomerId(customerId);
            List<FlowerSalesHistory> customerSalesHistoryList = flowerSalesHistoryMapper.selectFlowerSalesHistoryList(querySales);
            
            // 2. 查询指定客户的预定记录
            FlowerReservation queryReservation = new FlowerReservation();
            queryReservation.setCustomerId(customerId);
            List<FlowerReservation> customerReservationList = flowerReservationMapper.selectFlowerReservationList(queryReservation);
            
            // 3. 查询所有销售历史记录（用于生成相似客户推荐）
            List<FlowerSalesHistory> allSalesHistoryList = flowerSalesHistoryMapper.selectFlowerSalesHistoryList(new FlowerSalesHistory());
            
            // 4. 生成热销推荐
            Map<Long, Integer> flowerSalesCountMap = new HashMap<>();
            for (FlowerSalesHistory sales : allSalesHistoryList) {
                if (sales.getFlowerId() != null && sales.getQuantity() != null) {
                    flowerSalesCountMap.put(sales.getFlowerId(), 
                        flowerSalesCountMap.getOrDefault(sales.getFlowerId(), 0) + sales.getQuantity());
                }
            }
            
            List<Map.Entry<Long, Integer>> topSalesFlowers = flowerSalesCountMap.entrySet().stream()
                .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                .limit(10)
                .collect(Collectors.toList());
            
            // 为指定客户生成热销推荐
            generateTopSalesRecommendationsForCustomer(topSalesFlowers, customerId);
            
            // 5. 生成个性化推荐
            generatePersonalizedRecommendationsForCustomerBySales(customerSalesHistoryList, allSalesHistoryList, customerId);
            
            // 6. 基于预定记录生成推荐
            generateReservationBasedRecommendationsForCustomer(customerId, customerReservationList);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("为客户生成个性化推荐失败: 客户ID=" + customerId + ", 错误=" + e.getMessage());
        }
    }
    
    /**
     * 为指定客户生成基于预定的推荐
     */
    private void generateReservationBasedRecommendationsForCustomer(Long customerId, List<FlowerReservation> customerReservations) {
        try {
            if (customerReservations == null || customerReservations.isEmpty()) {
                return;
            }
            
            // 统计该客户预定的鲜花种类和数量
            Map<Long, Integer> customerFlowerCountMap = new HashMap<>();
            for (FlowerReservation reservation : customerReservations) {
                customerFlowerCountMap.put(reservation.getFlowerId(), 
                    customerFlowerCountMap.getOrDefault(reservation.getFlowerId(), 0) + reservation.getQuantity());
            }
            
            // 找出该客户最常预定的前3种鲜花
            List<Map.Entry<Long, Integer>> topCustomerFlowers = customerFlowerCountMap.entrySet().stream()
                .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                .limit(3)
                .collect(Collectors.toList());
            
            // 为该客户推荐相似类型的鲜花
            for (Map.Entry<Long, Integer> customerFlowerEntry : topCustomerFlowers) {
                Long favoriteFlowerId = customerFlowerEntry.getKey();
                
                // 查询所有预定记录，找出预定了相同鲜花的其他客户
                FlowerReservation queryReservation = new FlowerReservation();
                queryReservation.setFlowerId(favoriteFlowerId);
                List<FlowerReservation> similarCustomerReservations = flowerReservationMapper.selectFlowerReservationList(queryReservation);
                
                // 过滤掉当前客户自己的预定记录
                similarCustomerReservations = similarCustomerReservations.stream()
                    .filter(reservation -> !reservation.getCustomerId().equals(customerId))
                    .collect(Collectors.toList());
                
                // 统计这些相似客户还预定了哪些其他鲜花
                Map<Long, Integer> similarFlowerCountMap = new HashMap<>();
                for (FlowerReservation reservation : similarCustomerReservations) {
                    // 排除客户自己已经预定过的鲜花
                    if (!customerFlowerCountMap.containsKey(reservation.getFlowerId())) {
                        similarFlowerCountMap.put(reservation.getFlowerId(), 
                            similarFlowerCountMap.getOrDefault(reservation.getFlowerId(), 0) + reservation.getQuantity());
                    }
                }
                
                // 找出最常被相似客户预定的前3种鲜花作为推荐
                List<Map.Entry<Long, Integer>> recommendedFlowers = similarFlowerCountMap.entrySet().stream()
                    .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                    .limit(3)
                    .collect(Collectors.toList());
                
                // 插入推荐记录
                for (Map.Entry<Long, Integer> recommendEntry : recommendedFlowers) {
                    Long recommendFlowerId = recommendEntry.getKey();
                    Integer recommendCount = recommendEntry.getValue();
                    
                    // 检查是否已经存在相同的推荐记录
                    FlowerRecommendRecord queryRecord = new FlowerRecommendRecord();
                    queryRecord.setCustomerId(customerId);
                    queryRecord.setFlowerId(recommendFlowerId);
                    queryRecord.setRecommendType(2); // 偏好推荐
                    
                    List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(queryRecord);
                    
                    // 如果不存在相同的推荐记录，则插入新记录
                    if (existingRecords.isEmpty()) {
                        FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                        recommendRecord.setCustomerId(customerId);
                        recommendRecord.setFlowerId(recommendFlowerId);
                        recommendRecord.setRecommendReason("偏好推荐：预定了相似鲜花的客户也喜欢这款鲜花，预定量为" + recommendCount + "件");
                        recommendRecord.setRecommendType(2); // 偏好推荐
                        recommendRecord.setIsAccepted(0); // 默认未接受
                        recommendRecord.setRemark("基于预定行为生成的个性化推荐");
                        
                        flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("为客户生成基于预定的推荐失败: 客户ID=" + customerId + ", 错误=" + e.getMessage());
        }
    }
    
    /**
     * 为指定客户生成热销推荐
     */
    private void generateTopSalesRecommendationsForCustomer(List<Map.Entry<Long, Integer>> topSalesFlowers, Long customerId) {
        try {
            for (Map.Entry<Long, Integer> entry : topSalesFlowers) {
                Long flowerId = entry.getKey();
                Integer salesCount = entry.getValue();
                
                // 检查是否已经存在相同的推荐记录
                FlowerRecommendRecord queryRecord = new FlowerRecommendRecord();
                queryRecord.setCustomerId(customerId);
                queryRecord.setFlowerId(flowerId);
                queryRecord.setRecommendType(3); // 热销推荐
                
                List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(queryRecord);
                
                // 如果不存在相同的推荐记录，则插入新记录
                if (existingRecords.isEmpty()) {
                    FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                    recommendRecord.setCustomerId(customerId);
                    recommendRecord.setFlowerId(flowerId);
                    recommendRecord.setRecommendReason("热销推荐：该鲜花销量高达" + salesCount + "件");
                    recommendRecord.setRecommendType(3); // 热销推荐
                    recommendRecord.setIsAccepted(0); // 默认未接受
                    recommendRecord.setRemark("系统自动生成的热销推荐");
                    
                    flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("为客户生成热销推荐失败: 客户ID=" + customerId + ", 错误=" + e.getMessage());
        }
    }
    
    /**
     * 根据销售记录为指定客户生成个性化推荐
     */
    private void generatePersonalizedRecommendationsForCustomerBySales(
            List<FlowerSalesHistory> customerSalesList, 
            List<FlowerSalesHistory> allSalesHistoryList, 
            Long customerId) {
        try {
            // 统计该客户购买的鲜花种类和数量
            Map<Long, Integer> customerFlowerCountMap = new HashMap<>();
            for (FlowerSalesHistory sales : customerSalesList) {
                customerFlowerCountMap.put(sales.getFlowerId(), 
                    customerFlowerCountMap.getOrDefault(sales.getFlowerId(), 0) + sales.getQuantity());
            }
            
            // 找出该客户最常购买的前3种鲜花
            List<Map.Entry<Long, Integer>> topCustomerFlowers = customerFlowerCountMap.entrySet().stream()
                .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                .limit(3)
                .collect(Collectors.toList());
            
            // 为该客户推荐相似类型的鲜花（这里简化为推荐其他热销鲜花）
            for (Map.Entry<Long, Integer> customerFlowerEntry : topCustomerFlowers) {
                Long favoriteFlowerId = customerFlowerEntry.getKey();
                
                // 查询所有销售历史记录，找出购买了相同鲜花的其他客户
                List<FlowerSalesHistory> similarCustomerSales = allSalesHistoryList.stream()
                    .filter(sales -> sales.getFlowerId().equals(favoriteFlowerId) && !sales.getCustomerId().equals(customerId))
                    .collect(Collectors.toList());
                
                // 统计这些相似客户还购买了哪些其他鲜花
                Map<Long, Integer> similarFlowerCountMap = new HashMap<>();
                for (FlowerSalesHistory sales : similarCustomerSales) {
                    // 排除客户自己已经购买过的鲜花
                    if (!customerFlowerCountMap.containsKey(sales.getFlowerId())) {
                        similarFlowerCountMap.put(sales.getFlowerId(), 
                            similarFlowerCountMap.getOrDefault(sales.getFlowerId(), 0) + sales.getQuantity());
                    }
                }
                
                // 找出最常被相似客户购买的前3种鲜花作为推荐
                List<Map.Entry<Long, Integer>> recommendedFlowers = similarFlowerCountMap.entrySet().stream()
                    .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                    .limit(3)
                    .collect(Collectors.toList());
                
                // 插入推荐记录
                for (Map.Entry<Long, Integer> recommendEntry : recommendedFlowers) {
                    Long recommendFlowerId = recommendEntry.getKey();
                    Integer recommendCount = recommendEntry.getValue();
                    
                    // 检查是否已经存在相同的推荐记录
                    FlowerRecommendRecord queryRecord = new FlowerRecommendRecord();
                    queryRecord.setCustomerId(customerId);
                    queryRecord.setFlowerId(recommendFlowerId);
                    queryRecord.setRecommendType(2); // 偏好推荐
                    
                    List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(queryRecord);
                    
                    // 如果不存在相同的推荐记录，则插入新记录
                    if (existingRecords.isEmpty()) {
                        FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                        recommendRecord.setCustomerId(customerId);
                        recommendRecord.setFlowerId(recommendFlowerId);
                        recommendRecord.setRecommendReason("偏好推荐：购买了相似鲜花的客户也喜欢这款鲜花，购买量为" + recommendCount + "件");
                        recommendRecord.setRecommendType(2); // 偏好推荐
                        recommendRecord.setIsAccepted(0); // 默认未接受
                        recommendRecord.setRemark("系统自动生成的个性化推荐");
                        
                        flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("为客户生成个性化推荐失败: 客户ID=" + customerId + ", 错误=" + e.getMessage());
        }
    }
}