<template>
  <div class="dashboard-editor-container">
    <!-- 背景装饰元素 -->
    <div class="background-decoration">
      <div class="decoration-circle circle-1"></div>
      <div class="decoration-circle circle-2"></div>
      <div class="decoration-circle circle-3"></div>
    </div>
    
    <!-- 首页数据统计面板 -->
    <panel-group :statistics-data="statisticsData" class="panel-group-spacing" />

    <!-- 数据分析面板 -->
    <data-analysis-panel class="panel-group-spacing" />
  </div>
</template>

<script>
import PanelGroup from './dashboard/PanelGroup'
import DataAnalysisPanel from './dashboard/DataAnalysisPanel'

import { getDashboardStatistics } from '@/api/dashboard/statistics'

export default {
  name: 'Index',
  components: {
    PanelGroup,
    DataAnalysisPanel
  },
  data() {
    return {
      statisticsData: {
        inventoryStats: {
          totalInventory: 0,
          totalAvailable: 0,
          warningCount: 0
        },
        salesStats: {
          totalSalesCount: 0,
          totalSalesAmount: 0,
          totalSalesQuantity: 0
        },
        customerStats: {
          totalCustomers: 0,
          activeCustomers: 0,
          vipCustomers: 0
        }
      }
    }
  },
  created() {
    this.fetchDashboardStatistics()
  },
  methods: {
    // 获取首页统计数据
    fetchDashboardStatistics() {
      getDashboardStatistics().then(response => {
        if (response.code === 200) {
          this.statisticsData = response.data
        }
      }).catch(error => {
        console.error('获取首页统计数据失败:', error)
        this.$message.error('获取首页统计数据失败')
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 30px;
  background: linear-gradient(135deg, #f0f2f5 0%, #e6e9f0 100%);
  position: relative;
  min-height: calc(100vh - 84px);
  overflow: hidden;
  
  // 背景装饰元素
  .background-decoration {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 0;
    
    .decoration-circle {
      position: absolute;
      border-radius: 50%;
      opacity: 0.08;
      filter: blur(30px);
    }
    
    .circle-1 {
      width: 400px;
      height: 400px;
      background: linear-gradient(45deg, #409eff, #66b1ff);
      top: -150px;
      right: -150px;
    }
    
    .circle-2 {
      width: 300px;
      height: 300px;
      background: linear-gradient(45deg, #67c23a, #85ce61);
      bottom: -120px;
      left: 10%;
    }
    
    .circle-3 {
      width: 200px;
      height: 200px;
      background: linear-gradient(45deg, #e6a23c, #ebb563);
      top: 40%;
      right: 25%;
    }
  }
  
  // 内容区域需要在装饰元素之上
  & > * {
    position: relative;
    z-index: 1;
  }
  
  // 调整面板间距，使其更紧凑
  .panel-group-spacing {
    margin-bottom: 25px;
  }
  
  // 进一步减少面板内部的底部间距
  ::v-deep .panel-group {
    margin-bottom: 25px;
    border-radius: 16px;
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    backdrop-filter: blur(10px);
    background: rgba(255, 255, 255, 0.9);
    
    &:hover {
      box-shadow: 0 10px 35px rgba(0, 0, 0, 0.15);
      transform: translateY(-3px);
    }
  }
  
  ::v-deep .data-analysis-panel {
    padding: 25px;
    margin-bottom: 25px;
    border-radius: 16px;
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    
    &:hover {
      box-shadow: 0 10px 35px rgba(0, 0, 0, 0.15);
      transform: translateY(-3px);
    }
    
    .chart-wrapper {
      background: white;
      border-radius: 12px;
      box-shadow: 0 3px 15px rgba(0, 0, 0, 0.06);
      transition: all 0.3s ease;
      padding: 25px;
      
      &:hover {
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        transform: translateY(-2px);
      }
    }
  }
  
  // 响应式设计
  @media (max-width: 768px) {
    padding: 15px;
    
    .panel-group-spacing {
      margin-bottom: 15px;
    }
  }
}
</style>