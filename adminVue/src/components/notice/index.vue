<template>
  <el-card class="box-card" shadow="always">
    <div slot="header">
      <span>通知公告</span>
    </div>
    <!-- 新增按钮（表格左上角） -->
    <div class="table-toolbar">  <!-- 新增容器 -->
      <el-button
        @click="handleAdd"
        type="primary"
        size="mini"
        style="margin-bottom: 12px"
      >新增
      </el-button>
    </div>
    <el-table
      ref="multipleTable"
      :loading="listLoading"
      :data="list.slice((currentPage - 1) * pagesize, currentPage * pagesize)"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="公告ID" align="center" prop="noticeId"/>
      <el-table-column label="公告标题" align="center" prop="noticeTitle"/>
      <el-table-column label="公告内容" align="center" prop="noticeContent"/>
      <el-table-column label="公告类型" align="center" prop="noticeType">
        <template slot-scope="scope">
          {{ formatNoticeType(scope.row.noticeType) }}
        </template>
      </el-table-column>
      <el-table-column label="发布状态" align="center" prop="status">
        <template slot-scope="scope">
          {{ formatStatus(scope.row.status) }}
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark"/>
      <el-table-column
        fixed="right"
        label="操作"
        width="230">
        <template slot-scope="scope">
          <!-- <el-button @click="handleAdd(scope.row)" type="primary" size="mini">新增</el-button> -->
          <el-button @click="handleUpdate(scope.row)" type="warning" size="mini">修改</el-button>
          <el-button @click="handleDel(scope.row)" type="danger" size="mini">删除</el-button>
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
    <el-dialog :title="title" :visible.sync="open" width="50%" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
<!--        <el-form-item label="公告id" prop="noticeId">-->
<!--          <el-input v-model="form.noticeId" placeholder="请输入公告ID" />-->
<!--        </el-form-item>-->
        <el-form-item label="公告标题" prop="noticeTitle">
          <el-input v-model="form.noticeTitle" placeholder="请输入公告标题" />
        </el-form-item>
        <el-form-item label="公告类型" prop="noticeType">
          <el-select v-model="form.noticeType" placeholder="请选择公告类型">
            <el-option label="系统公告" value="1" />
            <el-option label="活动公告" value="2" />
            <el-option label="紧急通知" value="3" />
          </el-select>
        </el-form-item>
        <el-form-item label="公告内容" prop="noticeContent">
          <el-input
            v-model="form.noticeContent"
            type="textarea"
            :rows="4"
            placeholder="请输入公告内容"
          />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">草稿</el-radio>
            <el-radio label="1">发布</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

  </el-card>

</template>

<script>
import {listNotice, getNotice, delNotice, addNotice, updateNotice} from "@/api/recruit/notice";

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
      open: false, // 控制对话框显示
      title: "",   // 对话框标题
      form: {      // 表单数据
        // noticeId: null,
        noticeTitle: null,
        noticeType: null,
        noticeContent: null,
        status: "0", // 默认草稿状态
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
      }, rules: {     // 表单验证规则
        noticeTitle: [
          {required: true, message: "公告标题不能为空", trigger: "blur"}
        ],
        noticeType: [
          {required: true, message: "公告类型不能为空", trigger: "change"}
        ],
        noticeContent: [
          {required: true, message: "公告内容不能为空", trigger: "blur"}
        ]
      }
    }
  },

  created: function () {
    this.userinfo = JSON.parse(sessionStorage.getItem("user"));
    this.getListData();
  },
  methods: {
    // 表单重置
    reset() {
      this.form = {
        noticeId: null,
        noticeTitle: null,
        noticeType: null,
        noticeContent: null,
        status: null,
        createBy: null,
        // createTime: null,
        // updateBy: null,
        // updateTime: null,
        remark: null
      };
      // this.resetForm("form");
    },
    // 新增以下方法
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 只提取需要的字段
          const submitData = {
            noticeId: this.form.noticeId,
            noticeTitle: this.form.noticeTitle,
            noticeType: this.form.noticeType,
            noticeContent: this.form.noticeContent,
            status: this.form.status,
            remark: this.form.remark
          };

          if (this.form.noticeId) {
            // 修改公告
            updateNotice(submitData).then(response => {
              this.$message.success("修改成功");
              this.open = false;
              this.getListData();
            });
          } else {
            // 新增公告
            addNotice(submitData).then(response => {
              this.$message.success("新增成功");
              this.open = false;
              this.getListData();
            });
          }
        }
      });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    getListData() {
      listNotice()
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
    handleDel(row) {
      this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delNotice(row.id)
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
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加公告管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const noticeId = row.noticeId || this.ids
      getNotice(noticeId).then(response => {
        this.form = {
          ...this.form,  // 保留原有表单的默认值
          ...response.data  // 用响应数据覆盖对应的字段
        };
        console.log(this.form,'this.form')
        console.log(response.data,'response.data')
        this.open = true;
        this.title = "修改公告管理";
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
    // 格式化公告类型
    formatNoticeType(type) {
      const typeMap = {
        '1': '系统公告',
        '2': '活动公告',
        '3': '紧急通知'
      };
      return typeMap[type] || '未知类型';
    },
    // 格式化发布状态
    formatStatus(status) {
      const statusMap = {
        '0': '草稿',
        '1': '已发布'
      };
      return statusMap[status] || '未知状态';
    },
  }
}
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.table-toolbar {
  text-align: left;
  padding: 10 20px; /* 与表格内容对齐 */
}
</style>
