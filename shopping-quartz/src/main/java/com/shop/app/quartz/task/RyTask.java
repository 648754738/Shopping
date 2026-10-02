package com.shop.app.quartz.task;

import com.shop.app.common.utils.StringUtils;
import com.shop.app.domain.FlowerOrder;
import com.shop.app.service.IFlowerOrderService;
import com.shop.app.service.impl.FlowerOrderBusinessServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 定时任务调度测试
 * 
 * @author ruoyi
 */
@Component("ryTask")
public class RyTask
{
    @Autowired
    private IFlowerOrderService flowerOrderService;
    
    @Autowired
    private FlowerOrderBusinessServiceImpl flowerOrderBusinessService;

    public void ryMultipleParams(String s, Boolean b, Long l, Double d, Integer i)
    {
        System.out.println(StringUtils.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void ryParams(String params)
    {
        System.out.println("执行有参方法：" + params);
    }

    public void ryNoParams()
    {
        System.out.println("执行无参方法");
    }
    
    /**
     * 处理已完成订单数据，将数据插入到销售历史表中
     * 
     */
    public void processCompletedOrders()
    {

        try {
            // 查询所有状态为已完成的订单（状态值为4）
            FlowerOrder queryOrder = new FlowerOrder();
            queryOrder.setOrderStatus(4); // 已完成状态
            List<FlowerOrder> completedOrders = flowerOrderService.selectFlowerOrderList(queryOrder);
            
            System.out.println("找到 " + completedOrders.size() + " 个已完成订单");
            
            // 处理每个已完成订单
            for (FlowerOrder order : completedOrders) {
                try {
                    // 调用订单业务处理服务处理订单完成逻辑
                    flowerOrderBusinessService.handleOrderCompletion(order.getId());
                    System.out.println("已处理订单ID: " + order.getId() + ", 订单号: " + order.getOrderNo());
                } catch (Exception e) {
                    System.err.println("处理订单ID " + order.getId() + " 时发生错误: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            System.out.println("已完成订单数据处理完成");
        } catch (Exception e) {
            System.err.println("处理已完成订单数据时发生错误: " + e.getMessage());
            e.printStackTrace();
        }
    }
}