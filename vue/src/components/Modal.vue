<script setup lang="ts">
import { defineComponent, ref } from "vue";
import { FormInst, useMessage } from "naive-ui";

const props = defineProps({
  showModal: Boolean,
  onToggle: Function,
  onUpdateTable: Function,
});

function onUpdate(value: boolean) {
  props.onToggle!(value);
}

const formRef = ref<FormInst | null>(null);
const size = ref("medium");
const formValue = ref({
  user: {
    name: "",
    age: "",
  },
  phone: "",
});
const rules = {
  user: {
    name: {
      required: true,
      message: "Please input your name",
      trigger: "blur",
    },
    age: {
      required: true,
      message: "Please input your age",
      trigger: ["input", "blur"],
    },
  },
  phone: {
    required: true,
    message: "Please input your number",
    trigger: ["input"],
  },
};
function handleValidateClick(e: MouseEvent) {
  e.preventDefault();
  formRef.value?.validate((errors) => {
    if (!errors) {
      console.log("%cModal.vue line:46 formRef.value", "color: #007acc;", formValue.value);
      onUpdate(false);
      window.DATA = [
        { id: 1, title: "Wonderwall1", length: "4:18" },
        { id: 2, title: "Don't Look Back in Anger1", length: "4:48" },
        { id: 3, title: "Champagne Supernova2", length: "7:27" },
        { id: 4, title: "Champagne Supernova4", length: "7:27" },
      ];
      props.onUpdateTable();
    } else {
      console.log(errors);
      message.error("Invalid");
    }
  });
}
const message = useMessage();
</script>

<template>
  <n-modal @update:show="onUpdate" show="true" preset="card">
    <template #header-extra> </template>
    <div>
      <n-form ref="formRef" :label-width="80" :model="formValue" :rules="rules" :size="size">
        <n-form-item label="Name" path="user.name">
          <n-input v-model:value="formValue.user.name" placeholder="Input Name" />
        </n-form-item>
        <n-form-item label="Age" path="user.age">
          <n-input v-model:value="formValue.user.age" placeholder="Input Age" />
        </n-form-item>
        <n-form-item label="Phone" path="phone">
          <n-input v-model:value="formValue.phone" placeholder="Phone Number" />
        </n-form-item>
        <n-form-item>
          <n-button @click="handleValidateClick"> Validate </n-button>
        </n-form-item>
      </n-form>
    </div>
    <template #footer> Footer </template>
  </n-modal>
</template>
