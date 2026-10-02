package com.shop.app.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.shop.app.common.utils.poi.ExcelUtil;
import com.shop.app.domain.FlowerCustomer;
import com.shop.app.domain.FlowerRecommendRecord;
import com.shop.app.service.IFlowerCustomerService;
import com.shop.app.service.IFlowerRecommendRecordService;

/**
 * 客户信息Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/customer/customer")
public class FlowerCustomerController extends BaseController
{
    @Autowired
    private IFlowerCustomerService flowerCustomerService;
    
    @Autowired
    private IFlowerRecommendRecordService flowerRecommendRecordService;

    /**
     * 查询客户信息列表
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerCustomer flowerCustomer)
    {
        startPage();
        List<FlowerCustomer> list = flowerCustomerService.selectFlowerCustomerList(flowerCustomer);
        return getDataTable(list);
    }

    /**
     * 导出客户信息列表
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, FlowerCustomer flowerCustomer)
    {
        List<FlowerCustomer> list = flowerCustomerService.selectFlowerCustomerList(flowerCustomer);
        ExcelUtil<FlowerCustomer> util = new ExcelUtil<FlowerCustomer>(FlowerCustomer.class);
        util.exportExcel(response, list, "客户信息数据");
    }

    /**
     * 获取客户信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerCustomerService.selectFlowerCustomerById(id));
    }
    
    /**
     * 获取客户推荐记录列表
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:query')")
    @GetMapping(value = "/{id}/recommendations")
    public TableDataInfo getCustomerRecommendations(@PathVariable("id") Long id)
    {
        startPage();
        FlowerRecommendRecord query = new FlowerRecommendRecord();
        query.setCustomerId(id);
        List<FlowerRecommendRecord> list = flowerRecommendRecordService.selectFlowerRecommendRecordList(query);
        return getDataTable(list);
    }

    /**
     * 新增客户信息
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerCustomer flowerCustomer)
    {
        // 设置创建人和创建时间
        flowerCustomer.setCreateBy(SecurityUtils.getUsername());
        flowerCustomer.setCreateTime(new Date());
        return toAjax(flowerCustomerService.insertFlowerCustomer(flowerCustomer));
    }

    /**
     * 修改客户信息
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerCustomer flowerCustomer)
    {
        // 设置更新人和更新时间
        flowerCustomer.setUpdateBy(SecurityUtils.getUsername());
        flowerCustomer.setUpdateTime(new Date());
        return toAjax(flowerCustomerService.updateFlowerCustomer(flowerCustomer));
    }

    /**
     * 删除客户信息
     */
    @PreAuthorize("@ss.hasPermi('customer:customer:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerCustomerService.deleteFlowerCustomerByIds(ids));
    }
}