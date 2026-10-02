<template>
  <div :class="className" :style="{height:height,width:width}" ref="reservationCustomerChart" />
</template>

<script>
import * as echarts from 'echarts'

export default {
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '400px'
    },
    chartData: {
      type: Object,
      default: () => ({
        dates: [],
        customerCounts: []
      })
    }
  },
  data() {
    return {
      chart: null
    }
  },
  watch: {
    chartData: {
      handler(newVal) {
        this.setOptions(newVal)
      },
      deep: true
    }
  },
  mounted() {
    this.initChart()
    // 监听窗口大小变化
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    // 移除事件监听器
    window.removeEventListener('resize', this.handleResize)
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$refs.reservationCustomerChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      // 构造图表数据
      const dates = data.dates || []
      const customerCounts = data.customerCounts || []
      
      // 根据数据量调整标签旋转角度
      const labelRotate = dates.length > 10 ? 45 : (dates.length > 5 ? 30 : 0)
      
      this.chart.setOption({
        grid: {
          top: '15%',
          left: '10%',
          right: '10%',
          bottom: '15%',
          containLabel: true
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          },
          formatter: function(params) {
            return params[0].name + '<br/>' + 
                   params[0].marker + params[0].seriesName + ': ' + params[0].value + '人'
          }
        },
        xAxis: {
          type: 'category',
          data: dates,
          axisLabel: {
            fontSize: 12,
            rotate: labelRotate,
            interval: dates.length > 15 ? 'auto' : 0 // 数据过多时自动间隔显示
          }
        },
        yAxis: {
          type: 'value',
          name: '预定人数',
          axisLabel: {
            fontSize: 12
          },
          nameTextStyle: {
            fontSize: 12
          }
        },
        series: [
          {
            name: '预定人数',
            type: 'line',
            data: customerCounts,
            smooth: true,
            itemStyle: {
              color: '#5ab1ef'
            },
            areaStyle: {
              color: '#5ab1ef',
              opacity: 0.3
            },
            lineStyle: {
              width: 2
            },
            symbolSize: 6
          }
        ]
      })
    },
    // 处理窗口大小变化
    handleResize() {
      if (this.chart) {
        // 延迟执行resize以确保容器大小已更新
        setTimeout(() => {
          this.chart.resize({
            animation: {
              duration: 300
            }
          })
          // 重新设置选项以适应新尺寸
          this.setOptions(this.chartData)
        }, 100)
      }
    }
  }
}
</script>

<style scoped>
.chart {
  width: 100%;
  height: 100%;
}
</style>