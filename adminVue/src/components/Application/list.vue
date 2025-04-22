<template>
  <el-card class="box-card" shadow="always">
    <div slot="header">
      <span>岗位列表</span>
    </div>
    <el-table
        :data="list.slice((currentPage-1)*pagesize,currentPage*pagesize)"
        stripe
        style="width: 100%">
      <el-table-column
          prop="applicationId"
          label=ID
          width="180">
      </el-table-column>
      <el-table-column
          label="编辑日期"
          width="180">
        <template slot-scope="scope">
          {{ scope.row.recentTime | formatDate }}
        </template>
      </el-table-column>
      <el-table-column
          prop="positionTitle"
          label="岗位名称">
      </el-table-column>
      <el-table-column
          prop="resumeId"
          label="简历编号">
      </el-table-column>
      <el-table-column
          prop="lxr"
          label="投递人">
      </el-table-column>
      <el-table-column
          prop="lxrdh"
          label="投递人电话">
      </el-table-column>
      <el-table-column
          prop="hrName"
          label="企业HR">
      </el-table-column>
      <el-table-column
          prop="interviewTime"
          label="面试时间">
          <template slot-scope="scope">
              {{ scope.row.interviewTime | formatDate }}
            </template>
      </el-table-column>
      <el-table-column  prop="interviewResult" label="面试结果">
      </el-table-column>
      <el-table-column  prop="interview" label="面试评价">
      </el-table-column>
      <el-table-column  prop="registerStatus" label="登记审核状态"></el-table-column>
      <el-table-column  prop="interviewResult" label="入职时间">
          <template slot-scope="scope">
              {{ scope.row.workTime | formatDay }}
            </template>
      </el-table-column>
      <el-table-column
          prop="jjlxr"
          label="紧急联系人"></el-table-column>
      <el-table-column
          prop="jjlxrdh"
          label="紧急联系人电话"></el-table-column>
          <el-table-column
          fixed="right"
          label="操作"
          width="210">
        <template slot-scope="scope">
          <el-button @click="handleDel(scope.row)"  type="danger" size="mini">删除</el-button>
          <el-button 
            v-if="scope.row.interviewResult && scope.row.interviewResult.includes('通过')"
            @click="handleEmployment(scope.row)" 
            type="success" 
            size="mini">
            {{ 
              !scope.row.registerStatus || scope.row.registerStatus === '未登记' ? '入职登记' : 
              scope.row.registerStatus === '登记待审核' ? '登记审核' : 
              '重新入职登记' 
            }}
          </el-button>
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

    <!-- 入职登记对话框 -->
    <el-dialog title="入职登记" :visible.sync="employmentDialogVisible" width="600px">
      <el-form :model="employmentForm" :rules="employmentRules" ref="employmentForm" label-width="120px">
        <el-form-item label="岗位名称" prop="positionTitle">
          <el-input v-model="employmentForm.positionTitle" disabled></el-input>
        </el-form-item>
        <el-form-item label="联系人" prop="lxr">
          <el-input v-model="employmentForm.lxr" disabled></el-input>
        </el-form-item>
        <el-form-item label="联系人电话" prop="lxrdh">
          <el-input v-model="employmentForm.lxrdh" disabled></el-input>
        </el-form-item>
        <el-form-item label="紧急联系人" prop="jjlxr">
          <el-input v-model="employmentForm.jjlxr"></el-input>
        </el-form-item>
        <el-form-item label="紧急联系人电话" prop="jjlxrdh">
          <el-input v-model="employmentForm.jjlxrdh"></el-input>
        </el-form-item>
        <el-form-item label="薪资" prop="salary">
          <el-input-number v-model="employmentForm.salary" :min="0" :step="1000"></el-input-number>
        </el-form-item>
        <el-form-item label="薪资类型" prop="salaryType">
          <el-select v-model="employmentForm.salaryType" placeholder="请选择薪资类型">
            <el-option label="时薪" value="时薪"></el-option>
            <el-option label="日薪" value="日薪"></el-option>
            <el-option label="月薪" value="月薪"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="入职时间" prop="workTime">
          <el-date-picker
            v-model="employmentForm.workTime"
            type="date"
            value-format="yyyy-MM-dd "
            placeholder="选择入职时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="employmentDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitEmployment">确 定</el-button>
      </div>
    </el-dialog>
  </el-card>
</template>

<script>
  import { listApplication, delApplication, postResume, listResume, getApplicMsg,updateOnboardingRuzhi,updateOnboardingShenhe } from '@/api/manager'

  export default {
        name: "Guest",
      data(){
        return{
          currentPage: 1,
          pagesize: 5,
          list: [],
          visible2: false,
          loading: null,
          listLoading: false,
          multipleSelection: null,
          userinfo:{},
          categorys: [],
          educations: [],
          employmentDialogVisible: false,
          employmentForm: {
            applicationId: '',
            name: '',
            phone: '',
            salary: 0,
            position: '',
            workTime: ''
          },
          employmentRules: {
            jjlxr: [
              { required: true, message: '请输入紧急联系人姓名', trigger: 'blur' }
            ],
            jjlxrdh: [
              { required: true, message: '请输入联系电话', trigger: 'blur' },
              { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
            ],
            salary: [
              { required: true, message: '请输入薪资', trigger: 'blur' }
            ],
            workTime: [
              { required: true, message: '请选择入职时间', trigger: 'change' }
            ]
          }
        }
      },
      created: function () {
        this.userinfo = JSON.parse(sessionStorage.getItem("user"))
        this.getListData()
      },
      methods:{
        getListData(){
          listApplication()
          .then(res=>{
            this.list = res.data
            console.log('Application list:', this.list)
          })

        },
        handleSizeChange(val) {
          this.pagesize = val;
        },
        handleCurrentChange(val) {
          this.currentPage = val;
        },
        navigateTo(val){
          this.$router.push("/"+val)
        },
        handleDel(row){
          this.$confirm('此操作将永久删除该岗位, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            delApplication(row.applicationId)
            .then(res => {
              this.getListData()
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
            })
            .catch(function(error) {
              console.log(error);
            });

          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消删除'
            });
          });

        },
        handleEdit(index,row){
          localStorage.setItem("goodsInfo",JSON.stringify(row))
          this.$router.push({
            path: '/edit',
            params: {
              id: row.positionId
            }
          })
        },
        toggleSelection(rows) {
          if (rows) {
            rows.forEach(row => {
              this.$refs.multipleTable.toggleRowSelection(row)
            })
          } else {
            this.$refs.multipleTable.clearSelection()
          }
        },
        handleSelectionChange(){
          this.multipleSelection = val
        },
        educationFilter(id) {
          this.educations.forEach(item=>{
            if(item.id===id) return item.name
          })
          return '不限'
        },
        handleEmployment(row) {
           if (row.registerStatus === '登记待审核') {
            // 登记待审核，执行审核逻辑
            this.handleAudit(row);
          } else {
            // 登记已审核，打开重新入职登记对话框
            console.log('row.workTime:', row.workTime);
            this.employmentForm = {
              applicationId: row.applicationId,
              lxr: row.lxr || '',
              lxrdh: row.lxrdh || '',
              jjlxr: row.jjlxr || '',
              jjlxrdh: row.jjlxrdh || '',
              salary: row.salary || '',
              salaryType: row.salaryType || '',
              positionTitle: row.positionTitle || '',
              workTime: row.workTime ?  new Date(row.workTime) : ''
            };
            this.employmentDialogVisible = true;
          }
        },
        handleAudit(row) {
          // 登记审核逻辑
            const employmentData = {
                applicationId: row.applicationId
              };
              
            updateOnboardingShenhe(employmentData)
              .then(res => {
                this.$message({
                  type: 'success',
                  message: '登记审核成功'
                });
                this.employmentDialogVisible = false;
                this.getListData();
              })
              .catch(error => {
                console.log(error);
                this.$message.error('提交失败');
              });
            
        },
        submitEmployment() {
          this.$refs.employmentForm.validate((valid) => {
            if (valid) {
             
              const employmentData = {
                applicationId: this.employmentForm.applicationId,
                workTime: this.employmentForm.workTime ? this.employmentForm.workTime : '',  // 使用 this.employmentForm.workTime
                salary: this.employmentForm.salary,
                salaryType: this.employmentForm.salaryType,
                jjlxr: this.employmentForm.jjlxr,
                jjlxrdh: this.employmentForm.jjlxrdh
              };
              
              updateOnboardingRuzhi(employmentData)
                .then(res => {
                  this.$message({
                    type: 'success',
                    message: '入职登记提交成功，等待管理员审核'
                  });
                  this.employmentDialogVisible = false;
                  this.getListData();
                })
                .catch(error => {
                  console.log(error);
                  this.$message.error('提交失败');
                });
            }
          });
        }
      }
    }
</script>

<style scoped>
/* 调整对话框标题样式 */
.el-dialog__title {
  font-size: 18px;
  font-weight: bold;
}

/* 调整表单项之间的间距 */
.el-form-item {
  margin-bottom: 20px;
}

/* 调整输入框的宽度 */
.el-input, .el-input-number, .el-select {
  width: 100%;
}

/* 调整日期选择器的宽度 */
.el-date-editor {
  width: 100%;
}

/* 调整对话框底部按钮的样式 */
.dialog-footer {
  text-align: right;
}

/* 调整按钮的间距 */
.dialog-footer .el-button {
  margin-left: 10px;
}
</style>
