<template>
  <div :class="className" :style="{height:height,width:width}" ref="wordCloudChart" />
</template>

<script>
import * as echarts from 'echarts'
import 'echarts-wordcloud'

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
      type: Array,
      default: () => []
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
      this.chart = echarts.init(this.$refs.wordCloudChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      this.chart.setOption({
        tooltip: {
          show: true,
          formatter: function(item) {
            return `${item.name}: ${item.data.value}`
          }
        },
        series: [{
          type: 'wordCloud',
          sizeRange: [12, 60],
          rotationRange: [-90, 90],
          rotationStep: 45,
          gridSize: 8,
          shape: 'circle',
          drawOutOfBound: false,
          textStyle: {
            fontFamily: 'sans-serif',
            fontWeight: 'bold',
            color: function() {
              return 'rgb(' + [
                Math.round(Math.random() * 160),
                Math.round(Math.random() * 160),
                Math.round(Math.random() * 160)
              ].join(',') + ')'
            }
          },
          emphasis: {
            textStyle: {
              color: '#52c41a'
            }
          },
          data: data && data.length > 0 ? data : [{ name: '暂无数据', value: 1 }]
        }]
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