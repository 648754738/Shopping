package com.shop.app.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Base64Utils;

import com.shop.app.common.utils.SecurityUtils;
import com.shop.app.common.utils.file.FileUploadUtils;
import com.shop.app.mapper.FlowerCustomerMapper;
import com.shop.app.mapper.FlowerOrderMapper;
import com.shop.app.mapper.FlowerSalesHistoryMapper;
import com.shop.app.mapper.FlowerCustomerPurchaseHistoryMapper;
import com.shop.app.domain.FlowerOrder;
import com.shop.app.service.IFlowerOrderService;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import com.shop.app.common.config.RuoYiConfig;

/**
 * 订单Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-08
 */
@Service
public class FlowerOrderServiceImpl implements IFlowerOrderService 
{
    @Autowired
    private FlowerOrderMapper flowerOrderMapper;
    
    @Autowired
    private FlowerCustomerMapper flowerCustomerMapper;
    
    @Autowired
    private FlowerOrderBusinessServiceImpl flowerOrderBusinessService;
    
    @Autowired
    private FlowerSalesHistoryMapper flowerSalesHistoryMapper;
    
    @Autowired
    private FlowerCustomerPurchaseHistoryMapper flowerCustomerPurchaseHistoryMapper;

    /**
     * 查询订单
     * 
     * @param id 订单ID
     * @return 订单
     */
    @Override
    public FlowerOrder selectFlowerOrderById(Long id)
    {
        return flowerOrderMapper.selectFlowerOrderById(id);
    }

    /**
     * 查询订单列表
     * 
     * @param flowerOrder 订单
     * @return 订单
     */
    @Override
    public List<FlowerOrder> selectFlowerOrderList(FlowerOrder flowerOrder)
    {
        return flowerOrderMapper.selectFlowerOrderList(flowerOrder);
    }

    /**
     * 新增订单
     * 
     * @param flowerOrder 订单
     * @return 结果
     */
    @Override
    public int insertFlowerOrder(FlowerOrder flowerOrder)
    {
        // 自动生成订单号
        if (flowerOrder.getOrderNo() == null || flowerOrder.getOrderNo().isEmpty()) {
            flowerOrder.setOrderNo(generateOrderNo());
        }
        
        // 设置创建人和创建时间
        flowerOrder.setCreateBy(SecurityUtils.getUsername());
        flowerOrder.setCreateTime(new Date());
        
        // 生成二维码
        try {
            String qrCodeUrl = generateOrderQRCode(flowerOrder.getOrderNo());
            flowerOrder.setQrCodeUrl(qrCodeUrl);
        } catch (Exception e) {
            // 如果二维码生成失败，记录日志但不中断流程
            e.printStackTrace();
        }
        
        return flowerOrderMapper.insertFlowerOrder(flowerOrder);
    }

    /**
     * 修改订单
     * 
     * @param flowerOrder 订单
     * @return 结果
     */
    @Override
    public int updateFlowerOrder(FlowerOrder flowerOrder)
    {
        // 设置更新人和更新时间
        flowerOrder.setUpdateBy(SecurityUtils.getUsername());
        flowerOrder.setUpdateTime(new Date());
        
        return flowerOrderMapper.updateFlowerOrder(flowerOrder);
    }

    /**
     * 批量删除订单
     * 
     * @param ids 需要删除的订单ID
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderByIds(Long[] ids)
    {
        // 在删除订单前，处理已完成订单的数据插入历史表
        for (Long id : ids) {
            processCompletedOrderBeforeDelete(id);
        }
        
        // 先删除相关的销售历史记录
        flowerSalesHistoryMapper.deleteFlowerSalesHistoryByOrderIds(ids);
        
        // 再删除相关的客户购买历史记录
        flowerCustomerPurchaseHistoryMapper.deleteFlowerCustomerPurchaseHistoryByOrderIds(ids);
        
        // 然后删除订单明细
        flowerOrderMapper.deleteFlowerOrderDetailByOrderIds(ids);
        
        // 最后删除订单
        return flowerOrderMapper.deleteFlowerOrderByIds(ids);
    }

    /**
     * 删除订单信息
     * 
     * @param id 订单ID
     * @return 结果
     */
    @Override
    public int deleteFlowerOrderById(Long id)
    {
        // 在删除订单前，处理已完成订单的数据插入历史表
        processCompletedOrderBeforeDelete(id);
        
        // 先删除相关的销售历史记录
        flowerSalesHistoryMapper.deleteFlowerSalesHistoryByOrderId(id);
        
        // 再删除相关的客户购买历史记录
        flowerCustomerPurchaseHistoryMapper.deleteFlowerCustomerPurchaseHistoryByOrderId(id);
        
        // 然后删除订单明细
        flowerOrderMapper.deleteFlowerOrderDetailByOrderId(id);
        
        // 最后删除订单
        return flowerOrderMapper.deleteFlowerOrderById(id);
    }
    
    /**
     * 在删除订单前处理已完成订单的数据插入历史表
     * 
     * @param orderId 订单ID
     */
    private void processCompletedOrderBeforeDelete(Long orderId) {
        try {
            // 查询订单信息
            FlowerOrder order = flowerOrderMapper.selectFlowerOrderById(orderId);
            if (order != null && order.getOrderStatus() != null && order.getOrderStatus() == 4) {
                // 如果订单状态为已完成，调用业务处理服务处理订单完成逻辑
                // 这会将数据插入到销售历史表和客户购买历史表中
                flowerOrderBusinessService.handleOrderCompletion(orderId);
            }
        } catch (Exception e) {
            // 如果处理过程中出现异常，记录日志但不中断删除操作
            System.err.println("处理订单ID " + orderId + " 删除前的数据时发生错误: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * 生成订单号
     * 
     * @return 订单号
     */
    private String generateOrderNo() {
        // 格式：ORD + 年月日 + 6位随机数
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new Date());
        String randomStr = String.format("%06d", (int) (Math.random() * 1000000));
        return "ORD" + dateStr + randomStr;
    }
    
    /**
     * 生成订单二维码
     * 
     * @param orderNo 订单号
     * @return 二维码URL
     * @throws Exception
     */
    private String generateOrderQRCode(String orderNo) throws Exception {
        try {
            // 生成二维码内容
            String content = "订单号：" + orderNo;
            
            // 设置二维码参数
            Map<EncodeHintType, Object> hints = new HashMap<>();
            hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            hints.put(EncodeHintType.MARGIN, 1);

            // 生成二维码
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, 200, 200, hints);

            // 生成唯一的文件名
            String fileName = "qrcode_" + orderNo + "_" + System.currentTimeMillis() + ".png";

            // 获取上传目录
            String uploadDir = Paths.get(RuoYiConfig.getProfile(), "order", "qrcode").toString();

            // 确保目录存在
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 保存二维码图片
            Path path = Paths.get(uploadDir, fileName);
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

            // 返回文件访问路径
            return "/profile/order/qrcode/" + fileName;
        } catch (WriterException | IOException e) {
            // 如果生成二维码失败，记录日志或处理异常
            throw new RuntimeException("二维码生成失败: " + e.getMessage(), e);
        }
    }
}