import sharp from 'sharp';
import fs from 'fs';
import path from 'path';

const __dirname = path.dirname(new URL(import.meta.url).pathname);
const projectRoot = path.dirname(__dirname);

const packageJson = JSON.parse(fs.readFileSync(path.join(projectRoot, 'package.json'), 'utf-8'));
const TITLE = packageJson.name;
const AUTHOR = packageJson.author || 'Unknown Author';
const SLUG = packageJson.name.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');

const sourceImage = path.join(projectRoot, 'assets/cover-art.jpg');
const outputImage = path.join(projectRoot, 'assets/cover.jpg');

if (!fs.existsSync(sourceImage)) {
  console.warn(`⚠ No assets/cover-art.jpg found. Add cover art and re-run this script.`);
  process.exit(1);
}

try {
  await sharp(sourceImage)
    .resize(1600, 2384, { fit: 'fill' })
    .jpeg({ quality: 95 })
    .toFile(outputImage);

  console.log(`✓ Cover built: assets/cover.jpg`);
} catch (err) {
  console.error(`✗ Error building cover:`, err.message);
  process.exit(1);
}
