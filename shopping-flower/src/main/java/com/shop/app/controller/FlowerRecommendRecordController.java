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
import com.shop.app.domain.FlowerRecommendRecord;
import com.shop.app.service.IFlowerRecommendRecordService;

/**
 * 推荐记录Controller
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@RestController
@RequestMapping("/flower/recommendRecord")
public class FlowerRecommendRecordController extends BaseController
{
    @Autowired
    private IFlowerRecommendRecordService flowerRecommendRecordService;

    /**
     * 查询推荐记录列表
     */
    @PreAuthorize("@ss.hasPermi('flower:recommendRecord:list')")
    @GetMapping("/list")
    public TableDataInfo list(FlowerRecommendRecord flowerRecommendRecord)
    {
        startPage();
        List<FlowerRecommendRecord> list = flowerRecommendRecordService.selectFlowerRecommendRecordList(flowerRecommendRecord);
        return getDataTable(list);
    }

    /**
     * 获取推荐记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('flower:recommendRecord:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(flowerRecommendRecordService.selectFlowerRecommendRecordById(id));
    }

    /**
     * 新增推荐记录
     */
    @PreAuthorize("@ss.hasPermi('flower:recommendRecord:add')")
    @PostMapping
    public AjaxResult add(@RequestBody FlowerRecommendRecord flowerRecommendRecord)
    {
        return toAjax(flowerRecommendRecordService.insertFlowerRecommendRecord(flowerRecommendRecord));
    }

    /**
     * 修改推荐记录
     */
    @PreAuthorize("@ss.hasPermi('flower:recommendRecord:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody FlowerRecommendRecord flowerRecommendRecord)
    {
        return toAjax(flowerRecommendRecordService.updateFlowerRecommendRecord(flowerRecommendRecord));
    }

    /**
     * 删除推荐记录
     */
    @PreAuthorize("@ss.hasPermi('flower:recommendRecord:remove')")
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(flowerRecommendRecordService.deleteFlowerRecommendRecordByIds(ids));
    }
}