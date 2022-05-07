<script>
  export let id;

  const item = window.DATA.find(item => String(item.id) === id);
</script>

<div>{item.id}</div>
<div>{item.name}</div>