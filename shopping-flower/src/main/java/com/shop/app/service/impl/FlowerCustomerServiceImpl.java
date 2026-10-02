package com.shop.app.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.app.mapper.FlowerCustomerMapper;
import com.shop.app.domain.FlowerCustomer;
import com.shop.app.service.IFlowerCustomerService;

/**
 * 客户信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerCustomerServiceImpl implements IFlowerCustomerService 
{
    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;

    /**
     * 查询客户信息
     * 
     * @param id 客户信息ID
     * @return 客户信息
     */
    @Override
    public FlowerCustomer selectFlowerCustomerById(Long id)
    {
        return flowerCustomerMapper.selectFlowerCustomerById(id);
    }

    /**
     * 查询客户信息列表
     * 
     * @param flowerCustomer 客户信息
     * @return 客户信息
     */
    @Override
    public List<FlowerCustomer> selectFlowerCustomerList(FlowerCustomer flowerCustomer)
    {
        return flowerCustomerMapper.selectFlowerCustomerList(flowerCustomer);
    }

    /**
     * 新增客户信息
     * 
     * @param flowerCustomer 客户信息
     * @return 结果
     */
    @Override
    public int insertFlowerCustomer(FlowerCustomer flowerCustomer)
    {
        return flowerCustomerMapper.insertFlowerCustomer(flowerCustomer);
    }

    /**
     * 修改客户信息
     * 
     * @param flowerCustomer 客户信息
     * @return 结果
     */
    @Override
    public int updateFlowerCustomer(FlowerCustomer flowerCustomer)
    {
        return flowerCustomerMapper.updateFlowerCustomer(flowerCustomer);
    }

    /**
     * 批量删除客户信息
     * 
     * @param ids 需要删除的客户信息ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCustomerByIds(Long[] ids)
    {
        return flowerCustomerMapper.deleteFlowerCustomerByIds(ids);
    }

    /**
     * 删除客户信息信息
     * 
     * @param id 客户信息ID
     * @return 结果
     */
    @Override
    public int deleteFlowerCustomerById(Long id)
    {
        return flowerCustomerMapper.deleteFlowerCustomerById(id);
    }
}