<template>
  <div :class="className" :style="{height:height,width:width}" ref="pieChart" />
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
        types: [],
        counts: []
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
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$refs.pieChart)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      if (!this.chart) return
      
      // 构造饼图数据
      const pieData = []
      if (data.types && data.counts) {
        for (let i = 0; i < data.types.length; i++) {
          pieData.push({
            name: data.types[i],
            value: data.counts[i] || 0
          })
        }
      }
      
      this.chart.setOption({
        tooltip: {
          trigger: 'item'
        },
        legend: {
          bottom: '0%',
          left: 'center'
        },
        series: [
          {
            name: '客户类型',
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
                fontWeight: 'bold'
              }
            },
            labelLine: {
              show: false
            },
            data: pieData
          }
        ]
      })
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