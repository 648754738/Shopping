package com.shop.app.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 鲜花预定工具类
 * 
 * @author ruoyi
 * @date 2025-09-10
 */
public class FlowerReservationUtils {
    
    private static final String RESERVATION_PREFIX = "RES";
    private static final String ORDER_PREFIX = "ORD";
    private static final Random random = new Random();
    
    /**
     * 生成预定编号
     * 格式：RES + 日期 + 4位随机数
     * 
     * @return 预定编号
     */
    public static String generateReservationNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new Date());
        int randomNumber = 1000 + random.nextInt(9000); // 4位随机数
        return RESERVATION_PREFIX + dateStr + randomNumber;
    }
    
    /**
     * 生成订单编号
     * 格式：ORD + 日期 + 4位随机数
     * 
     * @return 订单编号
     */
    public static String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new Date());
        int randomNumber = 1000 + random.nextInt(9000); // 4位随机数
        return ORDER_PREFIX + dateStr + randomNumber;
    }
}