import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';

export default defineConfig({
	plugins: [
		sveltekit(),
		viteStaticCopy({
			targets: [
				{
					src: 'node_modules/onnxruntime-web/dist/*.jsep.*',
					dest: 'wasm'
				}
			]
		})
	],
	define: {
		APP_VERSION: JSON.stringify(process.env.npm_package_version),
		APP_BUILD_HASH: JSON.stringify(process.env.APP_BUILD_HASH || 'dev-build')
	},
	server: {
		proxy: {
			'/api': {
				target: 'http://localhost:8080',
				changeOrigin: true
			},
			'/v1': {
				target: 'http://localhost:8080',
				changeOrigin: true
			}
		}
	},
	build: {
		sourcemap: true
	},
	worker: {
		format: 'es'
	},
	esbuild: {
		pure: ['console.log', 'console.debug']
	}
});