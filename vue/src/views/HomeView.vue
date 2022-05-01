<script setup lang="ts">
import { h, ref, onMounted } from "vue";
import router from "../router";
import Modal from "../components/Modal.vue";
import { NButton, useMessage, DataTableColumns } from "naive-ui";

type Song = {
  no: number;
  title: string;
  length: string;
};

const createColumns = ({ play }: { play: (row: Song) => void }): DataTableColumns<Song> => {
  return [
    {
      title: "No",
      key: "no",
    },
    {
      title: "Title",
      key: "title",
    },
    {
      title: "Length",
      key: "length",
    },
    {
      title: "Action",
      key: "actions",
      render(row) {
        return h(
          NButton,
          {
            strong: true,
            tertiary: true,
            size: "small",
            onClick: () => play(row),
          },
          { default: () => "Play" }
        );
      },
    },
  ];
};

const loading = ref(true);

const data = ref(); //window.DATA;

const message = useMessage();

const showModal = ref(false);

function fetch() {
  loading.value = true;
  setTimeout(() => {
    data.value = (window as any).DATA;
    loading.value = false;
  }, 1000);
}

onMounted(() => {
  fetch();
});

const columns = createColumns({
  play(row: Song) {
    showModal.value = true;
  },
});

function onToggle(value: any) {
  showModal.value = value;
}

function onUpdateTable() {
  fetch();
}
</script>

<template>
  <main>
    <n-data-table :columns="columns" :data="data" :bordered="false" :loading="loading" />
    <h1 v-if="showModal">
      <Modal :showModal="showModal" :onToggle="onToggle" :onUpdateTable="onUpdateTable" />
    </h1>
  </main>
</template>
