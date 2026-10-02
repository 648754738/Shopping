<template>
  <div :class="className" :style="{height:height,width:width}" ref="paymentMethodChart" />
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
        methods: [],
        counts: [],
        amounts: []
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
      this.chart = echarts.init(this.$refs.paymentMethodChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      // 构造支付方式分布数据
      const pieData = []
      if (data.methods && data.counts) {
        for (let i = 0; i < data.methods.length; i++) {
          pieData.push({
            name: data.methods[i],
            value: data.counts[i] || 0
          })
        }
      }
      
      // 过滤掉值为0的数据
      const filteredPieData = pieData.filter(item => item.value > 0)
      
      // 添加标题显示
      const titleText = filteredPieData.length > 0 ? '支付方式分布' : '暂无支付数据'
      
      this.chart.setOption({
        title: {
          text: titleText,
          left: 'center',
          textStyle: {
            fontSize: 16,
            fontWeight: 'bold'
          }
        },
        tooltip: {
          trigger: 'item',
          formatter: function(params) {
            // 如果是空数据提示，直接返回
            if (params.name === '暂无数据') {
              return '暂无支付数据'
            }
            return params.name + '<br/>' + 
                   params.marker + '数量: ' + params.value + '<br/>' +
                   '占比: ' + params.percent + '%'
          }
        },
        legend: {
          bottom: '5%',
          left: 'center',
          textStyle: {
            fontSize: 12
          },
          type: 'scroll' // 添加滚动效果，防止标签过多显示不全
        },
        series: [
          {
            name: '支付方式',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: {
              show: false,
              position: 'center'
            },
            emphasis: {
              label: {
                show: true,
                fontSize: '14',
                fontWeight: 'bold',
                formatter: function(params) {
                  // 如果是空数据提示，只显示文字
                  if (params.name === '暂无数据') {
                    return '暂无数据'
                  }
                  return params.name + '\n' + params.percent + '%'
                }
              }
            },
            labelLine: {
              show: false
            },
            data: filteredPieData.length > 0 ? filteredPieData : [{name: '暂无数据', value: 1}]
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