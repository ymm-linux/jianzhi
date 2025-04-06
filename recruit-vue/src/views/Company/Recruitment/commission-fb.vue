
<template>
  <div class="commission-container">
    <el-card class="box-card" shadow="always">
      <div slot="header">
        <span>岗位数与佣金统计图</span>
      </div>
      <div ref="commissionChart" style="width: 100%; height: 400px;"></div>
    </el-card>
  </div>
</template>

<script>
import * as echarts from 'echarts';
import { getCommissionData } from '@/api/commission'; // 假设有一个 API 来获取数据

export default {
  name: "Commission",
  data() {
    return {
      commissionChart: null,
      chartData: {
        positions: [],
        commissions: []
      }
    };
  },
  mounted() {
    this.initChart();
    this.fetchCommissionData();
  },
  methods: {
    initChart() {
      this.commissionChart = echarts.init(this.$refs.commissionChart);
      this.setChartOptions();
    },
    setChartOptions() {
      const option = {
        title: {
          text: '岗位数与佣金统计'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['岗位数', '佣金']
        },
        xAxis: {
          type: 'category',
          data: this.chartData.positions
        },
        yAxis: [
          {
            type: 'value',
            name: '岗位数',
            position: 'left',
            axisLine: {
              lineStyle: {
                color: '#5470c6'
              }
            },
            axisLabel: {
              formatter: '{value} 个'
            }
          },
          {
            type: 'value',
            name: '佣金',
            position: 'right',
            offset: 80,
            axisLine: {
              lineStyle: {
                color: '#91cc75'
              }
            },
            axisLabel: {
              formatter: '{value} 元'
            }
          }
        ],
        series: [
          {
            name: '岗位数',
            type: 'bar',
            data: this.chartData.positionsCount,
            yAxisIndex: 0
          },
          {
            name: '佣金',
            type: 'line',
            yAxisIndex: 1,
            data: this.chartData.commissions
          }
        ]
      };
      this.commissionChart.setOption(option);
    },
    fetchCommissionData() {
      getCommissionData()
        .then(res => {
          console.log(res.data);
          this.chartData.positions = res.data.map(item => item.positionName);
          this.chartData.positionsCount = res.data.map(item => item.positionCount);
          this.chartData.commissions = res.data.map(item => item.totalCommission);
          this.setChartOptions();
        })
        .catch(error => {
          console.error('获取佣金数据失败:', error);
        });
    }
  }
};
</script>

<style scoped>
.commission-container {
  padding: 20px;
}
.box-card {
  width: 100%;
}
</style>
