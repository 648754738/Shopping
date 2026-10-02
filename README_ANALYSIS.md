# 数据分析面板说明文档

## 功能说明

本项目新增了数据分析面板功能，包含以下数据可视化内容：

1. 近七日销售趋势（折线图）
2. 近七日预定趋势（柱状图）
3. 客户类型分布（饼图）
4. 推荐鲜花词云图

## 安装依赖

数据分析面板使用了词云图组件，需要安装额外的依赖包：

### 方法一：使用npm安装（推荐）

```bash
cd shopping-ui
npm install echarts-wordcloud
```

### 方法二：使用批处理文件安装

双击运行项目根目录下的 `install-wordcloud.bat` 文件

### 方法三：手动更新package.json

在package.json的dependencies中添加：
```json
"echarts-wordcloud": "^2.1.0"
```

然后运行：
```bash
cd shopping-ui
npm install
```

## 后端接口

后端提供了以下数据接口：

1. `/data/analysis/sales/sevenDays` - 获取近七日销售数据
2. `/data/analysis/customer/typeDistribution` - 获取客户类型分布数据
3. `/data/analysis/recommend/wordCloud` - 获取推荐鲜花词云数据
4. `/data/analysis/reservation/sevenDays` - 获取近七日预定数据

## 前端组件

前端数据分析面板相关组件位于：
- `src/views/dashboard/DataAnalysisPanel.vue` - 数据分析面板主组件
- `src/views/dashboard/components/` - 各类图表组件
  - `LineChart.vue` - 折线图组件
  - `BarChart.vue` - 柱状图组件
  - `PieChart.vue` - 饼图组件
  - `WordCloudChart.vue` - 词云图组件

## 运行项目

安装完依赖后，运行项目：

```bash
cd shopping-ui
npm run dev
```

访问 `http://localhost:8080` 查看数据分析面板效果。

## 注意事项

1. 确保后端服务正常运行
2. 确保数据库中有相关数据，否则图表可能显示为空
3. 词云图需要足够的推荐数据才能显示效果