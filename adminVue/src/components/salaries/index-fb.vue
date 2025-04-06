<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联学生" prop="studentId">
        <el-input
          v-model="queryParams.studentId"
          placeholder="请输入关联学生"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="关联岗位" prop="positionId">
        <el-input
          v-model="queryParams.positionId"
          placeholder="请输入关联岗位"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="关联企业" prop="enterId">
        <el-input
          v-model="queryParams.enterId"
          placeholder="请输入关联企业"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="上岗日期" prop="startDate">
        <el-date-picker clearable
          v-model="queryParams.startDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择上岗日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="离岗日期" prop="endDate">
        <el-date-picker clearable
          v-model="queryParams.endDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择离岗日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="工作时长" prop="workHours">
        <el-input
          v-model="queryParams.workHours"
          placeholder="请输入工作时长"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="薪资" prop="salary">
        <el-input
          v-model="queryParams.salary"
          placeholder="请输入薪资"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="薪资总额" prop="salarySum">
        <el-input
          v-model="queryParams.salarySum"
          placeholder="请输入薪资总额"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['recruit:salaries:add']"
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
          v-hasPermi="['recruit:salaries:edit']"
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
          v-hasPermi="['recruit:salaries:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['recruit:salaries:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="salariesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="关联学生" align="center" prop="studentId" />
      <el-table-column label="关联岗位" align="center" prop="positionId" />
      <el-table-column label="关联企业" align="center" prop="enterId" />
      <el-table-column label="在岗状态 0、离职；1、在岗" align="center" prop="workStatus" />
      <el-table-column label="上岗日期" align="center" prop="startDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="离岗日期" align="center" prop="endDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="工作时长" align="center" prop="workHours" />
      <el-table-column label="薪资类型，0按小时,1按天,2按月" align="center" prop="salaryType" />
      <el-table-column label="薪资" align="center" prop="salary" />
      <el-table-column label="薪资总额" align="center" prop="salarySum" />
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
            v-hasPermi="['recruit:salaries:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['recruit:salaries:remove']"
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

    <!-- 添加或修改工时薪资对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联学生" prop="studentId">
          <el-input v-model="form.studentId" placeholder="请输入关联学生" />
        </el-form-item>
        <el-form-item label="关联岗位" prop="positionId">
          <el-input v-model="form.positionId" placeholder="请输入关联岗位" />
        </el-form-item>
        <el-form-item label="关联企业" prop="enterId">
          <el-input v-model="form.enterId" placeholder="请输入关联企业" />
        </el-form-item>
        <el-form-item label="上岗日期" prop="startDate">
          <el-date-picker clearable
            v-model="form.startDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择上岗日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="离岗日期" prop="endDate">
          <el-date-picker clearable
            v-model="form.endDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择离岗日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="工作时长" prop="workHours">
          <el-input v-model="form.workHours" placeholder="请输入工作时长" />
        </el-form-item>
        <el-form-item label="薪资" prop="salary">
          <el-input v-model="form.salary" placeholder="请输入薪资" />
        </el-form-item>
        <el-form-item label="薪资总额" prop="salarySum">
          <el-input v-model="form.salarySum" placeholder="请输入薪资总额" />
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
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listSalaries, getSalaries, delSalaries, addSalaries, updateSalaries } from "@/api/recruit/salaries";

export default {
  name: "Salaries",
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
      // 工时薪资表格数据
      salariesList: [],
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
        enterId: null,
        workStatus: null,
        startDate: null,
        endDate: null,
        workHours: null,
        salaryType: null,
        salary: null,
        salarySum: null,
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
          { required: true, message: "关联学生不能为空", trigger: "blur" }
        ],
        positionId: [
          { required: true, message: "关联岗位不能为空", trigger: "blur" }
        ],
        enterId: [
          { required: true, message: "关联企业不能为空", trigger: "blur" }
        ],
        startDate: [
          { required: true, message: "上岗日期不能为空", trigger: "blur" }
        ],
        workHours: [
          { required: true, message: "工作时长不能为空", trigger: "blur" }
        ],
        salary: [
          { required: true, message: "薪资不能为空", trigger: "blur" }
        ],
        salarySum: [
          { required: true, message: "薪资总额不能为空", trigger: "blur" }
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
    /** 查询工时薪资列表 */
    getList() {
      this.loading = true;
      listSalaries(this.queryParams).then(response => {
        this.salariesList = response.rows;
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
        studentId: null,
        positionId: null,
        enterId: null,
        workStatus: null,
        startDate: null,
        endDate: null,
        workHours: null,
        salaryType: null,
        salary: null,
        salarySum: null,
        createdBy: null,
        modifiedBy: null,
        createdAt: null,
        modifiedAt: null
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
      this.title = "添加工时薪资";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getSalaries(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改工时薪资";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateSalaries(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addSalaries(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除工时薪资编号为"' + ids + '"的数据项？').then(function() {
        return delSalaries(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('recruit/salaries/export', {
        ...this.queryParams
      }, `salaries_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
