<template>
    <div class="onboarding-container">
      <!-- 返回按钮 -->
      <el-button 
        type="text" 
        icon="el-icon-arrow-left" 
        @click="handleBack"
        style="margin-bottom: 20px;"
      >
        返回
      </el-button>
  
      <el-card class="form-card">
        <div slot="header" class="clearfix">
          <span>入职安排</span>
        </div>
        
        <el-form 
          ref="onboardingForm" 
          :model="form" 
          label-width="120px"
          :rules="rules"
        >
          <el-form-item label="入职时间" prop="workTime">
            <el-date-picker
              v-model="form.workTime"
              type="date"
              placeholder="选择入职日期"
              value-format="yyyy-MM-dd"
              style="width: 100%"
            ></el-date-picker>
          </el-form-item>
          
          <el-form-item label="薪资类型" prop="salaryType">
            <el-select 
              v-model="form.salaryType" 
              placeholder="请选择薪资类型"
              style="width: 100%"
            >
              <el-option
                v-for="item in salaryTypeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-form-item>
          
          <el-form-item label="薪资" prop="salary">
            <el-input-number
              v-model="form.salary"
              :min="0"
              :step="1000"
              controls-position="right"
              style="width: 100%"
            ></el-input-number>
            <span style="margin-left: 10px;">元</span>
          </el-form-item>
          
          <el-form-item>
            <el-button 
              type="primary" 
              @click="submitForm"
              :loading="submitting"
            >
              提交
            </el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </template>
  
  <script>
  import { submitOnboarding } from '@/api/hr'
  
  export default {
    name: 'OnboardingArrangement',
    data() {
      return {
        form: {
          applicationId: '',
          workTime: '',
          salaryType: '',
          salary: 0
        },
        salaryTypeOptions: [
          { value: 1, label: '月薪' },
          { value: 2, label: '年薪' },
          { value: 3, label: '时薪' },
          { value: 4, label: '项目制' }
        ],
        rules: {
          workTime: [
            { required: true, message: '请选择入职时间', trigger: 'blur' }
          ],
          salaryType: [
            { required: true, message: '请选择薪资类型', trigger: 'change' }
          ],
          salary: [
            { required: true, message: '请输入薪资', trigger: 'blur' },
            { type: 'number', min: 0, message: '薪资不能为负数', trigger: 'blur' }
          ]
        },
        submitting: false
      }
    },
    created() {
      this.form.applicationId = this.$route.query.applicationId
    },
    methods: {
      handleBack() {
        this.$router.go(-1)
      },
      submitForm() {
        this.$refs.onboardingForm.validate(valid => {
          if (valid) {
            this.submitting = true
            submitOnboarding(this.form)
              .then(() => {
                this.$message.success('入职安排提交成功')
                this.$router.push('/postResume')
              })
              .catch(error => {
                this.$message.error(error.message || '提交失败')
              })
              .finally(() => {
                this.submitting = false
              })
          }
        })
      }
    }
  }
  </script>
  
  <style scoped>
  .onboarding-container {
    padding: 20px;
    max-width: 800px;
    margin: 0 auto;
  }
  
  .form-card {
    margin-top: 20px;
  }
  </style>