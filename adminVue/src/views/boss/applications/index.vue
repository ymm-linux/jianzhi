<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生id，关联用户表" prop="studentId">
        <el-input
          v-model="queryParams.studentId"
          placeholder="请输入学生id，关联用户表"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="关联岗位表" prop="positionId">
        <el-input
          v-model="queryParams.positionId"
          placeholder="请输入关联岗位表"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="投递时间" prop="submissionTime">
        <el-date-picker clearable
          v-model="queryParams.submissionTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择投递时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="审核人" prop="enterId">
        <el-input
          v-model="queryParams.enterId"
          placeholder="请输入审核人"
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
          v-hasPermi="['boss:applications:add']"
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
          v-hasPermi="['boss:applications:edit']"
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
          v-hasPermi="['boss:applications:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['boss:applications:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="applicationsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="applyId" />
      <el-table-column label="学生id，关联用户表" align="center" prop="studentId" />
      <el-table-column label="关联岗位表" align="center" prop="positionId" />
      <el-table-column label="简历摘要" align="center" prop="resumeContent" />
      <el-table-column label="简历附件地址" align="center" prop="resumePath" />
      <el-table-column label="投递时间" align="center" prop="submissionTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.submissionTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请状态" align="center" prop="applicationStatus" />
      <el-table-column label="审核人" align="center" prop="enterId" />
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
            v-hasPermi="['boss:applications:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['boss:applications:remove']"
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

    <!-- 添加或修改岗位申请对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学生id，关联用户表" prop="studentId">
          <el-input v-model="form.studentId" placeholder="请输入学生id，关联用户表" />
        </el-form-item>
        <el-form-item label="关联岗位表" prop="positionId">
          <el-input v-model="form.positionId" placeholder="请输入关联岗位表" />
        </el-form-item>
        <el-form-item label="简历摘要">
          <editor v-model="form.resumeContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="简历附件地址" prop="resumePath">
          <el-input v-model="form.resumePath" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="投递时间" prop="submissionTime">
          <el-date-picker clearable
            v-model="form.submissionTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择投递时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="审核人" prop="enterId">
          <el-input v-model="form.enterId" placeholder="请输入审核人" />
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
        <el-divider content-position="center">企业岗位招聘信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddPositionRecruitment">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeletePositionRecruitment">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="positionRecruitmentList" :row-class-name="rowPositionRecruitmentIndex" @selection-change="handlePositionRecruitmentSelectionChange" ref="positionRecruitment">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="岗位分类" prop="positionCategory" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.positionCategory" placeholder="请输入岗位分类" />
            </template>
          </el-table-column>
          <el-table-column label="虚拟外键：所属企业" prop="enterId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.enterId" placeholder="请输入虚拟外键：所属企业" />
            </template>
          </el-table-column>
          <el-table-column label="岗位名称" prop="positionName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.positionName" placeholder="请输入岗位名称" />
            </template>
          </el-table-column>
          <el-table-column label="薪资类型，按小时,按天,按月" prop="salaryType" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.salaryType" placeholder="请选择薪资类型，按小时,按天,按月">
                <el-option
                  v-for="dict in dict.type.salary_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="薪资类型，按小时,按天,按月" prop="salaryTypeName" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.salaryTypeName" placeholder="请输入薪资类型，按小时,按天,按月" />
            </template>
          </el-table-column>
          <el-table-column label="薪资信息" prop="salaryInfo" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.salaryInfo" placeholder="请输入薪资信息" />
            </template>
          </el-table-column>
          <el-table-column label="学历要求" prop="academicRequirements" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.academicRequirements" placeholder="请输入学历要求" />
            </template>
          </el-table-column>
          <el-table-column label="工作经验要求" prop="workExperienceRequirements" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.workExperienceRequirements" placeholder="请输入工作经验要求" />
            </template>
          </el-table-column>
          <el-table-column label="招聘状态" prop="recruitmentStatus" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.recruitmentStatus" placeholder="请选择招聘状态">
                <el-option
                  v-for="dict in dict.type.recruitment_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="创建人" prop="createdBy" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.createdBy" placeholder="请输入创建人" />
            </template>
          </el-table-column>
          <el-table-column label="修改人" prop="modifiedBy" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.modifiedBy" placeholder="请输入修改人" />
            </template>
          </el-table-column>
          <el-table-column label="创建时间" prop="createdAt" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.createdAt" type="date" value-format="yyyy-MM-dd" placeholder="请选择创建时间" />
            </template>
          </el-table-column>
          <el-table-column label="修改时间" prop="modifiedAt" width="240">
            <template slot-scope="scope">
              <el-date-picker clearable v-model="scope.row.modifiedAt" type="date" value-format="yyyy-MM-dd" placeholder="请选择修改时间" />
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
import { listApplications, getApplications, delApplications, addApplications, updateApplications } from "@/api/boss/applications";

export default {
  name: "Applications",
  dicts: ['recruitment_status', 'salary_type'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedPositionRecruitment: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 岗位申请表格数据
      applicationsList: [],
      // 企业岗位招聘表格数据
      positionRecruitmentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentId: null,
        positionId: null,
        resumeContent: null,
        resumePath: null,
        submissionTime: null,
        applicationStatus: null,
        enterId: null,
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
        studentId: [
          { required: true, message: "学生id，关联用户表不能为空", trigger: "blur" }
        ],
        positionId: [
          { required: true, message: "关联岗位表不能为空", trigger: "blur" }
        ],
        submissionTime: [
          { required: true, message: "投递时间不能为空", trigger: "blur" }
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
    /** 查询岗位申请列表 */
    getList() {
      this.loading = true;
      listApplications(this.queryParams).then(response => {
        this.applicationsList = response.data.rows;
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
        applyId: null,
        studentId: null,
        positionId: null,
        resumeContent: null,
        resumePath: null,
        submissionTime: null,
        applicationStatus: "0",
        enterId: null,
        reviewerTime: null,
        createdBy: null,
        modifiedBy: null,
        createdAt: null,
        modifiedAt: null
      };
      this.positionRecruitmentList = [];
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
      this.ids = selection.map(item => item.applyId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加岗位申请";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const applyId = row.applyId || this.ids
      getApplications(applyId).then(response => {
        this.form = response.data;
        this.positionRecruitmentList = response.data.positionRecruitmentList;
        this.open = true;
        this.title = "修改岗位申请";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.positionRecruitmentList = this.positionRecruitmentList;
          if (this.form.applyId != null) {
            updateApplications(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addApplications(this.form).then(response => {
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
      const applyIds = row.applyId || this.ids;
      this.$modal.confirm('是否确认删除岗位申请编号为"' + applyIds + '"的数据项？').then(function() {
        return delApplications(applyIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
	/** 企业岗位招聘序号 */
    rowPositionRecruitmentIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 企业岗位招聘添加按钮操作 */
    handleAddPositionRecruitment() {
      let obj = {};
      obj.positionCategory = "";
      obj.enterId = "";
      obj.positionName = "";
      obj.positionImage = "";
      obj.positionDescription = "";
      obj.workRequirements = "";
      obj.salaryType = "";
      obj.salaryTypeName = "";
      obj.salaryInfo = "";
      obj.academicRequirements = "";
      obj.workExperienceRequirements = "";
      obj.recruitmentStatus = "";
      obj.createdBy = "";
      obj.modifiedBy = "";
      obj.createdAt = "";
      obj.modifiedAt = "";
      this.positionRecruitmentList.push(obj);
    },
    /** 企业岗位招聘删除按钮操作 */
    handleDeletePositionRecruitment() {
      if (this.checkedPositionRecruitment.length == 0) {
        this.$modal.msgError("请先选择要删除的企业岗位招聘数据");
      } else {
        const positionRecruitmentList = this.positionRecruitmentList;
        const checkedPositionRecruitment = this.checkedPositionRecruitment;
        this.positionRecruitmentList = positionRecruitmentList.filter(function(item) {
          return checkedPositionRecruitment.indexOf(item.index) == -1
        });
      }
    },
    /** 复选框选中数据 */
    handlePositionRecruitmentSelectionChange(selection) {
      this.checkedPositionRecruitment = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('boss/applications/export', {
        ...this.queryParams
      }, `applications_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
