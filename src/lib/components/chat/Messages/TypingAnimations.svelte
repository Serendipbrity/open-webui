<!------ This file creates the texting typing animation when loading Bodhi responses  ----------->
<script lang="ts">
	import { onMount, onDestroy } from 'svelte';

	export let size: 'sm' | 'md' | 'lg' = 'md';
	export let variant: 'dots' | 'wave' | 'pulse' | 'bars' = 'dots';
	export let color: string = 'rgb(156, 163, 175)'; // gray-400 default
	export let speed: number = 1.4;
	export let showContainer: boolean = true;

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	// Size configurations
	const sizes = {
		sm: { dot: 'w-1.5 h-1.5', container: 'px-3 py-2 gap-1', bar: 'w-0.5 h-3' },
		md: { dot: 'w-2 h-2', container: 'px-4 py-3 gap-1.5', bar: 'w-0.5 h-4' },
		lg: { dot: 'w-2.5 h-2.5', container: 'px-5 py-4 gap-2', bar: 'w-1 h-5' }
	};
</script>

{#if mounted}
	<div
		class="inline-flex items-center justify-center {showContainer
			? `bg-gray-100 dark:bg-gray-800 rounded-2xl ${sizes[size].container}`
			: sizes[size].container}"
		role="status"
		aria-label="Bodhi is typing"
	>
		{#if variant === 'dots'}
			<!-- Classic dots animation -->
			<div class="flex items-center gap-1">
				{#each [0, 1, 2] as i}
					<div
						class="rounded-full {sizes[size].dot} typing-dot"
						style="
							background-color: {color}; 
							animation-delay: {i * 0.15}s;
							animation-duration: {speed}s;
						"
					></div>
				{/each}
			</div>
		{/if}

		<span class="sr-only">Bodhi is typing...</span>
	</div>
{/if}

<style>
	.typing-animation-container {
		display: flex;
		align-items: center;
		height: 100%;
		width: 100%;
	}

	.typing-animation-container > div {
		display: flex;
		flex-direction: column;
		align-items: flex-start;
		max-width: 42rem; /* 672px */
		width: 100%;
	}

	.typing-animation-container > div > div {
		display: flex;
		justify-content: flex-start;
		margin-bottom: 1rem; /* 16px */
		width: 100%;
	}

	/* .typing-animation-container > div > div > .text-and-bubbles {
		display: flex;
		align-items: flex-end;
		gap: 0.5rem; /* 8px */
	/* }  */

	.typing-animation-container .bubble-title {
		width: 2rem; /* 32px */
		height: 2rem; /* 32px */
		border-radius: 9999px; /* Makes it circular */
		flex-shrink: 0;
		display: flex;
		align-items: flex-end;
		font-weight: 500;
		white-space: nowrap;
		margin-right: 0.5rem; /* 8px */
		align-self: flex-end;
	}

	/* .typing-animation-container .bubble-container {
		border-radius: 1rem;
		border-bottom-left-radius: 0.375rem; 
		background-color: rgb(243, 244, 246);
	} */

	@keyframes typing-dot {
		0%,
		60%,
		100% {
			opacity: 0.4;
			transform: scale(0.7);
		}
		30% {
			opacity: 1;
			transform: scale(1);
		}
	}

	@keyframes typing-bar {
		0%,
		100% {
			transform: scaleY(0.4);
			opacity: 0.4;
		}
		50% {
			transform: scaleY(1);
			opacity: 1;
		}
	}

	.typing-dot {
		animation: typing-dot 1.4s infinite ease-in-out;
	}

	.typing-bar {
		animation: typing-bar 1s infinite ease-in-out;
	}
</style>
