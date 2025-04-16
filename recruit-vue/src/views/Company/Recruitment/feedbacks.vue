<template>
   <div>
    <div slot="header">
        &nbsp;
    </div>
    <el-button @click="skipUpdate()" type="warning" >发起投诉</el-button>
    <el-table
      ref="multipleTable"
      :loading="listLoading"
      :data="list.slice((currentPage - 1) * pagesize, currentPage * pagesize)"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column label="主键" align="center" prop="id"  v-if="false />
      <el-table-column label="用户ID" align="center" prop="userId"  v-if="false />
      <el-table-column label="投诉用户" align="center" prop="userName"  v-if="false />
      <el-table-column label="用户类型" align="center" prop="userType" v-if="false />
      <el-table-column label="投诉内容" align="center" prop="content" />
      <el-table-column label="处理状态" align="center" prop="status" />
      <el-table-column label="发起时间" align="center" width="180">
        <template slot-scope="scope">
          {{ scope.row.sendTime | formatTime }}
        </template>
      </el-table-column>
      <el-table-column label="反馈内容" align="center" prop="reviewerContent" />
      <el-table-column label="处理人ID" align="center" prop="reviewerId" v-if="false  />
      <el-table-column label="处理人" align="center" prop="reviewerName" />
      <el-table-column label="反馈时间" align="center" width="180">
        <template slot-scope="scope">
          {{ scope.row.reviewerTime | formatTime }}
        </template>
      </el-table-column>
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

    <el-dialog title="发起投诉" :visible.sync="dialogVisible" width="30%" center>
     <!-- 隐藏的 ID 字段 -->
      <el-input type="textarea" :rows="2" v-model="content" />
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleEdit()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { listFeedbacks,listFeedbacksByHr,listFeedbacksByUser,getFeedBacks,addFeedbacksByHr,addFeedbacksByUser, delFeedbacks,updateFeedbacks } from '@/api/feedbacks';

export default {
  name: "Guest",
  data() {
    return {
      dialogVisible: false,
      content: '',
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
      listFeedbacksByHr()
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
    /** 修改按钮操作 */
     skipUpdate() {
      this.dialogVisible = true;
      this.title = "新增投诉";
      this.content = '';
    },
    handleDel(row) {
      const data = { id: row.id }; // 将 data 定义为对象
      this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delFeedbacks(data)
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
    handleEdit() {
      this.dialogVisible = false;
      const data = {
        content: this.content
       }; // 将 data 定义为对象
      console.log(data);
      addFeedbacksByHr(data)
        .then(res => {
          this.getListData();
          this.$message({
            type: 'success',
            message: '投诉成功!'
          });
        })
        .catch(error => {
          console.log(error);
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
