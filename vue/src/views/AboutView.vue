<template>
  <n-button @click="onClick">Default</n-button>
  <n-gradient-text type="error"> {{ counter.counter }} </n-gradient-text>
</template>

<script setup lang="ts">
import { useCounterStore } from "../stores/counter";
const counter = useCounterStore();
function onClick() {
  counter.increment();
}
</script>

<style scoped></style>
