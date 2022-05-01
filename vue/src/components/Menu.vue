<template>
<n-menu
  :collapsed="collapsed"
  :collapsed-width="64"
  :collapsed-icon-size="22"
  :options="menuOptions"
  :expand-icon="expandIcon"
/>
</template>

<script setup lang="ts">
import { RouterLink } from "vue-router";

import { h, ref, defineProps, onUpdated, Component } from "vue";
import type { MenuOption } from "naive-ui";
import { NIcon } from "naive-ui";
import { CaretDownOutline } from "@vicons/ionicons5";
import {
  BookOutline as BookIcon,
  PersonOutline as PersonIcon,
  WineOutline as WineIcon
} from '@vicons/ionicons5'

const props = defineProps({
  collapsed: Boolean,
})


onUpdated(() => {
console.log('%cMenu.vue line:28 collapsed', 'color: #007acc;', props.collapsed);

});

function expandIcon() {
  return h(NIcon, null, { default: () => h(CaretDownOutline) });
}

function renderIcon (icon: Component) {
  return () => h(NIcon, null, { default: () => h(icon) })
}

const menuOptions: MenuOption[] = [
  {
    key: "home",
    icon: renderIcon(BookIcon),
    label: () =>
      h(
        RouterLink,
        {
          to: {
            name: 'home',            
          }
        },
        { default: () => 'Home' }
      ),
  },
  {
    key: "about",
    icon: renderIcon(BookIcon),
    label: () =>
      h(
        RouterLink,
        {
          to: {
            name: 'about',            
          }
        },
        { default: () => 'About' }
      ),
  },  
];
</script>

<style scoped></style>
