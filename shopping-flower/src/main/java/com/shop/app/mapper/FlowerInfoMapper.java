package com.shop.app.mapper;

import java.util.List;
import com.shop.app.domain.FlowerInfo;
import com.shop.app.dto.FlowerInfoDTO;
import org.springframework.stereotype.Repository;

/**
 * 鲜花信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Repository
public interface FlowerInfoMapper 
{
    /**
     * 查询鲜花信息
     * 
     * @param id 鲜花信息ID
     * @return 鲜花信息
     */
    public FlowerInfo selectFlowerInfoById(Long id);
    
    /**
     * 查询鲜花信息DTO
     * 
     * @param id 鲜花信息ID
     * @return 鲜花信息DTO
     */
    public FlowerInfoDTO selectFlowerInfoDTOById(Long id);

    /**
     * 查询鲜花信息列表
     * 
     * @param flowerInfo 鲜花信息
     * @return 鲜花信息集合
     */
    public List<FlowerInfo> selectFlowerInfoList(FlowerInfo flowerInfo);
    
    /**
     * 查询鲜花信息DTO列表
     * 
     * @param flowerInfo 鲜花信息
     * @return 鲜花信息DTO集合
     */
    public List<FlowerInfoDTO> selectFlowerInfoDTOList(FlowerInfo flowerInfo);

    /**
     * 新增鲜花信息
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int insertFlowerInfo(FlowerInfo flowerInfo);

    /**
     * 修改鲜花信息
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int updateFlowerInfo(FlowerInfo flowerInfo);

    /**
     * 删除鲜花信息
     * 
     * @param id 鲜花信息ID
     * @return 结果
     */
    public int deleteFlowerInfoById(Long id);

    /**
     * 批量删除鲜花信息
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteFlowerInfoByIds(Long[] ids);
}