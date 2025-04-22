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
          prop="positionId"
          label=ID
          width="180">
      </el-table-column>
      <el-table-column
          label="编辑日期"
          width="180">
        <template slot-scope="scope">
          {{ scope.row.releaseDate | formatDate }}
        </template>
      </el-table-column>
      <el-table-column
          label="岗位名称"
          width="180">
        <template slot-scope="scope">
          {{scope.row.title||'未填写'}}
        </template>
      </el-table-column>
      <el-table-column
          prop="requirement"
          label="岗位要求">
      </el-table-column>
      <el-table-column
          prop="salaryType"
          label="薪资类型">
      </el-table-column>
      <el-table-column
          label="学历要求"
          width="180">
        <template slot-scope="scope">
          {{educations[scope.row.educationId]}}
        </template>
      </el-table-column>
      <el-table-column
          prop="quantity"
          label="招聘人数">
      </el-table-column>
      <el-table-column
          prop="workCity"
          label="工作城市">
      </el-table-column>
      <el-table-column
        label="薪资">
        <template slot-scope="scope">
          {{ scope.row.salaryDown&&scope.row.salaryUp?scope.row.salaryDown + '-' + scope.row.salaryUp:'未填写'}}
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-tag :type="getStatusType(scope.row.statePub)">
            {{getStatusText(scope.row.statePub)}}
          </el-tag>
        </template>
      </el-table-column>
       <el-table-column
            prop="commission"
            label="佣金">
        </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="280">
        <template slot-scope="scope">
          <el-button-group>
            <el-button 
              @click="handleEdit(scope.$index,scope.row)" 
              type="primary" 
              size="mini"
              style="width: 80px">编辑</el-button>
          
            <el-button 
              v-if="scope.row.statePub === 0"
              @click="handleSubmit(scope.$index,scope.row)" 
              type="warning" 
              size="mini"
              style="width: 80px">提交发布</el-button>
            <el-button 
              v-if="scope.row.statePub === 1"
              @click="handleAudit(scope.$index,scope.row)" 
              type="success" 
              size="mini"
              style="width: 80px">审核通过</el-button>
            <el-button 
              v-if="scope.row.statePub === 1"
              @click="handleReject(scope.$index,scope.row)" 
              type="danger" 
              size="mini"
              style="width: 80px">审核拒绝</el-button>
            <el-button 
              v-if="scope.row.statePub === 2"
              @click="handleUnpublish(scope.$index,scope.row)" 
              type="info" 
              size="mini"
              style="width: 80px">下架</el-button>
            <el-button 
              v-if="scope.row.statePub === 3"
              type="info" 
              size="mini"
              style="width: 80px" 
              disabled>已下架</el-button>
          </el-button-group>
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

  </el-card>
</template>

<script>
  import { listCategory, listEducation, listPosition, delPosition, updatePosition } from '@/api/manager'
  import { updatePositionState } from '@/api/position'

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
          educations: {}
        }
      },
      created: function () {
        this.userinfo = JSON.parse(sessionStorage.getItem("user"))
        this.listCategory()
        this.listEducation()
        this.getListData()
      },
      methods:{
        listCategory() {
          listCategory()
          .then(res=>{
            this.categorys = res.data
          })
        },
        listEducation() {
          listEducation()
          .then(res=>{
            this.educations={}
            res.data.forEach(item=>{
              this.educations[item.id] = item.name
            })
          })
        },
        getListData(){
          listPosition()
          .then(res=>{
            this.list = res.data
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
            delPosition(row.positionId)
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
        getStatusType(statePub) {
          switch(statePub) {
            case 0:
              return 'info'
            case 1:
              return 'warning'
            case 2:
              return 'success'
            case 3:
              return 'danger'
            default:
              return 'info'
          }
        },
        getStatusText(statePub) {
          switch(statePub) {
            case 0:
              return '未发布'
            case 1:
              return '待审核'
            case 2:
              return '已发布'
            case 3:
              return '已下架'
            default:
              return '未知'
          }
        },
        handleSubmit(index, row) {
          this.$confirm('确认提交发布该岗位?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const updatedPosition = {
              positionId: row.positionId,
              statePub: 1 // 设置为待审核状态
            };
            updatePositionState(updatedPosition)
              .then(res => {
                this.$message({
                  type: 'success',
                  message: '提交成功!'
                });
                this.getListData();
              })
              .catch(error => {
                console.log(error);
                this.$message.error('提交失败');
              });
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消提交'
            });
          });
        },
        handleAudit(index, row) {
          this.$confirm('确认通过该岗位?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const updatedPosition = {
              positionId: row.positionId,
              statePub: 2 // 设置为已发布状态
            };
            updatePositionState(updatedPosition)
              .then(res => {
                this.$message({
                  type: 'success',
                  message: '审核通过!'
                });
                this.getListData();
              })
              .catch(error => {
                console.log(error);
                this.$message.error('审核失败');
              });
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消审核'
            });
          });
        },
        handleReject(index, row) {
          this.$confirm('确认拒绝该岗位?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const updatedPosition = {
              positionId: row.positionId,
              statePub: 0 // 设置为未发布状态
            };
            updatePositionState(updatedPosition)
              .then(res => {
                this.$message({
                  type: 'success',
                  message: '已拒绝!'
                });
                this.getListData();
              })
              .catch(error => {
                console.log(error);
                this.$message.error('操作失败');
              });
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消操作'
            });
          });
        },
        handleUnpublish(index, row) {
          this.$confirm('确认下架该岗位?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const updatedPosition = {
              positionId: row.positionId,
              statePub: 3 // 设置为已下架状态
            };
            updatePositionState(updatedPosition)
              .then(res => {
                this.$message({
                  type: 'success',
                  message: '下架成功!'
                });
                this.getListData();
              })
              .catch(error => {
                console.log(error);
                this.$message.error('下架失败');
              });
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消下架'
            });
          });
        }
      }
    }
</script>

<style scoped>
.el-button-group {
  display: flex;
  justify-content: flex-start;
  gap: 5px;
}
.el-tag {
  width: 80px;
  text-align: center;
}
</style>
