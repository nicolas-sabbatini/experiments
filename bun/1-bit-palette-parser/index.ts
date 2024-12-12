import { readdir } from "node:fs/promises";
import { serialize } from "bun:jsc";

if (process.argv.length !== 4) {
  console.error("Usage: bun index.ts <path> <output>");
  process.exit(1);
}
const dir = process.argv[2];

async function parse_palette(path: string, palette: any[]) {
  const palette_name = path.split(".")[0];
  const file = Bun.file(`${dir}/${path}`);
  const text = (await file.text()).split("\n");
  palette.push({
    name: palette_name,
    background: `#${text[0]}`,
    strock: `#${text[1]}`,
  });
  palette.push({
    name: `${palette_name}-negative`,
    background: `#${text[1]}`,
    strock: `#${text[0]}`,
  });
}

let files: string[];
try {
  files = await readdir(dir);
  let palette: any[] = [];
  for (const file of files) {
    await parse_palette(file, palette);
  }
  const output = process.argv[3];
  await Bun.write(output, Bun.inspect(palette));
} catch (error) {
  console.error(error);
}
