package com.shop.app.service.impl;

import com.shop.app.domain.*;
import com.shop.app.mapper.*;
import com.shop.app.service.IFlowerInventoryService;
import com.shop.app.service.IFlowerReservationService;
import com.shop.app.utils.FlowerReservationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 鲜花预定业务逻辑处理
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
@Service
public class FlowerReservationBusinessServiceImpl {
    
    @Autowired
    private IFlowerReservationService flowerReservationService;
    
    @Autowired
    private IFlowerInventoryService flowerInventoryService;
    
    @Autowired
    private FlowerInventoryBusinessServiceImpl flowerInventoryBusinessService;
    
    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;
    
    @Autowired
    private FlowerInfoMapper flowerInfoMapper;
    
    @Autowired
    private FlowerOrderMapper flowerOrderMapper;
    
    @Autowired
    private FlowerOrderDetailMapper flowerOrderDetailMapper;
    
    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;
    
    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;
    
    @Autowired
    private FlowerRecommendRecordMapper flowerRecommendRecordMapper;
    
    @Autowired
    private FlowerInventoryMapper flowerInventoryMapper;
    
    @Autowired
    private FlowerRecommendationServiceImpl flowerRecommendationService;

    /**
     * 根据客户等级获取折扣率
     * 
     * @param customerLevel 客户等级 1-普通 2-银卡 3-金卡 4-钻石
     * @return 折扣率
     */
    private BigDecimal getDiscountRateByLevel(Integer customerLevel) {
        if (customerLevel == null) {
            return BigDecimal.ONE; // 无折扣
        }
        
        switch (customerLevel) {
            case 2: // 银卡
                return new BigDecimal("0.95"); // 95折
            case 3: // 金卡
                return new BigDecimal("0.90"); // 9折
            case 4: // 钻石
                return new BigDecimal("0.85"); // 85折
            default: // 普通客户
                return BigDecimal.ONE; // 无折扣
        }
    }

    /**
     * 查询预定列表（包含客户和鲜花信息）
     * 
     * @param flowerReservation 预定查询条件
     * @return 预定列表
     */
    public List<FlowerReservation> selectFlowerReservationListWithDetails(FlowerReservation flowerReservation) {
        // 先查询基础预定信息
        List<FlowerReservation> reservations = flowerReservationService.selectFlowerReservationList(flowerReservation);
        
        // 补充关联信息
        for (FlowerReservation reservation : reservations) {
            // 补充客户信息
            if (reservation.getCustomerId() != null) {
                FlowerCustomer customer = flowerCustomerMapper.selectFlowerCustomerById(reservation.getCustomerId());
                if (customer != null) {
                    // 可以设置客户姓名等信息到预定对象中（需要在FlowerReservation中添加相应字段）
                }
            }
            
            // 补充鲜花信息
            if (reservation.getFlowerId() != null) {
                FlowerInfo flower = flowerInfoMapper.selectFlowerInfoById(reservation.getFlowerId());
                if (flower != null) {
                    // 可以设置鲜花名称等信息到预定对象中（需要在FlowerReservation中添加相应字段）
                }
            }
        }
        
        return reservations;
    }

    /**
     * 新增预定（包含库存检查和占用）
     * 
     * @param flowerReservation 预定信息
     * @return 结果
     */
    @Transactional
    public int insertFlowerReservationWithInventory(FlowerReservation flowerReservation) {
        try {
            // 1. 查询客户信息以获取客户等级
            FlowerCustomer customer = null;
            if (flowerReservation.getCustomerId() != null) {
                customer = flowerCustomerMapper.selectFlowerCustomerById(flowerReservation.getCustomerId());
            }
            
            // 2. 查询鲜花信息以获取价格
            FlowerInfo flowerInfo = null;
            if (flowerReservation.getFlowerId() != null) {
                flowerInfo = flowerInfoMapper.selectFlowerInfoById(flowerReservation.getFlowerId());
            }
            
            // 3. 自动计算单价和总金额
            if (flowerInfo != null && flowerInfo.getPrice() != null) {
                // 获取基础单价
                BigDecimal unitPrice = flowerInfo.getPrice();
                
                // 根据客户等级计算折扣后的单价
                BigDecimal discountRate = customer != null ? getDiscountRateByLevel(customer.getLevel()) : BigDecimal.ONE;
                unitPrice = unitPrice.multiply(discountRate).setScale(2, BigDecimal.ROUND_HALF_UP);
                
                // 设置单价
                flowerReservation.setUnitPrice(unitPrice);
                
                // 计算总金额
                if (flowerReservation.getQuantity() != null) {
                    BigDecimal totalAmount = unitPrice.multiply(new BigDecimal(flowerReservation.getQuantity())).setScale(2, BigDecimal.ROUND_HALF_UP);
                    flowerReservation.setTotalAmount(totalAmount);
                }
            }
            
            // 4. 占用库存
            flowerInventoryBusinessService.reserveInventory(
                flowerReservation.getFlowerId(), 
                flowerReservation.getQuantity(), 
                "预定占用库存，预定ID：" + flowerReservation.getId()
            );
            
            // 5. 生成预定编号
            if (flowerReservation.getReservationNo() == null || flowerReservation.getReservationNo().isEmpty()) {
                flowerReservation.setReservationNo(FlowerReservationUtils.generateReservationNo());
            }
            
            // 6. 设置预定状态为待确认
            flowerReservation.setReservationStatus(1);
            
            // 7. 设置预定日期为当前日期
            if (flowerReservation.getReservationDate() == null) {
                flowerReservation.setReservationDate(new Date());
            }
            
            // 8. 保存预定信息
            int result = flowerReservationService.insertFlowerReservation(flowerReservation);
            
            // 9. 预定成功后立即生成订单
            if (result > 0) {
                generateOrderFromReservation(flowerReservation);
                
                // 10. 预定成功后插入推荐记录
                insertRecommendRecordForReservation(flowerReservation, customer, flowerInfo);
                
                // 11. 调用推荐算法生成个性化推荐
                if (customer != null) {
                    try {
                        flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(customer.getId());
                    } catch (Exception e) {
                        // 如果推荐算法调用失败，记录日志但不中断流程
                        System.err.println("调用推荐算法失败: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
            }
            
            return result;
        } catch (Exception e) {
            // 如果占用库存失败，抛出异常
            throw new RuntimeException("预定失败：" + e.getMessage());
        }
    }

    /**
     * 根据预定信息生成订单
     * 
     * @param reservation 预定信息
     */
    private void generateOrderFromReservation(FlowerReservation reservation) {
        try {
            // 生成订单
            FlowerOrder order = new FlowerOrder();
            order.setOrderNo(FlowerReservationUtils.generateOrderNo());
            order.setCustomerId(reservation.getCustomerId());
            order.setOrderType(2); // 预定订单
            order.setOrderAmount(reservation.getTotalAmount());
            order.setDiscountAmount(BigDecimal.ZERO);
            order.setActualAmount(reservation.getTotalAmount());
            order.setOrderStatus(1); // 待付款状态
            order.setPaymentMethod(1); // 默认微信支付
            order.setReceiverName(reservation.getContactPerson());
            order.setReceiverPhone(reservation.getContactPhone());
            order.setReceiverAddress(reservation.getDeliveryAddress());
            order.setDeliveryTime(reservation.getDeliveryTime());
            
            int result = flowerOrderMapper.insertFlowerOrder(order);
            if (result <= 0) {
                throw new RuntimeException("生成订单失败");
            }
            
            // 生成订单明细
            FlowerOrderDetail orderDetail = new FlowerOrderDetail();
            orderDetail.setOrderId(order.getId());
            orderDetail.setFlowerId(reservation.getFlowerId());
            orderDetail.setQuantity(reservation.getQuantity());
            orderDetail.setUnitPrice(reservation.getUnitPrice());
            orderDetail.setTotalPrice(reservation.getTotalAmount());
            
            result = flowerOrderDetailMapper.insertFlowerOrderDetail(orderDetail);
            if (result <= 0) {
                throw new RuntimeException("生成订单明细失败");
            }
            
            // 更新预定信息，关联订单ID
            reservation.setRemark("关联订单ID：" + order.getId());
            flowerReservationService.updateFlowerReservation(reservation);
        } catch (Exception e) {
            // 如果生成订单失败，记录日志但不中断预定流程
            e.printStackTrace();
        }
    }

    /**
     * 为预定插入推荐记录
     * 
     * @param reservation 预定信息
     * @param customer 客户信息
     * @param flowerInfo 鲜花信息
     */
    private void insertRecommendRecordForReservation(FlowerReservation reservation, FlowerCustomer customer, FlowerInfo flowerInfo) {
        try {
            if (reservation != null && customer != null && flowerInfo != null) {
                // 创建推荐记录
                FlowerRecommendRecord recommendRecord = new FlowerRecommendRecord();
                recommendRecord.setCustomerId(customer.getId());
                recommendRecord.setFlowerId(flowerInfo.getId());
                recommendRecord.setRecommendReason("预定推荐：客户" + customer.getCustomerName() + "预定了" + flowerInfo.getFlowerName());
                recommendRecord.setRecommendType(2); // 偏好推荐
                recommendRecord.setIsAccepted(0); // 默认未接受
                recommendRecord.setRemark("基于预定行为生成的推荐");
                
                // 插入推荐记录
                flowerRecommendRecordMapper.insertFlowerRecommendRecord(recommendRecord);
            }
        } catch (Exception e) {
            // 如果插入推荐记录失败，记录日志但不中断流程
            System.err.println("插入推荐记录失败: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 确认预定（更新订单状态并扣减库存）
     * 
     * @param reservationId 预定ID
     * @return 结果
     */
    @Transactional
    public int confirmReservation(Long reservationId) {
        // 1. 查询预定信息
        FlowerReservation reservation = flowerReservationService.selectFlowerReservationById(reservationId);
        if (reservation == null) {
            throw new RuntimeException("预定信息不存在");
        }
        
        if (reservation.getReservationStatus() != 1) {
            throw new RuntimeException("只有待确认的预定才能进行确认操作");
        }
        
        try {
            // 2. 扣减占用库存
            flowerInventoryBusinessService.deductReservedInventory(
                reservation.getFlowerId(), 
                reservation.getQuantity(), 
                "确认预定扣减库存，预定ID：" + reservationId
            );
            
            // 3. 更新关联订单状态为已付款
            updateOrderStatusFromReservation(reservation);
            
            // 4. 更新预定状态为已确认
            reservation.setReservationStatus(2);
            flowerReservationService.updateFlowerReservation(reservation);
            
            // 5. 记录销售历史
            FlowerSalesHistory salesHistory = new FlowerSalesHistory();
            salesHistory.setOrderId(getOrderIdFromReservation(reservation)); // 从预定信息中获取订单ID
            salesHistory.setFlowerId(reservation.getFlowerId());
            salesHistory.setCustomerId(reservation.getCustomerId());
            salesHistory.setQuantity(reservation.getQuantity());
            salesHistory.setUnitPrice(reservation.getUnitPrice());
            salesHistory.setTotalAmount(reservation.getTotalAmount());
            salesHistory.setSaleDate(new Date());
            salesHistory.setSaleTime(new Date());
            salesHistory.setPaymentMethod(1);
            salesHistory.setSalesperson("系统自动");
            
            flowerSalesHistoryMapper.insertFlowerSalesHistory(salesHistory);
            
            // 6. 更新鲜花销售数量
            updateFlowerSalesCount(reservation.getFlowerId(), reservation.getQuantity());
            
            // 7. 记录客户购买历史
            FlowerCustomerPurchaseHistory purchaseHistory = new FlowerCustomerPurchaseHistory();
            purchaseHistory.setCustomerId(reservation.getCustomerId());
            purchaseHistory.setFlowerId(reservation.getFlowerId());
            purchaseHistory.setOrderId(getOrderIdFromReservation(reservation)); // 从预定信息中获取订单ID
            purchaseHistory.setQuantity(reservation.getQuantity());
            purchaseHistory.setUnitPrice(reservation.getUnitPrice());
            purchaseHistory.setTotalAmount(reservation.getTotalAmount());
            purchaseHistory.setPurchaseDate(new Date());
            purchaseHistory.setPurchaseTime(new Date());
            // categoryId需要从flower_info中获取
            FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(reservation.getFlowerId());
            if (flowerInfo != null) {
                purchaseHistory.setCategoryId(flowerInfo.getCategoryId());
            }
            purchaseHistory.setPreferenceMatch(1); // 默认匹配
            
            flowerCustomerPurchaseHistoryMapper.insertFlowerCustomerPurchaseHistory(purchaseHistory);
            
            // 8. 检查是否需要生成推荐记录
            checkAndGenerateRecommendRecord(reservation.getFlowerId(), reservation.getCustomerId());
            
            return 1;
        } catch (Exception e) {
            // 如果扣减库存失败，抛出异常
            throw new RuntimeException("确认预定失败：" + e.getMessage());
        }
    }

    /**
     * 从预定信息中获取订单ID
     * 
     * @param reservation 预定信息
     * @return 订单ID
     */
    private Long getOrderIdFromReservation(FlowerReservation reservation) {
        // 从预定备注中提取订单ID
        String remark = reservation.getRemark();
        if (remark != null && remark.contains("关联订单ID：")) {
            try {
                String orderIdStr = remark.substring(remark.indexOf("关联订单ID：") + 6);
                return Long.parseLong(orderIdStr);
            } catch (Exception e) {
                // 解析失败，返回null
                return null;
            }
        }
        return null;
    }

    /**
     * 更新关联订单状态
     * 
     * @param reservation 预定信息
     */
    private void updateOrderStatusFromReservation(FlowerReservation reservation) {
        Long orderId = getOrderIdFromReservation(reservation);
        if (orderId != null) {
            FlowerOrder order = flowerOrderMapper.selectFlowerOrderById(orderId);
            if (order != null) {
                // 更新订单状态为已付款
                order.setOrderStatus(2);
                order.setPaymentMethod(1); // 默认微信支付
                flowerOrderMapper.updateFlowerOrder(order);
            }
        }
    }

    /**
     * 取消预定（释放占用的库存）
     * 
     * @param reservationId 预定ID
     * @return 结果
     */
    @Transactional
    public int cancelReservation(Long reservationId) {
        // 1. 查询预定信息
        FlowerReservation reservation = flowerReservationService.selectFlowerReservationById(reservationId);
        if (reservation == null) {
            throw new RuntimeException("预定信息不存在");
        }
        
        if (reservation.getReservationStatus() != 1 && reservation.getReservationStatus() != 2) {
            throw new RuntimeException("只有待确认或已确认的预定才能进行取消操作");
        }
        
        try {
            // 2. 释放占用的库存
            flowerInventoryBusinessService.releaseReservedInventory(
                reservation.getFlowerId(), 
                reservation.getQuantity(), 
                "取消预定释放库存，预定ID：" + reservationId
            );
            
            // 3. 更新预定状态为已取消
            reservation.setReservationStatus(4);
            return flowerReservationService.updateFlowerReservation(reservation);
        } catch (Exception e) {
            // 如果释放库存失败，抛出异常
            throw new RuntimeException("取消预定失败：" + e.getMessage());
        }
    }
    
    /**
     * 处理预定支付成功后的业务逻辑
     * 
     * @param reservationId 预定ID
     * @return 结果
     */
    @Transactional
    public int handleReservationPaymentSuccess(Long reservationId) {
        // 1. 查询预定信息
        FlowerReservation reservation = flowerReservationService.selectFlowerReservationById(reservationId);
        if (reservation == null) {
            throw new RuntimeException("预定信息不存在");
        }
        
        try {
            // 2. 更新预定状态为已完成
            reservation.setReservationStatus(3);
            flowerReservationService.updateFlowerReservation(reservation);
            
            // 3. 记录销售历史
            FlowerSalesHistory salesHistory = new FlowerSalesHistory();
            salesHistory.setOrderId(getOrderIdFromReservation(reservation)); // 从预定信息中获取订单ID
            salesHistory.setFlowerId(reservation.getFlowerId());
            salesHistory.setCustomerId(reservation.getCustomerId());
            salesHistory.setQuantity(reservation.getQuantity());
            salesHistory.setUnitPrice(reservation.getUnitPrice());
            salesHistory.setTotalAmount(reservation.getTotalAmount());
            salesHistory.setSaleDate(new Date());
            salesHistory.setSaleTime(new Date());
            salesHistory.setPaymentMethod(1);
            salesHistory.setSalesperson("系统自动");
            
            flowerSalesHistoryMapper.insertFlowerSalesHistory(salesHistory);
            
            // 4. 更新鲜花销售数量
            updateFlowerSalesCount(reservation.getFlowerId(), reservation.getQuantity());
            
            // 5. 记录客户购买历史
            FlowerCustomerPurchaseHistory purchaseHistory = new FlowerCustomerPurchaseHistory();
            purchaseHistory.setCustomerId(reservation.getCustomerId());
            purchaseHistory.setFlowerId(reservation.getFlowerId());
            purchaseHistory.setOrderId(getOrderIdFromReservation(reservation)); // 从预定信息中获取订单ID
            purchaseHistory.setQuantity(reservation.getQuantity());
            purchaseHistory.setUnitPrice(reservation.getUnitPrice());
            purchaseHistory.setTotalAmount(reservation.getTotalAmount());
            purchaseHistory.setPurchaseDate(new Date());
            purchaseHistory.setPurchaseTime(new Date());
            // categoryId需要从flower_info中获取
            FlowerInfo flowerInfo = flowerInfoMapper.selectFlowerInfoById(reservation.getFlowerId());
            if (flowerInfo != null) {
                purchaseHistory.setCategoryId(flowerInfo.getCategoryId());
            }
            purchaseHistory.setPreferenceMatch(1); // 默认匹配
            
            flowerCustomerPurchaseHistoryMapper.insertFlowerCustomerPurchaseHistory(purchaseHistory);
            
            // 6. 检查是否需要生成推荐记录
            checkAndGenerateRecommendRecord(reservation.getFlowerId(), reservation.getCustomerId());
            
            // 6.1 调用推荐算法生成推荐记录
            try {
                flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(reservation.getCustomerId());
            } catch (Exception e) {
                // 如果推荐算法调用失败，记录日志但不中断流程
                e.printStackTrace();
            }
            
            // 7. 调用推荐算法为客户生成个性化推荐
            try {
                flowerRecommendationService.generatePersonalizedRecommendationsForCustomer(reservation.getCustomerId());
            } catch (Exception e) {
                // 如果推荐算法调用失败，记录日志但不中断流程
                e.printStackTrace();
            }
            
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("处理预定支付成功失败：" + e.getMessage());
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