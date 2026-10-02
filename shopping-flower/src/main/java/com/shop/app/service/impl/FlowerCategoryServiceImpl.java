package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerCategoryMapper;
import com.shop.app.domain.FlowerCategory;
import com.shop.app.service.IFlowerCategoryService;

/**
 * 鲜花分类Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerCategoryServiceImpl implements IFlowerCategoryService 
{
    @Autowired
    private FlowerCategoryMapper flowerCategoryMapper;

    /**
     * 查询鲜花分类
     * 
     * @param id 鲜花分类ID
     * @return 鲜花分类
     */
    @Override
    public FlowerCategory selectFlowerCategoryById(Long id)
    {
        return flowerCategoryMapper.selectFlowerCategoryById(id);
    }

    /**
     * 查询鲜花分类列表
     * 
     * @param flowerCategory 鲜花分类
     * @return 鲜花分类
     */
    @Override
    public List<FlowerCategory> selectFlowerCategoryList(FlowerCategory flowerCategory)
    {
        return flowerCategoryMapper.selectFlowerCategoryList(flowerCategory);
    }

    /**
     * 新增鲜花分类
     * 
     * @param flowerCategory 鲜花分类
     * @return 结果
     */
    @Override
    public int insertFlowerCategory(FlowerCategory flowerCategory)
    {
        return flowerCategoryMapper.insertFlowerCategory(flowerCategory);
    }

    /**
     * 修改鲜花分类
     * 
     * @param flowerCategory 鲜花分类
     * @return 结果
     */
    @Override
    public int updateFlowerCategory(FlowerCategory flowerCategory)
    {
        return flowerCategoryMapper.updateFlowerCategory(flowerCategory);
    }

    /**
     * 批量删除鲜花分类
     * 
     * @param ids 需要删除的鲜花分类ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCategoryByIds(Long[] ids)
    {
        return flowerCategoryMapper.deleteFlowerCategoryByIds(ids);
    }

    /**
     * 删除鲜花分类信息
     * 
     * @param id 鲜花分类ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCategoryById(Long id)
    {
        return flowerCategoryMapper.deleteFlowerCategoryById(id);
    }

    /**
     * 检查分类下是否有关联的鲜花
     * 
     * @param categoryId 分类ID
     * @return 关联的鲜花数量
     */
    @Override
    public int countFlowersByCategoryId(Long categoryId)
    {
        return flowerCategoryMapper.countFlowersByCategoryId(categoryId);
    }
}