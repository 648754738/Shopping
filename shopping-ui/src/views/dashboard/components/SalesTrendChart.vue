<template>
  <div :class="className" :style="{height:height,width:width}" ref="salesTrendChart" />
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
    },
    chartType: {
      type: String,
      default: 'line' // line 或 bar
    },
    title: {
      type: String,
      default: '销售趋势'
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
    // 监听窗口大小变化，重新调整图表大小
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
      this.chart = echarts.init(this.$refs.salesTrendChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      // 构造图表数据
      const dates = data.dates || []
      const salesAmounts = data.salesAmounts || []
      const salesCounts = data.salesCounts || []
      
      // 根据数据量调整标签旋转角度
      const labelRotate = dates.length > 15 ? 45 : (dates.length > 8 ? 30 : 0)
      
      this.chart.setOption({
        title: {
          text: this.title,
          left: 'center',
          textStyle: {
            fontSize: 16,
            fontWeight: 'bold'
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
              if (param.seriesName === '销售额') {
                tooltip += param.marker + param.seriesName + ': ¥' + param.value.toFixed(2) + '<br/>'
              } else {
                tooltip += param.marker + param.seriesName + ': ' + param.value + '件<br/>'
              }
            })
            return tooltip
          }
        },
        legend: {
          data: ['销售额', '销售数量'],
          bottom: '2%',
          textStyle: {
            fontSize: 12
          }
        },
        grid: {
          top: '20%',
          left: '12%',
          right: '12%',
          bottom: '18%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: dates,
          axisLabel: {
            fontSize: 12,
            rotate: labelRotate,
            interval: dates.length > 20 ? 'auto' : 0 // 数据过多时自动间隔显示
          }
        },
        yAxis: [
          {
            type: 'value',
            name: '销售额(元)',
            position: 'left',
            axisLabel: {
              formatter: function (value) {
                return '¥' + value
              },
              fontSize: 12
            },
            nameTextStyle: {
              fontSize: 12
            }
          },
          {
            type: 'value',
            name: '销售数量(件)',
            position: 'right',
            axisLabel: {
              fontSize: 12
            },
            nameTextStyle: {
              fontSize: 12
            }
          }
        ],
        series: [
          {
            name: '销售额',
            type: this.chartType,
            yAxisIndex: 0,
            data: salesAmounts,
            itemStyle: {
              color: '#5ab1ef'
            },
            smooth: this.chartType === 'line' // 折线图启用平滑曲线
          },
          {
            name: '销售数量',
            type: this.chartType,
            yAxisIndex: 1,
            data: salesCounts,
            itemStyle: {
              color: '#b6a2de'
            },
            smooth: this.chartType === 'line' // 折线图启用平滑曲线
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