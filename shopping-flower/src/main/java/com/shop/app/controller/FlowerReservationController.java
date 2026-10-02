package com.shop.app.controller;

import com.shop.app.common.annotation.Log;
import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.common.core.page.TableDataInfo;
import com.shop.app.common.enums.BusinessType;
import com.shop.app.common.utils.poi.ExcelUtil;
import com.shop.app.domain.FlowerCustomer;
import com.shop.app.domain.FlowerInfo;
import com.shop.app.domain.FlowerReservation;
import com.shop.app.dto.ReservationInitDataDTO;
import com.shop.app.service.IFlowerCustomerService;
import com.shop.app.service.IFlowerInfoService;
import com.shop.app.service.IFlowerReservationService;
import com.shop.app.service.impl.FlowerReservationBusinessServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 预定管理Controller
 *
 * @author ruoyi
 * @date 2025-09-10
 */
@RestController
@RequestMapping("/reservation/reservation")
public class FlowerReservationController extends BaseController
{
    @Autowired
    private IFlowerReservationService flowerReservationService;
    
    @Autowired
    private FlowerReservationBusinessServiceImpl flowerReservationBusinessService;
    
    @Autowired
    private IFlowerCustomerService flowerCustomerService;
    
    @Autowired
    private IFlowerInfoService flowerInfoService;

    /**
     * 查询预定管理列表
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerReservation flowerReservation)
    {
        startPage();
        List<FlowerReservation> list = flowerReservationService.selectFlowerReservationList(flowerReservation);
        return getDataTable(list);
    }

    /**
     * 导出预定管理列表
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:export')")
    @Log(title = "预定管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FlowerReservation flowerReservation)
    {
        List<FlowerReservation> list = flowerReservationService.selectFlowerReservationList(flowerReservation);
        ExcelUtil<FlowerReservation> util = new ExcelUtil<FlowerReservation>(FlowerReservation.class);
        util.exportExcel(response, list, "预定管理数据");
    }

    /**
     * 获取预定管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(flowerReservationService.selectFlowerReservationById(id));
    }

    /**
     * 新增预定管理
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:add')")
    @Log(title = "预定管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FlowerReservation flowerReservation)
    {
        try {
            int result = flowerReservationBusinessService.insertFlowerReservationWithInventory(flowerReservation);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 修改预定管理
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:edit')")
    @Log(title = "预定管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerReservation flowerReservation)
    {
        return toAjax(flowerReservationService.updateFlowerReservation(flowerReservation));
    }

    /**
     * 删除预定管理
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:remove')")
    @Log(title = "预定管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerReservationService.deleteFlowerReservationByIds(ids));
    }
    
    /**
     * 确认预定
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:confirm')")
    @Log(title = "预定管理", businessType = BusinessType.UPDATE)
    @PostMapping("/confirm/{id}")
    public AjaxResult confirm(@PathVariable("id") Long id)
    {
        try {
            int result = flowerReservationBusinessService.confirmReservation(id);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 取消预定
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:cancel')")
    @Log(title = "预定管理", businessType = BusinessType.UPDATE)
    @PostMapping("/cancel/{id}")
    public AjaxResult cancel(@PathVariable("id") Long id)
    {
        try {
            int result = flowerReservationBusinessService.cancelReservation(id);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 处理预定支付成功
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:edit')")
    @Log(title = "预定管理", businessType = BusinessType.UPDATE)
    @PostMapping("/paymentSuccess/{id}")
    public AjaxResult paymentSuccess(@PathVariable("id") Long id)
    {
        try {
            int result = flowerReservationBusinessService.handleReservationPaymentSuccess(id);
            return toAjax(result);
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 获取预定初始化数据
     */
    @PreAuthorize("@ss.hasPermi('reservation:reservation:list')")
    @GetMapping("/initData")
    public AjaxResult getInitData()
    {
        ReservationInitDataDTO initData = new ReservationInitDataDTO();
        
        // 获取客户列表
        List<FlowerCustomer> customers = flowerCustomerService.selectFlowerCustomerList(new FlowerCustomer());
        initData.setCustomerList(customers);
        
        // 获取鲜花列表
        List<FlowerInfo> flowers = flowerInfoService.selectFlowerInfoList(new FlowerInfo());
        initData.setFlowerList(flowers);
        
        // 设置预定状态选项
        List<ReservationInitDataDTO.DictItem> statusOptions = new ArrayList<>();
        statusOptions.add(new ReservationInitDataDTO.DictItem(1, "待确认"));
        statusOptions.add(new ReservationInitDataDTO.DictItem(2, "已确认"));
        statusOptions.add(new ReservationInitDataDTO.DictItem(3, "已完成"));
        statusOptions.add(new ReservationInitDataDTO.DictItem(4, "已取消"));
        initData.setReservationStatusOptions(statusOptions);
        
        // 设置支付方式选项
        List<ReservationInitDataDTO.DictItem> paymentOptions = new ArrayList<>();
        paymentOptions.add(new ReservationInitDataDTO.DictItem(1, "微信"));
        paymentOptions.add(new ReservationInitDataDTO.DictItem(2, "支付宝"));
        paymentOptions.add(new ReservationInitDataDTO.DictItem(3, "银行卡"));
        paymentOptions.add(new ReservationInitDataDTO.DictItem(4, "现金"));
        initData.setPaymentMethodOptions(paymentOptions);
        
        return AjaxResult.success(initData);
    }
}