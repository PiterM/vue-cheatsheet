<script setup lang="ts">
import { ref } from 'vue'
import MainMenu from '@/components/MainMenu/MainMenu.vue'
import GridStack from '@/components/GridStack/GridStack.vue'

const mainMenuActive = ref(false)

function toggleMainMenu() {
  mainMenuActive.value = !mainMenuActive.value
}
</script>

<template>
  <div class="canvas" @dblclick="() => toggleMainMenu()">
    <MainMenu :isOpen="mainMenuActive" />
    <GridStack msg="hello" />
  </div>
</template>
