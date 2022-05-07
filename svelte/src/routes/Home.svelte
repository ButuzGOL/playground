<script lang="ts">
  import Button, { Label } from '@smui/button';
  import { Link } from "svelte-routing";
  import NewDialog from '../NewDialog.svelte';
  import { onMount } from 'svelte';
  import DataTable, { Head, Body, Row, Cell, SortValue } from '@smui/data-table';
  import LinearProgress from '@smui/linear-progress';
  import IconButton from '@smui/icon-button';
  import { data } from '../store';
  import { get } from 'svelte/store';

  type DataItem = {
    id: number;
    name: string;    
  };
  
  let items: DataItem[] = [];
  let loaded = false;
  let openFnRef = () => undefined;

  function load() {
      loaded = false;
 
      setTimeout(() => {
        // @ts-ignore
        items = get(data);
        loaded = true;
      }, 1000);
  }

  onMount(() => {
    load();
  });

function onOpenFn(fn) {
  openFnRef = fn;
}
function handleSort() {
  items.sort((a, b) => {
    const [aVal, bVal] = [a[sort], b[sort]][
      sortDirection === 'ascending' ? 'slice' : 'reverse'
    ]();
    if (typeof aVal === 'string' && typeof bVal === 'string') {
      return aVal.localeCompare(bVal);
    }
    return Number(aVal) - Number(bVal);
  });
  items = items;
}

let sort: keyof DataItem = 'id';
let sortDirection: Lowercase<keyof typeof SortValue> = 'ascending';
 
</script>


<Button on:click={() => (openFnRef())} variant="raised">
  <Label>New</Label>
</Button>
<DataTable
  sortable
  bind:sort
  bind:sortDirection
  on:SMUIDataTable:sorted={handleSort}
table$aria-label="Data list" style="width: 100%;">
  <Head>
    <Row>
      <Cell numeric columnId="id">
        <!-- For numeric columns, icon comes first. -->
        <IconButton class="material-icons">arrow_upward</IconButton>
        <Label>ID</Label>
      </Cell>
      <Cell style="width: 100%;">Name</Cell>
    </Row>
  </Head>
  <Body>
    {#each items as item (item.id)}
      <Row>
        <Cell numeric>{item.id}</Cell>
        <Cell><Link to={`/details/${item.id}`}>{item.name}</Link></Cell>
      </Row>
    {/each}
  </Body>
 
  <LinearProgress
    indete5rminate
    bind:closed={loaded}
    aria-label="Data is being loaded..."
    slot="progress"
  />
</DataTable>

<NewDialog onOpenFn={onOpenFn} onRefresh={load} />