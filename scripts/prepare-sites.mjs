import { mkdir, writeFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";

const serverDirectory = fileURLToPath(new URL("../dist/server/", import.meta.url));
const serverEntry = fileURLToPath(new URL("../dist/server/index.js", import.meta.url));

const workerSource = `export default {
  async fetch(request, env) {
    const response = await env.ASSETS.fetch(request);
    if (response.status !== 404) return response;

    const url = new URL(request.url);
    if (!url.pathname.endsWith("/") && !url.pathname.split("/").pop().includes(".")) {
      url.pathname += "/";
      return Response.redirect(url.toString(), 301);
    }

    if (url.pathname.endsWith("/")) {
      url.pathname += "index.html";
      return env.ASSETS.fetch(new Request(url, request));
    }

    return response;
  }
};
`;

await mkdir(serverDirectory, { recursive: true });
await writeFile(serverEntry, workerSource, "utf8");
