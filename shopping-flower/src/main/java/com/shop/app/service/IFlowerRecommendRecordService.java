package com.shop.app.service;

import java.util.List;
import com.shop.app.domain.FlowerRecommendRecord;

/**
 * 推荐记录Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerRecommendRecordService 
{
    /**
     * 查询推荐记录
     * 
     * @param id 推荐记录ID
     * @return 推荐记录
     */
    public FlowerRecommendRecord selectFlowerRecommendRecordById(Long id);

    /**
     * 查询推荐记录列表
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 推荐记录集合
     */
    public List<FlowerRecommendRecord> selectFlowerRecommendRecordList(FlowerRecommendRecord flowerRecommendRecord);

    /**
     * 新增推荐记录
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 结果
     */
    public int insertFlowerRecommendRecord(FlowerRecommendRecord flowerRecommendRecord);

    /**
     * 修改推荐记录
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 结果
     */
    public int updateFlowerRecommendRecord(FlowerRecommendRecord flowerRecommendRecord);

    /**
     * 批量删除推荐记录
     * 
     * @param ids 需要删除的推荐记录ID
     * @return 结果
     */
    public int deleteFlowerRecommendRecordByIds(Long[] ids);

    /**
     * 删除推荐记录信息
     * 
     * @param id 推荐记录ID
     * @return 结果
     */
    public int deleteFlowerRecommendRecordById(Long id);
}