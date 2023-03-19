<script setup lang="ts">
import { useGridStore } from '../../stores/gridStore'
const gridStore = useGridStore()

function loadDefaultSnapshot() {
  gridStore.setDefaultGridSnapshot()
}

function setLayout(layout: String) {
  gridStore.setCurrentSvgLayout(layout)
}
</script>

<template>
  <div class="main-menu">
    <div class="actions">
      <ul class="actions__menu">
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => setLayout('layout1')"
          >
            Layout #1
          </button>
        </li>
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => setLayout('layout2')"
          >
            Layout #2
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
    </div>
  </div>
</template>

<style scoped lang="sass">
.main-menu
  position: fixed
  top: 0
  width: 100%
  height: 55px
  background-color: #444
  color: #fff
  padding: 10px 20px
  z-index: 1000
  .actions
    &__title
      font-weight: bold
      -webkit-user-select: none
      -moz-user-select: none
      -ms-user-select: none
      user-select: none
    &__menu
      list-style-type: none
      padding-left: 0
      display: flex
    &__menu-item
      margin-right: 10px
    &__button
      width: 100%
</style>
