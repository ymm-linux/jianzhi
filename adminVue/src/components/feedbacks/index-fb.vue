<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="投诉用户" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="投诉用户"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发起时间" prop="sendTime">
        <el-date-picker clearable
          v-model="queryParams.sendTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择发起时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="反馈时间" prop="reviewerTime">
        <el-date-picker clearable
          v-model="queryParams.reviewerTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择反馈时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="feedbacksList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="投诉用户" align="center" prop="userId" />
      <el-table-column label="用户类型" align="center" prop="userType" />
      <el-table-column label="投诉内容" align="center" prop="content" />
      <el-table-column label="处理状态" align="center" prop="status" />
      <el-table-column label="发起时间" align="center" prop="sendTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.sendTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="反馈内容" align="center" prop="reviewerContent" />
      <el-table-column label="处理人" align="center" prop="reviewerId" />
      <el-table-column label="反馈时间" align="center" prop="reviewerTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.reviewerTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改投诉与反馈对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联用户，可以是企业或学生" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入关联用户，可以是企业或学生" />
        </el-form-item>
        <el-form-item label="投诉或反馈内容">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="发起时间" prop="sendTime">
          <el-date-picker clearable
            v-model="form.sendTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发起时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="反馈内容">
          <editor v-model="form.reviewerContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="处理人ID，管理员" prop="reviewerId">
          <el-input v-model="form.reviewerId" placeholder="请输入处理人ID，管理员" />
        </el-form-item>
        <el-form-item label="反馈时间" prop="reviewerTime">
          <el-date-picker clearable
            v-model="form.reviewerTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择反馈时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listFeedbacks, getFeedbacks, delFeedbacks, addFeedbacks, updateFeedbacks } from "@/api/recruit/feedbacks";

export default {
  name: "Feedbacks",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 投诉与反馈表格数据
      feedbacksList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        userType: null,
        content: null,
        status: null,
        sendTime: null,
        reviewerContent: null,
        reviewerId: null,
        reviewerTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "关联用户，可以是企业或学生不能为空", trigger: "blur" }
        ],
        userType: [
          { required: true, message: "0、企业hr，1、学生不能为空", trigger: "change" }
        ],
        content: [
          { required: true, message: "投诉或反馈内容不能为空", trigger: "blur" }
        ],
        sendTime: [
          { required: true, message: "发起时间不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询投诉与反馈列表 */
    getList() {
      this.loading = true;
      listFeedbacks(this.queryParams).then(response => {
        this.feedbacksList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        userId: null,
        userType: null,
        content: null,
        status: null,
        sendTime: null,
        reviewerContent: null,
        reviewerId: null,
        reviewerTime: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加投诉与反馈";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getFeedbacks(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改投诉与反馈";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateFeedbacks(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addFeedbacks(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除投诉与反馈编号为"' + ids + '"的数据项？').then(function() {
        return delFeedbacks(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('recruit/feedbacks/export', {
        ...this.queryParams
      }, `feedbacks_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
