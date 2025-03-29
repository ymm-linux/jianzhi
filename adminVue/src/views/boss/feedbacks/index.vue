<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联用户，可以是企业或学生" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入关联用户，可以是企业或学生"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处理状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择处理状态" clearable>
          <el-option
            v-for="dict in dict.type.feedback_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="处理人ID，管理员" prop="reviewerId">
        <el-input
          v-model="queryParams.reviewerId"
          placeholder="请输入处理人ID，管理员"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="审核时间" prop="reviewerTime">
        <el-date-picker clearable
          v-model="queryParams.reviewerTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择审核时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="创建人" prop="createdBy">
        <el-input
          v-model="queryParams.createdBy"
          placeholder="请输入创建人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="修改人" prop="modifiedBy">
        <el-input
          v-model="queryParams.modifiedBy"
          placeholder="请输入修改人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间" prop="createdAt">
        <el-date-picker clearable
          v-model="queryParams.createdAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="修改时间" prop="modifiedAt">
        <el-date-picker clearable
          v-model="queryParams.modifiedAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择修改时间">
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
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['boss:feedbacks:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['boss:feedbacks:edit']"
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
          v-hasPermi="['boss:feedbacks:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['boss:feedbacks:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="feedbacksList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="关联用户，可以是企业或学生" align="center" prop="userId" />
      <el-table-column label="投诉或反馈内容" align="center" prop="content" />
      <el-table-column label="处理状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.feedback_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="处理人ID" align="center" prop="reviewerContent" />
      <el-table-column label="处理人ID，管理员" align="center" prop="reviewerId" />
      <el-table-column label="审核时间" align="center" prop="reviewerTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.reviewerTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建人" align="center" prop="createdBy" />
      <el-table-column label="修改人" align="center" prop="modifiedBy" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="修改时间" align="center" prop="modifiedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.modifiedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['boss:feedbacks:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['boss:feedbacks:remove']"
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
        <el-form-item label="处理状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择处理状态">
            <el-option
              v-for="dict in dict.type.feedback_status"
              :key="dict.value"
              :label="dict.label"
:value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="处理人ID">
          <editor v-model="form.reviewerContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="处理人ID，管理员" prop="reviewerId">
          <el-input v-model="form.reviewerId" placeholder="请输入处理人ID，管理员" />
        </el-form-item>
        <el-form-item label="审核时间" prop="reviewerTime">
          <el-date-picker clearable
            v-model="form.reviewerTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择审核时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="创建人" prop="createdBy">
          <el-input v-model="form.createdBy" placeholder="请输入创建人" />
        </el-form-item>
        <el-form-item label="修改人" prop="modifiedBy">
          <el-input v-model="form.modifiedBy" placeholder="请输入修改人" />
        </el-form-item>
        <el-form-item label="创建时间" prop="createdAt">
          <el-date-picker clearable
            v-model="form.createdAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择创建时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="修改时间" prop="modifiedAt">
          <el-date-picker clearable
            v-model="form.modifiedAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择修改时间">
          </el-date-picker>
        </el-form-item>
        <el-divider content-position="center">用户信息信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddSysUser">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteSysUser">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="sysUserList" :row-class-name="rowSysUserIndex" @selection-change="handleSysUserSelectionChange" ref="sysUser">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="部门ID" prop="deptId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.deptId" placeholder="请输入部门ID" />
            </template>
          </el-table-column>
          <el-table-column label="用户账号" prop="userName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.userName" placeholder="请输入用户账号" />
            </template>
          </el-table-column>
          <el-table-column label="用户昵称" prop="nickName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.nickName" placeholder="请输入用户昵称" />
            </template>
          </el-table-column>
          <el-table-column label="真实姓名" prop="realName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.realName" placeholder="请输入真实姓名" />
            </template>
          </el-table-column>
          <el-table-column label="用户类型" prop="userType" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.userType" placeholder="请选择用户类型">
                <el-option label="请选择字典生成" value="" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="用户邮箱" prop="email" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.email" placeholder="请输入用户邮箱" />
            </template>
          </el-table-column>
          <el-table-column label="$comment" prop="phoneNumber" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.phoneNumber" placeholder="请输入$comment" />
            </template>
          </el-table-column>
          <el-table-column label="$comment" prop="sex" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.sex" placeholder="请选择$comment">
                <el-option label="请选择字典生成" value="" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="出生日期" prop="birthday" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.birthday" type="date" value-format="yyyy-MM-dd" placeholder="请选择出生日期" />
            </template>
          </el-table-column>
          <el-table-column label="头像地址" prop="avatar" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.avatar" placeholder="请输入头像地址" />
            </template>
          </el-table-column>
          <el-table-column label="密码" prop="password" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.password" placeholder="请输入密码" />
            </template>
          </el-table-column>
          <el-table-column label="$comment" prop="status" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.status" placeholder="请选择$comment">
                <el-option label="请选择字典生成" value="" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="最后登录IP" prop="loginIp" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.loginIp" placeholder="请输入最后登录IP" />
            </template>
          </el-table-column>
          <el-table-column label="最后登录时间" prop="loginDate" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.loginDate" type="date" value-format="yyyy-MM-dd" placeholder="请选择最后登录时间" />
            </template>
          </el-table-column>
          <el-table-column label="最后修改密码时间" prop="passwordModifyTime" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.passwordModifyTime" type="date" value-format="yyyy-MM-dd" placeholder="请选择最后修改密码时间" />
            </template>
          </el-table-column>
          <el-table-column label="拒绝登录时间" prop="lockEndTime" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.lockEndTime" type="date" value-format="yyyy-MM-dd" placeholder="请选择拒绝登录时间" />
            </template>
          </el-table-column>
          <el-table-column label="$comment" prop="forceModifyPassword" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.forceModifyPassword" placeholder="请输入$comment" />
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listFeedbacks, getFeedbacks, delFeedbacks, addFeedbacks, updateFeedbacks } from "@/api/boss/feedbacks";

export default {
  name: "Feedbacks",
  dicts: ['feedback_status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedSysUser: [],
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
      // 用户信息表格数据
      sysUserList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        content: null,
        status: null,
        reviewerContent: null,
        reviewerId: null,
        reviewerTime: null,
        createdBy: null,
        modifiedBy: null,
        createdAt: null,
        modifiedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "关联用户，可以是企业或学生不能为空", trigger: "blur" }
        ],
        content: [
          { required: true, message: "投诉或反馈内容不能为空", trigger: "blur" }
        ],
        reviewerTime: [
          { required: true, message: "审核时间不能为空", trigger: "blur" }
        ],
        createdAt: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
        modifiedAt: [
          { required: true, message: "修改时间不能为空", trigger: "blur" }
        ]
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
        this.feedbacksList = response.data.rows;
        this.total = response.data.total;
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
        content: null,
        status: null,
        reviewerContent: null,
        reviewerId: null,
        reviewerTime: null,
        createdBy: null,
        modifiedBy: null,
        createdAt: null,
        modifiedAt: null
      };
      this.sysUserList = [];
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
        this.sysUserList = response.data.sysUserList;
        this.open = true;
        this.title = "修改投诉与反馈";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.sysUserList = this.sysUserList;
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
	/** 用户信息序号 */
    rowSysUserIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 用户信息添加按钮操作 */
    handleAddSysUser() {
      let obj = {};
      obj.deptId = "";
      obj.userName = "";
      obj.nickName = "";
      obj.realName = "";
      obj.userType = "";
      obj.email = "";
      obj.phoneNumber = "";
      obj.sex = "";
      obj.birthday = "";
      obj.avatar = "";
      obj.password = "";
      obj.status = "";
      obj.loginIp = "";
      obj.loginDate = "";
      obj.passwordModifyTime = "";
      obj.lockEndTime = "";
      obj.forceModifyPassword = "";
      obj.preferences = "";
      obj.remark = "";
      this.sysUserList.push(obj);
    },
    /** 用户信息删除按钮操作 */
    handleDeleteSysUser() {
      if (this.checkedSysUser.length == 0) {
        this.$modal.msgError("请先选择要删除的用户信息数据");
      } else {
        const sysUserList = this.sysUserList;
        const checkedSysUser = this.checkedSysUser;
        this.sysUserList = sysUserList.filter(function(item) {
          return checkedSysUser.indexOf(item.index) == -1
        });
      }
    },
    /** 复选框选中数据 */
    handleSysUserSelectionChange(selection) {
      this.checkedSysUser = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('boss/feedbacks/export', {
        ...this.queryParams
      }, `feedbacks_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
