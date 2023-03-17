<script setup lang="ts">
const props = defineProps({
  isOpen: { type: Boolean, required: true }
})
</script>

<template>
  <div class="main-menu" :class="{ 'is-open': props.isOpen }">
    <div class="actions">
      <p class="actions__title">Actions:</p>
      <ul class="actions__menu">
        <li class="actions__menu-item">
          <button
            class="actions__button el-button el-button--primary"
            @click="() => $emit('restoreDefaults')"
          >
            Restore defaults
          </button>
        </li>
        <li class="actions__menu-item">
          <button class="actions__button el-button el-button--primary">Glitch positions</button>
        </li>
      </ul>
    </div>
  </div>
</template>

<style scoped lang="sass">
.main-menu
  position: fixed
  top: 0
  width: 100%
  height: 85px
  background-color: #444
  color: #fff
  padding: 10px 20px
  z-index: 1000
  transform: translateY(-100%)
  transition: transform 0.2s ease-out
  &.is-open
    transform: translateY(0)
  .actions
    &__title
      font-weight: bold
      -webkit-user-select: none
      -moz-user-select: none
      -ms-user-select: none
      user-select: none
    &__menu
      list-style-type: none
      padding-left: 0
      display: flex
    &__menu-item
      margin-right: 10px
    &__button
      width: 100%
</style>
