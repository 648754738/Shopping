package com.shop.app.mapper;

import java.util.List;
import com.shop.app.domain.FlowerCustomer;
import org.springframework.stereotype.Repository;

/**
 * 客户信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerCustomerMapper 
{
    /**
     * 查询客户信息
     * 
     * @param id 客户信息ID
     * @return 客户信息
     */
    public FlowerCustomer selectFlowerCustomerById(Long id);

    /**
     * 查询客户信息列表
     * 
     * @param flowerCustomer 客户信息
     * @return 客户信息集合
     */
    public List<FlowerCustomer> selectFlowerCustomerList(FlowerCustomer flowerCustomer);

    /**
     * 新增客户信息
     * 
     * @param flowerCustomer 客户信息
     * @return 结果
     */
    public int insertFlowerCustomer(FlowerCustomer flowerCustomer);

    /**
     * 修改客户信息
     * 
     * @param flowerCustomer 客户信息
     * @return 结果
     */
    public int updateFlowerCustomer(FlowerCustomer flowerCustomer);

    /**
     * 删除客户信息
     * 
     * @param id 客户信息ID
     * @return 结果
     */
    public int deleteFlowerCustomerById(Long id);

    /**
     * 批量删除客户信息
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerCustomerByIds(Long[] ids);
}