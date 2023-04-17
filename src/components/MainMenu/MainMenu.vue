<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useGridStore } from '../../stores/gridStore'
const gridStore = useGridStore()

const activeTab = ref<string>('home')
const router = useRouter()

function loadDefaultSnapshot() {
  gridStore.setDefaultGridSnapshot()
}

function setLayout(layout: String) {
  gridStore.setCurrentSvgLayout(layout)
}

function handleTabClick(event: any) {
  const nextTabName = event.props.name
  router.push(`/${nextTabName === 'puzzle' ? nextTabName : ''}`)
  activeTab.value = nextTabName
}
</script>

<template>
  <div class="main-menu">
    <el-tabs
      type="card"
      class="menu-tabs"
      v-model="activeTab"
      @tab-click="(event: any) => handleTabClick(event)"
    >
      <el-tab-pane
        label="Home"
        name="home"
        :class="{ isActive: activeTab === 'home' }"
      ></el-tab-pane>
      <el-tab-pane
        label="Puzzle"
        name="puzzle"
        :class="{ isActive: activeTab === 'puzzle' }"
      ></el-tab-pane>
    </el-tabs>
    <!-- <div class="actions">
      <ul class="actions__menu">
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => setLayout('layout1')"
          >
            Design #1
          </button>
        </li>
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => setLayout('layout2')"
          >
            Design #2
          </button>
        </li>
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => loadDefaultSnapshot()"
          >
            Restore defaults
          </button>
        </li>
      </ul>
    </div> -->
  </div>
</template>

<style lang="sass">
.main-menu
  position: relative
  top: 0
  width: 100%
  height: 55px
  background-color: #444
  color: #fff
  padding: 10px 20px
  z-index: 1000

  .menu-tabs
    position: absolute
    bottom: -14px
    .el-tabs__item
      background-color: #ddd
      &.is-active
        background-color: #fff
    .el-tabs__header
      border: none
  // .actions
  //   &__title
  //     font-weight: bold
  //     -webkit-user-select: none
  //     -moz-user-select: none
  //     -ms-user-select: none
  //     user-select: none
  //   &__menu
  //     list-style-type: none
  //     padding-left: 0
  //     display: flex
  //   &__menu-item
  //     margin-right: 10px
  //   &__button
  //     width: 100%
</style>
