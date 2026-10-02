package com.shop.app.service;

import com.shop.app.domain.FlowerCategory;
import java.util.List;

/**
 * 鲜花分类Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerCategoryService 
{
    /**
     * 查询鲜花分类
     * 
     * @param id 鲜花分类ID
     * @return 鲜花分类
     */
    public FlowerCategory selectFlowerCategoryById(Long id);

    /**
     * 查询鲜花分类列表
     * 
     * @param flowerCategory 鲜花分类
     * @return 鲜花分类集合
     */
    public List<FlowerCategory> selectFlowerCategoryList(FlowerCategory flowerCategory);

    /**
     * 新增鲜花分类
     * 
     * @param flowerCategory 鲜花分类
     * @return 结果
     */
    public int insertFlowerCategory(FlowerCategory flowerCategory);

    /**
     * 修改鲜花分类
     * 
     * @param flowerCategory 鲜花分类
     * @return 结果
     */
    public int updateFlowerCategory(FlowerCategory flowerCategory);

    /**
     * 批量删除鲜花分类
     * 
     * @param ids 需要删除的鲜花分类ID
     * @return 结果
     */
    public int deleteFlowerCategoryByIds(Long[] ids);

    /**
     * 删除鲜花分类信息
     * 
     * @param id 鲜花分类ID
     * @return 结果
     */
    public int deleteFlowerCategoryById(Long id);

    /**
     * 检查分类下是否有关联的鲜花
     * 
     * @param categoryId 分类ID
     * @return 关联的鲜花数量
     */
    public int countFlowersByCategoryId(Long categoryId);
}