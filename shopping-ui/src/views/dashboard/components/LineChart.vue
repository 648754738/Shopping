<template>
  <div :class="className" :style="{height:height,width:width}" ref="lineChart" />
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
        salesAmounts: [],
        salesCounts: []
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
      this.chart = echarts.init(this.$refs.lineChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      // 确保数据存在且为数组
      const dates = Array.isArray(data.dates) ? data.dates : []
      const salesAmounts = Array.isArray(data.salesAmounts) ? data.salesAmounts : []
      const salesCounts = Array.isArray(data.salesCounts) ? data.salesCounts : []
      
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
          axisLabel: {
            fontSize: 12,
            formatter: function (value) {
              if (value >= 10000) {
                return (value / 10000).toFixed(1) + 'w'
              } else if (value >= 1000) {
                return (value / 1000).toFixed(1) + 'k'
              }
              return value
            }
          }
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          },
          formatter: function (params) {
            let tooltip = params[0].name + '<br/>'
            params.forEach(param => {
              if (param.seriesName === '销售金额') {
                // 格式化金额显示
                let amount = param.value
                if (amount >= 10000) {
                  tooltip += param.marker + param.seriesName + ': ¥' + (amount / 10000).toFixed(2) + '万<br/>'
                } else if (amount >= 1000) {
                  tooltip += param.marker + param.seriesName + ': ¥' + (amount / 1000).toFixed(2) + '千<br/>'
                } else {
                  tooltip += param.marker + param.seriesName + ': ¥' + amount.toFixed(2) + '<br/>'
                }
              } else {
                tooltip += param.marker + param.seriesName + ': ' + param.value + '件<br/>'
              }
            })
            return tooltip
          }
        },
        legend: {
          data: ['销售金额', '销售数量'],
          bottom: '2%',
          textStyle: {
            fontSize: 12
          }
        },
        series: [
          {
            name: '销售金额',
            type: 'line',
            data: salesAmounts,
            smooth: true,
            itemStyle: {
              color: '#40c9c6'
            },
            lineStyle: {
              width: 2
            },
            symbolSize: 6
          },
          {
            name: '销售数量',
            type: 'line',
            data: salesCounts,
            smooth: true,
            itemStyle: {
              color: '#36a3f7'
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