<template>
  <div id="jobManagement">
    <el-dialog fullscreen title="岗位编辑" :visible.sync="dialogFormVisible">
      <div style="display: flex;justify-content: space-between">
        <el-form ref="ruleForm" :label-position="labelPosition" style="width: 40%" :model="position">
          <el-form-item prop="title" :rules="[{ required: true, message: '请输入岗位名称', trigger: 'blur'}]" label="岗位名称"
            :label-width="formLabelWidth">
            <el-input size="mini" v-model="position.title" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item prop="categoryId" label="岗位类别" :rules="[{ required: true, message: '请输入岗位类别', trigger: 'change'}]"
            :label-width="formLabelWidth">
            <!-- <el-input size="mini" v-model="position.categoryId" autocomplete="off"></el-input> -->
            <el-cascader v-model="value" :options="options">
            </el-cascader>
          </el-form-item>
          <el-form-item prop="requirement" label="岗位要求" :rules="[{ required: true, message: '请输入岗位要求', trigger: 'blur' }]"
            :label-width="formLabelWidth">
            <el-input size="mini" v-model="position.requirement" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item prop="education" label="学历要求" :rules="[{ required: true, message: '请输入学历要求',trigger: 'blur'}]"
            :label-width="formLabelWidth">
            <el-select v-model="position.educationId">
              <el-option v-for="option in educations" :key="option.id" :label="option.name"
                :value="option.id"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="quantity" label="需要人数" :rules="[{ required: true, message: '请输入需要人数', trigger: 'blur' }]"
            :label-width="formLabelWidth">
            <el-input-number size="mini" v-model="position.quantity" autocomplete="off" />
          </el-form-item>
          <el-form-item label="地址" :label-width="formLabelWidth">
            <el-select class="address" size="mini"  placeholder="省" value = '四川省'>
            
            </el-select>
            <el-select class="address" size="mini"  placeholder="市" value = '攀枝花市'>
              
            </el-select>
          </el-form-item>
          <el-form-item label="薪酬" :label-width="formLabelWidth">
            <el-input-number size="mini" v-model="position.salaryDown" autocomplete="off" /> - <el-input-number
              size="mini" v-model="position.salaryUp" autocomplete="off" />
          </el-form-item>
          <el-form-item label="招聘截止时间" :label-width="formLabelWidth" :rules="[{ required: true, message: '请选择招聘截止时间', trigger: 'change'}]">
            <el-date-picker v-model="position.recruitDeadline" type="date" value-format="yyyyMMdd">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="兼职时间" :label-width="formLabelWidth" :rules="[{ required: true, message: '请选择招聘截止时间', trigger: 'change' }]"> 
            <el-date-picker v-model="position.partTime" type="datetimerange" :picker-options="pickerOptions" range-separator="至"
              start-placeholder="开始日期" end-placeholder="结束日期" align="right">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="岗位性质" :label-width="formLabelWidth" :rules="[{ required: true, message: '请选择岗位性质', trigger: 'change'  }]"> 
            <el-select v-model="position.nature">
              <el-option v-for="option in natureList" :key="option.key" :label="option.label"
                :value="option.key"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save()">确 定</el-button>
      </div>
    </el-dialog>
    <el-button @click="addJobHandle()" size="mini">新增岗位</el-button>
    <el-table :data="jobList" stripe style="width: 100%">
      <el-table-column prop="positionId" label=ID width="180">
      </el-table-column>
      <el-table-column label="编辑日期" width="180">
        <template slot-scope="scope">
          {{ scope.row.releaseDate | formatDate }}
        </template>
      </el-table-column>
      <el-table-column label="岗位名称" width="180">
        <template slot-scope="scope">
          {{ scope.row.title || '未填写' }}
        </template>
      </el-table-column>
      <el-table-column prop="requirement" label="岗位要求">
      </el-table-column>
      <el-table-column label="学历要求" width="180">
        <template slot-scope="scope">
          {{ educationMap[scope.row.educationId] }}
        </template>
      </el-table-column>
      <el-table-column prop="quantity" label="招聘人数">
      </el-table-column>
      <el-table-column prop="workCity" label="工作城市">
      </el-table-column>
      <el-table-column label="薪资">
        <template slot-scope="scope">
          {{ scope.row.salaryDown && scope.row.salaryUp ? scope.row.salaryDown + '-' + scope.row.salaryUp : '未填写' }}
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          {{ getStatusText(scope.row.statePub) }}
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="210">
        <template slot-scope="scope">
          <el-button @click="handleClick(scope.row)" type="primary" size="mini">编辑</el-button>
          <el-button @click="publishSwitch(scope.row)" type="success"
            size="mini">{{ getPublishButtonText(scope.row.statePub) }}</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { publishPosition, showPosition, modifyPosition, delPosition, listCategory, listEducation } from '@/api/hr'
import { getProvinces } from "@/api/map";
import { updatePositionState } from "@/api/position";
import { MessageBox } from 'element-ui'

export default {
  name: "jobManagement",
  data() {
    return {
      provinces: [],
      cities: [],
      areas: [],
      selectPro: '',
      selectCity: '',
      selectArea: '',
      labelPosition: 'left',
      position: {
        positionId: 0,
        title: '',
        requirement: '',
        quantity: 0,
        workCity: '',
        workProvince: '',
        salaryUp: 0,
        salaryDown: 0,
        categoryId: 0,
        partTime: []
      },
      jobList: [],
      dialogFormVisible: false,
      formLabelWidth: '120px',
      options: [],
      value: [],
      categorys: [],
      educations: [],
      educationMap: {},
      pickerOptions: {
        shortcuts: [{
          text: '最近一周',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
            picker.$emit('pick', [start, end]);
          }
        }, {
          text: '最近一个月',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            picker.$emit('pick', [start, end]);
          }
        }, {
          text: '最近三个月',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
            picker.$emit('pick', [start, end]);
          }
        }]
      },
      natureList: [
        {key: '1', label: '兼职'}
      ]
    }
  },
  created() {
    // this.getList()
    this.getProvince()
    this.listCategory()
    this.listEducation()
  },
  watch: {
    selectPro: function () {
      this.getCity()
    },
  },
  methods: {
    listCategory() {
      const map = {}
      listCategory().then(res => {
        this.categorys = res.data
        res.data.forEach(item => {
          if (map[item.firstCategoryName]) {
            map[item.firstCategoryName].push(item)
          } else {
            map[item.firstCategoryName] = []
            map[item.firstCategoryName].push(item)
          }
        })
        this.options = []
        Object.keys(map).forEach(key => {
          const option = {
            value: key,
            label: key,
            children: []
          }
          map[key].forEach(sec => {
            const secOption = {
              value: sec.categoryId,
              label: sec.secondCategoryName
            }
            option.children.push(secOption)
          })
          this.options.push(option)
        })
      })
    },
    listEducation() {
      listEducation()
        .then(res => {
          this.educations = res.data
          res.data.forEach(item => {
            this.educationMap[item.id] = item.name
          })
          this.getList()
        })
    },
    save() {
      if (this.selectPro === '') {
        this.$message.error('请选择省份')
        return
      }
      if (this.selectCity === '') {
        this.$message.error('请选择城市')
        return
      }
      if (this.position.title === '') {
        this.$message.error('请填写岗位名称')
        return
      }
      if (this.position.requirement === '') {
        this.$message.error('请填写岗位要求')
        return
      }
      if (this.position.educationId === '') {
        this.$message.error('请填写学历要求')
        return
      }
      if (this.position.quantity === 0) {
        this.$message.error('请填写岗位需要人数')
        return
      }
      if (this.position.salaryUp <= this.position.salaryDown) {
        this.$message.error('请输入合理的薪酬区间')
        return
      }
      if (this.value.length === 0) {
        this.$message.error('请选择类别')
        return
      }
      if (this.position.recruitDeadline === '') {
        this.$message.error('请选择招聘截止时间')
        return
      }
      if (this.position.partTime.length === 0) {
        this.$message.error('请选择兼职时间')
        return
      }
      this.position.workTimeBegin = this.formatValue(this.position.partTime[0])
      this.position.workTimeEnd = this.formatValue(this.position.partTime[1])
      this.position.categoryId = this.value[1]
      this.position.workProvince = this.selectPro
      this.position.workCity = this.selectCity
      modifyPosition(this.position)
        .then(res => {
          if (res.data) {
            this.$message.success("修改成功")
            this.dialogFormVisible = false
            return
          }
        })
    },
    formatValue(value) {
      if (!value) return '';
      const date = new Date(value);
      return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
    },
    getList() {
      showPosition().then(res => {
        this.jobList = res.data
      })
    },
    handleClick(row) {
      this.selectPro = row.workProvince
      this.selectCity = row.workCity
      this.position = row
      this.categorys.forEach(item => {
        if (item.categoryId === row.categoryId) this.value = [item.firstCategoryName, item.categoryId]
      })
      console.log(this.value)
      this.dialogFormVisible = true
    },
    deleteHandle(row) {
      delPosition(row).then(res => {
        if (res.data) {
          this.$message.success('删除成功')
          this.getList()
          return
        }
        this.$message.error('删除失败')
      })
    },
    getStatusText(statePub) {
      switch(statePub) {
        case 0:
          return '未发布'
        case 1:
          return '待审核'
        case 2:
          return '已上架'
        case 3:
          return '已下架'
        default:
          return '未发布'
      }
    },
    getPublishButtonText(statePub) {
      switch(statePub) {
        case 0:
          return '提交审核'
        case 1:
          return '审核中' // 显示审核中状态
        case 2:
          return '下架' // 已上架状态显示下架按钮
        case 3:
          return '重新发布' // 已下架状态显示重新发布按钮
        default:
          return '提交审核'
      }
    },
    publishSwitch(row) {
      if (row.statePub === 1) {
        this.$message.info('该岗位正在审核中，请等待审核结果')
        return
      }
      
      if (row.statePub === 2) {
        // 处理下架操作
        MessageBox.confirm('确认下架该岗位?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          updatePositionState({
            positionId: row.positionId,
            statePub: 3 // 设置为已下架状态
          })
            .then(res => {
              if (res.data) {
                this.$message.success("下架成功")
                this.getList()
                return
              }
            })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消下架'
          })
        })
        return
      }

      if (row.statePub === 3) {
        // 已下架状态可以重新提交审核
        MessageBox.confirm('确认重新提交该岗位进行审核?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          updatePositionState({
            positionId: row.positionId,
            statePub: 1 // 设置为待审核状态
          })
            .then(res => {
              if (res.data) {
                this.$message.success("提交成功，等待审核")
                this.getList()
                return
              }
            })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消提交'
          })
        })
        return
      }
      
      if (row.workProvince === '') {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      if (row.workCity === '') {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      if (row.title === '') {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      if (row.requirement === '') {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      if (row.quantity === 0) {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      if (row.salaryUp <= row.salaryDown) {
        this.$message.error('信息不全，无法提交，请完善岗位信息')
        return
      }
      
      MessageBox.confirm('确认提交该岗位进行审核?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        updatePositionState({
          positionId: row.positionId,
          statePub: 1 // 设置为待审核状态
        })
          .then(res => {
            if (res.data) {
              this.$message.success("提交成功，等待审核")
              this.getList()
              return
            }
          })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消提交'
        })
      })
    },
    addJobHandle() {
      const position = {
      }
      publishPosition(position).then(res => {
        this.$message.success("新增岗位成功!请在岗位列表中编辑岗位或者发布~")
        this.getList()
      })
    },
    getProvince() {
      getProvinces('中国').then(res => {
        this.provinces = res
      })
    },
    getCity() {
      getProvinces(this.selectPro).then(res => {
        this.cities = res
        this.selectCity = '攀枝花市'
      })
    },
  }
}
</script>

<style lang="stylus" scoped>
#jobManagement
  padding 10px
  overflow-y scroll
  overflow-x hidden
  height 100%
.address
  width 30%
  margin-right 3%
</style>
