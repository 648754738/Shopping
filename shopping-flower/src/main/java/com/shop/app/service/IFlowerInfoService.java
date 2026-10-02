package com.shop.app.service;

import com.shop.app.domain.FlowerInfo;
import com.shop.app.dto.FlowerInfoDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 鲜花信息Service接口
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
public interface IFlowerInfoService 
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
     * 新增鲜花信息（不包含图片上传）
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int insertFlowerInfoWithoutImages(FlowerInfo flowerInfo);

    /**
     * 修改鲜花信息（不包含图片上传）
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int updateFlowerInfoWithoutImages(FlowerInfo flowerInfo);
    
    /**
     * 更新鲜花图片
     * 
     * @param id 鲜花信息ID
     * @param imageFile 图片文件
     * @return 结果
     */
    public int updateFlowerImages(Long id, MultipartFile imageFile);
    
    /**
     * 更新鲜花图片
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int updateFlowerImages(FlowerInfo flowerInfo);

    /**
     * 更新鲜花图片地址
     * 
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    public int updateFlowerImageUrl(FlowerInfo flowerInfo);

    /**
     * 批量删除鲜花信息
     * 
     * @param ids 需要删除的鲜花信息ID
     * @return 结果
     */
    public int deleteFlowerInfoByIds(Long[] ids);

    /**
     * 删除鲜花信息信息
     * 
     * @param id 鲜花信息ID
     * @return 结果
     */
    public int deleteFlowerInfoById(Long id);
}