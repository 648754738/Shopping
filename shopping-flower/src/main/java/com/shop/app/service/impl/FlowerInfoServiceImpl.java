package com.shop.app.service.impl;

import com.alibaba.fastjson2.JSON;
import com.google.zxing.WriterException;
import com.shop.app.common.config.RuoYiConfig;
import com.shop.app.common.utils.SecurityUtils;
import com.shop.app.common.utils.file.FileUploadUtils;
import com.shop.app.common.utils.file.MimeTypeUtils;
import com.shop.app.domain.FlowerInfo;
import com.shop.app.dto.FlowerInfoDTO;
import com.shop.app.mapper.FlowerInfoMapper;
import com.shop.app.service.IFlowerInfoService;
import com.shop.app.utils.FlowerQrCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 鲜花信息Service业务层处理
 *
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerInfoServiceImpl implements IFlowerInfoService
{
    @Autowired
    private FlowerInfoMapper flowerInfoMapper;

    /**
     * 查询鲜花信息
     *
     * @param id 鲜花信息ID
     * @return 鲜花信息
     */
    @Override
    public FlowerInfo selectFlowerInfoById(Long id)
    {
        return flowerInfoMapper.selectFlowerInfoById(id);
    }

    /**
     * 查询鲜花信息DTO
     *
     * @param id 鲜花信息ID
     * @return 鲜花信息DTO
     */
    @Override
    public FlowerInfoDTO selectFlowerInfoDTOById(Long id)
    {
        return flowerInfoMapper.selectFlowerInfoDTOById(id);
    }

    /**
     * 查询鲜花信息列表
     *
     * @param flowerInfo 鲜花信息
     * @return 鲜花信息
     */
    @Override
    public List<FlowerInfo> selectFlowerInfoList(FlowerInfo flowerInfo)
    {
        return flowerInfoMapper.selectFlowerInfoList(flowerInfo);
    }

    /**
     * 查询鲜花信息DTO列表
     *
     * @param flowerInfo 鲜花信息
     * @return 鲜花信息DTO
     */
    @Override
    public List<FlowerInfoDTO> selectFlowerInfoDTOList(FlowerInfo flowerInfo)
    {
        return flowerInfoMapper.selectFlowerInfoDTOList(flowerInfo);
    }

    /**
     * 新增鲜花信息（不包含图片上传）
     *
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    @Override
    public int insertFlowerInfoWithoutImages(FlowerInfo flowerInfo)
    {
        // 设置创建者
        flowerInfo.setCreateBy(SecurityUtils.getUsername());
        // 设置创建时间
        flowerInfo.setCreateTime(new Date());

        // 生成二维码
        generateQrCode(flowerInfo);

        return flowerInfoMapper.insertFlowerInfo(flowerInfo);
    }

    /**
     * 修改鲜花信息（包含图片上传）
     * @param flowerInfo 鲜花信息
     * @return 结果
     */

    /**
     * 修改鲜花信息（不包含图片上传）
     *
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    @Override
    public int updateFlowerInfoWithoutImages(FlowerInfo flowerInfo)
    {
        // 设置更新者
        flowerInfo.setUpdateBy(SecurityUtils.getUsername());
        // 设置更新时间
        flowerInfo.setUpdateTime(new Date());

        // 生成二维码
        generateQrCode(flowerInfo);

        return flowerInfoMapper.updateFlowerInfo(flowerInfo);
    }
    
    /**
     * 更新鲜花图片
     *
     * @param id 鲜花信息ID
     * @param imageFile 图片文件
     * @return 结果
     */
    @Override
    public int updateFlowerImages(Long id, MultipartFile imageFile) {
        // 参数验证
        if (id == null) {
            throw new IllegalArgumentException("鲜花信息ID不能为空");
        }
        
        if (imageFile == null || imageFile.isEmpty()) {
            throw new IllegalArgumentException("请选择要上传的图片文件");
        }
        
        // 创建鲜花信息对象
        FlowerInfo flowerInfo = new FlowerInfo();
        flowerInfo.setId(id);
        flowerInfo.setImageFiles(new MultipartFile[]{imageFile});
        
        // 处理图片上传
        handleImageUpload(flowerInfo);
        
        // 只更新图片字段
        return flowerInfoMapper.updateFlowerInfo(flowerInfo);
    }
    
    /**
     * 更新鲜花图片
     *
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    @Override
    public int updateFlowerImages(FlowerInfo flowerInfo) {
        // 处理图片上传
        handleImageUpload(flowerInfo);
        
        // 只更新图片字段
        return flowerInfoMapper.updateFlowerInfo(flowerInfo);
    }
    
    /**
     * 更新鲜花图片地址
     *
     * @param flowerInfo 鲜花信息
     * @return 结果
     */
    @Override
    public int updateFlowerImageUrl(FlowerInfo flowerInfo) {
        // 参数验证
        if (flowerInfo.getId() == null) {
            throw new IllegalArgumentException("鲜花信息ID不能为空");
        }
        
        if (flowerInfo.getImageUrl() == null || flowerInfo.getImageUrl().trim().isEmpty()) {
            throw new IllegalArgumentException("图片地址不能为空");
        }
        
        // 直接存储图片URL，不使用JSON数组格式
        flowerInfo.setImageUrls(flowerInfo.getImageUrl());
        
        // 设置更新者
        flowerInfo.setUpdateBy(SecurityUtils.getUsername());
        // 设置更新时间
        flowerInfo.setUpdateTime(new Date());
        
        // 只更新图片字段
        return flowerInfoMapper.updateFlowerInfo(flowerInfo);
    }

    /**
     * 批量删除鲜花信息
     *
     * @param ids 需要删除的鲜花信息ID
     * @return 结果
     */
    @Override
    public int deleteFlowerInfoByIds(Long[] ids)
    {
        return flowerInfoMapper.deleteFlowerInfoByIds(ids);
    }

    /**
     * 删除鲜花信息信息
     *
     * @param id 鲜花信息ID
     * @return 结果
     */
    @Override
    public int deleteFlowerInfoById(Long id)
    {
        return flowerInfoMapper.deleteFlowerInfoById(id);
    }

    /**
     * 处理图片上传（只处理一张图片）
     *
     * @param flowerInfo 鲜花信息
     */
    private void handleImageUpload(FlowerInfo flowerInfo) {
        MultipartFile[] imageFiles = flowerInfo.getImageFiles();
        if (imageFiles != null && imageFiles.length > 0) {
            // 限制只能上传1张图片
            if (imageFiles.length > 1) {
                throw new IllegalArgumentException("只能上传1张图片");
            }

            try {
                // 只处理第一张图片
                MultipartFile file = imageFiles[0];
                if (file != null && !file.isEmpty()) {
                    // 使用若依框架的FileUploadUtils上传单个文件
                    String imageUrl = FileUploadUtils.upload(RuoYiConfig.getProfile() + "/flower/images", file, MimeTypeUtils.IMAGE_EXTENSION);
                    // 直接存储图片URL，不使用JSON数组格式
                    flowerInfo.setImageUrls(imageUrl);
                }
            } catch (Exception e) {
                // 如果上传失败，记录日志或处理异常
                throw new RuntimeException("图片上传失败: " + e.getMessage(), e);
            }
        }
    }
    
    /**
     * 生成二维码并保存为文件
     *
     * @param flowerInfo 鲜花信息
     */
    private void generateQrCode(FlowerInfo flowerInfo) {
        try {
            // 构造二维码内容（可以是鲜花的详细信息链接或其他内容）
            String content = "鲜花名称: " + flowerInfo.getFlowerName() +
                            ", 价格: " + flowerInfo.getPrice() +
                            ", 描述: " + flowerInfo.getFlowerDesc();

            // 生成唯一的文件名
            String fileName = "qrcode_" + UUID.randomUUID().toString() + ".png";

            // 获取上传目录
            String uploadDir = Paths.get(RuoYiConfig.getProfile(), "flower", "qrcode").toString();

            // 确保目录存在
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 生成二维码并保存为文件
            String filePath = FlowerQrCodeUtils.generateQrCodeToFile(content, 200, 200, uploadDir, fileName);

            // 设置二维码URL（相对路径）
            String qrCodeUrl = "/profile/flower/qrcode/" + fileName;
            flowerInfo.setQrCodeUrl(qrCodeUrl);
        } catch (WriterException | IOException e) {
            // 如果生成二维码失败，记录日志或处理异常
            throw new RuntimeException("二维码生成失败: " + e.getMessage(), e);
        }
    }
}