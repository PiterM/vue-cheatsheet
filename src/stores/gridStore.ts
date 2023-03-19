import { ref } from 'vue'
import { defineStore } from 'pinia'
import gridDefaultSnapshot1 from '../assets/grid.snapshot.1.json'
import gridDefaultSnapshot2 from '../assets/grid.snapshot.2.json'

export const useGridStore = defineStore('gridStore', () => {
  const gridDefaultSnapshot = ref<any>([])
  const currentSvgLayout = ref<String>('layout1')

  function getDefaultGridSnapshot() {
    return gridDefaultSnapshot.value
  }
  function setDefaultGridSnapshot() {
    const snapshot =
      currentSvgLayout.value === 'layout1' ? gridDefaultSnapshot1 : gridDefaultSnapshot2
    gridDefaultSnapshot.value = snapshot
  }
  function resetDefaultGridSnapshot() {
    gridDefaultSnapshot.value = []
  }

  function setCurrentSvgLayout(layout: String) {
    currentSvgLayout.value = layout
  }

  return {
    gridDefaultSnapshot,
    getDefaultGridSnapshot,
    setDefaultGridSnapshot,
    resetDefaultGridSnapshot,
    currentSvgLayout,
    setCurrentSvgLayout
  }
})
