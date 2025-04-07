<template>
  <main id="bigMain">
    <top-bar></top-bar>
    <article>
      <transition name="fade">
        <router-view></router-view>
      </transition>
    </article>
    <footer>
      <p>CopyRight © 攀枝花学院大学生兼职管理系统</p>
      <p>2025-2028</p>
    </footer>
  </main>
</template>

<script>
import TopBar from "@/components/content/TopBar";
import Carousel from "@/components/conmmon/Carousel";
export default {
  name: "index",
  components: {
    TopBar,
    Carousel,
  },
};
</script>

<style lang="stylus" scoped>
.fade-enter-active, .fade-leave-active {
  transition: all .5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
#bigMain {
  display: flex;
  flex-direction: column;
  min-height: 100vh; /* 确保容器占满整个视口高度 */
  background: rgb(246, 246, 248);
}
article {
  flex-grow: 1; /* 占据剩余空间 */
  width: 70%;
  height: auto;
  margin: 0 auto; /* 居中 */
}
footer {
  width: 100%;
  height: 100px;
  background: #4b4b50;
  color: #52CCBA;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  & p {
    margin: 0;
    font-size: 13px;
  }
}
</style>
