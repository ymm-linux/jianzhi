// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueRouter from 'vue-router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import Vuex from 'vuex'
import 'font-awesome/css/font-awesome.min.css'
import moment from 'moment';

Vue.config.productionTip = false;

// 创建全局过滤器，格式化时间
Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('YYYY-MM-DD HH:mm:ss');
  }
});

Vue.filter('formatDay', function(value) {
  if (value) {
    return moment(String(value)).format('YYYY-MM-DD');
  }
});

Vue.config.productionTip = false
import echarts from 'echarts';
Vue.prototype.$echarts = echarts;

Vue.use(ElementUI)
Vue.use(VueRouter)
Vue.use(Vuex)
/* eslint-disable no-new */


router.beforeEach((to, from, next) => {
  // NProgress.start();
  if (to.path == '/login') {
    sessionStorage.removeItem('user');
  }
  let user = JSON.parse(sessionStorage.getItem('user'));
  if (!user && to.path != '/login') {
    next({ path: '/login' })
  } else {
    next()
  }
})
new Vue({
  //el: '#app',
  //template: '<App/>',
  router,
  store,
  //components: { App }
  render: h => h(App)
}).$mount('#app')
