<template>
  <el-card class="box-card" shadow="always">
    <div slot="header">
      <span>求职用户管理</span>
    </div>
    <el-table
      ref="multipleTable"
      :loading="listLoading"
      :data="list.slice((currentPage-1)*pagesize,currentPage*pagesize)"
      tooltip-effect="dark"
      style="width: 100%"
      @selection-change="handleSelectionChange">
      <el-table-column
        align="center"
        prop="userId"
        label="编号"/>
      <el-table-column
        align="center"
        prop="user"
        label="账号" show-overflow-tooltip/>
      <el-table-column
        align="center"
        prop="mobile"
        label="联系电话" show-overflow-tooltip/>
      <el-table-column
        align="center"
        prop="email"
        label="邮箱地址" show-overflow-tooltip/>
      <el-table-column
        align="center"
        label="性别">
        <template slot-scope="scope">
          {{scope.row.gender?'男': '女'}}
        </template>
      </el-table-column>
      <el-table-column
        align="center"
        prop="birthYear"
        label="出生年份"/>
      <el-table-column
        align="center"
        prop="graduation"
        label="毕业院校" show-overflow-tooltip/>
      <el-table-column
        align="center"
        prop="eduDegree"
        label="学历"/>
      <el-table-column
        align="center"
        prop="graduateYear"
        label="毕业年份"/>
      <el-table-column
        align="center"
        prop="major"
        label="应聘职位"/>
      <el-table-column
        align="center"
        prop="dirDesire"
        label="期望薪资"/>
      <el-table-column
        align="center"
        label="居住城市"  show-overflow-tooltip>
        <template slot-scope="scope">
          {{(scope.row.province?scope.row.province:'') + (scope.row.city?scope.row.city:'')}}
        </template>
      </el-table-column>
      <el-table-column width="155" label="操作" align="center" >
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button  slot="reference" :loading="scope.row.loading" size="mini" type="danger"  @click="handleDel(scope.row)">删除</el-button>
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
      <div class="bottom">
        <!-- <el-button type="primary" @click="navigateTo('user/add')">添加用户</el-button> -->
      </div>

    </div>

  </el-card>
</template>

<script>
  import { listUser, delUser } from "@/api/manager";

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
        }
      },
      created: function () {
        this.getListData()
      },
      methods:{
        getListData(){
          listUser()
          .then(res => {
            this.list = res.data
            console.log(res)
          });
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
        massDeletion() {
        },
        handleDel(row){
          this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            delUser(row.userId)
            .then(response => {
              if(response) {
                this.$message({
                  type: 'success',
                  message: '删除成功!'
                });
              }
              this.getListData()
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
          localStorage.setItem("userInfo",JSON.stringify(row))
          this.$router.push({
            path: '/user/edit',
            params: {
              id: row.userId
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
      },
    }
</script>

<style scoped>

</style>
