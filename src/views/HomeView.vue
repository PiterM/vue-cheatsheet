<script setup lang="ts">
import { GridStack } from "gridstack";
import { onMounted } from "vue";

const simple = [
  { x: 0, y: 0, w: 4, h: 1 },
  { x: 4, y: 0, w: 4, h: 4 },
  {
    x: 8,
    y: 0,
    w: 2,
    h: 1,
    content: "<img src='/svg/1.svg' style='width: 100%; height: 100%;' />",
  },
  {
    x: 10,
    y: 0,
    w: 2,
    h: 1,
    content: "<img src='/svg/2.svg' style='width: 100%; height: 100%;' />",
  },
  { x: 0, y: 2, w: 2, h: 1 },
  { x: 2, y: 2, w: 2, h: 4 },
  { x: 8, y: 2, w: 4, h: 1 },
  { x: 0, y: 4, w: 2, h: 1 },
  { x: 4, y: 4, w: 4, h: 1 },
  { x: 8, y: 4, w: 2, h: 1 },
  { x: 10, y: 4, w: 2, h: 1 },
];

onMounted(() => {
  const simpleGrid = GridStack.init(
    {
      alwaysShowResizeHandle: false,
      margin: 2,
    },
    "#simple-grid"
  );
  simpleGrid.load(simple);
});
</script>

<template>
  <div id="simple-grid"></div>
</template>

<style lang="css">
@import url("gridstack/dist/gridstack.min.css");
.grid-stack-item-content {
  border: 2px solid #000;
  overflow: hidden !important;
}
</style>
