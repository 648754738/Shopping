package com.shop.app.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.common.core.page.TableDataInfo;
import com.shop.app.domain.FlowerCustomerPurchaseHistory;
import com.shop.app.service.IFlowerCustomerPurchaseHistoryService;

/**
 * 客户购买历史Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/flower/customer/purchase/history")
public class FlowerCustomerPurchaseHistoryController extends BaseController
{
    @Autowired
    private IFlowerCustomerPurchaseHistoryService flowerCustomerPurchaseHistoryService;

    /**
     * 查询客户购买历史列表
     */
    @PreAuthorize("@ss.hasPermi('flower:customer:purchase:history:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        startPage();
        List<FlowerCustomerPurchaseHistory> list = flowerCustomerPurchaseHistoryService.selectFlowerCustomerPurchaseHistoryList(flowerCustomerPurchaseHistory);
        return getDataTable(list);
    }

    /**
     * 获取客户购买历史详细信息
     */
    @PreAuthorize("@ss.hasPermi('flower:customer:purchase:history:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerCustomerPurchaseHistoryService.selectFlowerCustomerPurchaseHistoryById(id));
    }

    /**
     * 新增客户购买历史
     */
    @PreAuthorize("@ss.hasPermi('flower:customer:purchase:history:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        return toAjax(flowerCustomerPurchaseHistoryService.insertFlowerCustomerPurchaseHistory(flowerCustomerPurchaseHistory));
    }

    /**
     * 修改客户购买历史
     */
    @PreAuthorize("@ss.hasPermi('flower:customer:purchase:history:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerCustomerPurchaseHistory flowerCustomerPurchaseHistory)
    {
        return toAjax(flowerCustomerPurchaseHistoryService.updateFlowerCustomerPurchaseHistory(flowerCustomerPurchaseHistory));
    }

    /**
     * 删除客户购买历史
     */
    @PreAuthorize("@ss.hasPermi('flower:customer:purchase:history:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerCustomerPurchaseHistoryService.deleteFlowerCustomerPurchaseHistoryByIds(ids));
    }
}