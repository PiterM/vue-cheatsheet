<script setup lang="ts">
import { useGridSnapshotStore } from '../../stores/gridSnapshot'
const gridSnapshotStore = useGridSnapshotStore()

function loadDefaultSnapshot() {
  gridSnapshotStore.setDefaultGridSnapshot()
}
</script>

<template>
  <div class="main-menu">
    <div class="actions">
      <ul class="actions__menu">
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
