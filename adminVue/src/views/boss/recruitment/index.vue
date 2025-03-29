<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="岗位分类" prop="positionCategory">
        <el-input
          v-model="queryParams.positionCategory"
          placeholder="请输入岗位分类"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="虚拟外键：所属企业" prop="enterId">
        <el-input
          v-model="queryParams.enterId"
          placeholder="请输入虚拟外键：所属企业"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="岗位名称" prop="positionName">
        <el-input
          v-model="queryParams.positionName"
          placeholder="请输入岗位名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="薪资类型，按小时,按天,按月" prop="salaryType">
        <el-select v-model="queryParams.salaryType" placeholder="请选择薪资类型，按小时,按天,按月" clearable>
          <el-option
            v-for="dict in dict.type.salary_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="薪资类型，按小时,按天,按月" prop="salaryTypeName">
        <el-input
          v-model="queryParams.salaryTypeName"
          placeholder="请输入薪资类型，按小时,按天,按月"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="薪资信息" prop="salaryInfo">
        <el-input
          v-model="queryParams.salaryInfo"
          placeholder="请输入薪资信息"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学历要求" prop="academicRequirements">
        <el-input
          v-model="queryParams.academicRequirements"
          placeholder="请输入学历要求"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="工作经验要求" prop="workExperienceRequirements">
        <el-input
          v-model="queryParams.workExperienceRequirements"
          placeholder="请输入工作经验要求"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="招聘状态" prop="recruitmentStatus">
        <el-select v-model="queryParams.recruitmentStatus" placeholder="请选择招聘状态" clearable>
          <el-option
            v-for="dict in dict.type.recruitment_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
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
          v-hasPermi="['boss:recruitment:add']"
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
          v-hasPermi="['boss:recruitment:edit']"
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
          v-hasPermi="['boss:recruitment:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['boss:recruitment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recruitmentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="positionId" />
      <el-table-column label="岗位分类" align="center" prop="positionCategory">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.position_category" :value="scope.row.positionCategory"/>
        </template>
      </el-table-column>
      <el-table-column label="虚拟外键：所属企业" align="center" prop="enterId" />
      <el-table-column label="岗位名称" align="center" prop="positionName" />
      <el-table-column label="岗位图片" align="center" prop="positionImage" width="100">
        <template slot-scope="scope">
          <image-preview :src="scope.row.positionImage" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="岗位描述" align="center" prop="positionDescription" />
      <el-table-column label="工作要求" align="center" prop="workRequirements" />
      <el-table-column label="薪资类型，按小时,按天,按月" align="center" prop="salaryType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.salary_type" :value="scope.row.salaryType"/>
        </template>
      </el-table-column>
      <el-table-column label="薪资类型，按小时,按天,按月" align="center" prop="salaryTypeName" />
      <el-table-column label="薪资信息" align="center" prop="salaryInfo" />
      <el-table-column label="学历要求" align="center" prop="academicRequirements" />
      <el-table-column label="工作经验要求" align="center" prop="workExperienceRequirements" />
      <el-table-column label="招聘状态" align="center" prop="recruitmentStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.recruitment_status" :value="scope.row.recruitmentStatus"/>
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
            v-hasPermi="['boss:recruitment:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['boss:recruitment:remove']"
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

    <!-- 添加或修改企业岗位招聘对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="岗位分类" prop="positionCategory">
          <el-input v-model="form.positionCategory" placeholder="请输入岗位分类" />
        </el-form-item>
        <el-form-item label="虚拟外键：所属企业" prop="enterId">
          <el-input v-model="form.enterId" placeholder="请输入虚拟外键：所属企业" />
        </el-form-item>
        <el-form-item label="岗位名称" prop="positionName">
          <el-input v-model="form.positionName" placeholder="请输入岗位名称" />
        </el-form-item>
        <el-form-item label="岗位图片">
          <image-upload v-model="form.positionImage"/>
        </el-form-item>
        <el-form-item label="岗位描述" prop="positionDescription">
          <el-input v-model="form.positionDescription" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="工作要求" prop="workRequirements">
          <el-input v-model="form.workRequirements" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="薪资类型，按小时,按天,按月" prop="salaryType">
          <el-select v-model="form.salaryType" placeholder="请选择薪资类型，按小时,按天,按月">
            <el-option
              v-for="dict in dict.type.salary_type"
              :key="dict.value"
              :label="dict.label"
:value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="薪资类型，按小时,按天,按月" prop="salaryTypeName">
          <el-input v-model="form.salaryTypeName" placeholder="请输入薪资类型，按小时,按天,按月" />
        </el-form-item>
        <el-form-item label="薪资信息" prop="salaryInfo">
          <el-input v-model="form.salaryInfo" placeholder="请输入薪资信息" />
        </el-form-item>
        <el-form-item label="学历要求" prop="academicRequirements">
          <el-input v-model="form.academicRequirements" placeholder="请输入学历要求" />
        </el-form-item>
        <el-form-item label="工作经验要求" prop="workExperienceRequirements">
          <el-input v-model="form.workExperienceRequirements" placeholder="请输入工作经验要求" />
        </el-form-item>
        <el-form-item label="招聘状态">
          <el-radio-group v-model="form.recruitmentStatus">
            <el-radio
              v-for="dict in dict.type.recruitment_status"
              :key="dict.value"
:label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
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
import { listRecruitment, getRecruitment, delRecruitment, addRecruitment, updateRecruitment } from "@/api/boss/recruitment";

export default {
  name: "Recruitment",
  dicts: ['recruitment_status', 'salary_type'],
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
      // 企业岗位招聘表格数据
      recruitmentList: [],
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
        positionCategory: null,
        enterId: null,
        positionName: null,
        positionImage: null,
        positionDescription: null,
        workRequirements: null,
        salaryType: null,
        salaryTypeName: null,
        salaryInfo: null,
        academicRequirements: null,
        workExperienceRequirements: null,
        recruitmentStatus: null,
        createdBy: null,
        modifiedBy: null,
        createdAt: null,
        modifiedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        positionCategory: [
          { required: true, message: "岗位分类不能为空", trigger: "blur" }
        ],
        enterId: [
          { required: true, message: "虚拟外键：所属企业不能为空", trigger: "blur" }
        ],
        positionName: [
          { required: true, message: "岗位名称不能为空", trigger: "blur" }
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
    /** 查询企业岗位招聘列表 */
    getList() {
      this.loading = true;
      listRecruitment(this.queryParams).then(response => {
        this.recruitmentList = response.data.rows;
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
        positionId: null,
        positionCategory: null,
        enterId: null,
        positionName: null,
        positionImage: null,
        positionDescription: null,
        workRequirements: null,
        salaryType: null,
        salaryTypeName: null,
        salaryInfo: null,
        academicRequirements: null,
        workExperienceRequirements: null,
        recruitmentStatus: "0",
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
      this.ids = selection.map(item => item.positionId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加企业岗位招聘";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const positionId = row.positionId || this.ids
      getRecruitment(positionId).then(response => {
        this.form = response.data;
        this.sysUserList = response.data.sysUserList;
        this.open = true;
        this.title = "修改企业岗位招聘";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.sysUserList = this.sysUserList;
          if (this.form.positionId != null) {
            updateRecruitment(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addRecruitment(this.form).then(response => {
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
      const positionIds = row.positionId || this.ids;
      this.$modal.confirm('是否确认删除企业岗位招聘编号为"' + positionIds + '"的数据项？').then(function() {
        return delRecruitment(positionIds);
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
      this.download('boss/recruitment/export', {
        ...this.queryParams
      }, `recruitment_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
