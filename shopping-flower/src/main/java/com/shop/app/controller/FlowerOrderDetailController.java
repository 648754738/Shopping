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
import com.shop.app.domain.FlowerOrderDetail;
import com.shop.app.service.IFlowerOrderDetailService;

/**
 * 订单明细Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/order/orderDetail")
public class FlowerOrderDetailController extends BaseController
{
    @Autowired
    private IFlowerOrderDetailService flowerOrderDetailService;

    /**
     * 查询订单明细列表
     */
    @PreAuthorize("@ss.hasPermi('flower:orderDetail:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerOrderDetail flowerOrderDetail)
    {
        startPage();
        List<FlowerOrderDetail> list = flowerOrderDetailService.selectFlowerOrderDetailList(flowerOrderDetail);
        return getDataTable(list);
    }

    /**
     * 获取订单明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('flower:orderDetail:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerOrderDetailService.selectFlowerOrderDetailById(id));
    }

    /**
     * 新增订单明细
     */
    @PreAuthorize("@ss.hasPermi('flower:orderDetail:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerOrderDetail flowerOrderDetail)
    {
        return toAjax(flowerOrderDetailService.insertFlowerOrderDetail(flowerOrderDetail));
    }

    /**
     * 修改订单明细
     */
    @PreAuthorize("@ss.hasPermi('flower:orderDetail:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerOrderDetail flowerOrderDetail)
    {
        return toAjax(flowerOrderDetailService.updateFlowerOrderDetail(flowerOrderDetail));
    }

    /**
     * 删除订单明细
     */
    @PreAuthorize("@ss.hasPermi('flower:orderDetail:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerOrderDetailService.deleteFlowerOrderDetailByIds(ids));
    }
}