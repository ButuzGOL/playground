import { writable } from "svelte/store";

export const data = writable([
  {
    id: 1,
    name: "Name",
  },
  {
    id: 2,
    name: "Name2",
  },
]);
