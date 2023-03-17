import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import gridSnapshot1 from '../assets/grid.snapshot.1.json'

export const useGridSnapshotStore = defineStore('gridSnapshot', () => {
  const gridSnapshot = ref<any>([])
  function setSavedGridSnapshot() {
    gridSnapshot.value = gridSnapshot1
  }

  return { gridSnapshot, setSavedGridSnapshot }
})
