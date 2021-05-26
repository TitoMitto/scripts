import puppeteer from "https://deno.land/x/puppeteer@5.5.1/mod.ts";

const browser = await puppeteer.launch();
const page = await browser.newPage();
await page.goto("https://app.solutechlabs.com", {
  waitUntil: "networkidle2",
});
await page.pdf({ path: "hn.pdf", format: "a4" });

await browser.close();