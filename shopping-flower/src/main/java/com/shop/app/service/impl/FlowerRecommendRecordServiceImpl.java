package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerRecommendRecordMapper;
import com.shop.app.domain.FlowerRecommendRecord;
import com.shop.app.service.IFlowerRecommendRecordService;

/**
 * 推荐记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerRecommendRecordServiceImpl implements IFlowerRecommendRecordService 
{
    @Autowired
    private FlowerRecommendRecordMapper flowerRecommendRecordMapper;

    /**
     * 查询推荐记录
     * 
     * @param id 推荐记录ID
     * @return 推荐记录
     */
    @Override
    public FlowerRecommendRecord selectFlowerRecommendRecordById(Long id)
    {
        return flowerRecommendRecordMapper.selectFlowerRecommendRecordById(id);
    }

    /**
     * 查询推荐记录列表
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 推荐记录
     */
    @Override
    public List<FlowerRecommendRecord> selectFlowerRecommendRecordList(FlowerRecommendRecord flowerRecommendRecord)
    {
        return flowerRecommendRecordMapper.selectFlowerRecommendRecordList(flowerRecommendRecord);
    }

    /**
     * 新增推荐记录
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 结果
     */
    @Override
    public int insertFlowerRecommendRecord(FlowerRecommendRecord flowerRecommendRecord)
    {
        return flowerRecommendRecordMapper.insertFlowerRecommendRecord(flowerRecommendRecord);
    }

    /**
     * 修改推荐记录
     * 
     * @param flowerRecommendRecord 推荐记录
     * @return 结果
     */
    @Override
    public int updateFlowerRecommendRecord(FlowerRecommendRecord flowerRecommendRecord)
    {
        return flowerRecommendRecordMapper.updateFlowerRecommendRecord(flowerRecommendRecord);
    }

    /**
     * 批量删除推荐记录
     * 
     * @param ids 需要删除的推荐记录ID
     * @return 结果
     */
    @Override
    public int deleteFlowerRecommendRecordByIds(Long[] ids)
    {
        return flowerRecommendRecordMapper.deleteFlowerRecommendRecordByIds(ids);
    }

    /**
     * 删除推荐记录信息
     * 
     * @param id 推荐记录ID
     * @return 结果
     */
    @Override
    public int deleteFlowerRecommendRecordById(Long id)
    {
        return flowerRecommendRecordMapper.deleteFlowerRecommendRecordById(id);
    }
}