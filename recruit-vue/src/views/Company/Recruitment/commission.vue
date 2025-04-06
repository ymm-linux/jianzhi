<template>
  <div class="bg-gray-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
      <!-- 侧边栏导航 -->
      <div class="sidebar bg-indigo-800 text-white w-64 flex-shrink-0">
        <div class="p-4">
          <h1 class="text-2xl font-bold flex items-center">
            <i class="fas fa-chart-pie mr-2"></i>
            薪酬统计
          </h1>
          <p class="text-indigo-200 text-sm mt-1">员工薪酬数据分析</p>
        </div>
        <nav class="mt-6">
          <div class="px-4 py-2 bg-indigo-900">
            <span class="text-indigo-300">主菜单</span>
          </div>
          <a href="#" class="block px-4 py-3 text-white hover:bg-indigo-700 flex items-center">
            <i class="fas fa-tachometer-alt mr-3"></i>
            仪表盘
          </a>
          <a href="#" class="block px-4 py-3 text-white hover:bg-indigo-700 flex items-center">
            <i class="fas fa-users mr-3"></i>
            员工管理
          </a>
          <a href="#" class="block px-4 py-3 text-white hover:bg-indigo-700 flex items-center">
            <i class="fas fa-money-bill-wave mr-3"></i>
            薪资发放
          </a>
          <div class="px-4 py-2 bg-indigo-900 mt-4">
            <span class="text-indigo-300">报表系统</span>
          </div>
          <a href="#" class="block px-4 py-3 text-white hover:bg-indigo-700 flex items-center">
            <i class="fas fa-chart-bar mr-3"></i>
            数据分析
          </a>
          <a href="#" class="block px-4 py-3 text-white hover:bg-indigo-700 flex items-center">
            <i class="fas fa-file-export mr-3"></i>
            数据导出
          </a>
        </nav>
        <div class="absolute bottom-0 w-full p-4">
          <div class="bg-indigo-900 rounded-lg p-3">
            <div class="flex items-center">
              <div class="w-10 h-10 rounded-full bg-indigo-600 flex items-center justify-center">
                <i class="fas fa-user"></i>
              </div>
              <div class="ml-3">
                <p class="text-sm">管理员</p>
                <p class="text-xs text-indigo-300">admin@example.com</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 主内容区域 -->
      <div class="flex-1 overflow-auto">
        <!-- 顶部导航栏 -->
        <header class="bg-white shadow-sm">
          <div class="flex items-center justify-between px-6 py-4">
            <div class="flex items-center">
              <button class="md:hidden mr-4 text-gray-600" @click="toggleSidebar">
                <i class="fas fa-bars"></i>
              </button>
              <h2 class="text-xl font-semibold text-gray-800">员工薪酬统计面板</h2>
            </div>
            <div class="flex items-center space-x-4">
              <div class="relative">
                <input
                  type="text"
                  placeholder="搜索..."
                  class="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
              </div>
              <button class="p-2 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i class="fas fa-bell"></i>
              </button>
            </div>
          </div>
        </header>

        <!-- 仪表盘内容 -->
        <main class="p-6">
          <!-- 摘要卡片 -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-gray-500">总工时</p>
                  <h3 class="text-2xl font-bold">{{ summary.totalHours.toLocaleString() }}</h3>
                  <p class="text-green-500 text-sm mt-1">较上月 ↑12%</p>
                </div>
                <div class="w-12 h-12 rounded-full bg-blue-100 flex items-center justify-center">
                  <i class="fas fa-clock text-blue-500"></i>
                </div>
              </div>
            </div>
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-gray-500">平均薪资</p>
                  <h3 class="text-2xl font-bold">¥{{ summary.avgSalary.toLocaleString() }}</h3>
                  <p class="text-green-500 text-sm mt-1">较上月 ↑5%</p>
                </div>
                <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center">
                  <i class="fas fa-dollar-sign text-green-500"></i>
                </div>
              </div>
            </div>
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-gray-500">岗位数量</p>
                  <h3 class="text-2xl font-bold">{{ summary.positionsCount }}</h3>
                  <p class="text-blue-500 text-sm mt-1">本月新增 3</p>
                </div>
                <div class="w-12 h-12 rounded-full bg-purple-100 flex items-center justify-center">
                  <i class="fas fa-briefcase text-purple-500"></i>
                </div>
              </div>
            </div>
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-gray-500">平均佣金率</p>
                  <h3 class="text-2xl font-bold">{{ summary.avgCommission }}%</h3>
                  <p class="text-red-500 text-sm mt-1">较上月 ↓1.2%</p>
                </div>
                <div class="w-12 h-12 rounded-full bg-yellow-100 flex items-center justify-center">
                  <i class="fas fa-percent text-yellow-500"></i>
                </div>
              </div>
            </div>
          </div>

          <!-- 图表区域 -->
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
            <!-- 工时vs薪资图表 -->
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between mb-4">
                <h3 class="font-semibold text-lg">工时与薪资关系</h3>
                <div class="flex space-x-2">
                  <button class="px-3 py-1 text-xs bg-indigo-100 text-indigo-700 rounded">月度</button>
                  <button class="px-3 py-1 text-xs bg-gray-100 text-gray-700 rounded">季度</button>
                  <button class="px-3 py-1 text-xs bg-gray-100 text-gray-700 rounded">年度</button>
                </div>
              </div>
              <!-- 修改所有图表容器，添加ID -->
              <div class="chart-container">
                <canvas id="hoursSalaryChart"></canvas>
              </div>
              
              <div class="chart-container">
                <canvas id="positionChart"></canvas>
              </div>
              
              <div class="chart-container">
                <canvas id="commissionChart"></canvas>
              </div>
            </div>

            <!-- 岗位分布图表 -->
            <div class="data-card bg-white rounded-xl shadow p-6">
              <div class="flex items-center justify-between mb-4">
                <h3 class="font-semibold text-lg">岗位分布</h3>
                <div class="flex space-x-2">
                  <button class="px-3 py-1 text-xs bg-indigo-100 text-indigo-700 rounded">按人数</button>
                  <button class="px-3 py-1 text-xs bg-gray-100 text-gray-700 rounded">按薪资</button>
                </div>
              </div>
              <div class="chart-container">
                <canvas ref="positionChart"></canvas>
              </div>
            </div>
          </div>

          <!-- 佣金率分析图表 -->
          <div class="data-card bg-white rounded-xl shadow p-6 mb-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="font-semibold text-lg">佣金率分析</h3>
              <div class="flex space-x-2">
                <button class="px-3 py-1 text-xs bg-indigo-100 text-indigo-700 rounded">销售岗</button>
                <button class="px-3 py-1 text-xs bg-gray-100 text-gray-700 rounded">服务岗</button>
                <button class="px-3 py-1 text-xs bg-gray-100 text-gray-700 rounded">全部</button>
              </div>
              <div class="chart-container">
                <canvas ref="commissionChart"></canvas>
              </div>
            </div>
          </div>

          <!-- 数据管理区域 -->
          <div class="bg-white rounded-xl shadow p-6 mb-6">
            <h3 class="font-semibold text-lg mb-4">数据管理</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <h4 class="font-medium mb-2">加载数据</h4>
                <div class="flex space-x-2">
                  <button @click="loadSampleData" class="px-4 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700">加载示例数据</button>
                  <button @click="loadApiData" class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">从API加载</button>
                </div>
                <div class="mt-4">
                  <label class="block text-sm font-medium text-gray-700 mb-1">或粘贴JSON数据:</label>
                  <textarea
                    v-model="jsonData"
                    class="w-full h-32 p-2 border border-gray-300 rounded focus:ring-indigo-500 focus:border-indigo-500"
                    placeholder="粘贴JSON数据..."
                  ></textarea>
                  <button @click="loadJsonData" class="mt-2 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">加载JSON</button>
                </div>
              </div>
              <div>
                <h4 class="font-medium mb-2">导出数据</h4>
                <div class="flex space-x-2">
                  <button class="px-4 py-2 bg-purple-600 text-white rounded hover:bg-purple-700">导出CSV</button>
                  <button class="px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-700">导出JSON</button>
                </div>
                <div class="mt-4">
                  <label class="block text-sm font-medium text-gray-700 mb-1">当前数据:</label>
                  <pre class="text-xs p-2 bg-gray-100 rounded overflow-auto h-32">{{ currentData }}</pre>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import Chart from 'chart.js/auto';

export default {
  name: 'Commission',
  setup() {
    const summary = ref({
      totalHours: 1240,
      avgSalary: 4250,
      positionsCount: 24,
      avgCommission: 8.5,
    });

    const jsonData = ref('');
    const currentData = ref('尚未加载数据');

    const hoursSalaryChart = ref(null);
    const positionChart = ref(null);
    const commissionChart = ref(null);

    const sampleData = {
      summary: {
        totalHours: 1240,
        avgSalary: 4250,
        positionsCount: 24,
        avgCommission: 8.5,
      },
      hoursSalary: {
        labels: ['1月', '2月', '3月', '4月', '5月', '6月'],
        hours: [180, 190, 210, 200, 220, 240],
        salaries: [3800, 4000, 4200, 4100, 4300, 4500],
      },
      positions: {
        labels: ['开发', '管理', '销售', '设计', '客服'],
        counts: [8, 3, 6, 4, 3],
        avgSalaries: [4500, 6000, 3500, 4000, 3200],
      },
      commissions: {
        labels: ['0-5%', '5-10%', '10-15%', '15-20%', '20%+'],
        counts: [5, 12, 4, 2, 1],
      },
    };

    const initCharts = (data) => {
      // 初始化工时与薪资关系图
      if (hoursSalaryChart.value) {
        hoursSalaryChart.value.destroy();
      }
      hoursSalaryChart.value = new Chart(document.getElementById('hoursSalaryChart'), {
        type: 'line',
        data: {
          labels: data.hoursSalary.labels,
          datasets: [
            {
              label: '工时(小时)',
              data: data.hoursSalary.hours,
              borderColor: 'rgb(99, 102, 241)',
              backgroundColor: 'rgba(99, 102, 241, 0.1)',
              tension: 0.3,
              yAxisID: 'y',
            },
            {
              label: '平均薪资(元)',
              data: data.hoursSalary.salaries,
              borderColor: 'rgb(16, 185, 129)',
              backgroundColor: 'rgba(16, 185, 129, 0.1)',
              tension: 0.3,
              yAxisID: 'y1',
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          interaction: {
            mode: 'index',
            intersect: false,
          },
          scales: {
            y: {
              type: 'linear',
              display: true,
              position: 'left',
              title: {
                display: true,
                text: '工时(小时)',
              },
            },
            y1: {
              type: 'linear',
              display: true,
              position: 'right',
              grid: {
                drawOnChartArea: false,
              },
              title: {
                display: true,
                text: '平均薪资(元)',
              },
            },
          },
        },
      });

      // 初始化岗位分布图
      if (positionChart.value) {
        positionChart.value.destroy();
      }
      positionChart.value = new Chart(document.getElementById('positionChart'), {
        type: 'bar',
        data: {
          labels: data.positions.labels,
          datasets: [
            {
              label: '员工人数',
              data: data.positions.counts,
              backgroundColor: 'rgba(124, 58, 237, 0.7)',
              borderColor: 'rgba(124, 58, 237, 1)',
              borderWidth: 1,
            },
            {
              label: '平均薪资(元)',
              data: data.positions.avgSalaries,
              backgroundColor: 'rgba(16, 185, 129, 0.7)',
              borderColor: 'rgba(16, 185, 129, 1)',
              borderWidth: 1,
              type: 'line',
              yAxisID: 'y1',
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              beginAtZero: true,
              title: {
                display: true,
                text: '员工人数',
              },
            },
            y1: {
              beginAtZero: true,
              position: 'right',
              grid: {
                drawOnChartArea: false,
              },
              title: {
                display: true,
                text: '平均薪资(元)',
              },
            },
          },
        },
      });

      // 初始化佣金率分析图
      if (commissionChart.value) {
        commissionChart.value.destroy();
      }
      commissionChart.value = new Chart(document.getElementById('commissionChart'), {
        type: 'doughnut',
        data: {
          labels: data.commissions.labels,
          datasets: [
            {
              data: data.commissions.counts,
              backgroundColor: [
                'rgba(59, 130, 246, 0.7)',
                'rgba(16, 185, 129, 0.7)',
                'rgba(245, 158, 11, 0.7)',
                'rgba(244, 63, 94, 0.7)',
                'rgba(139, 92, 246, 0.7)',
              ],
              borderColor: [
                'rgba(59, 130, 246, 1)',
                'rgba(16, 185, 129, 1)',
                'rgba(245, 158, 11, 1)',
                'rgba(244, 63, 94, 1)',
                'rgba(139, 92, 246, 1)',
              ],
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'right',
            },
            tooltip: {
              callbacks: {
                label: function (context) {
                  const label = context.label || '';
                  const value = context.raw || 0;
                  const total = context.dataset.data.reduce((a, b) => a + b, 0);
                  const percentage = Math.round((value / total) * 100);
                  return `${label}: ${value}人 (${percentage}%)`;
                },
              },
            },
          },
        },
      });
    };

    const loadSampleData = () => {
      summary.value = sampleData.summary;
      currentData.value = JSON.stringify(sampleData, null, 2);
      initCharts(sampleData);
    };

    const loadApiData = () => {
      alert('这里将调用API接口加载数据\n实际使用时请替换fetch代码');
      // fetch('your-api-endpoint')
      //   .then(response => response.json())
      //   .then(data => {
      //     summary.value = data.summary;
      //     currentData.value = JSON.stringify(data, null, 2);
      //     initCharts(data);
      //   })
      //   .catch(error => alert('加载数据错误: ' + error));
    };

    const loadJsonData = () => {
      try {
        const data = JSON.parse(jsonData.value);
        summary.value = data.summary;
        currentData.value = JSON.stringify(data, null, 2);
        initCharts(data);
      } catch (e) {
        alert('JSON数据格式错误: ' + e.message);
      }
    };

    const toggleSidebar = () => {
      document.querySelector('.sidebar').classList.toggle('active');
    };

    onMounted(() => {
      loadSampleData();
    });

    return {
      summary,
      jsonData,
      currentData,
      hoursSalaryChart,
      positionChart,
      commissionChart,
      loadSampleData,
      loadApiData,
      loadJsonData,
      toggleSidebar,
    };
  },
};
</script>

<style scoped>
.chart-container {
  position: relative;
  height: 300px;
  width: 100%;
}
.data-card {
  transition: all 0.3s ease;
}
.data-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}
.sidebar {
  transition: all 0.3s ease;
}
@media (max-width: 768px) {
  .sidebar {
    transform: translateX(-100%);
    position: absolute;
    z-index: 10;
  }
  .sidebar.active {
    transform: translateX(0);
  }
}
</style>
