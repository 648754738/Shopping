-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        11.4.2-MariaDB - mariadb.org binary distribution
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 导出  表 flower_sales_system.flower_category 结构
CREATE TABLE IF NOT EXISTS `flower_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) NOT NULL COMMENT '分类名称',
  `category_desc` varchar(200) DEFAULT NULL COMMENT '分类描述',
  `sort_order` int(11) DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 1-正常 0-禁用',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='鲜花分类表';

-- 正在导出表  flower_sales_system.flower_category 的数据：~10 rows (大约)
INSERT INTO `flower_category` (`id`, `category_name`, `category_desc`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '热情奔放类', '玫瑰花系列', 0, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:01:34', '情人节主打'),
	(2, '血色浪漫类', '百合花系列', 2, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:01:42', '婚礼常用'),
	(3, '温馨关爱类', '康乃馨系列', 3, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:02:01', '母亲节主打'),
	(4, '青春活力类', '郁金香系列', 4, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:02:15', '春季特色'),
	(5, '阳光灿烂类', '向日葵系列', 5, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:02:27', '阳光主题'),
	(6, '烂漫爱情类', '满天星系列', 6, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:02:46', '配花首选'),
	(7, '长寿养生类', '优雅高贵类', 7, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:03:16', '优雅系列'),
	(8, '希望成长类', '茉莉花系列', 8, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:03:26', '清香系列'),
	(9, '学业有成类', '牡丹系列', 9, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:03:43', '富贵主题'),
	(10, '金榜题名类', '菊花系列', 10, 1, '', '2025-09-08 11:12:16', 'admin', '2025-09-12 15:03:55', '秋季特色');

-- 导出  表 flower_sales_system.flower_customer 结构
CREATE TABLE IF NOT EXISTS `flower_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `customer_name` varchar(50) NOT NULL COMMENT '客户姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `gender` tinyint(1) DEFAULT 1 COMMENT '性别 1-男 0-女',
  `preference` text DEFAULT NULL COMMENT '客户偏好（JSON格式存储）',
  `level` tinyint(1) DEFAULT 1 COMMENT '客户等级 1-普通 2-银卡 3-金卡 4-钻石',
  `points` int(11) DEFAULT 0 COMMENT '积分',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 1-正常 0-禁用',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_phone` (`phone`),
  KEY `idx_customer_name` (`customer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='客户信息表';

-- 正在导出表  flower_sales_system.flower_customer 的数据：~15 rows (大约)
INSERT INTO `flower_customer` (`id`, `customer_name`, `phone`, `email`, `address`, `birthday`, `gender`, `preference`, `level`, `points`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '张三', '13800138001', 'zhangsan@example.com', '北京市朝阳区xxx街道', '1990-05-11', 1, '["favorite_color","preferred_occasion","preferred_category","flowers","business_meetings","holiday_gifts"]', 3, 1200, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-09 10:29:19', '金卡客户'),
	(2, '李四', '13800138002', 'lisi@example.com', '上海市浦东新区xxx路', '1985-12-10', 0, '{"favorite_color":"粉色","preferred_occasion":"母亲节","preferred_category":[3,6]}', 2, 800, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '银卡客户'),
	(3, '王五', '13800138003', 'wangwu@example.com', '广州市天河区xxx大道', '1992-03-22', 1, '["favorite_color","preferred_occasion","preferred_category","baskets","holiday_gifts","business_meetings"]', 4, 2500, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-09 10:30:25', '钻石客户'),
	(4, '赵六', '13800138004', 'zhaoliu@example.com', '深圳市南山区xxx路', '1988-07-30', 0, '{"favorite_color":"紫色","preferred_occasion":"生日","preferred_category":[5,7]}', 1, 200, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '普通客户'),
	(5, '钱七', '13800138005', 'qianqi@example.com', '杭州市西湖区xxx街道', '1995-11-11', 1, '["favorite_color","preferred_occasion","preferred_category","holiday_gifts","business_meetings"]', 2, 600, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-09 13:17:32', '银卡客户'),
	(6, '孙八', '13800138006', 'sunba@example.com', '南京市鼓楼区xxx路', '1991-09-09', 0, '{"favorite_color":"蓝色","preferred_occasion":"纪念日","preferred_category":[7,8]}', 3, 1500, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '金卡客户'),
	(7, '周九', '13800138007', 'zhoujiu@example.com', '成都市锦江区xxx街道', '1987-04-18', 1, '{"favorite_color":"橙色","preferred_occasion":"探病","preferred_category":[3,10]}', 1, 100, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '普通客户'),
	(8, '吴十', '13800138008', 'wushi@example.com', '武汉市江汉区xxx大道', '1993-06-25', 0, '{"favorite_color":"绿色","preferred_occasion":"毕业","preferred_category":[1,8]}', 2, 700, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '银卡客户'),
	(9, '郑十一', '13800138009', 'zhengshiyi@example.com', '西安市雁塔区xxx路', '1994-02-14', 1, '{"favorite_color":"粉色","preferred_occasion":"表白","preferred_category":[1,6]}', 3, 1300, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '金卡客户'),
	(10, '王十二', '13800138010', 'wangshier@example.com', '重庆市渝中区xxx街道', '1989-08-08', 0, '{"favorite_color":"红色","preferred_occasion":"结婚","preferred_category":[1,2]}', 4, 3000, 1, '', '2025-09-08 11:12:17', '', '2025-09-08 11:12:17', '钻石客户'),
	(11, '韩梅梅', '13700000000', '1111@163.com', '西安碑林区', '2025-09-09', 0, '["flowers","plants","bouquets","baskets","opening_baskets","wedding_flowers","holiday_gifts","business_meetings"]', 1, 3, 1, 'admin', '2025-09-09 09:59:33', 'admin', '2025-09-09 10:18:30', '2323'),
	(12, '刘胡兰', '13259703573', '', '西安', NULL, NULL, NULL, 1, 0, 1, '', '2025-09-12 15:30:19', '', '2025-09-12 15:30:19', NULL),
	(13, '刘亦菲', '13700000001', 'liuyifei@example.com', '西安三桥新街', NULL, NULL, '', 1, 0, 1, '', '2025-09-12 15:47:24', '', '2025-09-12 15:47:24', ''),
	(14, '刘德华', '13259703577', 'liudehua@example.com', '西安三桥新街万象城星巴克', NULL, NULL, '', 1, 0, 1, '', '2025-09-12 16:38:25', '', '2025-09-12 16:38:25', ''),
	(15, '冯程程', '13277777777', '', '三桥新街', NULL, NULL, '', 1, 0, 1, '', '2025-09-12 17:24:02', '', '2025-09-12 17:24:02', ''),
	(16, '梁山伯', '13200000000', '', '西安三桥新街', NULL, NULL, '', 1, 0, 1, '', '2025-09-12 17:37:05', '', '2025-09-12 17:37:05', ''),
	(17, '冯程程', '13259703576', '', '陕西西安三桥', NULL, NULL, '', 1, 0, 1, '', '2025-09-15 11:01:20', '', '2025-09-15 11:01:20', '');

-- 导出  表 flower_sales_system.flower_customer_purchase_history 结构
CREATE TABLE IF NOT EXISTS `flower_customer_purchase_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '购买历史ID',
  `customer_id` bigint(20) NOT NULL COMMENT '客户ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10,2) NOT NULL COMMENT '总金额',
  `purchase_date` date NOT NULL COMMENT '购买日期',
  `purchase_time` datetime NOT NULL COMMENT '购买时间',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `preference_match` tinyint(1) DEFAULT 0 COMMENT '是否匹配客户偏好 1-匹配 0-不匹配',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_flower_id` (`flower_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_purchase_date` (`purchase_date`),
  KEY `fk_purchase_category` (`category_id`),
  CONSTRAINT `fk_purchase_category` FOREIGN KEY (`category_id`) REFERENCES `flower_category` (`id`),
  CONSTRAINT `fk_purchase_customer` FOREIGN KEY (`customer_id`) REFERENCES `flower_customer` (`id`),
  CONSTRAINT `fk_purchase_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`),
  CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='客户购买历史表';

-- 正在导出表  flower_sales_system.flower_customer_purchase_history 的数据：~1 rows (大约)
INSERT INTO `flower_customer_purchase_history` (`id`, `customer_id`, `flower_id`, `order_id`, `quantity`, `unit_price`, `total_amount`, `purchase_date`, `purchase_time`, `category_id`, `preference_match`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(19, 14, 1, 28, 1, 99.00, 99.00, '2025-09-15', '2025-09-15 10:57:13', 1, 1, '', '2025-09-15 10:57:13', '', '2025-09-15 10:57:13', NULL);

-- 导出  表 flower_sales_system.flower_info 结构
CREATE TABLE IF NOT EXISTS `flower_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '鲜花ID',
  `flower_name` varchar(100) NOT NULL COMMENT '鲜花名称',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `flower_desc` text DEFAULT NULL COMMENT '鲜花描述',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '成本价',
  `image_urls` text DEFAULT NULL COMMENT '图片URL列表(JSON格式)',
  `qr_code_url` varchar(255) DEFAULT NULL COMMENT '二维码URL',
  `stock` int(11) DEFAULT 0 COMMENT '库存数量',
  `sales_count` int(11) DEFAULT 0 COMMENT '销售数量',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 1-上架 0-下架',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_flower_category` FOREIGN KEY (`category_id`) REFERENCES `flower_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='鲜花信息表';

-- 正在导出表  flower_sales_system.flower_info 的数据：~10 rows (大约)
INSERT INTO `flower_info` (`id`, `flower_name`, `category_id`, `flower_desc`, `price`, `market_price`, `cost_price`, `image_urls`, `qr_code_url`, `stock`, `sales_count`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '红玫瑰', 1, '红色玫瑰，象征热情的爱情', 99.00, 120.00, 50.00, 'https://img2.baidu.com/it/u=539744227,3181201690&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1734', '/profile/flower/qrcode/qrcode_d91f0f44-613a-4dd5-846c-dc08deed996c.png', 97, 58, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:25:37', '经典款1'),
	(2, '白百合', 2, '白色百合，象征纯洁和高雅', 88.00, 110.00, 45.00, 'https://img0.baidu.com/it/u=1095963996,630643021&fm=253&app=138&f=JPEG?w=800&h=1428', 'https://example.com/qrcode/lily_white', 80, 30, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '婚礼首选'),
	(3, '粉康乃馨', 3, '粉色康乃馨，表达温馨的祝福', 66.00, 80.00, 35.00, 'https://img0.baidu.com/it/u=115376943,3298469016&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1132', 'https://example.com/qrcode/carnation_pink', 120, 73, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '母亲节特供'),
	(4, '黄郁金香', 4, '黄色郁金香，象征阳光和快乐', 77.00, 95.00, 40.00, 'https://img1.baidu.com/it/u=3313534139,501255597&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666', 'https://example.com/qrcode/tulip_yellow', 90, 40, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '春季限定'),
	(5, '橙色向日葵', 5, '橙色向日葵，传递积极向上的能量', 55.00, 70.00, 30.00, 'https://img1.baidu.com/it/u=1473705063,1689718657&fm=253&fmt=auto?w=500&h=500', 'https://example.com/qrcode/sunflower_orange', 60, 25, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '活力系列'),
	(6, '紫色满天星', 6, '紫色满天星，浪漫的配花选择', 35.00, 45.00, 20.00, 'https://img1.baidu.com/it/u=1393669761,1846631909&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=718', 'https://example.com/qrcode/babybreath_purple', 200, 100, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '配花必备'),
	(7, '蓝紫罗兰', 7, '蓝紫罗兰，代表忠诚和谦逊', 68.00, 85.00, 38.00, 'https://img1.baidu.com/it/u=914880489,1467988321&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=751', 'https://example.com/qrcode/violet_blue', 70, 35, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '优雅之选'),
	(8, '白茉莉', 8, '白色茉莉，散发着淡雅的清香', 45.00, 60.00, 25.00, 'https://img2.baidu.com/it/u=2213784590,1393097375&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664', 'https://example.com/qrcode/jasmine_white', 110, 56, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '清香系列'),
	(9, '红牡丹', 9, '红色牡丹，富贵吉祥的象征', 120.00, 150.00, 70.00, 'https://b0.bdstatic.com/ugc/C9HgbrRkDq0W5ET925xVcA8aa5c27cd0d56df88ade9418cf23e9a7.jpg', 'https://example.com/qrcode/peony_red', 50, 20, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '富贵花开'),
	(10, '黄菊花', 10, '黄色菊花，秋季盛开的佳品', 40.00, 55.00, 22.00, 'https://img0.baidu.com/it/u=1938294405,2459758777&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1737', 'https://example.com/qrcode/chrysanthemum_yellow', 143, 87, 1, '', '2025-09-08 11:12:17', 'admin', '2025-09-15 11:24:39', '秋季特供');

-- 导出  表 flower_sales_system.flower_inventory 结构
CREATE TABLE IF NOT EXISTS `flower_inventory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '库存ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `quantity` int(11) NOT NULL COMMENT '库存数量',
  `reserved_quantity` int(11) DEFAULT 0 COMMENT '预定占用数量',
  `available_quantity` int(11) NOT NULL COMMENT '可用数量',
  `warning_threshold` int(11) DEFAULT 10 COMMENT '预警阈值',
  `last_restock_time` datetime DEFAULT NULL COMMENT '最近补货时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_flower_id` (`flower_id`),
  CONSTRAINT `fk_inventory_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='库存表';

-- 正在导出表  flower_sales_system.flower_inventory 的数据：~10 rows (大约)
INSERT INTO `flower_inventory` (`id`, `flower_id`, `quantity`, `reserved_quantity`, `available_quantity`, `warning_threshold`, `last_restock_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 1, 101, 30, 71, 10, '2023-08-25 10:00:00', '', '2025-09-08 11:12:18', '', '2025-09-11 12:34:26', '红玫瑰库存 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null 预定占用库存，预定ID：null'),
	(2, 2, 80, 13, 67, 10, '2023-08-26 11:00:00', '', '2025-09-08 11:12:18', '', '2025-09-10 14:42:28', '白百合库存 预定占用库存，预定ID：null 预定占用库存，预定ID：null'),
	(3, 3, 120, 4, 116, 15, '2023-08-27 09:30:00', '', '2025-09-08 11:12:18', '', '2025-09-11 12:28:46', '康乃馨库存 预定占用库存，预定ID：null'),
	(4, 4, 90, 1, 89, 10, '2023-08-28 14:20:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '郁金香库存'),
	(5, 5, 60, 2, 58, 10, '2023-08-29 16:45:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '向日葵库存'),
	(6, 6, 200, 10, 190, 20, '2023-08-30 10:15:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '满天星库存'),
	(7, 7, 70, 1, 69, 10, '2023-08-31 11:30:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '紫罗兰库存'),
	(8, 8, 110, 1, 109, 15, '2023-09-01 13:45:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '茉莉花库存'),
	(9, 9, 50, 3, 47, 5, '2023-09-02 15:20:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '牡丹库存'),
	(10, 10, 150, 2, 148, 20, '2023-09-03 09:50:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '菊花库存');

-- 导出  表 flower_sales_system.flower_order 结构
CREATE TABLE IF NOT EXISTS `flower_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户ID',
  `order_type` tinyint(1) DEFAULT 1 COMMENT '订单类型 1-普通订单 2-预定订单',
  `order_amount` decimal(10,2) NOT NULL COMMENT '订单金额',
  `discount_amount` decimal(10,2) DEFAULT 0.00 COMMENT '优惠金额',
  `actual_amount` decimal(10,2) NOT NULL COMMENT '实际支付金额',
  `order_status` tinyint(1) DEFAULT 1 COMMENT '订单状态 1-待付款 2-已付款 3-已发货 4-已完成 5-已取消',
  `payment_method` tinyint(1) DEFAULT 1 COMMENT '支付方式 1-微信 2-支付宝 3-银行卡 4-现金',
  `receiver_name` varchar(50) DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(20) DEFAULT NULL COMMENT '收货人电话',
  `receiver_address` varchar(200) DEFAULT NULL COMMENT '收货地址',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `qr_code_url` text DEFAULT NULL COMMENT '订单二维码URL',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_order_status` (`order_status`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `flower_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单表';

-- 正在导出表  flower_sales_system.flower_order 的数据：~2 rows (大约)
INSERT INTO `flower_order` (`id`, `order_no`, `customer_id`, `order_type`, `order_amount`, `discount_amount`, `actual_amount`, `order_status`, `payment_method`, `receiver_name`, `receiver_phone`, `receiver_address`, `delivery_time`, `receive_time`, `qr_code_url`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(28, 'DD1757904889502', 14, 2, 99.00, 0.00, 99.00, 4, NULL, '台灯一二三', '13259703577', '西安三桥', NULL, NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABdUlEQVR4Xu2WMXbEIAxERcUxuCmGm/oYqlBmhmSTzXubIg0qVs9vF/RdjEbItsWrsN+JR7zJ38QNUbxxUW+zNphoOUiDxMl0DN0ysfcsZBh2d3G7lMNdLCITgWrEVAW5CJaARl9TkaDStpjjLTOez8FJQq1l53QNJnKQHU6xo8ZSzxkZCHqrESkgkFtvSF6f9ZwmEXBxIYcdhd+93pdnIUtTMsy60oXjkoTc3ex6Jr1GFlJpZJGvWE82/1P1aUJHd27AWtgJ7d9enyX8n5J88YVGR0t8eX2YwEIKH3y0wF2SKwnRGeTOaaq0s4gUhJKtS3WwAkh+1HOaUCzb+5XT2lXPcRJ8gy32GXOsUVbzUxC34vxoCowLuDF6ErKD57HN7SUuRAbilFmCei/+akR813OctJBYdHhVzDHThDmIvGQOi11Er3I0C+GsDD75WvBIZiLOhLqNoZH8HCTYbboI1ZCPSEM0JTyJxkHxHyfxOHkVb/I/8gFoZgVBnOPRTgAAAABJRU5ErkJggg==', '', '2025-09-15 10:54:49', 'admin', '2025-09-15 10:58:03', '无'),
	(29, 'DD1757905280558', 17, 2, 99.00, 0.00, 99.00, 4, NULL, '冯程程', '13259703576', '陕西西安三桥', NULL, NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABbElEQVR4Xu2VO3LDMAxEoYrH4E1F6qY8hittdhdyPMmMU6QRCmM4Mo2HYokPGXhn8dvxbR/yN3kEbcPaox/AjD7l6DVIp8Qjv97wK2cNQqVycNNwNsLYShFJXntbUZCw5m1twCxGoCIHJbMZRfCzD+4kGorN1c415ahB0qQa1n45ShD/cyLXcJ2n81qEBOt8SV7BXALnM9e3k2E4tOmnLhiNSxXCXEJ6ndS8aWoQ/a7Nw0E3dAJMZ/R+kpPBHswQRuoQeZ4KRKrZfSn8gN60EgQcERY5ay6bfm9LEOnlpRK7JPNL7c/b5Xai+VBSuaK5By28BPF8yJxIrskQ8goEr0fs8Pie3pcgHAtPhgjUkpRMTwmS9sg7z7nMQ1QgkskpsUNuSVZSS5AO5RKaYyxDh9Qg02/s7jtmuNqMLUR0K+OQXtV8PF6q7yd+Y2fTo6GoMgT5T1Brb0uNWYIwh1edB2Nc7dlQgryzD/kf+QITAw2N+AVEygAAAABJRU5ErkJggg==', '', '2025-09-15 11:01:20', 'admin', '2025-09-15 11:04:38', '无');

-- 导出  表 flower_sales_system.flower_order_detail 结构
CREATE TABLE IF NOT EXISTS `flower_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_flower_id` (`flower_id`),
  CONSTRAINT `fk_detail_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`),
  CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单明细表';

-- 正在导出表  flower_sales_system.flower_order_detail 的数据：~2 rows (大约)
INSERT INTO `flower_order_detail` (`id`, `order_id`, `flower_id`, `quantity`, `unit_price`, `total_price`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(33, 28, 1, 1, 99.00, 99.00, '', '2025-09-15 10:54:49', '', '2025-09-15 10:54:49', '预定订单明细'),
	(34, 29, 1, 1, 99.00, 99.00, '', '2025-09-15 11:01:20', '', '2025-09-15 11:01:20', '预定订单明细');

-- 导出  表 flower_sales_system.flower_recommend_record 结构
CREATE TABLE IF NOT EXISTS `flower_recommend_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '推荐记录ID',
  `customer_id` bigint(20) NOT NULL COMMENT '客户ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `recommend_reason` varchar(200) DEFAULT NULL COMMENT '推荐理由',
  `recommend_type` tinyint(1) DEFAULT 1 COMMENT '推荐类型 1-节日推荐 2-偏好推荐 3-热销推荐 4-新品推荐 5-搭配推荐',
  `is_accepted` tinyint(1) DEFAULT 0 COMMENT '是否接受 1-接受 0-拒绝',
  `acceptance_time` datetime DEFAULT NULL COMMENT '接受时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_flower_id` (`flower_id`),
  CONSTRAINT `fk_recommend_customer` FOREIGN KEY (`customer_id`) REFERENCES `flower_customer` (`id`),
  CONSTRAINT `fk_recommend_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='推荐记录表';

-- 正在导出表  flower_sales_system.flower_recommend_record 的数据：~69 rows (大约)
INSERT INTO `flower_recommend_record` (`id`, `customer_id`, `flower_id`, `recommend_reason`, `recommend_type`, `is_accepted`, `acceptance_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 1, 1, '情人节推荐', 1, 1, '2023-09-01 09:30:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户接受了推荐'),
	(2, 2, 3, '母亲节推荐', 1, 1, '2023-09-02 08:45:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户购买了推荐商品'),
	(3, 3, 9, '金卡客户专享推荐', 3, 1, '2023-09-03 10:15:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '高价值客户推荐'),
	(4, 4, 5, '开业场合推荐', 2, 1, '2023-09-04 09:20:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '根据客户偏好推荐'),
	(5, 5, 1, '生日推荐', 1, 0, NULL, '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户未接受推荐'),
	(6, 6, 7, '纪念日推荐', 1, 1, '2023-09-06 11:30:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户接受了推荐'),
	(7, 7, 10, '探病场合推荐', 2, 1, '2023-09-07 14:45:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '根据场合推荐'),
	(8, 8, 8, '毕业季推荐', 1, 0, NULL, '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户未接受推荐'),
	(9, 9, 1, '表白场景推荐', 1, 1, '2023-09-09 08:30:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '客户接受了推荐'),
	(10, 10, 9, '钻石客户专享推荐', 3, 1, '2023-09-10 15:20:00', '', '2025-09-08 11:12:18', '', '2025-09-08 11:12:18', '高价值客户推荐'),
	(11, 1, 1, '预定推荐：客户张三预定了红玫瑰', 2, 0, NULL, '', '2025-09-10 15:40:51', '', '2025-09-10 15:40:51', '基于预定行为生成的推荐'),
	(12, 1, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 15:40:51', '', '2025-09-10 15:40:51', '系统自动生成的热销推荐'),
	(13, 1, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 15:42:11', '', '2025-09-10 15:42:11', '系统自动生成的热销推荐'),
	(14, 6, 3, '购买推荐：客户6购买了粉康乃馨', 1, 0, NULL, '', '2025-09-10 16:34:20', '', '2025-09-10 16:34:20', '基于购买行为生成的推荐'),
	(15, 6, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:20', '', '2025-09-10 16:34:20', '系统自动生成的热销推荐'),
	(16, 6, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:20', '', '2025-09-10 16:34:20', '系统自动生成的热销推荐'),
	(17, 5, 4, '购买推荐：客户5购买了黄郁金香', 1, 0, NULL, '', '2025-09-10 16:34:23', '', '2025-09-10 16:34:23', '基于购买行为生成的推荐'),
	(18, 5, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:23', '', '2025-09-10 16:34:23', '系统自动生成的热销推荐'),
	(19, 5, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:23', '', '2025-09-10 16:34:23', '系统自动生成的热销推荐'),
	(20, 4, 5, '购买推荐：客户4购买了橙色向日葵', 1, 0, NULL, '', '2025-09-10 16:34:26', '', '2025-09-10 16:34:26', '基于购买行为生成的推荐'),
	(21, 4, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:26', '', '2025-09-10 16:34:26', '系统自动生成的热销推荐'),
	(22, 4, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:26', '', '2025-09-10 16:34:26', '系统自动生成的热销推荐'),
	(23, 3, 9, '购买推荐：客户3购买了红牡丹', 1, 0, NULL, '', '2025-09-10 16:34:28', '', '2025-09-10 16:34:28', '基于购买行为生成的推荐'),
	(24, 3, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:28', '', '2025-09-10 16:34:28', '系统自动生成的热销推荐'),
	(25, 3, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:28', '', '2025-09-10 16:34:28', '系统自动生成的热销推荐'),
	(26, 2, 2, '购买推荐：客户2购买了白百合', 1, 0, NULL, '', '2025-09-10 16:34:31', '', '2025-09-10 16:34:31', '基于购买行为生成的推荐'),
	(27, 2, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:31', '', '2025-09-10 16:34:31', '系统自动生成的热销推荐'),
	(28, 2, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:31', '', '2025-09-10 16:34:31', '系统自动生成的热销推荐'),
	(29, 1, 6, '购买推荐：客户1购买了紫色满天星', 1, 0, NULL, '', '2025-09-10 16:34:33', '', '2025-09-10 16:34:33', '基于购买行为生成的推荐'),
	(30, 9, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:36', '', '2025-09-10 16:34:36', '系统自动生成的热销推荐'),
	(31, 9, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:36', '', '2025-09-10 16:34:36', '系统自动生成的热销推荐'),
	(32, 10, 9, '购买推荐：客户10购买了红牡丹', 1, 0, NULL, '', '2025-09-10 16:34:39', '', '2025-09-10 16:34:39', '基于购买行为生成的推荐'),
	(33, 10, 1, '购买推荐：客户10购买了红玫瑰', 1, 0, NULL, '', '2025-09-10 16:34:39', '', '2025-09-10 16:34:39', '基于购买行为生成的推荐'),
	(34, 10, 6, '购买推荐：客户10购买了紫色满天星', 1, 0, NULL, '', '2025-09-10 16:34:39', '', '2025-09-10 16:34:39', '基于购买行为生成的推荐'),
	(35, 10, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:39', '', '2025-09-10 16:34:39', '系统自动生成的热销推荐'),
	(36, 10, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:39', '', '2025-09-10 16:34:39', '系统自动生成的热销推荐'),
	(37, 11, 1, '购买推荐：客户11购买了红玫瑰', 1, 0, NULL, '', '2025-09-10 16:34:46', '', '2025-09-10 16:34:46', '基于购买行为生成的推荐'),
	(38, 11, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:46', '', '2025-09-10 16:34:46', '系统自动生成的热销推荐'),
	(39, 11, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:34:46', '', '2025-09-10 16:34:46', '系统自动生成的热销推荐'),
	(40, 10, 2, '购买推荐：客户10购买了白百合', 1, 0, NULL, '', '2025-09-10 16:34:46', '', '2025-09-10 16:34:46', '基于购买行为生成的推荐'),
	(41, 8, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:37:44', '', '2025-09-10 16:37:44', '系统自动生成的热销推荐'),
	(42, 8, 2, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:37:44', '', '2025-09-10 16:37:44', '系统自动生成的热销推荐'),
	(43, 8, 8, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:37:44', '', '2025-09-10 16:37:44', '系统自动生成的热销推荐'),
	(44, 8, 3, '热销推荐：该鲜花销量高达2件', 3, 0, NULL, '', '2025-09-10 16:37:44', '', '2025-09-10 16:37:44', '系统自动生成的热销推荐'),
	(45, 8, 3, '购买推荐：客户8购买了粉康乃馨', 1, 0, NULL, '', '2025-09-10 16:37:56', '', '2025-09-10 16:37:56', '基于购买行为生成的推荐'),
	(46, 10, 3, '热销推荐：该鲜花销量高达2件', 3, 0, NULL, '', '2025-09-10 16:38:15', '', '2025-09-10 16:38:15', '系统自动生成的热销推荐'),
	(47, 10, 8, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:38:15', '', '2025-09-10 16:38:15', '系统自动生成的热销推荐'),
	(48, 1, 3, '热销推荐：该鲜花销量高达2件', 3, 0, NULL, '', '2025-09-10 16:42:48', '', '2025-09-10 16:42:48', '系统自动生成的热销推荐'),
	(49, 1, 8, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-10 16:42:48', '', '2025-09-10 16:42:48', '系统自动生成的热销推荐'),
	(50, 1, 1, '预定推荐：客户张三预定了红玫瑰', 2, 0, NULL, '', '2025-09-10 17:55:44', '', '2025-09-10 17:55:44', '基于预定行为生成的推荐'),
	(51, 2, 1, '预定推荐：客户李四预定了红玫瑰', 2, 0, NULL, '', '2025-09-10 17:56:06', '', '2025-09-10 17:56:06', '基于预定行为生成的推荐'),
	(52, 3, 1, '预定推荐：客户王五预定了红玫瑰', 2, 0, NULL, '', '2025-09-10 17:56:26', '', '2025-09-10 17:56:26', '基于预定行为生成的推荐'),
	(53, 2, 1, '购买推荐：客户2购买了红玫瑰', 1, 0, NULL, '', '2025-09-10 17:57:17', '', '2025-09-10 17:57:17', '基于购买行为生成的推荐'),
	(54, 3, 1, '购买推荐：客户3购买了红玫瑰', 1, 0, NULL, '', '2025-09-10 17:57:35', '', '2025-09-10 17:57:35', '基于购买行为生成的推荐'),
	(55, 1, 1, '预定推荐：客户张三预定了红玫瑰', 2, 0, NULL, '', '2025-09-11 09:13:31', '', '2025-09-11 09:13:31', '基于预定行为生成的推荐'),
	(56, 2, 1, '预定推荐：客户李四预定了红玫瑰', 2, 0, NULL, '', '2025-09-11 09:17:02', '', '2025-09-11 09:17:02', '基于预定行为生成的推荐'),
	(57, 7, 1, '热销推荐：该鲜花销量高达2件', 3, 0, NULL, '', '2025-09-11 09:18:45', '', '2025-09-11 09:18:45', '系统自动生成的热销推荐'),
	(58, 11, 3, '预定推荐：客户韩梅梅预定了粉康乃馨', 2, 0, NULL, '', '2025-09-11 12:28:47', '', '2025-09-11 12:28:47', '基于预定行为生成的推荐'),
	(59, 11, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:29:26', '', '2025-09-11 12:29:26', '系统自动生成的热销推荐'),
	(60, 11, 3, '购买推荐：客户11购买了粉康乃馨', 1, 0, NULL, '', '2025-09-11 12:29:44', '', '2025-09-11 12:29:44', '基于购买行为生成的推荐'),
	(61, 2, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:12', '', '2025-09-11 12:30:12', '系统自动生成的热销推荐'),
	(62, 3, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:12', '', '2025-09-11 12:30:12', '系统自动生成的热销推荐'),
	(63, 4, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:12', '', '2025-09-11 12:30:12', '系统自动生成的热销推荐'),
	(64, 5, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:13', '', '2025-09-11 12:30:13', '系统自动生成的热销推荐'),
	(65, 6, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:13', '', '2025-09-11 12:30:13', '系统自动生成的热销推荐'),
	(66, 7, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:13', '', '2025-09-11 12:30:13', '系统自动生成的热销推荐'),
	(67, 9, 3, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-11 12:30:13', '', '2025-09-11 12:30:13', '系统自动生成的热销推荐'),
	(68, 2, 1, '预定推荐：客户李四预定了红玫瑰', 2, 0, NULL, '', '2025-09-11 12:34:26', '', '2025-09-11 12:34:26', '基于预定行为生成的推荐'),
	(69, 14, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-15 10:57:13', '', '2025-09-15 10:57:13', '系统自动生成的热销推荐'),
	(70, 14, 1, '购买推荐：客户14购买了红玫瑰', 1, 0, NULL, '', '2025-09-15 10:58:01', '', '2025-09-15 10:58:01', '基于购买行为生成的推荐'),
	(71, 17, 1, '购买推荐：客户17购买了红玫瑰', 1, 0, NULL, '', '2025-09-15 11:03:28', '', '2025-09-15 11:03:28', '基于购买行为生成的推荐'),
	(72, 17, 1, '热销推荐：该鲜花销量高达1件', 3, 0, NULL, '', '2025-09-15 11:03:28', '', '2025-09-15 11:03:28', '系统自动生成的热销推荐');

-- 导出  表 flower_sales_system.flower_reservation 结构
CREATE TABLE IF NOT EXISTS `flower_reservation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '预定ID',
  `reservation_no` varchar(32) NOT NULL COMMENT '预定编号',
  `customer_id` bigint(20) NOT NULL COMMENT '客户ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `quantity` int(11) NOT NULL COMMENT '预定数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10,2) NOT NULL COMMENT '总金额',
  `reservation_date` date NOT NULL COMMENT '预定日期',
  `delivery_time` datetime DEFAULT NULL COMMENT '配送时间',
  `reservation_status` tinyint(1) DEFAULT 1 COMMENT '预定状态 1-待确认 2-已确认 3-已完成 4-已取消',
  `contact_person` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `delivery_address` varchar(200) DEFAULT NULL COMMENT '配送地址',
  `qr_code_url` text DEFAULT NULL COMMENT '预定二维码URL',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_reservation_no` (`reservation_no`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_flower_id` (`flower_id`),
  KEY `idx_reservation_status` (`reservation_status`),
  CONSTRAINT `fk_reservation_customer` FOREIGN KEY (`customer_id`) REFERENCES `flower_customer` (`id`),
  CONSTRAINT `fk_reservation_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='预定表';

-- 正在导出表  flower_sales_system.flower_reservation 的数据：~3 rows (大约)
INSERT INTO `flower_reservation` (`id`, `reservation_no`, `customer_id`, `flower_id`, `quantity`, `unit_price`, `total_amount`, `reservation_date`, `delivery_time`, `reservation_status`, `contact_person`, `contact_phone`, `delivery_address`, `qr_code_url`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(32, 'YD1757669825213', 16, 1, 1, 99.00, 99.00, '2025-09-12', '2025-09-12 00:00:00', 1, '梁山伯', '13200000000', '西安三桥新街', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABbElEQVR4Xu2WO5IDIQxERcQxuCkDN+UYRPR2C49d5S1vsAkKrKIw4hE0+jA2fDJ733jal/xNptES0KwsjswFrcQghRL7LCR92jVLpz+jEO1hVCc185SlUMRnhpNuOAK0DJKu6AYicI8R5RH8roOTxLtkKqh7vPXPSfKwIehxfVgEItVSWvOoyvbYixAEKkCO5rOGKfMhiDLsbeHtAn9g1r7PcSLViqLlcYEzePBCDKICHIlJZtazeleSgxAqNXnL1L7wDr64iECmPv5tPzDAzjaCEEgvVTcruoFnWzACuVWbz5cOPivxOHGPjbJznvk836rPE1afJC/FUuuax32f80QFCKnukr95CUKWWkRPi4rRb9CelXiWbJvytOGSVxAimVKdGFrfZgcnBCGFPx0umZ8OhwptDMLf7jmv6mPPdjiiLtHe619AEKIuIWdQTfKjEEB7W/Xis7dLMgRRfpN7jWJ1iTuix8kn+5L/kR/AFvpeGqb9gQAAAABJRU5ErkJggg==', '', '2025-09-12 17:37:05', '', '2025-09-12 17:38:00', '无'),
	(33, 'YD1757904889340', 14, 1, 1, 99.00, 99.00, '2025-09-15', NULL, 1, '台灯一二三', '13259703577', '西安三桥', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABdUlEQVR4Xu2WMXbEIAxERcUxuCmGm/oYqlBmhmSTzXubIg0qVs9vF/RdjEbItsWrsN+JR7zJ38QNUbxxUW+zNphoOUiDxMl0DN0ysfcsZBh2d3G7lMNdLCITgWrEVAW5CJaARl9TkaDStpjjLTOez8FJQq1l53QNJnKQHU6xo8ZSzxkZCHqrESkgkFtvSF6f9ZwmEXBxIYcdhd+93pdnIUtTMsy60oXjkoTc3ex6Jr1GFlJpZJGvWE82/1P1aUJHd27AWtgJ7d9enyX8n5J88YVGR0t8eX2YwEIKH3y0wF2SKwnRGeTOaaq0s4gUhJKtS3WwAkh+1HOaUCzb+5XT2lXPcRJ8gy32GXOsUVbzUxC34vxoCowLuDF6ErKD57HN7SUuRAbilFmCei/+akR813OctJBYdHhVzDHThDmIvGQOi11Er3I0C+GsDD75WvBIZiLOhLqNoZH8HCTYbboI1ZCPSEM0JTyJxkHxHyfxOHkVb/I/8gFoZgVBnOPRTgAAAABJRU5ErkJggg==', '', '2025-09-15 10:54:49', '', '2025-09-15 10:54:49', '无'),
	(34, 'YD1757905280542', 15, 1, 1, 99.00, 99.00, '2025-09-15', '2025-09-16 00:00:00', 1, '冯程程', '13277777777', '三桥新街', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABbElEQVR4Xu2VO3LDMAxEoYrH4E1F6qY8hittdhdyPMmMU6QRCmM4Mo2HYokPGXhn8dvxbR/yN3kEbcPaox/AjD7l6DVIp8Qjv97wK2cNQqVycNNwNsLYShFJXntbUZCw5m1twCxGoCIHJbMZRfCzD+4kGorN1c415ahB0qQa1n45ShD/cyLXcJ2n81qEBOt8SV7BXALnM9e3k2E4tOmnLhiNSxXCXEJ6ndS8aWoQ/a7Nw0E3dAJMZ/R+kpPBHswQRuoQeZ4KRKrZfSn8gN60EgQcERY5ay6bfm9LEOnlpRK7JPNL7c/b5Xai+VBSuaK5By28BPF8yJxIrskQ8goEr0fs8Pie3pcgHAtPhgjUkpRMTwmS9sg7z7nMQ1QgkskpsUNuSVZSS5AO5RKaYyxDh9Qg02/s7jtmuNqMLUR0K+OQXtV8PF6q7yd+Y2fTo6GoMgT5T1Brb0uNWYIwh1edB2Nc7dlQgryzD/kf+QITAw2N+AVEygAAAABJRU5ErkJggg==', '', '2025-09-15 11:01:20', '', '2025-09-15 11:01:58', '无');

-- 导出  表 flower_sales_system.flower_sales_history 结构
CREATE TABLE IF NOT EXISTS `flower_sales_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '销售历史ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `flower_id` bigint(20) NOT NULL COMMENT '鲜花ID',
  `customer_id` bigint(20) NOT NULL COMMENT '客户ID',
  `quantity` int(11) NOT NULL COMMENT '销售数量',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价',
  `total_amount` decimal(10,2) NOT NULL COMMENT '总金额',
  `sale_date` date NOT NULL COMMENT '销售日期',
  `sale_time` datetime NOT NULL COMMENT '销售时间',
  `payment_method` tinyint(1) DEFAULT 1 COMMENT '支付方式 1-微信 2-支付宝 3-银行卡 4-现金',
  `salesperson` varchar(50) DEFAULT NULL COMMENT '销售人员',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_flower_id` (`flower_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_sale_date` (`sale_date`),
  CONSTRAINT `fk_sales_customer` FOREIGN KEY (`customer_id`) REFERENCES `flower_customer` (`id`),
  CONSTRAINT `fk_sales_flower` FOREIGN KEY (`flower_id`) REFERENCES `flower_info` (`id`),
  CONSTRAINT `fk_sales_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='销售历史记录表';

-- 正在导出表  flower_sales_system.flower_sales_history 的数据：~1 rows (大约)
INSERT INTO `flower_sales_history` (`id`, `order_id`, `flower_id`, `customer_id`, `quantity`, `unit_price`, `total_amount`, `sale_date`, `sale_time`, `payment_method`, `salesperson`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(19, 28, 1, 14, 1, 99.00, 99.00, '2025-09-15', '2025-09-15 10:57:12', 1, '系统自动', '', '2025-09-15 10:57:13', '', '2025-09-15 10:57:13', NULL);

-- 导出  表 flower_sales_system.gen_table 结构
CREATE TABLE IF NOT EXISTS `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';

-- 正在导出表  flower_sales_system.gen_table 的数据：~0 rows (大约)
INSERT INTO `gen_table` (`table_id`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `tpl_web_type`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(7, 'flower_reservation', '预定表', NULL, NULL, 'FlowerReservation', 'crud', 'element-ui', 'com.shop.app', 'reservation', 'reservation', '预定管理', 'ruoyi', '0', '/', '{"parentMenuId":2000}', 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28', NULL);

-- 导出  表 flower_sales_system.gen_table_column 结构
CREATE TABLE IF NOT EXISTS `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';

-- 正在导出表  flower_sales_system.gen_table_column 的数据：~19 rows (大约)
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(88, 7, 'id', '预定ID', 'bigint(20)', 'Long', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(89, 7, 'reservation_no', '预定编号', 'varchar(32)', 'String', 'reservationNo', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(90, 7, 'customer_id', '客户ID', 'bigint(20)', 'Long', 'customerId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(91, 7, 'flower_id', '鲜花ID', 'bigint(20)', 'Long', 'flowerId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(92, 7, 'quantity', '预定数量', 'int(11)', 'Long', 'quantity', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(93, 7, 'unit_price', '单价', 'decimal(10,2)', 'BigDecimal', 'unitPrice', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(94, 7, 'total_amount', '总金额', 'decimal(10,2)', 'BigDecimal', 'totalAmount', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 7, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(95, 7, 'reservation_date', '预定日期', 'date', 'Date', 'reservationDate', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 8, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(96, 7, 'delivery_time', '配送时间', 'datetime', 'Date', 'deliveryTime', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'datetime', '', 9, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(97, 7, 'reservation_status', '预定状态 1-待确认 2-已确认 3-已完成 4-已取消', 'tinyint(1)', 'Integer', 'reservationStatus', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'radio', '', 10, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(98, 7, 'contact_person', '联系人', 'varchar(50)', 'String', 'contactPerson', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 11, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(99, 7, 'contact_phone', '联系电话', 'varchar(20)', 'String', 'contactPhone', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 12, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(100, 7, 'delivery_address', '配送地址', 'varchar(200)', 'String', 'deliveryAddress', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 13, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(101, 7, 'qr_code_url', '预定二维码URL', 'varchar(255)', 'String', 'qrCodeUrl', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'select', 'flower_reservation_status', 14, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(102, 7, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(103, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(104, 7, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'input', '', 17, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(105, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28'),
	(106, 7, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 19, 'admin', '2025-09-10 09:49:20', '', '2025-09-10 10:59:28');

-- 导出  表 flower_sales_system.qrtz_blob_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob DEFAULT NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blob类型的触发器表';

-- 正在导出表  flower_sales_system.qrtz_blob_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_calendars 结构
CREATE TABLE IF NOT EXISTS `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='日历信息表';

-- 正在导出表  flower_sales_system.qrtz_calendars 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_cron_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cron类型的触发器表';

-- 正在导出表  flower_sales_system.qrtz_cron_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_fired_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='已触发的触发器表';

-- 正在导出表  flower_sales_system.qrtz_fired_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_job_details 结构
CREATE TABLE IF NOT EXISTS `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob DEFAULT NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务详细信息表';

-- 正在导出表  flower_sales_system.qrtz_job_details 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_locks 结构
CREATE TABLE IF NOT EXISTS `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='存储的悲观锁信息表';

-- 正在导出表  flower_sales_system.qrtz_locks 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_paused_trigger_grps 结构
CREATE TABLE IF NOT EXISTS `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂停的触发器表';

-- 正在导出表  flower_sales_system.qrtz_paused_trigger_grps 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_scheduler_state 结构
CREATE TABLE IF NOT EXISTS `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='调度器状态表';

-- 正在导出表  flower_sales_system.qrtz_scheduler_state 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_simple_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='简单触发器的信息表';

-- 正在导出表  flower_sales_system.qrtz_simple_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_simprop_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步机制的行锁表';

-- 正在导出表  flower_sales_system.qrtz_simprop_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.qrtz_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob DEFAULT NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='触发器详细信息表';

-- 正在导出表  flower_sales_system.qrtz_triggers 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.sys_config 结构
CREATE TABLE IF NOT EXISTS `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';

-- 正在导出表  flower_sales_system.sys_config 的数据：~8 rows (大约)
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
	(2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '初始化密码 123456'),
	(3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '深色主题theme-dark，浅色主题theme-light'),
	(4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '是否开启验证码功能（true开启，false关闭）'),
	(5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '是否开启注册用户功能（true开启，false关闭）'),
	(6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),
	(7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),
	(8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-08 11:14:56', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- 导出  表 flower_sales_system.sys_dept 结构
CREATE TABLE IF NOT EXISTS `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';

-- 正在导出表  flower_sales_system.sys_dept 的数据：~10 rows (大约)
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL),
	(109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-08 11:14:51', '', NULL);

-- 导出  表 flower_sales_system.sys_dict_data 结构
CREATE TABLE IF NOT EXISTS `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';

-- 正在导出表  flower_sales_system.sys_dict_data 的数据：~48 rows (大约)
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '性别男'),
	(2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '性别女'),
	(3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '性别未知'),
	(4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '显示菜单'),
	(5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '隐藏菜单'),
	(6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '正常状态'),
	(7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '停用状态'),
	(8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '正常状态'),
	(9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '停用状态'),
	(10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '默认分组'),
	(11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '系统分组'),
	(12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '系统默认是'),
	(13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '系统默认否'),
	(14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '通知'),
	(15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '公告'),
	(16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '正常状态'),
	(17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '关闭状态'),
	(18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '其他操作'),
	(19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '新增操作'),
	(20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '修改操作'),
	(21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '删除操作'),
	(22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '授权操作'),
	(23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '导出操作'),
	(24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '导入操作'),
	(25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '强退操作'),
	(26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '生成操作'),
	(27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '清空操作'),
	(28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '正常状态'),
	(29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '停用状态'),
	(100, 0, '正常', '1', 'category_status', NULL, 'default', 'N', '0', 'admin', '2025-09-08 15:04:08', '', NULL, NULL),
	(101, 0, '禁用', '0', 'category_status', NULL, 'default', 'N', '0', 'admin', '2025-09-08 15:04:16', '', NULL, NULL),
	(102, 0, '上架', '1', 'flower_status', NULL, 'default', 'N', '0', 'admin', '2025-09-08 16:05:12', '', NULL, NULL),
	(103, 0, '下架', '0', 'flower_status', NULL, 'default', 'N', '0', 'admin', '2025-09-08 16:05:22', '', NULL, NULL),
	(104, 0, '正常', '1', 'customer_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:37:11', '', NULL, NULL),
	(105, 0, '禁用', '0', 'customer_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:37:17', 'admin', '2025-09-09 09:37:42', NULL),
	(106, 0, '普通', '1', 'customer_level', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:38:44', '', NULL, NULL),
	(107, 0, '银卡', '2', 'customer_level', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:38:53', 'admin', '2025-09-09 09:39:10', NULL),
	(108, 0, '金卡', '3', 'customer_level', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:39:03', '', NULL, NULL),
	(109, 0, '钻石', '4', 'customer_level', NULL, 'default', 'N', '0', 'admin', '2025-09-09 09:39:24', '', NULL, NULL),
	(110, 0, '普通订单', '1', 'order_type', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:46:14', '', NULL, NULL),
	(111, 0, '预定订单', '2', 'order_type', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:46:22', '', NULL, NULL),
	(112, 0, '待支付', '1', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:47:15', '', NULL, NULL),
	(113, 0, '已支付', '2', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:47:43', '', NULL, NULL),
	(114, 0, '已付款', '3', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:47:49', '', NULL, NULL),
	(115, 0, '已发货', '4', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:48:33', '', NULL, NULL),
	(116, 0, '已完成', '5', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:48:50', '', NULL, NULL),
	(117, 0, '已取消', '6', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:48:58', '', NULL, NULL),
	(118, 0, '微信支付', '1', 'order_pay_method', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:56:49', '', NULL, NULL),
	(119, 0, '支付宝', '2', 'order_pay_method', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:56:55', '', NULL, NULL),
	(120, 0, '银行卡', '3', 'order_pay_method', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:57:02', '', NULL, NULL),
	(121, 0, '现金', '4', 'order_pay_method', NULL, 'default', 'N', '0', 'admin', '2025-09-09 13:57:12', 'admin', '2025-09-09 13:57:30', NULL),
	(122, 0, '待确认', '1', 'flower_reservation_status', NULL, 'default', 'N', '0', 'admin', '2025-09-10 09:42:51', '', NULL, NULL),
	(123, 0, '已确认', '2', 'flower_reservation_status', NULL, 'default', 'N', '0', 'admin', '2025-09-10 09:42:59', '', NULL, NULL),
	(124, 0, '已完成', '3', 'flower_reservation_status', NULL, 'default', 'N', '0', 'admin', '2025-09-10 09:43:12', '', NULL, NULL),
	(125, 0, '已取消', '4', 'flower_reservation_status', NULL, 'default', 'N', '0', 'admin', '2025-09-10 09:43:23', '', NULL, NULL);

-- 导出  表 flower_sales_system.sys_dict_type 结构
CREATE TABLE IF NOT EXISTS `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';

-- 正在导出表  flower_sales_system.sys_dict_type 的数据：~15 rows (大约)
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '用户性别列表'),
	(2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '菜单状态列表'),
	(3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '系统开关列表'),
	(4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '任务状态列表'),
	(5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '任务分组列表'),
	(6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '系统是否列表'),
	(7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '通知类型列表'),
	(8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '通知状态列表'),
	(9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '操作类型列表'),
	(10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-08 11:14:56', '', NULL, '登录状态列表'),
	(100, '类别状态', 'category_status', '0', 'admin', '2025-09-08 15:03:47', '', NULL, NULL),
	(101, '鲜花状态', 'flower_status', '0', 'admin', '2025-09-08 16:04:42', '', NULL, NULL),
	(102, '客户状态', 'customer_status', '0', 'admin', '2025-09-09 09:36:56', '', NULL, NULL),
	(103, '客户等级', 'customer_level', '0', 'admin', '2025-09-09 09:38:31', '', NULL, NULL),
	(104, '订单类型', 'order_type', '0', 'admin', '2025-09-09 13:45:54', '', NULL, NULL),
	(105, '订单状态', 'order_status', '0', 'admin', '2025-09-09 13:46:53', '', NULL, NULL),
	(106, '订单支付方式', 'order_pay_method', '0', 'admin', '2025-09-09 13:56:25', '', NULL, NULL),
	(107, '预定状态', 'flower_reservation_status', '0', 'admin', '2025-09-10 09:42:27', '', NULL, NULL);

-- 导出  表 flower_sales_system.sys_job 结构
CREATE TABLE IF NOT EXISTS `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';

-- 正在导出表  flower_sales_system.sys_job 的数据：~3 rows (大约)
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-08 11:14:56', '', NULL, ''),
	(2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-08 11:14:56', '', NULL, ''),
	(3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-08 11:14:56', '', NULL, ''),
	(100, '删除已完成历史订单', 'DEFAULT', 'ryTask.processCompletedOrders()', '0 0 0 * * ?', '1', '1', '1', 'admin', '2025-09-10 16:33:52', '', NULL, '');

-- 导出  表 flower_sales_system.sys_job_log 结构
CREATE TABLE IF NOT EXISTS `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度日志表';

-- 正在导出表  flower_sales_system.sys_job_log 的数据：~0 rows (大约)

-- 导出  表 flower_sales_system.sys_logininfor 结构
CREATE TABLE IF NOT EXISTS `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';

-- 正在导出表  flower_sales_system.sys_logininfor 的数据：~31 rows (大约)
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES
	(100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-08 11:56:04'),
	(101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-08 11:57:37'),
	(102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-08 14:55:14'),
	(103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-08 18:51:33'),
	(104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-08 18:52:18'),
	(105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-08 19:51:53'),
	(106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-09 08:56:43'),
	(107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-09 09:30:04'),
	(108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-09 11:51:20'),
	(109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-09 13:14:47'),
	(110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-09 17:18:11'),
	(111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-10 09:38:03'),
	(112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-10 09:38:06'),
	(113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-10 10:52:32'),
	(114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-10 13:09:22'),
	(115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-10 15:09:04'),
	(116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-10 17:49:20'),
	(117, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 09:09:19'),
	(118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-11 09:34:37'),
	(119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-11 09:38:30'),
	(120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 09:38:35'),
	(121, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 11:50:16'),
	(122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-11 12:28:16'),
	(123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-11 12:28:20'),
	(124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 11:36:46'),
	(125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 15:00:45'),
	(126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 16:01:39'),
	(127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-12 17:25:06'),
	(128, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-12 17:25:14'),
	(129, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-15 09:03:14'),
	(130, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-15 10:35:24'),
	(131, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-15 10:35:30');

-- 导出  表 flower_sales_system.sys_menu 结构
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2037 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';

-- 正在导出表  flower_sales_system.sys_menu 的数据：~110 rows (大约)
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-09-08 11:14:54', '', NULL, '系统管理目录'),
	(2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-09-08 11:14:54', '', NULL, '系统监控目录'),
	(3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-09-08 11:14:54', '', NULL, '系统工具目录'),
	(4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2025-09-08 11:14:54', 'admin', '2025-09-08 15:02:04', '若依官网地址'),
	(100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-09-08 11:14:55', '', NULL, '用户管理菜单'),
	(101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-09-08 11:14:55', '', NULL, '角色管理菜单'),
	(102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-09-08 11:14:55', '', NULL, '菜单管理菜单'),
	(103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-09-08 11:14:55', '', NULL, '部门管理菜单'),
	(104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-09-08 11:14:55', '', NULL, '岗位管理菜单'),
	(105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-09-08 11:14:55', '', NULL, '字典管理菜单'),
	(106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-09-08 11:14:55', '', NULL, '参数设置菜单'),
	(107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-09-08 11:14:55', '', NULL, '通知公告菜单'),
	(108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-09-08 11:14:55', '', NULL, '日志管理菜单'),
	(109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-09-08 11:14:55', '', NULL, '在线用户菜单'),
	(110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-09-08 11:14:55', '', NULL, '定时任务菜单'),
	(111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-09-08 11:14:55', '', NULL, '数据监控菜单'),
	(112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-09-08 11:14:55', '', NULL, '服务监控菜单'),
	(113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-09-08 11:14:55', '', NULL, '缓存监控菜单'),
	(114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-09-08 11:14:55', '', NULL, '缓存列表菜单'),
	(115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '1', '0', 'tool:build:list', 'build', 'admin', '2025-09-08 11:14:55', 'admin', '2025-09-08 15:02:20', '表单构建菜单'),
	(116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-09-08 11:14:55', '', NULL, '代码生成菜单'),
	(117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '1', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-09-08 11:14:55', 'admin', '2025-09-08 15:02:29', '系统接口菜单'),
	(500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-09-08 11:14:55', '', NULL, '操作日志菜单'),
	(501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-09-08 11:14:55', '', NULL, '登录日志菜单'),
	(1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-09-08 11:14:55', '', NULL, ''),
	(2000, '数据管理', 0, 0, 'shopping', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'date-range', 'admin', '2025-09-08 15:05:07', '', NULL, ''),
	(2001, '鲜花分类', 2000, 2, 'category', 'category/category/index', NULL, '', 1, 0, 'C', '0', '0', 'category:category:list', '#', 'admin', '2025-09-08 15:07:35', 'admin', '2025-09-12 17:28:52', '鲜花分类菜单'),
	(2002, '鲜花分类查询', 2001, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'category:category:query', '#', 'admin', '2025-09-08 15:07:39', '', NULL, ''),
	(2003, '鲜花分类新增', 2001, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'category:category:add', '#', 'admin', '2025-09-08 15:07:39', '', NULL, ''),
	(2004, '鲜花分类修改', 2001, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'category:category:edit', '#', 'admin', '2025-09-08 15:07:39', '', NULL, ''),
	(2005, '鲜花分类删除', 2001, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'category:category:remove', '#', 'admin', '2025-09-08 15:07:39', '', NULL, ''),
	(2006, '鲜花分类导出', 2001, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'category:category:export', '#', 'admin', '2025-09-08 15:07:39', '', NULL, ''),
	(2007, '鲜花信息', 2000, 3, 'info', 'info/info/index', NULL, '', 1, 0, 'C', '0', '0', 'info:info:list', '#', 'admin', '2025-09-08 16:07:38', 'admin', '2025-09-12 17:29:27', '鲜花信息菜单'),
	(2008, '鲜花信息查询', 2007, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'info:info:query', '#', 'admin', '2025-09-08 16:07:39', '', NULL, ''),
	(2009, '鲜花信息新增', 2007, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'info:info:add', '#', 'admin', '2025-09-08 16:07:39', '', NULL, ''),
	(2010, '鲜花信息修改', 2007, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'info:info:edit', '#', 'admin', '2025-09-08 16:07:39', '', NULL, ''),
	(2011, '鲜花信息删除', 2007, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'info:info:remove', '#', 'admin', '2025-09-08 16:07:39', '', NULL, ''),
	(2012, '鲜花信息导出', 2007, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'info:info:export', '#', 'admin', '2025-09-08 16:07:39', '', NULL, ''),
	(2013, '客户信息', 2000, 4, 'customer', 'customer/customer/index', NULL, '', 1, 0, 'C', '0', '0', 'customer:customer:list', '#', 'admin', '2025-09-09 09:41:29', 'admin', '2025-09-12 17:29:58', '客户信息菜单'),
	(2014, '客户信息查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'customer:customer:query', '#', 'admin', '2025-09-09 09:41:32', '', NULL, ''),
	(2015, '客户信息新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'customer:customer:add', '#', 'admin', '2025-09-09 09:41:32', '', NULL, ''),
	(2016, '客户信息修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'customer:customer:edit', '#', 'admin', '2025-09-09 09:41:32', '', NULL, ''),
	(2017, '客户信息删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'customer:customer:remove', '#', 'admin', '2025-09-09 09:41:32', '', NULL, ''),
	(2018, '客户信息导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'customer:customer:export', '#', 'admin', '2025-09-09 09:41:32', '', NULL, ''),
	(2019, '库存管理', 2000, 5, 'inventory', 'inventory/inventory/index', NULL, '', 1, 0, 'C', '0', '0', 'inventory:inventory:list', '#', 'admin', '2025-09-09 13:19:51', 'admin', '2025-09-12 17:29:44', '库存菜单'),
	(2020, '库存查询', 2019, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'inventory:inventory:query', '#', 'admin', '2025-09-09 13:19:52', '', NULL, ''),
	(2021, '库存新增', 2019, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'inventory:inventory:add', '#', 'admin', '2025-09-09 13:19:52', '', NULL, ''),
	(2022, '库存修改', 2019, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'inventory:inventory:edit', '#', 'admin', '2025-09-09 13:19:52', '', NULL, ''),
	(2023, '库存删除', 2019, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'inventory:inventory:remove', '#', 'admin', '2025-09-09 13:19:52', '', NULL, ''),
	(2024, '库存导出', 2019, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'inventory:inventory:export', '#', 'admin', '2025-09-09 13:19:52', '', NULL, ''),
	(2025, '订单管理', 2000, 1, 'order', 'order/order/index', NULL, '', 1, 0, 'C', '0', '0', 'order:order:list', '#', 'admin', '2025-09-09 13:53:10', '', NULL, '订单管理菜单'),
	(2026, '订单管理查询', 2025, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:order:query', '#', 'admin', '2025-09-09 13:53:10', '', NULL, ''),
	(2027, '订单管理新增', 2025, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:order:add', '#', 'admin', '2025-09-09 13:53:10', '', NULL, ''),
	(2028, '订单管理修改', 2025, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:order:edit', '#', 'admin', '2025-09-09 13:53:10', '', NULL, ''),
	(2029, '订单管理删除', 2025, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:order:remove', '#', 'admin', '2025-09-09 13:53:10', '', NULL, ''),
	(2030, '订单管理导出', 2025, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'order:order:export', '#', 'admin', '2025-09-09 13:53:10', '', NULL, ''),
	(2031, '预定管理', 2000, 0, 'reservation', 'reservation/reservation/index', NULL, '', 1, 0, 'C', '0', '0', 'reservation:reservation:list', '#', 'admin', '2025-09-10 09:51:02', 'admin', '2025-09-10 11:55:01', '预定管理菜单'),
	(2032, '预定管理查询', 2031, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'reservation:reservation:query', '#', 'admin', '2025-09-10 09:51:04', '', NULL, ''),
	(2033, '预定管理新增', 2031, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'reservation:reservation:add', '#', 'admin', '2025-09-10 09:51:04', '', NULL, ''),
	(2034, '预定管理修改', 2031, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'reservation:reservation:edit', '#', 'admin', '2025-09-10 09:51:04', '', NULL, ''),
	(2035, '预定管理删除', 2031, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'reservation:reservation:remove', '#', 'admin', '2025-09-10 09:51:04', '', NULL, ''),
	(2036, '预定管理导出', 2031, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'reservation:reservation:export', '#', 'admin', '2025-09-10 09:51:04', '', NULL, '');

-- 导出  表 flower_sales_system.sys_notice 结构
CREATE TABLE IF NOT EXISTS `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob DEFAULT NULL COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';

-- 正在导出表  flower_sales_system.sys_notice 的数据：~2 rows (大约)
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', _binary 0xe696b0e78988e69cace58685e5aeb9, '0', 'admin', '2025-09-08 11:14:57', '', NULL, '管理员'),
	(2, '维护通知：2018-07-01 若依系统凌晨维护', '1', _binary 0xe7bbb4e68aa4e58685e5aeb9, '0', 'admin', '2025-09-08 11:14:57', '', NULL, '管理员');

-- 导出  表 flower_sales_system.sys_oper_log 结构
CREATE TABLE IF NOT EXISTS `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';

-- 正在导出表  flower_sales_system.sys_oper_log 的数据：~261 rows (大约)
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES
	(100, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2025-09-08 11:14:54","icon":"guide","isCache":"0","isFrame":"0","menuId":4,"menuName":"若依官网","menuType":"M","orderNum":4,"params":{},"parentId":0,"path":"http://ruoyi.vip","perms":"","query":"","routeName":"","status":"0","updateBy":"admin","visible":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:02:05', 58),
	(101, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"tool/build/index","createTime":"2025-09-08 11:14:55","icon":"build","isCache":"0","isFrame":"1","menuId":115,"menuName":"表单构建","menuType":"C","orderNum":1,"params":{},"parentId":3,"path":"build","perms":"tool:build:list","query":"","routeName":"","status":"0","updateBy":"admin","visible":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:02:20', 15),
	(102, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"tool/swagger/index","createTime":"2025-09-08 11:14:55","icon":"swagger","isCache":"0","isFrame":"1","menuId":117,"menuName":"系统接口","menuType":"C","orderNum":3,"params":{},"parentId":3,"path":"swagger","perms":"tool:swagger:list","query":"","routeName":"","status":"0","updateBy":"admin","visible":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:02:29', 24),
	(103, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_category"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:02:54', 171),
	(104, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"类别状态","dictType":"category_status","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:03:47', 27),
	(105, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"正常","dictSort":0,"dictType":"category_status","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:04:08', 29),
	(106, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"禁用","dictSort":0,"dictType":"category_status","dictValue":"0","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:04:16', 20),
	(107, '菜单管理', 1, 'com.shop.app.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createBy":"admin","icon":"date-range","isCache":"0","isFrame":"1","menuName":"数据管理","menuType":"M","orderNum":0,"params":{},"parentId":0,"path":"shopping","status":"0","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:05:08', 12),
	(108, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"category","className":"FlowerCategory","columns":[{"capJavaField":"Id","columnComment":"分类ID","columnId":1,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-08 15:02:54","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":1,"updateBy":"","usableColumn":false},{"capJavaField":"CategoryName","columnComment":"分类名称","columnId":2,"columnName":"category_name","columnType":"varchar(50)","createBy":"admin","createTime":"2025-09-08 15:02:54","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"categoryName","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"LIKE","required":true,"sort":2,"superColumn":false,"tableId":1,"updateBy":"","usableColumn":false},{"capJavaField":"CategoryDesc","columnComment":"分类描述","columnId":3,"columnName":"category_desc","columnType":"varchar(200)","createBy":"admin","createTime":"2025-09-08 15:02:54","dictType":"","edit":true,"htmlType":"editor","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"0","isRequired":"1","javaField":"categoryDesc","javaType":"String","list":true,"params":{},"pk":false,"query":false,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":1,"updateBy":"","usableColumn":false},{"capJavaField":"SortOrder","columnComment":"排序","columnId":4,"columnName":"sort_order","columnType":"int(11)","createBy":"admin","createTime":"2025-09-08 15:02:54","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuer', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:06:56', 96),
	(109, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"玫瑰花系列","categoryName":"玫瑰","createBy":"","createTime":"2025-09-08 11:12:16","id":1,"params":{},"remark":"情人节主打rre","sortOrder":1,"status":1,"updateBy":"","updateTime":"2025-09-08 11:12:16"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:24:15', 26),
	(110, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"玫瑰花系列","categoryName":"玫瑰","createBy":"","createTime":"2025-09-08 11:12:16","id":1,"params":{},"remark":"情人节主打rretttt","sortOrder":1,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:29:30"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:29:30', 17),
	(111, '鲜花分类', 1, 'com.shop.app.controller.FlowerCategoryController.add()', 'POST', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"eeeeeeeeeeeeeeeee","categoryName":"e","createBy":"admin","createTime":"2025-09-08 15:29:52","id":11,"params":{},"remark":"eeee","sortOrder":0,"status":1}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:29:52', 17),
	(112, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"菊花系列","categoryName":"菊花","createBy":"","createTime":"2025-09-08 11:12:16","id":10,"params":{},"remark":"秋季特色eer","sortOrder":10,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:30:06"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:30:06', 19),
	(113, '鲜花分类', 3, 'com.shop.app.controller.FlowerCategoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/category/category/11', '127.0.0.1', '内网IP', '[11]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:33:06', 61),
	(114, '鲜花分类', 1, 'com.shop.app.controller.FlowerCategoryController.add()', 'POST', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"erer","categoryName":"erer","createBy":"admin","createTime":"2025-09-08 15:33:14","id":12,"params":{},"remark":"erer","sortOrder":0,"status":1}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:33:15', 18),
	(115, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"erer","categoryName":"erer","createBy":"admin","createTime":"2025-09-08 15:33:14","id":12,"params":{},"remark":"ererererer","sortOrder":0,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:33:24"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:33:24', 20),
	(116, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"erer","categoryName":"erer","createBy":"admin","createTime":"2025-09-08 15:33:14","id":12,"params":{},"remark":"ererererer","sortOrder":3,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:33:39"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:33:39', 16),
	(117, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"玫瑰花系列","categoryName":"玫瑰","createBy":"","createTime":"2025-09-08 11:12:16","id":1,"params":{},"remark":"情人节主打rretttt","sortOrder":0,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:33:50"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:33:50', 15),
	(118, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"erer","categoryName":"erer","createBy":"admin","createTime":"2025-09-08 15:33:14","id":12,"params":{},"remark":"ererererer","sortOrder":0,"status":1,"updateBy":"admin","updateTime":"2025-09-08 15:34:03"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:34:03', 8),
	(119, '鲜花分类', 3, 'com.shop.app.controller.FlowerCategoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/category/category/12', '127.0.0.1', '内网IP', '[12]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:34:11', 22),
	(120, '鲜花分类', 3, 'com.shop.app.controller.FlowerCategoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/category/category/1', '127.0.0.1', '内网IP', '[1]', '{"msg":"分类\'玫瑰\'下有关联的鲜花，不能删除","code":500}', 0, NULL, '2025-09-08 15:34:17', 8),
	(121, '鲜花分类', 5, 'com.shop.app.controller.FlowerCategoryController.export()', 'POST', 1, 'admin', '研发部门', '/category/category/export', '127.0.0.1', '内网IP', '{"pageSize":"10","pageNum":"1"}', NULL, 0, NULL, '2025-09-08 15:34:50', 2232),
	(122, '鲜花分类', 5, 'com.shop.app.controller.FlowerCategoryController.export()', 'POST', 1, 'admin', '研发部门', '/category/category/export', '127.0.0.1', '内网IP', '{"pageSize":"10","pageNum":"1"}', NULL, 0, NULL, '2025-09-08 15:37:27', 253),
	(123, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/1', '127.0.0.1', '内网IP', '[1]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:47:00', 159),
	(124, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_info"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 15:47:51', 244),
	(125, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"鲜花状态","dictType":"flower_status","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 16:04:42', 18),
	(126, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"上架","dictSort":0,"dictType":"flower_status","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 16:05:12', 20),
	(127, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"下架","dictSort":0,"dictType":"flower_status","dictValue":"0","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 16:05:23', 21),
	(128, '代码生成', 2, 'com.shop.app.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/flower_info', '127.0.0.1', '内网IP', '{}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 16:05:33', 101),
	(129, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"info","className":"FlowerInfo","columns":[{"capJavaField":"Id","columnComment":"鲜花ID","columnId":11,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-08 15:47:51","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":2,"updateBy":"","updateTime":"2025-09-08 16:05:33","usableColumn":false},{"capJavaField":"FlowerName","columnComment":"鲜花名称","columnId":12,"columnName":"flower_name","columnType":"varchar(100)","createBy":"admin","createTime":"2025-09-08 15:47:51","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"flowerName","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"LIKE","required":true,"sort":2,"superColumn":false,"tableId":2,"updateBy":"","updateTime":"2025-09-08 16:05:33","usableColumn":false},{"capJavaField":"CategoryId","columnComment":"分类ID","columnId":13,"columnName":"category_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-08 15:47:51","dictType":"","edit":true,"htmlType":"select","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"categoryId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":2,"updateBy":"","updateTime":"2025-09-08 16:05:33","usableColumn":false},{"capJavaField":"FlowerDesc","columnComment":"鲜花描述","columnId":14,"columnName":"flower_desc","columnType":"text","createBy":"admin","createTime":"2025-09-08 15:47:51","dictType":"","edit":true,"htmlType":"textarea","increment":false,"i', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 16:07:24', 100),
	(130, '用户头像', 2, 'com.shop.app.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{"msg":"操作成功","imgUrl":"/profile/avatar/2025/09/08/8a2dff9705f5490b870117ef56a80bd7.jpg","code":200}', 0, NULL, '2025-09-08 17:12:56', 119),
	(131, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.addWithImages()', 'POST', 1, 'admin', '研发部门', '/info/info/addWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"1","flowerDesc":"1","price":"1","flowerName":"1","costPrice":"1","remark":"1","stock":"100","categoryId":"1","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:38:54', 480),
	(132, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.addWithImages()', 'POST', 1, 'admin', '研发部门', '/info/info/addWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"20","flowerDesc":"3434","price":"10","flowerName":"222","costPrice":"5","remark":"43434","categoryId":"1","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:40:22', 63),
	(133, '鲜花信息', 3, 'com.shop.app.controller.FlowerInfoController.remove()', 'DELETE', 1, 'admin', '研发部门', '/info/info/12', '127.0.0.1', '内网IP', '[12]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:41:56', 46),
	(134, '鲜花信息', 3, 'com.shop.app.controller.FlowerInfoController.remove()', 'DELETE', 1, 'admin', '研发部门', '/info/info/11', '127.0.0.1', '内网IP', '[11]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:41:57', 16),
	(135, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.addWithImages()', 'POST', 1, 'admin', '研发部门', '/info/info/addWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"1","flowerDesc":"1","price":"1","flowerName":"1","costPrice":"1","remark":"1212","stock":"10","categoryId":"1","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:47:54', 68),
	(136, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.addWithImages()', 'POST', 1, 'admin', '研发部门', '/info/info/addWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"20","flowerDesc":"222","price":"10","flowerName":"2","costPrice":"10","remark":"2323","categoryId":"1","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:56:09', 496),
	(137, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.editWithImages()', 'PUT', 1, 'admin', '研发部门', '/info/info/editWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"20","flowerDesc":"222","price":"10","flowerName":"2","costPrice":"10","remark":"2323","id":"14","categoryId":"1","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:56:30', 38),
	(138, '鲜花信息', 3, 'com.shop.app.controller.FlowerInfoController.remove()', 'DELETE', 1, 'admin', '研发部门', '/info/info/13,14', '127.0.0.1', '内网IP', '[13,14]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:56:42', 11),
	(139, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.addWithImages()', 'POST', 1, 'admin', '研发部门', '/info/info/addWithImages', '127.0.0.1', '内网IP', '{"marketPrice":"1","flowerDesc":"1","price":"1","flowerName":"1","costPrice":"1","remark":"111","stock":"10","categoryId":"2","status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 17:57:24', 37),
	(140, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":50,"flowerDesc":"红色玫瑰，象征热情的爱情","flowerName":"红玫瑰","marketPrice":120,"params":{},"price":99,"qrCodeUrl":"/profile/flower/qrcode/qrcode_b4a301aa-80e2-46f5-8a85-fb0067b8f0c8.png","remark":"经典款","status":1,"stock":100,"updateBy":"admin","updateTime":"2025-09-08 18:27:09"}', '{"msg":"操作失败","code":500}', 0, NULL, '2025-09-08 18:27:10', 208),
	(141, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":50,"flowerDesc":"红色玫瑰，象征热情的爱情","flowerName":"红玫瑰","marketPrice":120,"params":{},"price":99,"qrCodeUrl":"/profile/flower/qrcode/qrcode_a608da87-744b-43bc-ac1f-d9a2e80d87cd.png","remark":"经典款","status":1,"stock":100,"updateBy":"admin","updateTime":"2025-09-08 18:31:46"}', '{"msg":"操作失败","code":500}', 0, NULL, '2025-09-08 18:31:46', 119),
	(142, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":50,"flowerDesc":"红色玫瑰，象征热情的爱情","flowerName":"红玫瑰","marketPrice":120,"params":{},"price":99,"qrCodeUrl":"/profile/flower/qrcode/qrcode_4ff5ff1e-6a5c-4dbc-a0ea-bf27abeb478c.png","remark":"经典款","status":1,"stock":100,"updateBy":"admin","updateTime":"2025-09-08 18:31:59"}', '{"msg":"操作失败","code":500}', 0, NULL, '2025-09-08 18:31:59', 45),
	(143, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":50,"flowerDesc":"红色玫瑰，象征热情的爱情","flowerName":"红玫瑰","marketPrice":120,"params":{},"price":99,"qrCodeUrl":"/profile/flower/qrcode/qrcode_0b19b39c-cbdf-41b6-8967-daaa794ea87c.png","remark":"经典款","status":1,"stock":100,"updateBy":"admin","updateTime":"2025-09-08 18:38:01"}', '{"msg":"操作失败","code":500}', 0, NULL, '2025-09-08 18:38:01', 43),
	(144, '鲜花信息', 1, 'com.shop.app.controller.FlowerInfoController.add()', 'POST', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":1,"createBy":"admin","createTime":"2025-09-08 18:38:28","flowerDesc":"1","flowerName":"1","id":16,"marketPrice":1,"params":{},"price":1,"qrCodeUrl":"/profile/flower/qrcode/qrcode_1251635d-c43a-48a7-8f62-8d121b3a1cc4.png","remark":"1","status":1,"stock":10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 18:38:28', 23),
	(145, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":1,"flowerDesc":"1","flowerName":"1","marketPrice":1,"params":{},"price":1,"qrCodeUrl":"/profile/flower/qrcode/qrcode_68c14025-b9b9-4091-8573-a6071a110404.png","remark":"1","status":1,"stock":10,"updateBy":"admin","updateTime":"2025-09-08 18:38:37"}', '{"msg":"操作失败","code":500}', 0, NULL, '2025-09-08 18:38:37', 26),
	(146, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 19:21:31', 89),
	(147, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 19:21:48', 10),
	(148, '鲜花信息', 2, 'com.shop.app.controller.FlowerInfoController.edit()', 'PUT', 1, 'admin', '研发部门', '/info/info', '127.0.0.1', '内网IP', '{"categoryId":1,"costPrice":50,"flowerDesc":"红色玫瑰，象征热情的爱情","flowerName":"红玫瑰","id":1,"marketPrice":120,"params":{},"price":99,"qrCodeUrl":"/profile/flower/qrcode/qrcode_d91f0f44-613a-4dd5-846c-dc08deed996c.png","remark":"经典款1","status":1,"stock":100,"updateBy":"admin","updateTime":"2025-09-08 19:25:42"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 19:25:42', 210),
	(149, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 19:52:34', 61),
	(150, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-08 19:53:00', 13),
	(151, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"玫瑰花系列","categoryName":"玫瑰","createBy":"","createTime":"2025-09-08 11:12:16","id":1,"params":{},"remark":"情人节主打","sortOrder":0,"status":1,"updateBy":"admin","updateTime":"2025-09-09 08:58:39"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 08:58:39', 13),
	(152, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"菊花系列","categoryName":"菊花","createBy":"","createTime":"2025-09-08 11:12:16","id":10,"params":{},"remark":"秋季特色","sortOrder":10,"status":1,"updateBy":"admin","updateTime":"2025-09-09 08:58:45"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 08:58:45', 3),
	(153, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:30:34', 60),
	(154, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/2', '127.0.0.1', '内网IP', '[2]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:35:21', 19),
	(155, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_customer"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:35:48', 70),
	(156, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"客户状态","dictType":"customer_status","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:36:56', 13),
	(157, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"正常","dictSort":0,"dictType":"customer_status","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:37:11', 9),
	(158, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"停用","dictSort":0,"dictType":"customer_status","dictValue":"0","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:37:17', 7),
	(159, '字典数据', 2, 'com.shop.app.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","createTime":"2025-09-09 09:37:17","default":false,"dictCode":105,"dictLabel":"禁用","dictSort":0,"dictType":"customer_status","dictValue":"0","isDefault":"N","listClass":"default","params":{},"status":"0","updateBy":"admin"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:37:42', 8),
	(160, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"客户等级","dictType":"customer_level","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:38:31', 5),
	(161, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"普通","dictSort":0,"dictType":"customer_level","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:38:44', 21),
	(162, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"银卡","dictSort":0,"dictType":"customer_level","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:38:53', 11),
	(163, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"金卡","dictSort":0,"dictType":"customer_level","dictValue":"3","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:39:03', 6),
	(164, '字典数据', 2, 'com.shop.app.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","createTime":"2025-09-09 09:38:53","default":false,"dictCode":107,"dictLabel":"银卡","dictSort":0,"dictType":"customer_level","dictValue":"2","isDefault":"N","listClass":"default","params":{},"status":"0","updateBy":"admin"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:39:10', 8),
	(165, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"钻石","dictSort":0,"dictType":"customer_level","dictValue":"4","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:39:24', 7),
	(166, '代码生成', 2, 'com.shop.app.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/flower_customer', '127.0.0.1', '内网IP', '{}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:39:43', 53),
	(167, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"customer","className":"FlowerCustomer","columns":[{"capJavaField":"Id","columnComment":"客户ID","columnId":28,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 09:35:48","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":3,"updateBy":"","updateTime":"2025-09-09 09:39:43","usableColumn":false},{"capJavaField":"CustomerName","columnComment":"客户姓名","columnId":29,"columnName":"customer_name","columnType":"varchar(50)","createBy":"admin","createTime":"2025-09-09 09:35:48","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"customerName","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"LIKE","required":true,"sort":2,"superColumn":false,"tableId":3,"updateBy":"","updateTime":"2025-09-09 09:39:43","usableColumn":false},{"capJavaField":"Phone","columnComment":"联系电话","columnId":30,"columnName":"phone","columnType":"varchar(20)","createBy":"admin","createTime":"2025-09-09 09:35:48","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"0","isRequired":"1","javaField":"phone","javaType":"String","list":true,"params":{},"pk":false,"query":false,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":3,"updateBy":"","updateTime":"2025-09-09 09:39:43","usableColumn":false},{"capJavaField":"Email","columnComment":"邮箱","columnId":31,"columnName":"email","columnType":"varchar(100)","createBy":"admin","createTime":"2025-09-09 09:35:48","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":t', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 09:41:09', 56),
	(168, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/3', '127.0.0.1', '内网IP', '[3]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:17:57', 18),
	(169, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_inventory"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:18:20', 44),
	(170, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"inventory","className":"FlowerInventory","columns":[{"capJavaField":"Id","columnComment":"库存ID","columnId":44,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:18:20","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":4,"updateBy":"","usableColumn":false},{"capJavaField":"FlowerId","columnComment":"鲜花ID","columnId":45,"columnName":"flower_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:18:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"flowerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":4,"updateBy":"","usableColumn":false},{"capJavaField":"Quantity","columnComment":"库存数量","columnId":46,"columnName":"quantity","columnType":"int(11)","createBy":"admin","createTime":"2025-09-09 13:18:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"quantity","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":4,"updateBy":"","usableColumn":false},{"capJavaField":"ReservedQuantity","columnComment":"预定占用数量","columnId":47,"columnName":"reserved_quantity","columnType":"int(11)","createBy":"admin","createTime":"2025-09-09 13:18:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequi', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:19:21', 46),
	(171, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"inventory/inventory/index","createTime":"2025-09-09 13:19:51","icon":"#","isCache":"0","isFrame":"1","menuId":2019,"menuName":"库存管理","menuType":"C","orderNum":1,"params":{},"parentId":2000,"path":"inventory","perms":"inventory:inventory:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:33:49', 15),
	(172, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/4', '127.0.0.1', '内网IP', '[4]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:44:05', 16),
	(173, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_order"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:44:30', 102),
	(174, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"订单类型","dictType":"order_type","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:45:54', 7),
	(175, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"普通订单","dictSort":0,"dictType":"order_type","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:46:14', 12),
	(176, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"预定订单","dictSort":0,"dictType":"order_type","dictValue":"2","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:46:22', 16),
	(177, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"订单状态","dictType":"order_status","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:46:53', 5),
	(178, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"待支付","dictSort":0,"dictType":"order_status","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:47:15', 8),
	(179, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","cssClass":"","default":false,"dictLabel":"已支付","dictSort":0,"dictType":"order_status","dictValue":"2","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:47:44', 16),
	(180, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已付款","dictSort":0,"dictType":"order_status","dictValue":"3","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:47:49', 15),
	(181, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已发货","dictSort":0,"dictType":"order_status","dictValue":"4","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:48:33', 17),
	(182, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已完成","dictSort":0,"dictType":"order_status","dictValue":"5","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:48:50', 16),
	(183, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已取消","dictSort":0,"dictType":"order_status","dictValue":"6","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:48:58', 4),
	(184, '代码生成', 2, 'com.shop.app.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/flower_order', '127.0.0.1', '内网IP', '{}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:51:49', 56),
	(185, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"order","className":"FlowerOrder","columns":[{"capJavaField":"Id","columnComment":"订单ID","columnId":56,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:51:49","usableColumn":false},{"capJavaField":"OrderNo","columnComment":"订单编号","columnId":57,"columnName":"order_no","columnType":"varchar(32)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"orderNo","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:51:49","usableColumn":false},{"capJavaField":"CustomerId","columnComment":"客户ID","columnId":58,"columnName":"customer_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"customerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:51:49","usableColumn":false},{"capJavaField":"OrderType","columnComment":"订单类型 1-普通订单 2-预定订单","columnId":59,"columnName":"order_type","columnType":"tinyint(1)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"select","increment":fal', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:52:50', 71),
	(186, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"订单支付方式","dictType":"order_pay_method","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:56:25', 5),
	(187, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"微信支付","dictSort":0,"dictType":"order_pay_method","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:56:49', 6),
	(188, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"支付宝","dictSort":0,"dictType":"order_pay_method","dictValue":"2","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:56:55', 16),
	(189, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"银行卡","dictSort":0,"dictType":"order_pay_method","dictValue":"3","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:57:02', 23),
	(190, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"现金","dictSort":0,"dictType":"order_pay_method","dictValue":"3","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:57:12', 7),
	(191, '字典数据', 2, 'com.shop.app.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","createTime":"2025-09-09 13:57:12","default":false,"dictCode":121,"dictLabel":"现金","dictSort":0,"dictType":"order_pay_method","dictValue":"4","isDefault":"N","listClass":"default","params":{},"status":"0","updateBy":"admin"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 13:57:30', 6),
	(192, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"order","className":"FlowerOrder","columns":[{"capJavaField":"Id","columnComment":"订单ID","columnId":56,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:52:50","usableColumn":false},{"capJavaField":"OrderNo","columnComment":"订单编号","columnId":57,"columnName":"order_no","columnType":"varchar(32)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"orderNo","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:52:50","usableColumn":false},{"capJavaField":"CustomerId","columnComment":"客户ID","columnId":58,"columnName":"customer_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"customerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":5,"updateBy":"","updateTime":"2025-09-09 13:52:50","usableColumn":false},{"capJavaField":"OrderType","columnComment":"订单类型 1-普通订单 2-预定订单","columnId":59,"columnName":"order_type","columnType":"tinyint(1)","createBy":"admin","createTime":"2025-09-09 13:44:30","dictType":"","edit":true,"htmlType":"select","increment":fal', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 14:01:44', 36),
	(193, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"actualAmount":88,"createBy":"","createTime":"2025-09-08 11:12:17","customerId":2,"deliveryTime":"2023-09-02 09:15:00","discountAmount":0,"id":2,"orderAmount":88,"orderNo":"ORD202309020002","orderStatus":4,"orderType":1,"params":{},"paymentMethod":2,"qrCodeUrl":"https://example.com/qrcode/order/ORD202309020002","receiveTime":"2023-09-03 11:45:00","receiverAddress":"上海市浦东新区xxx路","receiverName":"李四","receiverPhone":"13800138002","remark":"母亲节订单","updateBy":"admin","updateTime":"2025-09-09 18:15:53"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 18:15:53', 20),
	(194, '订单管理', 1, 'com.shop.app.controller.FlowerOrderController.add()', 'POST', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"actualAmount":90,"createBy":"admin","createTime":"2025-09-09 18:16:23","customerId":1,"deliveryTime":"2025-09-09 00:00:00","discountAmount":10,"id":11,"orderAmount":100,"orderNo":"ORD20250909568860","orderStatus":1,"orderType":1,"params":{},"paymentMethod":1,"qrCodeUrl":"/profile/order/qrcode/qrcode_ORD20250909568860_1757412983941.png","receiveTime":"2025-09-10 00:00:00","receiverAddress":"陕西西安","receiverName":"菲菲","receiverPhone":"120","remark":"无"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-09 18:16:23', 60),
	(195, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"actualAmount":178,"createBy":"","createTime":"2025-09-08 11:12:17","customerId":1,"deliveryTime":"2023-09-01 10:30:00","discountAmount":20,"id":1,"orderAmount":198,"orderNo":"ORD202309010001","orderStatus":4,"orderType":1,"params":{},"paymentMethod":1,"qrCodeUrl":"https://example.com/qrcode/order/ORD202309010001","receiveTime":"2023-09-02 14:20:00","receiverAddress":"北京市朝阳区xxx街道","receiverName":"张三","receiverPhone":"13800138001","remark":"情人节订单","updateBy":"admin","updateTime":"2025-09-10 09:38:37"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:38:37', 16),
	(196, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/5', '127.0.0.1', '内网IP', '[5]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:41:17', 22),
	(197, '字典类型', 1, 'com.shop.app.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{"createBy":"admin","dictName":"预定状态","dictType":"flower_reservation_status","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:42:27', 14),
	(198, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"待确认","dictSort":0,"dictType":"flower_reservation_status","dictValue":"1","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:42:51', 11),
	(199, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已确认","dictSort":0,"dictType":"flower_reservation_status","dictValue":"2","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:42:59', 9),
	(200, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已完成","dictSort":0,"dictType":"flower_reservation_status","dictValue":"3","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:43:12', 9),
	(201, '字典数据', 1, 'com.shop.app.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{"createBy":"admin","default":false,"dictLabel":"已取消","dictSort":0,"dictType":"flower_reservation_status","dictValue":"4","listClass":"default","params":{},"status":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:43:23', 14),
	(202, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_inventory"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:45:58', 84),
	(203, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"inventory","className":"FlowerInventory","columns":[{"capJavaField":"Id","columnComment":"库存ID","columnId":76,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:45:58","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":6,"updateBy":"","usableColumn":false},{"capJavaField":"FlowerId","columnComment":"鲜花ID","columnId":77,"columnName":"flower_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:45:58","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"flowerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":6,"updateBy":"","usableColumn":false},{"capJavaField":"Quantity","columnComment":"库存数量","columnId":78,"columnName":"quantity","columnType":"int(11)","createBy":"admin","createTime":"2025-09-10 09:45:58","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"quantity","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":6,"updateBy":"","usableColumn":false},{"capJavaField":"ReservedQuantity","columnComment":"预定占用数量","columnId":79,"columnName":"reserved_quantity","columnType":"int(11)","createBy":"admin","createTime":"2025-09-10 09:45:58","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequi', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:48:46', 70),
	(204, '代码生成', 2, 'com.shop.app.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/flower_inventory', '127.0.0.1', '内网IP', '{}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:48:50', 44),
	(205, '代码生成', 3, 'com.shop.app.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/6', '127.0.0.1', '内网IP', '[6]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:49:16', 6),
	(206, '代码生成', 6, 'com.shop.app.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{"tables":"flower_reservation"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:49:20', 58),
	(207, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"reservation","className":"FlowerReservation","columns":[{"capJavaField":"Id","columnComment":"预定ID","columnId":88,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":7,"updateBy":"","usableColumn":false},{"capJavaField":"ReservationNo","columnComment":"预定编号","columnId":89,"columnName":"reservation_no","columnType":"varchar(32)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"reservationNo","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":7,"updateBy":"","usableColumn":false},{"capJavaField":"CustomerId","columnComment":"客户ID","columnId":90,"columnName":"customer_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"customerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":7,"updateBy":"","usableColumn":false},{"capJavaField":"FlowerId","columnComment":"鲜花ID","columnId":91,"columnName":"flower_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQu', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 09:50:14', 70),
	(208, '代码生成', 2, 'com.shop.app.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{"businessName":"reservation","className":"FlowerReservation","columns":[{"capJavaField":"Id","columnComment":"预定ID","columnId":88,"columnName":"id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":false,"htmlType":"input","increment":true,"insert":false,"isIncrement":"1","isInsert":"0","isPk":"1","isRequired":"0","javaField":"id","javaType":"Long","list":false,"params":{},"pk":true,"query":false,"queryType":"EQ","required":false,"sort":1,"superColumn":false,"tableId":7,"updateBy":"","updateTime":"2025-09-10 09:50:14","usableColumn":false},{"capJavaField":"ReservationNo","columnComment":"预定编号","columnId":89,"columnName":"reservation_no","columnType":"varchar(32)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"reservationNo","javaType":"String","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":2,"superColumn":false,"tableId":7,"updateBy":"","updateTime":"2025-09-10 09:50:14","usableColumn":false},{"capJavaField":"CustomerId","columnComment":"客户ID","columnId":90,"columnName":"customer_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","increment":false,"insert":true,"isEdit":"1","isIncrement":"0","isInsert":"1","isList":"1","isPk":"0","isQuery":"1","isRequired":"1","javaField":"customerId","javaType":"Long","list":true,"params":{},"pk":false,"query":true,"queryType":"EQ","required":true,"sort":3,"superColumn":false,"tableId":7,"updateBy":"","updateTime":"2025-09-10 09:50:14","usableColumn":false},{"capJavaField":"FlowerId","columnComment":"鲜花ID","columnId":91,"columnName":"flower_id","columnType":"bigint(20)","createBy":"admin","createTime":"2025-09-10 09:49:20","dictType":"","edit":true,"htmlType":"input","i', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 10:59:28', 110),
	(209, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"王昭君","contactPhone":"110","customerId":11,"deliveryAddress":"西安市三桥新街","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"id":11,"params":{},"quantity":3,"remark":"无","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757475581211","reservationStatus":1,"totalAmount":297.00,"unitPrice":99.00}', '{"msg":"预定失败：\\r\\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Table \'flower_sales_system.flower_reservation_history\' doesn\'t exist\\r\\n### The error may exist in file [E:\\\\tools\\\\javacode\\\\shopping\\\\shopping-flower\\\\target\\\\classes\\\\mapper\\\\FlowerReservationHistoryMapper.xml]\\r\\n### The error may involve com.shop.app.mapper.FlowerReservationHistoryMapper.insertFlowerReservationHistory-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into flower_reservation_history          ( reservation_id,             customer_id,             flower_id,             quantity,             unit_price,             total_amount,             reservation_date,             delivery_time,             reservation_status,             contact_person,             contact_phone,             delivery_address,             operation_type,             operation_time,             operator,                                       create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                       sysdate() )\\r\\n### Cause: java.sql.SQLSyntaxErrorException: Table \'flower_sales_system.flower_reservation_history\' doesn\'t exist\\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Table \'flower_sales_system.flower_reservation_history\' doesn\'t exist","code":500}', 0, NULL, '2025-09-10 11:40:32', 193),
	(210, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"李世民","contactPhone":"120","customerId":11,"deliveryAddress":"西安三桥新街","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"id":12,"params":{},"quantity":2,"remark":"华润二十四城","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757476195410","reservationStatus":1,"totalAmount":198.00,"unitPrice":99.00}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 11:50:46', 162),
	(211, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"reservation/reservation/index","createTime":"2025-09-10 09:51:02","icon":"#","isCache":"0","isFrame":"1","menuId":2031,"menuName":"预定管理","menuType":"C","orderNum":0,"params":{},"parentId":2000,"path":"reservation","perms":"reservation:reservation:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 11:55:01', 38),
	(212, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/10,9,8,7,6,5,4,3,2,1', '127.0.0.1', '内网IP', '[10,9,8,7,6,5,4,3,2,1]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 11:55:15', 11),
	(213, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"刘德华","contactPhone":"120","customerId":1,"deliveryAddress":"三桥","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"id":13,"params":{},"quantity":1,"remark":"无","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757476517039","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 11:55:57', 17),
	(214, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/1,2,3,4,5,6,7,8,9,10', '127.0.0.1', '内网IP', '[1,2,3,4,5,6,7,8,9,10]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 11:56:35', 69),
	(215, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/1,2,3,4,5,6,7,8,9,10', '127.0.0.1', '内网IP', '[1,2,3,4,5,6,7,8,9,10]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 11:56:42', 7),
	(216, '预定管理', 2, 'com.shop.app.controller.FlowerReservationController.edit()', 'PUT', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"刘德华","contactPhone":"120","createBy":"","createTime":"2025-09-10 11:55:57","customerId":11,"customerName":"张三","customerPhone":"13800138001","deliveryAddress":"三桥","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"flowerName":"红玫瑰","id":13,"params":{},"quantity":1,"remark":"无","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757476517039","reservationStatus":1,"totalAmount":99,"unitPrice":99,"updateBy":"","updateTime":"2025-09-10 11:55:57"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 11:57:07', 7),
	(217, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/13', '127.0.0.1', '内网IP', '[13]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 12:02:50', 7),
	(218, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"刘德华","contactPhone":"120","customerId":11,"deliveryAddress":"西安三桥新街","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"id":14,"params":{},"quantity":1,"remark":"关联订单ID：12","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757476974263","reservationStatus":1,"totalAmount":99.00,"unitPrice":99.00}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 12:03:39', 32),
	(219, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"actualAmount":99,"createBy":"","createTime":"2025-09-10 12:03:39","customerId":11,"deliveryTime":"2025-09-10 00:00:00","discountAmount":0,"id":12,"orderAmount":99,"orderNo":"ORD202509105947","orderStatus":2,"orderType":2,"params":{},"paymentMethod":1,"receiveTime":"2025-09-11 00:00:00","receiverAddress":"西安三桥新街","receiverName":"刘德华","receiverPhone":"120","remark":"无","updateBy":"admin","updateTime":"2025-09-10 12:04:24"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 12:04:24', 10),
	(220, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":12,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 12:04:40"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 12:04:40', 4),
	(221, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":12,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 12:04:45"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 12:04:45', 6),
	(222, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"王十二","contactPhone":"13800138010","customerId":10,"deliveryAddress":"重庆市渝中区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":2,"id":15,"params":{},"quantity":1,"remark":"关联订单ID：13","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757481297564","reservationStatus":1,"totalAmount":74.80,"unitPrice":74.80}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:15:25', 196),
	(223, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/13', '127.0.0.1', '内网IP', '13', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:15:51', 52),
	(224, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":13,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 13:16:04"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:16:04', 11),
	(225, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":13,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 13:16:08"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:16:09', 13),
	(226, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"韩梅梅","contactPhone":"13700000000","customerId":11,"deliveryAddress":"西安碑林区","deliveryTime":"2025-09-10 00:00:00","flowerId":1,"id":16,"params":{},"quantity":1,"remark":"关联订单ID：14","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757482268730","reservationStatus":1,"totalAmount":99.00,"unitPrice":99.00}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:31:39', 41),
	(227, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":17,"params":{},"quantity":1,"remark":"关联订单ID：15","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757483029112","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 13:44:05', 203),
	(228, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-12 00:00:00","flowerId":1,"id":18,"params":{},"quantity":1,"remark":"关联订单ID：16","reservationDate":"2025-09-12 00:00:00","reservationNo":"YD1757486482053","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 14:41:39', 200),
	(229, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"李四","contactPhone":"13800138002","customerId":2,"deliveryAddress":"上海市浦东新区xxx路","deliveryTime":"2025-09-18 00:00:00","flowerId":2,"id":19,"params":{},"quantity":10,"remark":"关联订单ID：17","reservationDate":"2025-09-16 00:00:00","reservationNo":"YD1757486500214","reservationStatus":1,"totalAmount":836.00,"unitPrice":83.60}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 14:42:28', 17),
	(230, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"赵六","contactPhone":"13800138004","customerId":4,"deliveryAddress":"深圳市南山区xxx路","deliveryTime":"2025-09-26 00:00:00","flowerId":1,"params":{},"quantity":90,"reservationDate":"2025-09-14 00:00:00","reservationNo":"YD1757486550501","reservationStatus":1,"totalAmount":8910.00,"unitPrice":99.00}', '{"msg":"预定失败：库存不足，无法完成预定操作","code":500}', 0, NULL, '2025-09-10 14:43:04', 20),
	(231, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":6,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 15:16:04"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:16:05', 13),
	(232, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":9,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 15:16:19"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:16:19', 4),
	(233, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":9,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 15:16:26"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:16:26', 4),
	(234, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-15 00:00:00","flowerId":1,"id":20,"params":{},"quantity":10,"remark":"关联订单ID：18","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757489046589","reservationStatus":1,"totalAmount":891.00,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:24:32', 183),
	(235, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":21,"params":{},"quantity":1,"remark":"关联订单ID：19","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757489099294","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:25:19', 35),
	(236, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/21,20,19,18,17,16,15,14', '127.0.0.1', '内网IP', '[21,20,19,18,17,16,15,14]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:25:51', 11),
	(237, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":22,"params":{},"quantity":1,"remark":"关联订单ID：20","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757490032785","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:40:51', 58),
	(238, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/20', '127.0.0.1', '内网IP', '20', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 15:42:11', 152),
	(239, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:12:05', 70),
	(240, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/22', '127.0.0.1', '内网IP', '[22]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:23:05', 23),
	(241, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/11,12,13,14,15,16,17,18,19,20', '127.0.0.1', '内网IP', '[11,12,13,14,15,16,17,18,19,20]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          ,              ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:23:40', 17),
	(242, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/20', '127.0.0.1', '内网IP', '[20]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:23:54', 4),
	(243, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/12', '127.0.0.1', '内网IP', '[12]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_order_detail`, CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:24:02', 8),
	(244, '定时任务', 1, 'com.shop.app.quartz.controller.SysJobController.add()', 'POST', 1, 'admin', '研发部门', '/monitor/job', '127.0.0.1', '内网IP', '{"concurrent":"1","createBy":"admin","cronExpression":"0 0 0 * * ?","invokeTarget":"ryTask.processCompletedOrders()","jobGroup":"DEFAULT","jobId":100,"jobName":"删除已完成历史订单","misfirePolicy":"1","nextValidTime":"2025-09-11 00:00:00","params":{},"status":"1"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:33:52', 50),
	(245, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/6', '127.0.0.1', '内网IP', '[6]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:20', 82),
	(246, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/5', '127.0.0.1', '内网IP', '[5]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:23', 59),
	(247, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/4', '127.0.0.1', '内网IP', '[4]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:26', 73),
	(248, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/3', '127.0.0.1', '内网IP', '[3]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:28', 49),
	(249, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/2', '127.0.0.1', '内网IP', '[2]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:31', 49),
	(250, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/1', '127.0.0.1', '内网IP', '[1]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:33', 54),
	(251, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/9', '127.0.0.1', '内网IP', '[9]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:36', 49),
	(252, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/10', '127.0.0.1', '内网IP', '[10]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:39', 79),
	(253, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/12,13', '127.0.0.1', '内网IP', '[12,13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          ,              ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:34:46', 88),
	(254, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/12', '127.0.0.1', '内网IP', '[12]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:34:51', 33),
	(255, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:34:53', 41),
	(256, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:35:09', 28),
	(257, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/8', '127.0.0.1', '内网IP', '8', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:37:44', 327),
	(258, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":8,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 16:37:52"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:37:52', 19),
	(259, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":8,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 16:37:56"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:37:56', 51),
	(260, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/8', '127.0.0.1', '内网IP', '8', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:37:58', 51),
	(261, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/8', '127.0.0.1', '内网IP', '[8]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:38:12', 108),
	(262, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:38:15', 63),
	(263, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/8', '127.0.0.1', '内网IP', '[8]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:38:23', 40),
	(264, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:39:08', 48),
	(265, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/13', '127.0.0.1', '内网IP', '13', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:39:19', 22),
	(266, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:39:32', 41),
	(267, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/11', '127.0.0.1', '内网IP', '[11]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:21', 18),
	(268, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/14', '127.0.0.1', '内网IP', '[14]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:24', 15),
	(269, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/15', '127.0.0.1', '内网IP', '[15]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:27', 18),
	(270, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/16', '127.0.0.1', '内网IP', '[16]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:30', 20),
	(271, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/17', '127.0.0.1', '内网IP', '[17]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:32', 18),
	(272, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/18', '127.0.0.1', '内网IP', '[18]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:34', 19),
	(273, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/19', '127.0.0.1', '内网IP', '[19]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:36', 16),
	(274, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":20,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 16:42:45"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:45', 15),
	(275, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":20,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 16:42:48"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:42:48', 47),
	(276, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/20', '127.0.0.1', '内网IP', '[20]', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\r\n### The error may exist in file [E:\\tools\\javacode\\shopping\\shopping-flower\\target\\classes\\mapper\\FlowerOrderMapper.xml]\r\n### The error may involve com.shop.app.mapper.FlowerOrderMapper.deleteFlowerOrderByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from flower_order where id in          (               ?          )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`)); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`flower_sales_system`.`flower_customer_purchase_history`, CONSTRAINT `fk_purchase_order` FOREIGN KEY (`order_id`) REFERENCES `flower_order` (`id`))', '2025-09-10 16:42:56', 49),
	(277, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/7', '127.0.0.1', '内网IP', '[7]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 16:43:14', 20),
	(278, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/20', '127.0.0.1', '内网IP', '[20]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:50:19', 108),
	(279, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/13', '127.0.0.1', '内网IP', '[13]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:50:21', 51),
	(280, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/8', '127.0.0.1', '内网IP', '[8]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:50:23', 50),
	(281, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":23,"params":{},"quantity":1,"remark":"关联订单ID：21","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757498128552","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:55:44', 44),
	(282, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"李四","contactPhone":"13800138002","customerId":2,"deliveryAddress":"上海市浦东新区xxx路","deliveryTime":"2025-09-12 00:00:00","flowerId":1,"id":24,"params":{},"quantity":1,"remark":"关联订单ID：22","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757498146664","reservationStatus":1,"totalAmount":94.05,"unitPrice":94.05}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:06', 42),
	(283, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"王五","contactPhone":"13800138003","customerId":3,"deliveryAddress":"广州市天河区xxx大道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":25,"params":{},"quantity":1,"remark":"关联订单ID：23","reservationDate":"2025-09-10 00:00:00","reservationNo":"YD1757498168161","reservationStatus":1,"totalAmount":84.15,"unitPrice":84.15}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:26', 37),
	(284, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":21,"orderStatus":2,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:56:49"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:49', 20),
	(285, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":21,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:56:53"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:53', 13),
	(286, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":21,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:56:56"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:56', 23),
	(287, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/21', '127.0.0.1', '内网IP', '21', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:56:59', 31),
	(288, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":22,"orderStatus":2,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:11"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:11', 3),
	(289, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":22,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:14"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:14', 8),
	(290, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":22,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:17"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:17', 37),
	(291, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/22', '127.0.0.1', '内网IP', '22', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:21', 29),
	(292, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":23,"orderStatus":2,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:29"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:29', 14),
	(293, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":23,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:32"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:32', 7),
	(294, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":23,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-10 17:57:35"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:35', 32),
	(295, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/23', '127.0.0.1', '内网IP', '23', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 17:57:37', 21),
	(296, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/21', '127.0.0.1', '内网IP', '[21]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 18:01:02', 60),
	(297, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/23', '127.0.0.1', '内网IP', '[23]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 18:01:04', 38),
	(298, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/22', '127.0.0.1', '内网IP', '[22]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-10 18:01:07', 41),
	(299, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"张三","contactPhone":"13800138001","customerId":1,"deliveryAddress":"北京市朝阳区xxx街道","deliveryTime":"2025-09-11 00:00:00","flowerId":1,"id":26,"params":{},"quantity":1,"remark":"关联订单ID：24","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757553199630","reservationStatus":1,"totalAmount":89.10,"unitPrice":89.10}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:13:31', 158),
	(300, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/24', '127.0.0.1', '内网IP', '24', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:13:42', 269),
	(301, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"李四","contactPhone":"13800138002","customerId":2,"deliveryAddress":"上海市浦东新区xxx路","deliveryTime":"2025-09-13 00:00:00","flowerId":1,"id":27,"params":{},"quantity":1,"remark":"关联订单ID：25","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757553402004","reservationStatus":1,"totalAmount":94.05,"unitPrice":94.05}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:17:02', 85),
	(302, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/25', '127.0.0.1', '内网IP', '25', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:17:20', 85),
	(303, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":25,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-11 09:18:24"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:18:24', 8),
	(304, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":25,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-11 09:18:32"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:18:32', 34),
	(305, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/27', '127.0.0.1', '内网IP', '[27]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:19:14', 6),
	(306, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/26', '127.0.0.1', '内网IP', '[26]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 09:19:17', 4),
	(307, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"韩梅梅","contactPhone":"13700000000","customerId":11,"deliveryAddress":"西安碑林区","deliveryTime":"2025-09-13 00:00:00","flowerId":3,"id":28,"params":{},"quantity":1,"remark":"关联订单ID：26","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757564906764","reservationStatus":1,"totalAmount":66.00,"unitPrice":66.00}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:28:47', 99),
	(308, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/26', '127.0.0.1', '内网IP', '26', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:29:26', 129),
	(309, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":26,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-11 12:29:38"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:29:38', 8),
	(310, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":26,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-11 12:29:44"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:29:44', 40),
	(311, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/26', '127.0.0.1', '内网IP', '26', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:29:50', 38),
	(312, '预定管理', 1, 'com.shop.app.controller.FlowerReservationController.add()', 'POST', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"李四","contactPhone":"13800138002","customerId":2,"deliveryAddress":"上海市浦东新区xxx路","deliveryTime":"2025-09-12 00:00:00","flowerId":1,"id":29,"params":{},"quantity":1,"remark":"关联订单ID：27","reservationDate":"2025-09-11 00:00:00","reservationNo":"YD1757565234027","reservationStatus":1,"totalAmount":94.05,"unitPrice":94.05}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-11 12:34:26', 32),
	(313, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"玫瑰花系列","categoryName":"热情奔放类","createBy":"","createTime":"2025-09-08 11:12:16","id":1,"params":{},"remark":"情人节主打","sortOrder":0,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:01:34"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:01:34', 13),
	(314, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"百合花系列","categoryName":"血色浪漫类","createBy":"","createTime":"2025-09-08 11:12:16","id":2,"params":{},"remark":"婚礼常用","sortOrder":2,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:01:42"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:01:43', 17),
	(315, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"康乃馨系列","categoryName":"温馨关爱类","createBy":"","createTime":"2025-09-08 11:12:16","id":3,"params":{},"remark":"母亲节主打","sortOrder":3,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:02:01"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:02:01', 13),
	(316, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"郁金香系列","categoryName":"青春活力类","createBy":"","createTime":"2025-09-08 11:12:16","id":4,"params":{},"remark":"春季特色","sortOrder":4,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:02:15"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:02:15', 21),
	(317, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"向日葵系列","categoryName":"阳光灿烂类","createBy":"","createTime":"2025-09-08 11:12:16","id":5,"params":{},"remark":"阳光主题","sortOrder":5,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:02:27"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:02:27', 16),
	(318, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"满天星系列","categoryName":"烂漫爱情类","createBy":"","createTime":"2025-09-08 11:12:16","id":6,"params":{},"remark":"配花首选","sortOrder":6,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:02:46"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:02:46', 15),
	(319, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"优雅高贵类","categoryName":"紫罗兰","createBy":"","createTime":"2025-09-08 11:12:16","id":7,"params":{},"remark":"优雅系列","sortOrder":7,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:02:57"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:02:57', 7),
	(320, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"优雅高贵类","categoryName":"长寿养生类","createBy":"","createTime":"2025-09-08 11:12:16","id":7,"params":{},"remark":"优雅系列","sortOrder":7,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:03:16"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:03:16', 15),
	(321, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"茉莉花系列","categoryName":"希望成长类","createBy":"","createTime":"2025-09-08 11:12:16","id":8,"params":{},"remark":"清香系列","sortOrder":8,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:03:26"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:03:26', 13),
	(322, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"牡丹系列","categoryName":"学业有成类","createBy":"","createTime":"2025-09-08 11:12:16","id":9,"params":{},"remark":"富贵主题","sortOrder":9,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:03:43"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:03:43', 13),
	(323, '鲜花分类', 2, 'com.shop.app.controller.FlowerCategoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/category/category', '127.0.0.1', '内网IP', '{"categoryDesc":"菊花系列","categoryName":"金榜题名类","createBy":"","createTime":"2025-09-08 11:12:16","id":10,"params":{},"remark":"秋季特色","sortOrder":10,"status":1,"updateBy":"admin","updateTime":"2025-09-12 15:03:55"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:03:55', 14),
	(324, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/2', '127.0.0.1', '内网IP', '2', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:08:28', 91),
	(325, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/1', '127.0.0.1', '内网IP', '1', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:09:19', 11),
	(326, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/3', '127.0.0.1', '内网IP', '3', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:10:21', 17),
	(327, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/4', '127.0.0.1', '内网IP', '4', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:11:16', 11),
	(328, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/5', '127.0.0.1', '内网IP', '5', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:12:01', 6),
	(329, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/6', '127.0.0.1', '内网IP', '6', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:12:52', 9),
	(330, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/7', '127.0.0.1', '内网IP', '7', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:14:06', 15),
	(331, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/8', '127.0.0.1', '内网IP', '8', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:14:44', 19),
	(332, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/9', '127.0.0.1', '内网IP', '9', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:15:15', 17),
	(333, '鲜花信息图片上传', 2, 'com.shop.app.controller.FlowerInfoController.uploadImages()', 'POST', 1, 'admin', '研发部门', '/info/info/uploadImages/10', '127.0.0.1', '内网IP', '10', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:15:54', 16),
	(334, '鲜花信息', 3, 'com.shop.app.controller.FlowerInfoController.remove()', 'DELETE', 1, 'admin', '研发部门', '/info/info/15,16', '127.0.0.1', '内网IP', '[15,16]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 15:16:03', 10),
	(335, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/27', '127.0.0.1', '内网IP', '27', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:02', 267),
	(336, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":27,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-12 16:02:06"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:06', 26),
	(337, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":27,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-12 16:02:10"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:11', 56),
	(338, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/27', '127.0.0.1', '内网IP', '27', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:14', 56),
	(339, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":24,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-12 16:02:27"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:27', 6),
	(340, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":24,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-12 16:02:31"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:31', 52),
	(341, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/24', '127.0.0.1', '内网IP', '24', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 16:02:34', 56),
	(342, '订单管理', 3, 'com.shop.app.controller.FlowerOrderController.remove()', 'DELETE', 1, 'admin', '研发部门', '/order/order/24,25,26,27', '127.0.0.1', '内网IP', '[24,25,26,27]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:25:35', 251),
	(343, '预定管理', 3, 'com.shop.app.controller.FlowerReservationController.remove()', 'DELETE', 1, 'admin', '研发部门', '/reservation/reservation/31,30,29,28,25,24,23', '127.0.0.1', '内网IP', '[31,30,29,28,25,24,23]', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:27:25', 6),
	(344, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"category/category/index","createTime":"2025-09-08 15:07:35","icon":"#","isCache":"0","isFrame":"1","menuId":2001,"menuName":"鲜花分类","menuType":"C","orderNum":2,"params":{},"parentId":2000,"path":"category","perms":"category:category:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:28:52', 32),
	(345, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"customer/customer/index","createTime":"2025-09-09 09:41:29","icon":"#","isCache":"0","isFrame":"1","menuId":2013,"menuName":"客户信息","menuType":"C","orderNum":3,"params":{},"parentId":2000,"path":"customer","perms":"customer:customer:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:28:59', 8),
	(346, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"info/info/index","createTime":"2025-09-08 16:07:38","icon":"#","isCache":"0","isFrame":"1","menuId":2007,"menuName":"鲜花信息","menuType":"C","orderNum":3,"params":{},"parentId":2000,"path":"info","perms":"info:info:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:29:27', 10),
	(347, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"inventory/inventory/index","createTime":"2025-09-09 13:19:51","icon":"#","isCache":"0","isFrame":"1","menuId":2019,"menuName":"库存管理","menuType":"C","orderNum":5,"params":{},"parentId":2000,"path":"inventory","perms":"inventory:inventory:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:29:44', 19),
	(348, '菜单管理', 2, 'com.shop.app.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"customer/customer/index","createTime":"2025-09-09 09:41:29","icon":"#","isCache":"0","isFrame":"1","menuId":2013,"menuName":"客户信息","menuType":"C","orderNum":4,"params":{},"parentId":2000,"path":"customer","perms":"customer:customer:list","routeName":"","status":"0","updateBy":"admin","visible":"0"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:29:58', 6),
	(349, '预定管理', 2, 'com.shop.app.controller.FlowerReservationController.edit()', 'PUT', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"梁山伯","contactPhone":"13200000000","createBy":"","createTime":"2025-09-12 17:37:05","customerId":16,"customerName":"梁山伯","customerPhone":"13200000000","deliveryAddress":"西安三桥新街","deliveryTime":"2025-09-12 00:00:00","flowerId":1,"flowerName":"红玫瑰","id":32,"params":{},"qrCodeUrl":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABbElEQVR4Xu2WO5IDIQxERcQxuCkDN+UYRPR2C49d5S1vsAkKrKIw4hE0+jA2fDJ733jal/xNptES0KwsjswFrcQghRL7LCR92jVLpz+jEO1hVCc185SlUMRnhpNuOAK0DJKu6AYicI8R5RH8roOTxLtkKqh7vPXPSfKwIehxfVgEItVSWvOoyvbYixAEKkCO5rOGKfMhiDLsbeHtAn9g1r7PcSLViqLlcYEzePBCDKICHIlJZtazeleSgxAqNXnL1L7wDr64iECmPv5tPzDAzjaCEEgvVTcruoFnWzACuVWbz5cOPivxOHGPjbJznvk836rPE1afJC/FUuuax32f80QFCKnukr95CUKWWkRPi4rRb9CelXiWbJvytOGSVxAimVKdGFrfZgcnBCGFPx0umZ8OhwptDMLf7jmv6mPPdjiiLtHe619AEKIuIWdQTfKjEEB7W/Xis7dLMgRRfpN7jWJ1iTuix8kn+5L/kR/AFvpeGqb9gQAAAABJRU5ErkJggg==","quantity":1,"remark":"无","reservationDate":"2025-09-12 00:00:00","reservationNo":"YD1757669825213","reservationStatus":1,"totalAmount":99,"unitPrice":99,"updateBy":"","updateTime":"2025-09-12 17:37:05"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-12 17:38:00', 10),
	(350, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":1,"imageUrls":"[\\"https://b0.bdstatic.com/ugc/C9HgbrRkDq0W5ET925xVcA8aa5c27cd0d56df88ade9418cf23e9a7.jpg\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 10:47:38"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:47:38', 24),
	(351, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":2,"imageUrls":"[\\"https://img0.baidu.com/it/u=1750804444,1991982306&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 10:48:34"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:48:34', 4),
	(352, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.paymentSuccess()', 'POST', 1, 'admin', '研发部门', '/order/order/paymentSuccess/28', '127.0.0.1', '内网IP', '28', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:57:13', 110),
	(353, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":28,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-15 10:57:16"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:57:16', 9),
	(354, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":28,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-15 10:58:01"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:58:01', 53),
	(355, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/28', '127.0.0.1', '内网IP', '28', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 10:58:03', 38),
	(356, '预定管理', 2, 'com.shop.app.controller.FlowerReservationController.edit()', 'PUT', 1, 'admin', '研发部门', '/reservation/reservation', '127.0.0.1', '内网IP', '{"contactPerson":"冯程程","contactPhone":"13277777777","createBy":"","createTime":"2025-09-15 11:01:20","customerId":15,"customerName":"冯程程","customerPhone":"13259703576","deliveryAddress":"三桥新街","deliveryTime":"2025-09-16 00:00:00","flowerId":1,"flowerName":"红玫瑰","id":34,"params":{},"qrCodeUrl":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAABbElEQVR4Xu2VO3LDMAxEoYrH4E1F6qY8hittdhdyPMmMU6QRCmM4Mo2HYokPGXhn8dvxbR/yN3kEbcPaox/AjD7l6DVIp8Qjv97wK2cNQqVycNNwNsLYShFJXntbUZCw5m1twCxGoCIHJbMZRfCzD+4kGorN1c415ahB0qQa1n45ShD/cyLXcJ2n81qEBOt8SV7BXALnM9e3k2E4tOmnLhiNSxXCXEJ6ndS8aWoQ/a7Nw0E3dAJMZ/R+kpPBHswQRuoQeZ4KRKrZfSn8gN60EgQcERY5ay6bfm9LEOnlpRK7JPNL7c/b5Xai+VBSuaK5By28BPF8yJxIrskQ8goEr0fs8Pie3pcgHAtPhgjUkpRMTwmS9sg7z7nMQ1QgkskpsUNuSVZSS5AO5RKaYyxDh9Qg02/s7jtmuNqMLUR0K+OQXtV8PF6q7yd+Y2fTo6GoMgT5T1Brb0uNWYIwh1edB2Nc7dlQgryzD/kf+QITAw2N+AVEygAAAABJRU5ErkJggg==","quantity":1,"remark":"无","reservationDate":"2025-09-15 00:00:00","reservationNo":"YD1757905280542","reservationStatus":1,"totalAmount":99,"unitPrice":99,"updateBy":"","updateTime":"2025-09-15 11:01:20"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:01:58', 11),
	(357, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":29,"orderStatus":2,"params":{},"updateBy":"admin","updateTime":"2025-09-15 11:03:21"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:03:21', 5),
	(358, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":29,"orderStatus":3,"params":{},"updateBy":"admin","updateTime":"2025-09-15 11:03:25"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:03:25', 5),
	(359, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.edit()', 'PUT', 1, 'admin', '研发部门', '/order/order', '127.0.0.1', '内网IP', '{"id":29,"orderStatus":4,"params":{},"updateBy":"admin","updateTime":"2025-09-15 11:03:28"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:03:28', 36),
	(360, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/29', '127.0.0.1', '内网IP', '29', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:03:53', 26),
	(361, '订单管理', 2, 'com.shop.app.controller.FlowerOrderController.complete()', 'POST', 1, 'admin', '研发部门', '/order/order/complete/29', '127.0.0.1', '内网IP', '29', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:04:38', 43),
	(362, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":3,"imageUrls":"[\\"https://img0.baidu.com/it/u=115376943,3298469016&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1132\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:08:32"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:08:32', 7),
	(363, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":4,"imageUrls":"[\\"https://img1.baidu.com/it/u=3313534139,501255597&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:09:00"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:09:00', 6),
	(364, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":5,"imageUrls":"[\\"https://img1.baidu.com/it/u=1473705063,1689718657&fm=253&fmt=auto?w=500&h=500\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:09:23"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:09:23', 7),
	(365, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":6,"imageUrls":"[\\"https://img1.baidu.com/it/u=1393669761,1846631909&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=718\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:09:49"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:09:49', 7),
	(366, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":7,"imageUrls":"[\\"https://img1.baidu.com/it/u=914880489,1467988321&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=751\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:10:12"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:10:12', 8),
	(367, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":8,"imageUrls":"[\\"https://img2.baidu.com/it/u=2213784590,1393097375&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:10:33"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:10:33', 5),
	(368, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":10,"imageUrls":"[\\"https://img0.baidu.com/it/u=1938294405,2459758777&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1737\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:10:49"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:10:49', 12),
	(369, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":9,"imageUrls":"[\\"https://b0.bdstatic.com/ugc/C9HgbrRkDq0W5ET925xVcA8aa5c27cd0d56df88ade9418cf23e9a7.jpg\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:11:08"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:11:08', 9),
	(370, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":1,"imageUrls":"[\\"https://img1.baidu.com/it/u=3101748816,2697453055&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:11:29"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:11:29', 6),
	(371, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":9,"imageUrls":"[\\"https://b0.bdstatic.com/ugc/C9HgbrRkDq0W5ET925xVcA8aa5c27cd0d56df88ade9418cf23e9a7.jpg\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:15:55"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:15:55', 6),
	(372, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":1,"imageUrls":"[\\"https://b0.bdstatic.com/ugc/C9HgbrRkDq0W5ET925xVcA8aa5c27cd0d56df88ade9418cf23e9a7.jpg\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:15:59"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:15:59', 4),
	(373, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":2,"imageUrls":"[\\"https://img0.baidu.com/it/u=1750804444,1991982306&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:16:08"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:16:08', 4),
	(374, '鲜花信息图片地址设置', 2, 'com.shop.app.controller.FlowerInfoController.updateImageUrl()', 'PUT', 1, 'admin', '研发部门', '/info/info/updateImageUrl', '127.0.0.1', '内网IP', '{"id":2,"imageUrls":"[\\"https://img0.baidu.com/it/u=1095963996,630643021&fm=253&app=138&f=JPEG?w=800&h=1428\\"]","params":{},"updateBy":"admin","updateTime":"2025-09-15 11:16:58"}', '{"msg":"操作成功","code":200}', 0, NULL, '2025-09-15 11:16:58', 5);

-- 导出  表 flower_sales_system.sys_post 结构
CREATE TABLE IF NOT EXISTS `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';

-- 正在导出表  flower_sales_system.sys_post 的数据：~4 rows (大约)
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 'ceo', '董事长', 1, '0', 'admin', '2025-09-08 11:14:52', '', NULL, ''),
	(2, 'se', '项目经理', 2, '0', 'admin', '2025-09-08 11:14:52', '', NULL, ''),
	(3, 'hr', '人力资源', 3, '0', 'admin', '2025-09-08 11:14:52', '', NULL, ''),
	(4, 'user', '普通员工', 4, '0', 'admin', '2025-09-08 11:14:52', '', NULL, '');

-- 导出  表 flower_sales_system.sys_role 结构
CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';

-- 正在导出表  flower_sales_system.sys_role 的数据：~2 rows (大约)
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-09-08 11:14:54', '', NULL, '超级管理员'),
	(2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-08 11:14:54', '', NULL, '普通角色');

-- 导出  表 flower_sales_system.sys_role_dept 结构
CREATE TABLE IF NOT EXISTS `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';

-- 正在导出表  flower_sales_system.sys_role_dept 的数据：~3 rows (大约)
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES
	(2, 100),
	(2, 101),
	(2, 105);

-- 导出  表 flower_sales_system.sys_role_menu 结构
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';

-- 正在导出表  flower_sales_system.sys_role_menu 的数据：~85 rows (大约)
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 100),
	(2, 101),
	(2, 102),
	(2, 103),
	(2, 104),
	(2, 105),
	(2, 106),
	(2, 107),
	(2, 108),
	(2, 109),
	(2, 110),
	(2, 111),
	(2, 112),
	(2, 113),
	(2, 114),
	(2, 115),
	(2, 116),
	(2, 117),
	(2, 500),
	(2, 501),
	(2, 1000),
	(2, 1001),
	(2, 1002),
	(2, 1003),
	(2, 1004),
	(2, 1005),
	(2, 1006),
	(2, 1007),
	(2, 1008),
	(2, 1009),
	(2, 1010),
	(2, 1011),
	(2, 1012),
	(2, 1013),
	(2, 1014),
	(2, 1015),
	(2, 1016),
	(2, 1017),
	(2, 1018),
	(2, 1019),
	(2, 1020),
	(2, 1021),
	(2, 1022),
	(2, 1023),
	(2, 1024),
	(2, 1025),
	(2, 1026),
	(2, 1027),
	(2, 1028),
	(2, 1029),
	(2, 1030),
	(2, 1031),
	(2, 1032),
	(2, 1033),
	(2, 1034),
	(2, 1035),
	(2, 1036),
	(2, 1037),
	(2, 1038),
	(2, 1039),
	(2, 1040),
	(2, 1041),
	(2, 1042),
	(2, 1043),
	(2, 1044),
	(2, 1045),
	(2, 1046),
	(2, 1047),
	(2, 1048),
	(2, 1049),
	(2, 1050),
	(2, 1051),
	(2, 1052),
	(2, 1053),
	(2, 1054),
	(2, 1055),
	(2, 1056),
	(2, 1057),
	(2, 1058),
	(2, 1059),
	(2, 1060);

-- 导出  表 flower_sales_system.sys_user 结构
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';

-- 正在导出表  flower_sales_system.sys_user 的数据：~2 rows (大约)
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2025/09/08/8a2dff9705f5490b870117ef56a80bd7.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-15 10:35:30', '2025-09-08 11:14:51', 'admin', '2025-09-08 11:14:51', '', '2025-09-15 10:35:30', '管理员'),
	(2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-08 11:14:51', '2025-09-08 11:14:51', 'admin', '2025-09-08 11:14:51', '', NULL, '测试员');

-- 导出  表 flower_sales_system.sys_user_post 结构
CREATE TABLE IF NOT EXISTS `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';

-- 正在导出表  flower_sales_system.sys_user_post 的数据：~2 rows (大约)
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES
	(1, 1),
	(2, 2);

-- 导出  表 flower_sales_system.sys_user_role 结构
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';

-- 正在导出表  flower_sales_system.sys_user_role 的数据：~2 rows (大约)
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES
	(1, 1),
	(2, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
