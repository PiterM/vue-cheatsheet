<script setup lang="ts">
import { ref } from 'vue'
import MainMenu from '@/components/MainMenu/MainMenu.vue'
import GridStack from '@/components/GridStack/GridStack.vue'
import gridSnapshot1 from '../assets/grid.snapshot.1.json'

const mainMenuActive = ref(false)
const restoredGridSnapshot = ref<any>([])

function toggleMainMenu() {
  mainMenuActive.value = !mainMenuActive.value
}

function restoreDefaults() {
  restoredGridSnapshot.value = gridSnapshot1
}
</script>

<template>
  <div class="canvas" @dblclick="() => toggleMainMenu()">
    <MainMenu :isOpen="mainMenuActive" @restore-defaults="() => restoreDefaults()" />
    <GridStack restoredGridSnapshot="restoredGridSnapshot" />
  </div>
</template>
