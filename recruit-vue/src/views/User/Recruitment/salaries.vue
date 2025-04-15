<template>
 <div>
    <div slot="header">
      <span>&nbsp;</span>
    </div>
    <el-table
      ref="multipleTable"
      :loading="listLoading"
      :data="list.slice((currentPage - 1) * pagesize, currentPage * pagesize)"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column label="岗位" align="center" prop="title" />
      <el-table-column label="HR" align="center" prop="hrName" />
      <el-table-column label="企业" align="center" prop="companyName" />
      <el-table-column label="在岗状态" align="center" prop="workStatus" />
      <el-table-column label="上岗日期" align="center" prop="workTime" width="180">
        <template slot-scope="scope">
          {{ scope.row.workTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column label="离岗日期" align="center" prop="leaveTime" width="180">
         <template slot-scope="scope">
          {{ scope.row.leaveTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column label="工作时长（天）" align="center" prop="workDays" />
      <el-table-column label="薪资类型" align="center" prop="salaryType" />
      <el-table-column label="薪资（元）" align="center" prop="salary" />
      <el-table-column label="薪资总额（元）" align="center" prop="totalSalary" />
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

      <div style="display: flex; justify-content: space-between;margin:50px">
        <div id="barChart" style="width: 50%; height: 400px;"></div>
        <div id="pieChart" style="width: 50%; height: 400px;"></div>
      </div>
   </div>
</template>
<script>import * as echarts from 'echarts';
import { listSalariesByUser, delSalaries } from '@/api/salaries';

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
      educations: []
    };
  },
  created() {
    this.userinfo = JSON.parse(sessionStorage.getItem("user"));
    this.getListData();
  },
  methods: {
    getListData() {
      listSalariesByUser()
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
    handleDel(row) {
      this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delSalaries(row.id)
          .then(res => {
            this.getListData();
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
          })
          .catch(error => {
            console.log(error);
          });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
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
      // 按岗位分类统计薪资总额和岗位数量
      const jobData = this.list.reduce((acc, item) => {
        const job = item.title; // 岗位名称
        if (!acc[job]) {
          acc[job] = {
            totalSalary: 0,
            count: 0,
          };
        }
        acc[job].totalSalary += item.totalSalary; // 累加薪资总额
        acc[job].count += 1; // 累加岗位数量
        return acc;
      }, {});

      // 柱状图数据：每个岗位的薪资总额
      const barData = Object.keys(jobData).map(job => ({
        name: job,
        value: jobData[job].totalSalary,
        count: jobData[job].count, // 岗位数量
      })).sort((a, b) => b.value - a.value); // 按薪资总额从高到低排序

      // 饼图数据：每个岗位的薪资分布
      const pieData = Object.keys(jobData).map(job => ({
        name: job,
        value: jobData[job].totalSalary,
        count: jobData[job].count, // 岗位数量
      })).sort((a, b) => b.value - a.value); // 按薪资总额从高到低排序

      // 渲染柱状图
      const barChart = echarts.init(document.getElementById('barChart'));
      barChart.setOption({
        title: {
          text: '岗位薪资总额（按岗位分类）',
          left: 'center',
        },
        tooltip: {
          trigger: 'axis',
          formatter: function (params) {
            const data = params[0].data;
            return `岗位: ${data.name}<br>薪资总额: ${data.value} 元<br>岗位数量: ${data.count}`;
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
            name: '薪资总额',
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
          text: '岗位薪资分布（按岗位分类）',
          left: 'center',
        },
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            return `岗位: ${params.name}<br>薪资总额: ${params.value} 元<br>岗位数量: ${params.data.count}`;
          },
        },
        color: ['#5470C6', '#91CC75', '#EE6666', '#FAC858', '#73C0DE', '#3BA272', '#FC8452', '#9A60B4'], // 自定义颜色
        series: [
          {
            name: '薪资分布',
            type: 'pie',
            radius: '50%',
            data: pieData,
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
    },
  },
};
</script>

<style scoped>.box-card {
  margin-bottom: 20px;
}
</style>
