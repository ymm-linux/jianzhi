<template>
  <el-card class="box-card" shadow="always">
    <div slot="header">
      <span>在岗人员</span>
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
       <el-table-column label="员工" align="center" prop="nickname" />
       <el-table-column label="岗位" align="center" prop="title" />
       <el-table-column label="HR" align="center" prop="hrName" />
       <el-table-column label="企业" align="center" prop="companyName" />
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
  </el-card>
</template>

<script>
import { listWorkers } from '@/api/recruit/workers';

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
    }
  },
  created: function () {
    this.userinfo = JSON.parse(sessionStorage.getItem("user"));
    this.getListData();
  },
  methods: {
    getListData() {
      listWorkers()
        .then(res => {
          console.log(res.data);
          this.list = res.data;
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
  }
}
</script>

<style scoped>

</style>
