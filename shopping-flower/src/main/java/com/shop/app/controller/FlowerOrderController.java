package com.shop.app.controller;

import com.shop.app.common.annotation.Log;
import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.common.core.page.TableDataInfo;
import com.shop.app.common.enums.BusinessType;
import com.shop.app.common.utils.poi.ExcelUtil;
import com.shop.app.domain.FlowerOrder;
import com.shop.app.service.IFlowerOrderService;
import com.shop.app.service.impl.FlowerOrderBusinessServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 订单管理Controller
 *
 * @author ruoyi
 * @date 2025-09-09
 */
@RestController
@RequestMapping("/order/order")
public class FlowerOrderController extends BaseController
{
    @Autowired
    private IFlowerOrderService flowerOrderService;
    
    @Autowired
    private FlowerOrderBusinessServiceImpl flowerOrderBusinessService;

    /**
     * 查询订单管理列表
     */
    @PreAuthorize("@ss.hasPermi('order:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerOrder flowerOrder)
    {
        startPage();
        List<FlowerOrder> list = flowerOrderService.selectFlowerOrderList(flowerOrder);
        return getDataTable(list);
    }

    /**
     * 导出订单管理列表
     */
    @PreAuthorize("@ss.hasPermi('order:order:export')")
    @Log(title = "订单管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FlowerOrder flowerOrder)
    {
        List<FlowerOrder> list = flowerOrderService.selectFlowerOrderList(flowerOrder);
        ExcelUtil<FlowerOrder> util = new ExcelUtil<FlowerOrder>(FlowerOrder.class);
        util.exportExcel(response, list, "订单管理数据");
    }

    /**
     * 获取订单管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('order:order:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(flowerOrderService.selectFlowerOrderById(id));
    }

    /**
     * 新增订单管理
     */
    @PreAuthorize("@ss.hasPermi('order:order:add')")
    @Log(title = "订单管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FlowerOrder flowerOrder) {
        // 如果订单状态为已完成，处理订单完成逻辑
        if (flowerOrder.getOrderStatus() != null && flowerOrder.getOrderStatus() == 4) {
            try {
                int result = flowerOrderService.insertFlowerOrder(flowerOrder);
                if (result > 0) {
                    // 处理订单完成后的业务逻辑
                    flowerOrderBusinessService.handleOrderCompletion(flowerOrder.getId());
                }
                return toAjax(result);
            } catch (Exception e) {
                return AjaxResult.error(e.getMessage());
            }
        } else {
            return toAjax(flowerOrderService.insertFlowerOrder(flowerOrder));
        }
    }

    /**
     * 修改订单管理
     */
    @PreAuthorize("@ss.hasPermi('order:order:edit')")
    @Log(title = "订单管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerOrder flowerOrder) {
        // 如果订单状态修改为已完成，处理订单完成逻辑
        if (flowerOrder.getOrderStatus() != null && flowerOrder.getOrderStatus() == 4) {
            try {
                int result = flowerOrderService.updateFlowerOrder(flowerOrder);
                if (result > 0) {
                    // 处理订单完成后的业务逻辑
                    flowerOrderBusinessService.handleOrderCompletion(flowerOrder.getId());
                }
                return toAjax(result);
            } catch (Exception e) {
                return AjaxResult.error(e.getMessage());
            }
        } else {
            return toAjax(flowerOrderService.updateFlowerOrder(flowerOrder));
        }
    }

    /**
     * 删除订单管理
     */
    @PreAuthorize("@ss.hasPermi('order:order:remove')")
    @Log(title = "订单管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerOrderService.deleteFlowerOrderByIds(ids));
    }
    
    /**
     * 处理订单支付成功
     */
    @PreAuthorize("@ss.hasPermi('order:order:edit')")
    @Log(title = "订单管理", businessType = BusinessType.UPDATE)
    @PostMapping("/paymentSuccess/{id}")
    public AjaxResult paymentSuccess(@PathVariable("id") Long id)
    {
        try {
            int result = flowerOrderBusinessService.handleOrderPaymentSuccess(id);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 处理订单完成
     */
    @PreAuthorize("@ss.hasPermi('order:order:edit')")
    @Log(title = "订单管理", businessType = BusinessType.UPDATE)
    @PostMapping("/complete/{id}")
    public AjaxResult complete(@PathVariable("id") Long id)
    {
        try {
            int result = flowerOrderBusinessService.handleOrderCompletion(id);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
}