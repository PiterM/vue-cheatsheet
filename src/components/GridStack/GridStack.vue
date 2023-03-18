<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import { GridStack } from 'gridstack'
import { onMounted } from 'vue'
import svgData from '../../assets/svgs.json'
import { useGridSnapshotStore } from '../../stores/gridSnapshot'
const LOCAL_STORAGE_GRID_SNAPSHOT_KEY = 'GridStack.Snapshot.Current'

const gridSnapshotStore = useGridSnapshotStore()
const defaultGridSnapshot = computed(() => gridSnapshotStore.gridDefaultSnapshot)

let simpleGrid: any

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
    simpleGrid.load(JSON.parse(savedSnapshot))
  }
}

function isSavedSnapshot() {
  return !!localStorage.getItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY)
}

const emit = defineEmits(['hideMainMenu'])

watch(gridSnapshot, (first) => {
  localStorage.setItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY, first)
})

watch(defaultGridSnapshot, (first) => {
  if (first.length) {
    simpleGrid.load([])
    simpleGrid.load(first)
    localStorage.setItem(LOCAL_STORAGE_GRID_SNAPSHOT_KEY, JSON.stringify(first))
    gridSnapshotStore.setDefaultGridSnapshot([])
    emit('hideMainMenu')
  }
})

onMounted(() => {
  simpleGrid = GridStack.init(
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

#simple-grid
  margin: 20px
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
