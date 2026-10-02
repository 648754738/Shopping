<template>
  <div class="data-analysis-panel">
    <!-- 预定数据图表 -->
    <el-row :gutter="24">
      <el-col :xs="24" :sm="12" :lg="8">
        <div class="chart-wrapper">
          <div class="chart-header">
            <div class="chart-icon reservation-icon"></div>
            <div class="chart-title">近七日预定趋势</div>
          </div>
          <div class="chart-description">展示鲜花预定数量的变化趋势</div>
          <bar-chart :chart-data="reservationData" class="chart-container" />
        </div>
      </el-col>
      
      <!-- 客户类型分布 -->
      <el-col :xs="24" :sm="12" :lg="8">
        <div class="chart-wrapper">
          <div class="chart-header">
            <div class="chart-icon customer-icon"></div>
            <div class="chart-title">客户类型分布</div>
          </div>
          <div class="chart-description">展示不同等级客户的占比情况</div>
          <pie-chart :chart-data="customerTypeData" class="chart-container" />
        </div>
      </el-col>
      
      <!-- 预定人数趋势 -->
      <el-col :xs="24" :sm="12" :lg="8">
        <div class="chart-wrapper">
          <div class="chart-header">
            <div class="chart-icon trend-icon"></div>
            <div class="chart-title">近七日预定人数趋势</div>
          </div>
          <div class="chart-description">展示每日预定人数的变化趋势</div>
          <reservation-customer-chart :chart-data="reservationCustomerData" class="chart-container" />
        </div>
      </el-col>
      
      <!-- 推荐鲜花词云 -->
      <el-col :xs="24" :sm="24" :lg="24">
        <div class="chart-wrapper wordcloud-wrapper">
          <div class="chart-header">
            <div class="chart-icon wordcloud-icon"></div>
            <div class="chart-title">推荐鲜花词云</div>
          </div>
          <div class="chart-description">展示被推荐最多的鲜花品种</div>
          <word-cloud-chart :chart-data="wordCloudData" class="chart-container" />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { 
  BarChart, 
  PieChart, 
  WordCloudChart, 
  ReservationCustomerChart
} from './components'

import { 
  getSevenDaysReservationData,
  getSevenDaysReservationCustomerCount,
  getCustomerTypeDistribution, 
  getRecommendWordCloudData
} from '@/api/data/analysis'

export default {
  name: 'DataAnalysisPanel',
  components: {
    BarChart,
    PieChart,
    WordCloudChart,
    ReservationCustomerChart
  },
  data() {
    return {
      reservationData: {
        dates: [],
        reservationCounts: []
      },
      reservationCustomerData: {
        dates: [],
        customerCounts: []
      },
      customerTypeData: {
        types: [],
        counts: []
      },
      wordCloudData: []
    }
  },
  created() {
    this.fetchAllData()
  },
  methods: {
    // 获取所有数据
    fetchAllData() {
      this.fetchReservationData()
      this.fetchReservationCustomerData()
      this.fetchCustomerTypeData()
      this.fetchWordCloudData()
    },
    
    // 获取预定数据
    fetchReservationData() {
      getSevenDaysReservationData().then(response => {
        if (response.code === 200) {
          this.reservationData = response.data
        }
      }).catch(error => {
        console.error('获取预定数据失败:', error)
        this.$message.error('获取预定数据失败')
      })
    },
    
    // 获取预定人数数据
    fetchReservationCustomerData() {
      getSevenDaysReservationCustomerCount().then(response => {
        if (response.code === 200) {
          this.reservationCustomerData = response.data
        }
      }).catch(error => {
        console.error('获取预定人数数据失败:', error)
        this.$message.error('获取预定人数数据失败')
      })
    },
    
    // 获取客户类型分布数据
    fetchCustomerTypeData() {
      getCustomerTypeDistribution().then(response => {
        if (response.code === 200) {
          this.customerTypeData = response.data
        }
      }).catch(error => {
        console.error('获取客户类型分布数据失败:', error)
        this.$message.error('获取客户类型分布数据失败')
      })
    },
    
    // 获取推荐词云数据
    fetchWordCloudData() {
      getRecommendWordCloudData().then(response => {
        if (response.code === 200) {
          // 将返回的数据转换为词云需要的格式
          const wordCloudData = response.data.wordCloudData.map(item => {
            return {
              name: item.name,
              value: item.value
            }
          })
          this.wordCloudData = wordCloudData
        }
      }).catch(error => {
        console.error('获取推荐词云数据失败:', error)
        this.$message.error('获取推荐词云数据失败')
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.data-analysis-panel {
  padding: 30px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(12px);
  border-radius: 18px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.12);
  border: 1px solid rgba(255, 255, 255, 0.3);
  
  .chart-wrapper {
    background: #fff;
    padding: 28px;
    margin-bottom: 28px;
    border-radius: 16px;
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    position: relative;
    overflow: hidden;
    border: 1px solid rgba(0, 0, 0, 0.03);
    
    &:hover {
      box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
      transform: translateY(-4px);
      border-color: rgba(0, 0, 0, 0.05);
    }
    
    &.wordcloud-wrapper {
      padding: 32px;
    }
    
    .chart-header {
      display: flex;
      align-items: center;
      margin-bottom: 18px;
      
      .chart-icon {
        width: 40px;
        height: 40px;
        border-radius: 12px;
        margin-right: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        
        &::after {
          content: "";
          width: 22px;
          height: 22px;
          background-size: contain;
          background-repeat: no-repeat;
        }
      }
      
      .reservation-icon {
        background: linear-gradient(135deg, #409eff, #66b1ff);
        box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
        
        &::after {
          background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z'/%3E%3C/svg%3E");
        }
      }
      
      .customer-icon {
        background: linear-gradient(135deg, #67c23a, #85ce61);
        box-shadow: 0 4px 12px rgba(103, 194, 58, 0.3);
        
        &::after {
          background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M16 4c0-1.11.89-2 2-2s2 .89 2 2-.89 2-2 2-2-.89-2-2zm4 18v-6h2.5l-2.54-7.63A1.5 1.5 0 0 0 18.54 8H16c-.8 0-1.54.37-2.01.99l-7.07-3.53A1.5 1.5 0 0 0 5.5 6H4c-1.1 0-2 .89-2 2v12c0 1.1.9 2 2 2h2.5c.5 0 .96-.2 1.32-.53l7.07 3.53c.16.07.33.12.51.12.83 0 1.5-.67 1.5-1.5 0-.18-.05-.35-.12-.51L20 22z'/%3E%3C/svg%3E");
        }
      }
      
      .trend-icon {
        background: linear-gradient(135deg, #e6a23c, #ebb563);
        box-shadow: 0 4px 12px rgba(230, 162, 60, 0.3);
        
        &::after {
          background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6z'/%3E%3C/svg%3E");
        }
      }
      
      .wordcloud-icon {
        background: linear-gradient(135deg, #f56c6c, #fab6b6);
        box-shadow: 0 4px 12px rgba(245, 108, 108, 0.3);
        
        &::after {
          background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M16 4c0-1.11.89-2 2-2s2 .89 2 2-.89 2-2 2-2-.89-2-2zm4 18v-6h2.5l-2.54-7.63A1.5 1.5 0 0 0 18.54 8H16c-.8 0-1.54.37-2.01.99l-7.07-3.53A1.5 1.5 0 0 0 5.5 6H4c-1.1 0-2 .89-2 2v12c0 1.1.9 2 2 2h2.5c.5 0 .96-.2 1.32-.53l7.07 3.53c.16.07.33.12.51.12.83 0 1.5-.67 1.5-1.5 0-.18-.05-.35-.12-.51L20 22z'/%3E%3C/svg%3E");
        }
      }
      
      .chart-title {
        font-size: 20px;
        font-weight: 700;
        color: #303133;
        margin-bottom: 0;
      }
    }
    
    .chart-description {
      font-size: 15px;
      color: #909399;
      margin-bottom: 24px;
      margin-left: 54px;
      font-weight: 400;
    }
  }
  
  .panel-group {
    margin-bottom: 24px;
  }
  
  // 调整tabs样式
  ::v-deep .el-tabs__item {
    height: 44px;
    line-height: 44px;
    font-size: 15px;
    font-weight: 500;
  }
  
  ::v-deep .el-tabs__content {
    min-height: 420px;
  }
  
  // 销售趋势标签页样式
  .sales-trend-tabs {
    ::v-deep .el-tab-pane {
      height: 420px;
    }
  }
  
  // 图表容器样式 - 调整宽度和高度以优化显示
  .chart-container,
  .sales-trend-chart {
    width: 100%;
    height: 380px;
  }
  
  // 响应式调整
  @media (max-width: 768px) {
    padding: 20px;
    
    .chart-wrapper {
      padding: 20px;
      margin-bottom: 20px;
      
      &.wordcloud-wrapper {
        padding: 24px;
      }
      
      .chart-header {
        margin-bottom: 14px;
        
        .chart-icon {
          width: 36px;
          height: 36px;
          border-radius: 10px;
          
          &::after {
            width: 18px;
            height: 18px;
          }
        }
        
        .chart-title {
          font-size: 18px;
        }
      }
      
      .chart-description {
        font-size: 14px;
        margin-bottom: 20px;
        margin-left: 50px;
      }
    }
    
    .chart-container,
    .sales-trend-chart {
      height: 280px;
    }
    
    ::v-deep .el-tabs__content {
      min-height: 280px;
    }
    
    .sales-trend-tabs {
      ::v-deep .el-tab-pane {
        height: 280px;
      }
    }
  }
  
  // 中等屏幕调整
  @media (min-width: 769px) and (max-width: 1200px) {
    padding: 25px;
    
    .chart-wrapper {
      padding: 24px;
      margin-bottom: 24px;
      
      &.wordcloud-wrapper {
        padding: 28px;
      }
    }
    
    .chart-container,
    .sales-trend-chart {
      height: 340px;
    }
    
    ::v-deep .el-tabs__content {
      min-height: 340px;
    }
    
    .sales-trend-tabs {
      ::v-deep .el-tab-pane {
        height: 340px;
      }
    }
  }
}
</style>