<script setup lang="ts">
import { ref } from "vue";
import { RouterView } from "vue-router";
import Menu from "@/components/Menu.vue";
import { useCounterStore } from "./stores/counter";

import { darkTheme } from "naive-ui";

const collapsed = ref(true);
const counter = useCounterStore();
</script>

<template>
  <n-config-provider :theme="darkTheme">
    <n-message-provider>
      <n-space vertical>
        <n-layout has-sider>
          <n-layout-sider
            bordered
            collapse-mode="width"
            :collapsed-width="64"
            :width="240"
            :collapsed="collapsed"
            show-trigger
            @collapse="collapsed = true"
            @expand="collapsed = false"
          >
            <Menu :collapsed="collapsed" />
          </n-layout-sider>
          <n-layout>
            {{ counter.counter }}
            <span>
              <RouterView />
            </span>
          </n-layout>
        </n-layout>
      </n-space>
    </n-message-provider>
  </n-config-provider>
</template>

<style>
@import "@/assets/base.css";
</style>
