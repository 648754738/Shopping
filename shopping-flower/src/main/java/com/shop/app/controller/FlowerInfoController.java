package com.shop.app.controller;

import com.shop.app.common.annotation.Log;
import com.shop.app.common.core.controller.BaseController;
import com.shop.app.common.core.domain.AjaxResult;
import com.shop.app.common.core.page.TableDataInfo;
import com.shop.app.common.enums.BusinessType;
import com.shop.app.common.utils.poi.ExcelUtil;
import com.shop.app.domain.FlowerInfo;
import com.shop.app.dto.FlowerInfoDTO;
import com.shop.app.service.IFlowerInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 鲜花信息Controller
 *
 * @author 席老师
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/info/info")
public class FlowerInfoController extends BaseController
{
    @Autowired
    private IFlowerInfoService flowerInfoService;

    /**
     * 查询鲜花信息列表
     */
    @PreAuthorize("@ss.hasPermi('info:info:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerInfo flowerInfo)
    {
        startPage();
        List<FlowerInfo> list = flowerInfoService.selectFlowerInfoList(flowerInfo);
        return getDataTable(list);
    }
    
    /**
     * 查询鲜花信息DTO列表
     */
    @PreAuthorize("@ss.hasPermi('info:info:list')")
    @GetMapping("/listDTO")
    public TableDataInfo listDTO(FlowerInfo flowerInfo)
    {
        startPage();
        List<FlowerInfoDTO> list = flowerInfoService.selectFlowerInfoDTOList(flowerInfo);
        return getDataTable(list);
    }

    /**
     * 导出鲜花信息列表
     */
    @PreAuthorize("@ss.hasPermi('info:info:export')")
    @Log(title = "鲜花信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FlowerInfo flowerInfo)
    {
        List<FlowerInfo> list = flowerInfoService.selectFlowerInfoList(flowerInfo);
        ExcelUtil<FlowerInfo> util = new ExcelUtil<FlowerInfo>(FlowerInfo.class);
        util.exportExcel(response, list, "鲜花信息数据");
    }

    /**
     * 获取鲜花信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('info:info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(flowerInfoService.selectFlowerInfoById(id));
    }
    
    /**
     * 获取鲜花信息DTO详细信息
     */
    @PreAuthorize("@ss.hasPermi('info:info:query')")
    @GetMapping(value = "/getDTO/{id}")
    public AjaxResult getDTOInfo(@PathVariable("id") Long id)
    {
        return success(flowerInfoService.selectFlowerInfoDTOById(id));
    }

    /**
     * 新增鲜花信息
     */
    @PreAuthorize("@ss.hasPermi('info:info:add')")
    @Log(title = "鲜花信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FlowerInfo flowerInfo)
    {
        return toAjax(flowerInfoService.insertFlowerInfoWithoutImages(flowerInfo));
    }

    /**
     * 修改鲜花信息
     */
    @PreAuthorize("@ss.hasPermi('info:info:edit')")
    @Log(title = "鲜花信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerInfo flowerInfo)
    {
        return toAjax(flowerInfoService.updateFlowerInfoWithoutImages(flowerInfo));
    }

    /**
     * 删除鲜花信息
     */
    @PreAuthorize("@ss.hasPermi('info:info:remove')")
    @Log(title = "鲜花信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerInfoService.deleteFlowerInfoByIds(ids));
    }
    
    /**
     * 单独上传图片接口（只上传一张图片）
     */
    @PreAuthorize("@ss.hasPermi('info:info:edit')")
    @Log(title = "鲜花信息图片上传", businessType = BusinessType.UPDATE)
    @PostMapping("/uploadImages/{id}")
    public AjaxResult uploadImages(@PathVariable("id") Long id,
                                  @RequestParam(value = "imageFile", required = false) MultipartFile imageFile)
    {
        try {
            return toAjax(flowerInfoService.updateFlowerImages(id, imageFile));
        } catch (Exception e) {
            logger.error("图片上传失败: ", e);
            return error("图片上传失败: " + e.getMessage());
        }
    }
    
    /**
     * 设置鲜花图片地址接口
     */
    @PreAuthorize("@ss.hasPermi('info:info:edit')")
    @Log(title = "鲜花信息图片地址设置", businessType = BusinessType.UPDATE)
    @PutMapping("/updateImageUrl")
    public AjaxResult updateImageUrl(@RequestBody FlowerInfo flowerInfo)
    {
        try {
            return toAjax(flowerInfoService.updateFlowerImageUrl(flowerInfo));
        } catch (Exception e) {
            logger.error("图片地址设置失败: ", e);
            return error("图片地址设置失败: " + e.getMessage());
        }
    }
}