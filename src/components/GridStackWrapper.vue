<script setup lang="ts">
import { GridStack } from 'gridstack'
import { onMounted } from 'vue'
import svgData from '../assets/svgs.json'

defineProps<{
  msg: string
}>()

const grid = svgData.reverse().map((value) => {
  const aspectRatio = value.width / value.height
  const w = Math.floor(aspectRatio / 2) * 2
  const h = 1

  return {
    x: 0,
    y: 0,
    w,
    h,
    content: `<img src='/svg/${value.filename}' style='width: 100%; height: 100%;' />`
  }
})

onMounted(() => {
  const simpleGrid = GridStack.init(
    {
      alwaysShowResizeHandle: false,
      margin: 2
    },
    '#simple-grid'
  )
  simpleGrid.load(grid)
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
  &:hover
    border-color: #000
</style>
