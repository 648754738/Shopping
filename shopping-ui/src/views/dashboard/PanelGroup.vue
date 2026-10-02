<template>
  <el-row :gutter="24" class="panel-group">
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('newVisitis')">
        <div class="card-panel-icon-wrapper icon-people">
          <svg-icon icon-class="peoples" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            客户总数
          </div>
          <count-to :start-val="0" :end-val="statisticsData.customerStats.totalCustomers || 0" :duration="2600" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('messages')">
        <div class="card-panel-icon-wrapper icon-message">
          <svg-icon icon-class="message" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            销售订单
          </div>
          <count-to :start-val="0" :end-val="statisticsData.salesStats.totalSalesCount || 0" :duration="3000" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('purchases')">
        <div class="card-panel-icon-wrapper icon-money">
          <svg-icon icon-class="money" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            销售金额
          </div>
          <count-to :start-val="0" :end-val="statisticsData.salesStats.totalSalesAmount || 0" :duration="3200" class="card-panel-num" :decimals="2" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('shoppings')">
        <div class="card-panel-icon-wrapper icon-shopping">
          <svg-icon icon-class="shopping" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            可用库存
          </div>
          <count-to :start-val="0" :end-val="statisticsData.inventoryStats.totalAvailable || 0" :duration="3600" class="card-panel-num" />
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import CountTo from 'vue-count-to'

export default {
  props: {
    statisticsData: {
      type: Object,
      default: () => ({
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
      })
    }
  },
  components: {
    CountTo
  },
  methods: {
    handleSetLineChartData(type) {
      this.$emit('handleSetLineChartData', type)
    }
  }
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-bottom: 24px;

  .card-panel-col {
    margin-bottom: 24px;
  }

  .card-panel {
    height: 130px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
    border-radius: 16px;
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    backdrop-filter: blur(10px);
    background: rgba(255, 255, 255, 0.9);

    &:hover {
      transform: translateY(-6px);
      box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);

      .card-panel-icon-wrapper {
        color: #fff;
        transform: scale(1.15);
      }

      .icon-people {
        background: linear-gradient(135deg, #40c9c6, #36a3f7);
        box-shadow: 0 6px 15px rgba(54, 163, 247, 0.4);
      }

      .icon-message {
        background: linear-gradient(135deg, #36a3f7, #40c9c6);
        box-shadow: 0 6px 15px rgba(64, 201, 198, 0.4);
      }

      .icon-money {
        background: linear-gradient(135deg, #f4516c, #f7897c);
        box-shadow: 0 6px 15px rgba(244, 81, 108, 0.4);
      }

      .icon-shopping {
        background: linear-gradient(135deg, #34bfa3, #40c9c6);
        box-shadow: 0 6px 15px rgba(52, 191, 163, 0.4);
      }
    }

    .icon-people {
      color: #40c9c6;
      background: rgba(64, 201, 198, 0.15);
      box-shadow: 0 4px 10px rgba(64, 201, 198, 0.2);
    }

    .icon-message {
      color: #36a3f7;
      background: rgba(54, 163, 247, 0.15);
      box-shadow: 0 4px 10px rgba(54, 163, 247, 0.2);
    }

    .icon-money {
      color: #f4516c;
      background: rgba(244, 81, 108, 0.15);
      box-shadow: 0 4px 10px rgba(244, 81, 108, 0.2);
    }

    .icon-shopping {
      color: #34bfa3;
      background: rgba(52, 191, 163, 0.15);
      box-shadow: 0 4px 10px rgba(52, 191, 163, 0.2);
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 18px 0 0 18px;
      padding: 18px;
      transition: all 0.4s ease-out;
      border-radius: 12px;
      width: 60px;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .card-panel-icon {
      float: left;
      font-size: 32px;
    }

    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 28px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 20px;
        color: rgba(0, 0, 0, 0.5);
        font-size: 17px;
        margin-bottom: 14px;
        font-weight: 500;
      }

      .card-panel-num {
        font-size: 26px;
        font-weight: 700;
        color: #303133;
      }
    }
  }
}

@media (max-width:550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 16px auto !important;
      float: none !important;
    }
  }
}

// 响应式优化
@media (max-width: 768px) {
  .panel-group {
    margin-bottom: 16px;
    
    .card-panel-col {
      margin-bottom: 16px;
    }
    
    .card-panel {
      height: 110px;
      border-radius: 14px;
      
      .card-panel-icon-wrapper {
        margin: 14px 0 0 14px;
        padding: 14px;
        width: 50px;
        height: 50px;
      }
      
      .card-panel-icon {
        font-size: 26px;
      }
      
      .card-panel-description {
        margin: 22px;
        
        .card-panel-text {
          font-size: 15px;
          margin-bottom: 10px;
        }
        
        .card-panel-num {
          font-size: 22px;
        }
      }
    }
  }
}
</style>