<script lang="ts">
	import { Router, Link, Route } from "svelte-routing";
  import Home from "./routes/Home.svelte";
  import Details from "./routes/Details.svelte";
	
	export let url = "";
</script>

<main>
	<Router url="{url}">
		<nav>
			<Link to="/">Home</Link>	
						
		</nav>
		<div>
			<Route path="details/:id" component="{Details}" />
			<Route path="/"><Home /></Route>
		</div>
	</Router>
	
</main>

<style>
	
</style>