import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";
import naive from "naive-ui";

const app = createApp(App);

app.use(createPinia());
app.use(router);
app.use(naive);

window.DATA = [
  { id: 1, title: 'Wonderwall', length: '4:18' },
  { id: 2, title: "Don't Look Back in Anger", length: '4:48' },
  { id: 3, title: 'Champagne Supernova', length: '7:27' }
];

app.mount("#app");
