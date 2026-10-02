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
import com.shop.app.domain.FlowerSalesHistory;
import com.shop.app.service.IFlowerSalesHistoryService;

/**
 * 销售历史Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/flower/salesHistory")
public class FlowerSalesHistoryController extends BaseController
{
    @Autowired
    private IFlowerSalesHistoryService flowerSalesHistoryService;

    /**
     * 查询销售历史列表
     */
    @PreAuthorize("@ss.hasPermi('flower:salesHistory:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerSalesHistory flowerSalesHistory)
    {
        startPage();
        List<FlowerSalesHistory> list = flowerSalesHistoryService.selectFlowerSalesHistoryList(flowerSalesHistory);
        return getDataTable(list);
    }

    /**
     * 获取销售历史详细信息
     */
    @PreAuthorize("@ss.hasPermi('flower:salesHistory:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerSalesHistoryService.selectFlowerSalesHistoryById(id));
    }

    /**
     * 新增销售历史
     */
    @PreAuthorize("@ss.hasPermi('flower:salesHistory:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerSalesHistory flowerSalesHistory)
    {
        return toAjax(flowerSalesHistoryService.insertFlowerSalesHistory(flowerSalesHistory));
    }

    /**
     * 修改销售历史
     */
    @PreAuthorize("@ss.hasPermi('flower:salesHistory:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerSalesHistory flowerSalesHistory)
    {
        return toAjax(flowerSalesHistoryService.updateFlowerSalesHistory(flowerSalesHistory));
    }

    /**
     * 删除销售历史
     */
    @PreAuthorize("@ss.hasPermi('flower:salesHistory:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerSalesHistoryService.deleteFlowerSalesHistoryByIds(ids));
    }
}