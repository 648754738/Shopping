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
import com.shop.app.common.utils.SecurityUtils;
import com.shop.app.domain.FlowerInventory;
import com.shop.app.service.IFlowerInventoryService;

/**
 * 库存Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/flower/inventory")
public class FlowerInventoryController extends BaseController
{
    @Autowired
    private IFlowerInventoryService flowerInventoryService;

    /**
     * 查询库存列表
     */
    @PreAuthorize("@ss.hasPermi('flower:inventory:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerInventory flowerInventory)
    {
        startPage();
        List<FlowerInventory> list = flowerInventoryService.selectFlowerInventoryList(flowerInventory);
        return getDataTable(list);
    }

    /**
     * 获取库存详细信息
     */
    @PreAuthorize("@ss.hasPermi('flower:inventory:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerInventoryService.selectFlowerInventoryById(id));
    }

    /**
     * 新增库存
     */
    @PreAuthorize("@ss.hasPermi('flower:inventory:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerInventory flowerInventory)
    {
        // 设置创建人和更新人信息
        String username = SecurityUtils.getUsername();
        flowerInventory.setCreateBy(username);
        flowerInventory.setUpdateBy(username);
        return toAjax(flowerInventoryService.insertFlowerInventory(flowerInventory));
    }

    /**
     * 修改库存
     */
    @PreAuthorize("@ss.hasPermi('flower:inventory:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerInventory flowerInventory)
    {
        // 设置更新人信息
        String username = SecurityUtils.getUsername();
        flowerInventory.setUpdateBy(username);
        return toAjax(flowerInventoryService.updateFlowerInventory(flowerInventory));
    }

    /**
     * 删除库存
     */
    @PreAuthorize("@ss.hasPermi('flower:inventory:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerInventoryService.deleteFlowerInventoryByIds(ids));
    }
}