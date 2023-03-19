<script setup lang="ts">
import { ref } from 'vue'
import MainMenu from '@/components/MainMenu/MainMenu.vue'
import GridStack from '@/components/GridStack/GridStack.vue'
import svgGridJson1 from '@/tex/source/1/svgs.json'
import svgGridJson2 from '@/tex/source/2/svgs.json'

const mainMenuActive = ref(false)
const currentSvgGridJson = ref(svgGridJson1)

function toggleMainMenu() {
  mainMenuActive.value = !mainMenuActive.value
}
</script>

<template>
  <div class="canvas" @dblclick="() => toggleMainMenu()">
    <MainMenu v-if="mainMenuActive" />
    <GridStack @hide-main-menu="toggleMainMenu" json="currentSvgGridJson" />
  </div>
</template>
