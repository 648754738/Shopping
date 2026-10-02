package com.shop.app.controller;

import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.mapper.FlowerCustomerMapper;
import com.shop.app.mapper.FlowerCustomerPurchaseHistoryMapper;
import com.shop.app.mapper.FlowerInventoryMapper;
import com.shop.app.mapper.FlowerSalesHistoryMapper;
import com.shop.app.service.IFlowerRecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 首页数据统计Controller
 *
 * @author ruoyi
 * @date 2025-09-10
 */
@RestController
@RequestMapping("/dashboard")
public class DashboardController extends BaseController {

    @Autowired
    private FlowerInventoryMapper flowerInventoryMapper;

    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;

    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;

    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;

    @Autowired
    private IFlowerRecommendationService flowerRecommendationService;

    /**
     * 获取首页统计数据
     */
    @GetMapping("/statistics")
    public AjaxResult getDashboardStatistics() {
        Map<String, Object> result = new HashMap<>();

        // 1. 获取库存统计数据
        Map<String, Object> inventoryStats = getInventoryStatistics();
        result.put("inventoryStats", inventoryStats);

        // 2. 获取销售统计数据
        Map<String, Object> salesStats = getSalesStatistics();
        result.put("salesStats", salesStats);

        // 3. 获取客户统计数据
        Map<String, Object> customerStats = getCustomerStatistics();
        result.put("customerStats", customerStats);

        return AjaxResult.success(result);
    }

    /**
     * 触发推荐算法生成推荐数据
     */
    @PostMapping("/generateRecommendations")
    public AjaxResult generateRecommendations() {
        try {
            flowerRecommendationService.generateAndInsertRecommendations();
            return AjaxResult.success("推荐数据生成成功");
        } catch (Exception e) {
            return AjaxResult.error("推荐数据生成失败: " + e.getMessage());
        }
    }

    /**
     * 获取库存统计数据
     */
    private Map<String, Object> getInventoryStatistics() {
        Map<String, Object> inventoryStats = new HashMap<>();

        // 查询所有库存
        List<com.shop.app.domain.FlowerInventory> inventoryList = flowerInventoryMapper.selectFlowerInventoryList(new com.shop.app.domain.FlowerInventory());

        int totalInventory = 0;          // 总库存数量
        int totalAvailable = 0;          // 总可用数量
        int warningCount = 0;            // 预警库存数量

        for (com.shop.app.domain.FlowerInventory inventory : inventoryList) {
            if (inventory.getQuantity() != null) {
                totalInventory += inventory.getQuantity();
            }
            if (inventory.getAvailableQuantity() != null) {
                totalAvailable += inventory.getAvailableQuantity();
            }
            // 检查是否需要预警
            if (inventory.needWarning()) {
                warningCount++;
            }
        }

        inventoryStats.put("totalInventory", totalInventory);
        inventoryStats.put("totalAvailable", totalAvailable);
        inventoryStats.put("warningCount", warningCount);

        return inventoryStats;
    }

    /**
     * 获取销售统计数据
     */
    private Map<String, Object> getSalesStatistics() {
        Map<String, Object> salesStats = new HashMap<>();

        // 查询所有销售历史
        List<com.shop.app.domain.FlowerSalesHistory> salesList = flowerSalesHistoryMapper.selectFlowerSalesHistoryList(new com.shop.app.domain.FlowerSalesHistory());

        System.out.println("销售历史记录数: " + salesList.size()); // 添加调试信息

        int totalSalesCount = salesList.size();     // 总销售订单数
        BigDecimal totalSalesAmount = BigDecimal.ZERO; // 总销售金额
        int totalSalesQuantity = 0;                 // 总销售数量

        for (com.shop.app.domain.FlowerSalesHistory sales : salesList) {
            if (sales.getTotalAmount() != null) {
                totalSalesAmount = totalSalesAmount.add(sales.getTotalAmount());
                System.out.println("销售金额: " + sales.getTotalAmount()); // 添加调试信息
            }
            if (sales.getQuantity() != null) {
                totalSalesQuantity += sales.getQuantity();
                System.out.println("销售数量: " + sales.getQuantity()); // 添加调试信息
            }
        }

        System.out.println("总销售订单数: " + totalSalesCount); // 添加调试信息
        System.out.println("总销售金额: " + totalSalesAmount); // 添加调试信息
        System.out.println("总销售数量: " + totalSalesQuantity); // 添加调试信息

        salesStats.put("totalSalesCount", totalSalesCount);
        salesStats.put("totalSalesAmount", totalSalesAmount);
        salesStats.put("totalSalesQuantity", totalSalesQuantity);

        return salesStats;
    }

    /**
     * 获取客户统计数据
     */
    private Map<String, Object> getCustomerStatistics() {
        Map<String, Object> customerStats = new HashMap<>();

        // 查询所有客户
        List<com.shop.app.domain.FlowerCustomer> customerList = flowerCustomerMapper.selectFlowerCustomerList(new com.shop.app.domain.FlowerCustomer());

        int totalCustomers = customerList.size();   // 总客户数
        int activeCustomers = 0;                    // 活跃客户数
        int vipCustomers = 0;                       // VIP客户数

        for (com.shop.app.domain.FlowerCustomer customer : customerList) {
            // 统计活跃客户（状态为正常的客户）
            if (customer.getStatus() != null && customer.getStatus() == 1) {
                activeCustomers++;
            }
            // 统计VIP客户（金卡和钻石客户）
            if (customer.getLevel() != null && (customer.getLevel() == 3 || customer.getLevel() == 4)) {
                vipCustomers++;
            }
        }

        customerStats.put("totalCustomers", totalCustomers);
        customerStats.put("activeCustomers", activeCustomers);
        customerStats.put("vipCustomers", vipCustomers);

        return customerStats;
    }
}