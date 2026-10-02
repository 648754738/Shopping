package com.shop.app.service.impl;

import com.shop.app.domain.*;
import com.shop.app.mapper.*;
import com.shop.app.service.IFlowerOrderService;
import com.shop.app.utils.FlowerReservationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单业务逻辑处理
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
@Service
public class FlowerOrderBusinessServiceImpl {
    
    @Autowired
    private IFlowerOrderService flowerOrderService;
    
    @Autowired
    private FlowerOrderMapper flowerOrderMapper;
    
    @Autowired
    private FlowerOrderDetailMapper flowerOrderDetailMapper;
    
    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;
    
    @Autowired
    private FlowerInfoMapper flowerInfoMapper;
    
    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;
    
    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;
    
    @Autowired
    private FlowerRecommendRecordMapper flowerRecommendRecordMapper;
    
    @Autowired
    private FlowerInventoryMapper flowerInventoryMapper;
    
    @Autowired
    private FlowerReservationMapper flowerReservationMapper;
    
    @Autowired
    private FlowerRecommendationServiceImpl flowerRecommendationService;

    /**
     * 处理订单支付成功后的业务逻辑
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Transactional
    public int handleOrderPaymentSuccess(Long orderId) {
        try {
            // 1. 查询订单信息
            FlowerOrder order = flowerOrderMapper.selectFlowerOrderById(orderId);
            if (order == null) {
                throw new RuntimeException("订单信息不存在");
            }
            
            // 2. 更新订单状态为已付款
            if (order.getOrderStatus() != 1) {
                throw new RuntimeException("只有待付款的订单才能进行支付成功处理");
            }
            
            order.setOrderStatus(2); // 已付款
            flowerOrderService.updateFlowerOrder(order);
            
            // 3. 查询订单明细
            FlowerOrderDetail orderDetail = new FlowerOrderDetail();
            orderDetail.setOrderId(orderId);
            List<FlowerOrderDetail> orderDetails = flowerOrderDetailMapper.selectFlowerOrderDetailList(orderDetail);
            
            // 4. 处理每个订单明细项
            for (FlowerOrderDetail detail : orderDetails) {
                // 5. 记录销售历史
                FlowerSalesHistory salesHistory = new FlowerSalesHistory();
                salesHistory.setOrderId(order.getId());
                salesHistory.setFlowerId(detail.getFlowerId());
                salesHistory.setCustomerId(order.getCustomerId());
                salesHistory.setQuantity(detail.getQuantity());
                salesHistory.setUnitPrice(detail.getUnitPrice());
                salesHistory.setTotalAmount(detail.getTotalPrice());
                salesHistory.setSaleDate(new Date());
                salesHistory.setSaleTime(new Date());
                salesHistory.setPaymentMethod(order.getPaymentMethod());
                salesHistory.setSalesperson("系统自动");
                
                flowerSalesHistoryMapper.insertFlowerSalesHistory(salesHistory);
                
                // 6. 更新鲜花销售数量
                updateFlowerSalesCount(detail.getFlowerId(), detail.getQuantity());
                
                // 7. 记录客户购买历史
                FlowerCustomerPurchaseHistory purchaseHistory = new FlowerCustomerPurchaseHistory();
                purchaseHistory.setCustomerId(order.getCustomerId());
                purchaseHistory.setFlowerId(detail.getFlowerId());
                purchaseHistory.setOrderId(order.getId());
                purchaseHistory.setQuantity(detail.getQuantity());
                purchaseHistory.setUnitPrice(detail.getUnitPrice());
                purchaseHistory.setTotalAmount(detail.getTotalPrice());
                purchaseHistory.setPurchaseDate(new Date());
                purchaseHistory.setPurchaseTime(new Date());
                
                // categoryId需要从flower_info中获取
                FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(detail.getFlowerId());
                if (flowerInfo != null) {
                    purchaseHistory.setCategoryId(flowerInfo.getCategoryId());
                }
                purchaseHistory.setPreferenceMatch(1); // 默认匹配
                
                flowerCustomerPurchaseHistoryMapper.insertFlowerCustomerPurchaseHistory(purchaseHistory);
                
                // 8. 检查是否需要生成推荐记录
                checkAndGenerateRecommendRecord(detail.getFlowerId(), order.getCustomerId());
                
                // 8.1 调用推荐算法生成推荐记录
                try {
                    flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(order.getCustomerId());
                } catch (Exception e) {
                    // 如果推荐算法调用失败，记录日志但不中断流程
                    e.printStackTrace();
                }
            }
            
            // 9. 更新关联的预定状态（如果是预定订单）
            if (order.getOrderType() != null && order.getOrderType() == 2) {
                updateRelatedReservationStatus(orderId);
            }
            
            // 10. 调用推荐算法为客户生成个性化推荐
            try {
                flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(order.getCustomerId());
            } catch (Exception e) {
                // 如果推荐算法调用失败，记录日志但不中断流程
                e.printStackTrace();
            }
            
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("处理订单支付成功失败：" + e.getMessage());
        }
    }
    
    /**
     * 处理订单完成后的业务逻辑
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Transactional
    public int handleOrderCompletion(Long orderId) {
        try {
            // 1. 查询订单信息
            FlowerOrder order = flowerOrderMapper.selectFlowerOrderById(orderId);
            if (order == null) {
                throw new RuntimeException("订单信息不存在");
            }
            
            // 2. 更新订单状态为已完成
            order.setOrderStatus(4); // 已完成
            flowerOrderService.updateFlowerOrder(order);
            
            // 3. 查询订单明细
            FlowerOrderDetail orderDetail = new FlowerOrderDetail();
            orderDetail.setOrderId(orderId);
            List<FlowerOrderDetail> orderDetails = flowerOrderDetailMapper.selectFlowerOrderDetailList(orderDetail);
            
            // 4. 处理每个订单明细项
            for (FlowerOrderDetail detail : orderDetails) {
                // 5. 插入推荐记录
                insertRecommendRecordForOrder(order, detail);
            }
            
            // 6. 调用推荐算法为客户生成个性化推荐
            try {
                flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(order.getCustomerId());
            } catch (Exception e) {
                // 如果推荐算法调用失败，记录日志但不中断流程
                System.err.println("调用推荐算法失败: " + e.getMessage());
                e.printStackTrace();
            }
            
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("处理订单完成失败：" + e.getMessage());
        }
    }
    
    /**
     * 为订单插入推荐记录
     * 
     * @param order 订单信息
     * @param detail 订单明细
     */
    private void insertRecommendRecordForOrder(FlowerOrder order, FlowerOrderDetail detail) {
        try {
            // 查询鲜花信息
            FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(detail.getFlowerId());
            if (flowerInfo != null) {
                // 检查是否已经存在相同的推荐记录（避免重复插入）
                FlowerRecommendRecord recordCheck = new FlowerRecommendRecord();
                recordCheck.setCustomerId(order.getCustomerId());
                recordCheck.setFlowerId(detail.getFlowerId());
                recordCheck.setRecommendType(1); // 购买推荐
                List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(recordCheck);
                
                // 如果不存在相同的推荐记录，则生成新的推荐记录
                if (existingRecords == null || existingRecords.isEmpty()) {
                    // 创建推荐记录
                    FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                    recommendRecord.setCustomerId(order.getCustomerId());
                    recommendRecord.setFlowerId(detail.getFlowerId());
                    recommendRecord.setRecommendReason("购买推荐：客户" + order.getCustomerId() + "购买了" + flowerInfo.getFlowerName());
                    recommendRecord.setRecommendType(1); // 购买推荐
                    recommendRecord.setIsAccepted(0); // 默认未接受
                    recommendRecord.setRemark("基于购买行为生成的推荐");
                    
                    // 插入推荐记录
                    flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                }
            }
        } catch (Exception e) {
            // 如果插入推荐记录失败，记录日志但不中断流程
            System.err.println("插入推荐记录失败: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * 更新关联的预定状态
     * 
     * @param orderId 订单ID
     */
    private void updateRelatedReservationStatus(Long orderId) {
        try {
            // 通过订单ID直接查找关联的预定记录
            List<FlowerReservation> reservations = flowerReservationMapper.selectFlowerReservationByOrderId(orderId);
            
            // 更新所有关联的预定记录状态为已完成
            for (FlowerReservation reservation : reservations) {
                // 更新预定状态为已完成
                reservation.setReservationStatus(3);
                flowerReservationMapper.updateFlowerReservation(reservation);
            }
        } catch (Exception e) {
            // 如果更新预定状态失败，记录日志但不中断流程
            e.printStackTrace();
        }
    }
    
    /**
     * 更新鲜花销售数量
     * 
     * @param flowerId 鲜花ID
     * @param quantity 销售数量
     */
    private void updateFlowerSalesCount(Long flowerId, Integer quantity) {
        try {
            // 查询鲜花信息
            FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(flowerId);
            if (flowerInfo != null) {
                // 更新销售数量
                int currentSalesCount = flowerInfo.getSalesCount() != null ? flowerInfo.getSalesCount() : 0;
                flowerInfo.setSalesCount(currentSalesCount + quantity);
                flowerInfoMapper.updateFlowerInfo(flowerInfo);
            }
        } catch (Exception e) {
            // 如果更新销售数量失败，记录日志但不中断流程
            e.printStackTrace();
        }
    }
    
    /**
     * 检查并生成推荐记录
     * 
     * @param flowerId 鲜花ID
     * @param customerId 客户ID
     */
    private void checkAndGenerateRecommendRecord(Long flowerId, Long customerId) {
        try {
            // 查询该鲜花的信息
            FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(flowerId);
            if (flowerInfo != null) {
                // 检查销售数量是否超过阈值（例如100）
                if (flowerInfo.getSalesCount() != null && flowerInfo.getSalesCount() > 100) {
                    // 检查是否已经存在相同的推荐记录
                    FlowerRecommendRecord recordCheck = new FlowerRecommendRecord();
                    recordCheck.setFlowerId(flowerId);
                    recordCheck.setCustomerId(customerId);
                    List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(recordCheck);
                    
                    // 如果不存在相同的推荐记录，则生成新的推荐记录
                    if (existingRecords == null || existingRecords.isEmpty()) {
                        FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                        recommendRecord.setCustomerId(customerId);
                        recommendRecord.setFlowerId(flowerId);
                        recommendRecord.setRecommendReason("热销推荐：该花品种销售火爆，已售出" + flowerInfo.getSalesCount() + "件");
                        recommendRecord.setRecommendType(3); // 热销推荐
                        recommendRecord.setIsAccepted(1); // 默认接受
                        recommendRecord.setAcceptanceTime(new Date());
                        
                        flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                    }
                }
                
                // 检查库存是否充足，如果库存较少但销售不错，也可以生成推荐（库存紧张推荐）
                FlowerInventory inventory = new FlowerInventory();
                inventory.setFlowerId(flowerId);
                List<FlowerInventory> inventoryList = flowerInventoryMapper.selectFlowerInventoryList(inventory);
                if (!inventoryList.isEmpty()) {
                    FlowerInventory flowerInventory = inventoryList.get(0);
                    // 如果库存较少（少于20）但销售数量不错（超过50），生成推荐
                    if (flowerInventory.getAvailableQuantity() != null && 
                        flowerInventory.getAvailableQuantity() < 20 && 
                        flowerInfo.getSalesCount() != null && 
                        flowerInfo.getSalesCount() > 50) {
                        
                        // 检查是否已经存在相同的推荐记录
                        FlowerRecommendRecord recordCheck = new FlowerRecommendRecord();
                        recordCheck.setFlowerId(flowerId);
                        recordCheck.setCustomerId(customerId);
                        List<FlowerRecommendRecord> existingRecords = flowerRecommendRecordMapper.selectFlowerRecommendRecordList(recordCheck);
                        
                        // 检查是否存在热销推荐类型的记录
                        boolean hasHotSaleRecommend = false;
                        if (existingRecords != null) {
                            for (FlowerRecommendRecord record : existingRecords) {
                                if (record.getRecommendType() != null && record.getRecommendType() == 3) {
                                    hasHotSaleRecommend = true;
                                    break;
                                }
                            }
                        }
                        
                        // 如果不存在相同的推荐记录，则生成新的推荐记录
                        if (!hasHotSaleRecommend) {
                            FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                            recommendRecord.setCustomerId(customerId);
                            recommendRecord.setFlowerId(flowerId);
                            recommendRecord.setRecommendReason("库存紧张推荐：该花品种库存较少（剩余" + flowerInventory.getAvailableQuantity() + "件），但销售不错");
                            recommendRecord.setRecommendType(3); // 热销推荐
                            recommendRecord.setIsAccepted(1); // 默认接受
                            recommendRecord.setAcceptanceTime(new Date());
                            
                            flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
                        }
                    }
                }
            }
        } catch (Exception e) {
            // 如果生成推荐记录失败，记录日志但不中断流程
            e.printStackTrace();
        }
    }
}