<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { GridStack } from 'gridstack'
import { onMounted } from 'vue'
import svgData from '../../assets/svgs.json'

const LOCAL_STORAGE_GRID_SNAPSHOT_KEY = 'GridStack.Snapshot.Current'

const gridSnapshot = ref()

const grid = svgData.reverse().map((value) => {
  const aspectRatio = value.width / value.height
  const w = Math.floor(aspectRatio / 2) * 2
  const h = 1

  return {
    x: 0,
    y: 0,
    w,
    h,
    content: `<img src="/svg/${value.filename}" class="svg-item" />`
  }
})

function loadSavedSnapshot(grid: any) {
  const savedSnapshot = localStorage.getItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY)
  if (savedSnapshot) {
    grid.load(JSON.parse(savedSnapshot))
  }
}

function isSavedSnapshot() {
  return !!localStorage.getItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY)
}

watch(gridSnapshot, (first) => {
  localStorage.setItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY, first)
})

onMounted(() => {
  const simpleGrid = GridStack.init(
    {
      alwaysShowResizeHandle: false,
      margin: 2
    },
    '#simple-grid'
  )
  if (isSavedSnapshot()) {
    loadSavedSnapshot(simpleGrid)
  } else {
    simpleGrid.load(grid)
  }

  simpleGrid.on('change', () => {
    gridSnapshot.value = JSON.stringify(simpleGrid.save())
  })
})
</script>

<template>
  <div id="simple-grid"></div>
</template>

<style lang="sass">
@import url("gridstack/dist/gridstack.min.css")

.grid-stack-item-content
  border: 1px solid transparent
  overflow: hidden !important
  -webkit-user-select: none
  -moz-user-select: none
  -ms-user-select: none
  user-select: none
  &:hover
    border-color: #000
  & .svg-item
    width: 100%
    height: 100%
</style>
