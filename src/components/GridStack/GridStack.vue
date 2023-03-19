<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import { GridStack } from 'gridstack'
import { onMounted } from 'vue'
import svgData1 from '@/tex/source/1/svgs.json'
import svgData2 from '@/tex/source/2/svgs.json'
import { useGridStore } from '../../stores/gridStore'

const localStorageGridSnapshotKey = {
  layout1: 'GridStack.Snapshot.1.Current',
  layout2: 'GridStack.Snapshot.2.Current'
}

const gridStore = useGridStore()
const defaultGridSnapshot = computed(() => gridStore.gridDefaultSnapshot)
const currentSvgLayout = computed(() => gridStore.currentSvgLayout as string)

let svgData: any
let simpleGrid: any
let grid: any

svgData = currentSvgLayout.value === 'layout1' ? svgData1 : svgData2

grid = svgData.reverse().map((value: any) => {
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

const gridSnapshot = ref()

function loadSavedSnapshot() {
  const savedSnapshot = localStorage.getItem(
    (localStorageGridSnapshotKey as any)[currentSvgLayout.value]
  )
  if (savedSnapshot) {
    simpleGrid.load([])
    simpleGrid.load(JSON.parse(savedSnapshot))
  }
}

function isSavedSnapshot() {
  return !!localStorage.getItem((localStorageGridSnapshotKey as any)[currentSvgLayout.value])
}

function loadGrid(grid: any) {
  simpleGrid.load([])
  simpleGrid.load(grid)
}

function manageGrids(grid: any) {
  if (isSavedSnapshot()) {
    loadSavedSnapshot()
  } else {
    loadGrid(grid)
  }
}

const emit = defineEmits(['hideMainMenu'])

watch(gridSnapshot, (first) => {
  localStorage.setItem((localStorageGridSnapshotKey as any)[currentSvgLayout.value], first)
})

watch(defaultGridSnapshot, (first) => {
  if (first.length) {
    simpleGrid.load([])
    simpleGrid.load(first)
    localStorage.setItem(
      (localStorageGridSnapshotKey as any)[currentSvgLayout.value],
      JSON.stringify(first)
    )
    gridStore.resetDefaultGridSnapshot()
    emit('hideMainMenu')
  }
})

watch(currentSvgLayout, (first) => {
  svgData = first === 'layout1' ? svgData1 : svgData2

  grid = svgData.reverse().map((value: any) => {
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
  manageGrids(grid)
  emit('hideMainMenu')
})

onMounted(() => {
  simpleGrid = GridStack.init(
    {
      alwaysShowResizeHandle: false,
      margin: 2
    },
    '#simple-grid'
  )

  manageGrids(grid)

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
