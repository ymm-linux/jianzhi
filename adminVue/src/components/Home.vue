<template>
  <div>
    <el-row class="container">
      <el-col :span="24" class="header">
        <el-col :span="10" class="logo" :class="collapsed? 'logo-collapse-width':'logo-width'">
          {{collapsed? '':sysName}}
        </el-col>
        <el-col :span="10">
          <div class="tools" @click.prevent="collapse">
            <i class="fa fa-align-justify"></i>
          </div>
        </el-col>
        <el-col :span="4" class="userinfo">
          <el-dropdown  trigger="hover"  @click="handleClick">
              	<span class="userinfo-inner"><img src="../assets/logo.png" /> {{sysUserName}}</span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item  @click.native="reset">修改密码</el-dropdown-item>
                <el-dropdown-item  @click.native="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
        </el-col>
      </el-col>
      <el-col :span="24" class="main">
        <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="collapsed">
          <el-menu-item index="1" @click="pushRoute(1)">
            岗位列表
          </el-menu-item>
          <el-menu-item index="2" @click="pushRoute(2)">
            应聘记录
          </el-menu-item>
          <el-menu-item index="3" @click="pushRoute(3)">
            职业分类管理
          </el-menu-item>
          <el-menu-item index="4" @click="pushRoute(4)">
            学历参数
          </el-menu-item>
          <el-menu-item index="5" @click="pushRoute(5)">
            求职用户
          </el-menu-item>
          <el-menu-item index="7" @click="pushRoute(6)">
            企业用户
          </el-menu-item>
          <el-menu-item index="8" @click="pushRoute(7)">
            投诉反馈
          </el-menu-item>
          <el-menu-item index="9" @click="pushRoute(8)">
            公告管理
          </el-menu-item>
          <el-menu-item index="10" @click="pushRoute(9)">
            工时薪资
          </el-menu-item>
          <el-menu-item index="11" @click="pushRoute(10)">
            在岗人员
          </el-menu-item>
          <el-menu-item index="12" @click="pushRoute(11)">
            佣金统计
          </el-menu-item>
        </el-menu>
        <section class="content-container">
          <div class="grid-content bg-purple-light">
            <el-col :span="24" class="breadcrumb-container">
              <strong class="title">{{$route.name}}</strong>
              <!-- <el-breadcrumb separator="/" class="breadcrumb-inner">
                <el-breadcrumb-item v-for="item in $route.matched" :key="item.path">
                  {{ item.name }}
                </el-breadcrumb-item>
              </el-breadcrumb> -->
            </el-col>
            <el-col :span="24" class="content-wrapper">
              <transition name="fade" mode="out-in">
                <router-view></router-view>
              </transition>
            </el-col>
          </div>
        </section>
      </el-col>
    </el-row>
  </div>

</template>

<script>
export default {
  data() {
    return {
      collapsed: false,
      sysName: "攀枝花学院",
      sysUserAvatar: "",
      sysUserName: "",
        userinfo:{},
      form: {
        name: "",
        region: "",
        date1: "",
        date2: "",
        delivery: false,
        type: [],
        resource: "",
        desc: "",
        userinfo:{}
      }
    };
  },
  methods: {
    pushRoute(index) {

      switch(index) {
        case 1:
          this.$router.push({path:'/position/list'});
          break;
        case 2:
          this.$router.push({path:'/application/list'});
          break;
        case 3:
          this.$router.push({path:'/category'});
          break;
        case 4:
          this.$router.push({path:'/education'});
          break;
        case 5:
          this.$router.push({path:'/user/list'});
          break;
        case 6:
          this.$router.push({path:'/company/list'});
          break;
        case 7:
          this.$router.push({path:'/recruit/feedbacks'});
          break;
        case 8:
          this.$router.push({path:'/recruit/notice'});
          break;
        case 9:
          this.$router.push({path:'/recruit/salaries'});
          break;
        case 10:
          this.$router.push({path:'/recruit/workers'});
          break;
         case 11:
           this.$router.push({path:'/recruit/commission'});
           break;
      }
    },
    collapse() {
      this.collapsed = !this.collapsed;
    },
    handleClick() {},
    handleOpen() {},
    handleClose() {},
    handleSelect() {},
    logout() {
      var _this = this;
      this.$confirm("确认退出吗?", "提示", {
        //type: 'warning'
      })
        .then(() => {
          sessionStorage.removeItem("user");
          _this.$router.push("/login");
        })
        .catch(() => {});
    },
    reset(){
        this.$router.push("/reset")
    },
    showMenu(i, status) {
      this.$refs.menuCollapsed.getElementsByClassName(
        "submenu-hook-" + i
      )[0].style.display = status ? "block" : "none";
    }
  },
  mounted() {
    var user = sessionStorage.getItem("user");
    this.userinfo = JSON.parse(sessionStorage.getItem("user"))
      if (user) {
        user = JSON.parse(user);
        this.sysUserName = user.hrName || "";
        this.sysUserAvatar = user.avatar || "";
      }
    }
};
</script>

<style  scoped lang="scss">
.container {
  margin: 0;
  padding: 0;
  position: absolute;
  top: 0px;
  bottom: 0px;
  left: 0px;
  width: 100%;
  .header {
    height: 60px;
    line-height: 60px;
    background: seagreen;
    color: #fff;
    .userinfo {
      text-align: right;
      padding-right: 35px;
      float: right;
      .userinfo-inner {
        cursor: pointer;
        color: #fff;
        img {
          width: 40px;
          height: 40px;
          border-radius: 20px;
          margin: 10px 0px 10px 10px;
          float: right;
        }
      }
    }
    .logo {
      height: 60px;
      font-size: 22px;
      padding-left: 20px;
      padding-right: 20px;
      border-color: rgba(238, 241, 146, 0.3);
      border-right-width: 1px;
      border-right-style: solid;
      img {
        width: 40px;
        float: left;
        margin: 10px 10px 10px 18px;
      }
      .txt {
        color: #fff;
      }
    }
    .logo-width {
      width: 230px;
    }
    .logo-collapse-width {
      width: 65px;
    }
    .tools {
      padding: 0px 23px;
      width: 14px;
      height: 60px;
      line-height: 60px;
      cursor: pointer;
    }
  }
  .main {
    display: flex;
    position: absolute;
    top: 60px;
    bottom: 0px;
    overflow: hidden;
    aside {
      flex: 0 0 230px;
      width: 230px;
      .el-menu {
        height: 100%;
        background-color: #d5d8db;
        .el-menu-item {
          padding: 0 20px;
          height: 50px;
          line-height: 50px;
          &:hover {
            background-color: #c0c4cc;
          }
          &.is-active {
            background-color: #b3b7bf;
            color: #303133;
          }
        }
      }
      .collapsed {
        width: 60px;
        .item {
          position: relative;
        }
        .submenu {
          position: absolute;
          top: 0px;
          left: 60px;
          z-index: 99999;
          height: auto;
          display: none;
        }
      }
    }
    .menu-collapsed {
      width: 60px;
    }
    .menu-expanded {
      width: 230px;
    }
    .content-container {
      flex: 1;
      overflow-y: scroll;
      padding: 20px;
      .breadcrumb-container {
        .title {
          width: 200px;
          text-align: left;
          float: left;
          color: #475669;
        }
        .breadcrumb-inner {
          float: right;
        }
      }
      .content-wrapper {
        background-color: #fff;
        box-sizing: border-box;
      }
    }
  }
}
</style>
