<script lang="ts">
	import Router from "./lib/PoorMansNav/PoorMansClientSideRouter.svelte";
	import Route from "./lib/PoorMansNav/PoorMansRoute.svelte";
	import Redirect from "./lib/Redirect.svelte";
	import Tysnd from "./lib/TYSND.svelte";

	async function getCatalogue() {
		const res = await fetch(`/data/catalogue.json`);
		const values = await res.json();

		return values;
	}

	let cataloguePromise = getCatalogue();
</script>

<main class="main">
	<div class="header"> 
		MORE UPDATES TO XKCD'S "THINGS YOU SHOULD NOT DO" LIST,<br/>
		SUGGESTED BY GPT-3 (INSPRIRED BY <a href="https://xkcd.com/what-if-2/">WHAT IF? 2</a>)
	</div>
	<div class="content">
		<Router>
			{#await cataloguePromise then catalogue}
				<Route path={"/"}>
					<Redirect path={`/part/${catalogue.latest}`} />
				</Route>
				<Route path={"/part/{part}"}>
					<Tysnd
						all_catalogue={catalogue.all}
						latestPart={catalogue.latest}
					/>
				</Route>
			{:catch error}
				{"Not ready yet! ;)"}
			{/await}
		</Router>
	</div>

	<div class="footer">
		Come back infrequently<a href="/part/7331">*</a> for updates :)
		<br />These lists are generated by GPT-3 and may not have been reviewed
		by a human - opinions are not my own.<br />
		View the
		<a href="https://github.com/zaidmukaddam/things-you-should-not-do"
			>source</a
		>. <br />
		Based on <a href={"https://xkcd.com/2669/"}>this comic</a> by XKCD.<br
		/>
		Maintained by
		<a href="https://za16.co">Zaid Mukaddam</a>.
		<br />
	</div>
</main>

<style>
	.main {
		display: flex;
		min-height: 100vh;
		flex-direction: column;
	}

	.header {
		margin-top: 20px;
		text-align: center;
	}

	.content {
		margin-top: 20px;
		flex: 1;
	}

	.footer {
		text-align: center;
		margin-bottom: 20px;
	}

	@font-face {
		font-family: "xkcd";
		src: url("/fonts/xkcd-script.ttf");
	}
</style>
