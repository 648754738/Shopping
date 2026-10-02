package com.shop.app.controller;

import com.shop.app.common.annotation.Log;
import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.common.core.page.TableDataInfo;
import com.shop.app.common.enums.BusinessType;
import com.shop.app.common.utils.poi.ExcelUtil;
import com.shop.app.common.utils.SecurityUtils;
import com.shop.app.domain.FlowerCategory;
import com.shop.app.service.IFlowerCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 鲜花分类Controller
 *
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/category/category")
public class FlowerCategoryController extends BaseController
{
    @Autowired
    private IFlowerCategoryService flowerCategoryService;

    /**
     * 查询鲜花分类列表
     */
    @PreAuthorize("@ss.hasPermi('category:category:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerCategory flowerCategory)
    {
        startPage();
        List<FlowerCategory> list = flowerCategoryService.selectFlowerCategoryList(flowerCategory);
        return getDataTable(list);
    }

    /**
     * 导出鲜花分类列表
     */
    @PreAuthorize("@ss.hasPermi('category:category:export')")
    @Log(title = "鲜花分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FlowerCategory flowerCategory)
    {
        List<FlowerCategory> list = flowerCategoryService.selectFlowerCategoryList(flowerCategory);
        ExcelUtil<FlowerCategory> util = new ExcelUtil<FlowerCategory>(FlowerCategory.class);
        util.exportExcel(response, list, "鲜花分类数据");
    }

    /**
     * 获取鲜花分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('category:category:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(flowerCategoryService.selectFlowerCategoryById(id));
    }

    /**
     * 新增鲜花分类
     */
    @PreAuthorize("@ss.hasPermi('category:category:add')")
    @Log(title = "鲜花分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FlowerCategory flowerCategory)
    {
        // 设置创建人和创建时间
        flowerCategory.setCreateBy(SecurityUtils.getUsername());
        flowerCategory.setCreateTime(new Date());
        return toAjax(flowerCategoryService.insertFlowerCategory(flowerCategory));
    }

    /**
     * 修改鲜花分类
     */
    @PreAuthorize("@ss.hasPermi('category:category:edit')")
    @Log(title = "鲜花分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerCategory flowerCategory)
    {
        // 设置更新人和更新时间
        flowerCategory.setUpdateBy(SecurityUtils.getUsername());
        flowerCategory.setUpdateTime(new Date());
        return toAjax(flowerCategoryService.updateFlowerCategory(flowerCategory));
    }

    /**
     * 删除鲜花分类
     */
    @PreAuthorize("@ss.hasPermi('category:category:remove')")
    @Log(title = "鲜花分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        // 检查每个要删除的分类下是否有关联的鲜花
        for (Long id : ids) {
            int flowerCount = flowerCategoryService.countFlowersByCategoryId(id);
            if (flowerCount > 0) {
                FlowerCategory category = flowerCategoryService.selectFlowerCategoryById(id);
                return AjaxResult.error("分类'" + category.getCategoryName() + "'下有关联的鲜花，不能删除");
            }
        }
        
        return toAjax(flowerCategoryService.deleteFlowerCategoryByIds(ids));
    }
}