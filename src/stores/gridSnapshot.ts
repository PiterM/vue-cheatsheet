import { ref } from 'vue'
import { defineStore } from 'pinia'
import gridDefaultSnapshot1 from '../assets/grid.snapshot.1.json'

export const useGridSnapshotStore = defineStore('gridSnapshot', () => {
  const gridDefaultSnapshot = ref<any>([])
  function getDefaultGridSnapshot() {
    return gridDefaultSnapshot.value
  }
  function setDefaultGridSnapshot(snapshot = gridDefaultSnapshot1) {
    gridDefaultSnapshot.value = snapshot
  }

  return {
    gridDefaultSnapshot,
    getDefaultGridSnapshot,
    setDefaultGridSnapshot
  }
})
