// @ts-check
import { defineConfig } from 'astro/config';

import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  integrations: [sitemap()],
  site: "https://spotlight.gosim.org",
  i18n: {
    defaultLocale: "en",
    locales: ["en", "fr", "zh"],
    routing: {
      prefixDefaultLocale: false,
    },
  },
});
