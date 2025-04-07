<template>
  <el-card class="box-card" shadow="always">
    <div slot="header">
      <span>编辑公告</span>
    </div>
    <el-form ref="form" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="公告标题" prop="noticeTitle">
        <el-input v-model="form.noticeTitle" placeholder="请输入公告标题" />
      </el-form-item>
      <el-form-item label="公告内容" prop="noticeContent">
        <el-input
          type="textarea"
          :rows="4"
          v-model="form.noticeContent"
          placeholder="请输入公告内容"
        />
      </el-form-item>
      <el-form-item label="公告类型" prop="noticeType">
        <el-select v-model="form.noticeType" placeholder="请选择公告类型">
          <el-option label="系统公告" value="系统公告" />
          <el-option label="活动公告" value="活动公告" />
          <el-option label="紧急通知" value="紧急通知" />
        </el-select>
      </el-form-item>
      <el-form-item label="发布状态" prop="status">
        <el-select v-model="form.status" placeholder="请选择发布状态">
          <el-option label="已发布" value="已发布" />
          <el-option label="未发布" value="未发布" />
        </el-select>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input
          type="textarea"
          :rows="2"
          v-model="form.remark"
          placeholder="请输入备注"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm">保存</el-button>
        <el-button @click="resetForm">重置</el-button>
        <el-button @click="cancel">取消</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { getNotice, updateNotice } from "@/api/recruit/notice";

export default {
  name: "EditNotice",
  data() {
    return {
      form: {
        noticeId: null,
        noticeTitle: null,
        noticeContent: null,
        noticeType: null,
        status: null,
        remark: null,
      },
      rules: {
        noticeTitle: [
          { required: true, message: "公告标题不能为空", trigger: "blur" },
        ],
        noticeContent: [
          { required: true, message: "公告内容不能为空", trigger: "blur" },
        ],
        noticeType: [
          { required: true, message: "公告类型不能为空", trigger: "change" },
        ],
        status: [
          { required: true, message: "发布状态不能为空", trigger: "change" },
        ],
      },
    };
  },
  created() {
    const noticeId = this.$route.params.noticeId;
    if (noticeId) {
      this.getNoticeInfo(noticeId);
    }
  },
  methods: {
    // 获取公告信息
    getNoticeInfo(noticeId) {
      getNotice(noticeId)
        .then((response) => {
          this.form = response.data;
        })
        .catch((error) => {
          console.error("获取公告信息失败:", error);
        });
    },
    // 提交表单
    submitForm() {
      this.$refs.form.validate((valid) => {
        if (valid) {
