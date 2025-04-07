<template>
  <div>
    <!-- 原有表格部分 -->
    <el-card class="box-card" shadow="always">
      <div slot="header">
        <span>佣金统计</span>
      </div>
      <el-table
        ref="multipleTable"
        :loading="listLoading"
        :data="list.slice((currentPage - 1) * pagesize, currentPage * pagesize)"
        tooltip-effect="dark"
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="岗位发布企业" align="center" prop="companyName" />
        <el-table-column label="发布HR" align="center" prop="hrName" />
        <el-table-column label="岗位发布总数" align="center" prop="cnt" />
        <el-table-column label="佣金总额（元）" align="center" prop="totalCommission" />
        <el-table-column label="佣金均价（元/每条）" align="center" prop="avgCommission" />
      </el-table>
      <div style="padding: 14px;">
        <el-pagination
          style="float: right"
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-size="pagesize"
          layout="total, prev, pager, next, jumper"
          :total="list.length">
        </el-pagination>
      </div>
    </el-card>

    <!-- 新增统计图表部分 -->
    <el-card class="box-card" shadow="always" style="margin-top: 20px;">
      <div slot="header">
        <span>佣金统计图</span>
      </div>
      <div style="display: flex; justify-content: space-between;">
        <div id="barChart" style="width: 50%; height: 400px;"></div>
        <div id="pieChart" style="width: 50%; height: 400px;"></div>
      </div>
    </el-card>
  </div>
</template>

<script>
import * as echarts from 'echarts';
import { listCommission } from '@/api/recruit/salaries';

export default {
  name: "Guest",
  data() {
    return {
      currentPage: 1,
      pagesize: 5,
      list: [],
      visible2: false,
      loading: null,
      listLoading: false,
      multipleSelection: null,
      userinfo: {},
      categorys: [],
      educations: [],
    };
  },
  created() {
    this.userinfo = JSON.parse(sessionStorage.getItem("user"));
    this.getListData();
  },
  methods: {
    getListData() {
      listCommission()
        .then(res => {
          console.log(res.data);
          this.list = res.data;
          this.renderCharts(); // 调用渲染图表的方法
        })
        .catch(error => {
          console.log(error);
        });
    },
    handleSizeChange(val) {
      this.pagesize = val;
    },
    handleCurrentChange(val) {
      this.currentPage = val;
    },
    navigateTo(val) {
      this.$router.push("/" + val);
    },
    handleEdit(index, row) {
      localStorage.setItem("goodsInfo", JSON.stringify(row));
      this.$router.push({
        path: '/edit',
        params: {
          id: row.positionId
        }
      });
    },
    toggleSelection(rows) {
      if (rows) {
        rows.forEach(row => {
          this.$refs.multipleTable.toggleRowSelection(row);
        });
      } else {
        this.$refs.multipleTable.clearSelection();
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    educationFilter(id) {
      const education = this.educations.find(item => item.id === id);
      return education ? education.name : '不限';
    },
    renderCharts() {
  // 柱状图数据：按金额排序，展示每个企业的佣金总额和岗位发布数
  const barData = this.list
    .map(item => ({
      name: item.companyName,
      value: item.totalCommission,
      cnt: item.cnt, // 岗位发布数
    }))
    .sort((a, b) => b.value - a.value); // 按金额从高到低排序

  // 饼图数据：按金额排序，展示佣金的分布情况
  const pieData = this.list.reduce((acc, item) => {
    const company = item.companyName;
    if (!acc[company]) acc[company] = { totalCommission: 0, cnt: 0 };
    acc[company].totalCommission += item.totalCommission;
    acc[company].cnt += item.cnt;
    return acc;
  }, {});
  const pieDataFormatted = Object.keys(pieData)
    .map(key => ({
      name: key,
      value: pieData[key].totalCommission,
      cnt: pieData[key].cnt, // 岗位发布数
    }))
    .sort((a, b) => b.value - a.value); // 按金额从高到低排序

  // 渲染柱状图
  const barChart = echarts.init(document.getElementById('barChart'));
  barChart.setOption({
    title: {
      text: '企业佣金总额（按金额排序）',
      left: 'center',
    },
    tooltip: {
      trigger: 'axis',
      formatter: function (params) {
        const data = params[0].data;
        return `企业: ${data.name}<br>佣金总额: ${data.value} 元<br>岗位发布数: ${data.cnt}`;
      },
    },
    xAxis: {
      type: 'category',
      data: barData.map(item => item.name),
    },
    yAxis: {
      type: 'value',
    },
    series: [
      {
        name: '佣金总额',
        type: 'bar',
        data: barData,
        label: {
          show: true,
          position: 'top',
          formatter: function (params) {
            return `${params.data.value} 元`;
          },
        },
      },
    ],
  });

  // 渲染饼图
  const pieChart = echarts.init(document.getElementById('pieChart'));
  pieChart.setOption({
    title: {
      text: '佣金分布（按金额排序）',
      left: 'center',
    },
    tooltip: {
      trigger: 'item',
      formatter: function (params) {
        return `企业: ${params.name}<br>佣金总额: ${params.value} 元<br>岗位发布数: ${params.data.cnt}`;
      },
    },
    color: ['#5470C6', '#91CC75', '#EE6666', '#FAC858', '#73C0DE', '#3BA272', '#FC8452', '#9A60B4'], // 自定义颜色
    series: [
      {
        name: '佣金分布',
        type: 'pie',
        radius: '50%',
        data: pieDataFormatted,
        label: {
          show: true,
          formatter: function (params) {
            return `${params.name}: ${params.value} 元`;
          },
        },
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)',
          },
        },
      },
    ],
  });
}

  },
};
</script>

<style scoped>
.box-card {
  margin-bottom: 20px;
}
</style>
