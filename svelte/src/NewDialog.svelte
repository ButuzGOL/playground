<script lang="ts">
  import Dialog, { Header, Title, Content, Actions } from '@smui/dialog';
  import IconButton from '@smui/icon-button';
  import Button, { Label } from '@smui/button';
  import { onMount } from 'svelte';
  import Textfield from '@smui/textfield';
  import FormField from '@smui/form-field';
  import { data } from './store';
  
  export let onOpenFn;
  export let onRefresh;
  let open = false;
  let response = 'Nothing yet.';

  let value = '';
  let loading = true;

  function closeHandler(e: CustomEvent<{ action: string }>) {
    switch (e.detail.action) {
      case 'close':
        response = 'Closed without response.';
        break;
      case 'cancel':
        break;
      case 'submit':
        e.preventDefault()
        loading = true;
        setTimeout(() => {
          data.update(n => ([...n, { id: String(Math.random()), name: value }]));
          loading = false;
          value = '';
          onRefresh();
        }, 1000);
        break;
    }
  }

  onMount(() => {
    onOpenFn(() => {
      open = true;
    })
  })
</script>

<Dialog
  bind:open
  fullscreen
  aria-labelledby="fullscreen-title"
  aria-describedby="fullscreen-content"
  on:SMUIDialog:closed={closeHandler}
>
  <Header>
    <Title id="fullscreen-title">New</Title>
    <IconButton action="close" class="material-icons">close</IconButton>
  </Header>
  <Content id="fullscreen-content">
    <FormField>
      <Textfield
        variant="outlined"
        bind:value
        label="Name"
        required
      />
    </FormField>
  </Content>
  <Actions>
    <Button action="cancel">
      <Label>Cancel</Label>
    </Button>
    <Button action="submit" bond:loading defaultAction>
      <Label>Submit</Label>
    </Button>
  </Actions>
</Dialog>