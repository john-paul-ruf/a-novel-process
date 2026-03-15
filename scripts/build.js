import fs from 'fs';
import path from 'path';
import { markdownToDocx, markdownToEpub } from 'auto-pandoc';
import { mdToPdf } from 'md-to-pdf';

const __dirname = path.dirname(new URL(import.meta.url).pathname);
const projectRoot = path.dirname(__dirname);

const packageJson = JSON.parse(fs.readFileSync(path.join(projectRoot, 'package.json'), 'utf-8'));
const TITLE = packageJson.name;
const AUTHOR = packageJson.author || 'AUTHOR_NAME';
const SLUG = packageJson.name.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');

const COVER = path.join(projectRoot, 'assets/cover.jpg');
const OUT_DIR = path.join(projectRoot, 'build');
const MD_OUT = path.join(OUT_DIR, `${SLUG}.md`);

function makeAnchor(text) {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9 ]/g, '')
    .replace(/ +/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

function extractTitle(dir) {
  const draft = path.join(projectRoot, 'chapters', dir, 'draft.md');
  if (!fs.existsSync(draft)) return '';

  const content = fs.readFileSync(draft, 'utf-8');
  const lines = content.split('\n');

  let label = '';
  let title = '';

  if (lines[0]?.startsWith('**') && lines[0]?.endsWith('**')) {
    label = lines[0].slice(2, -2);
  } else if (lines[0]?.startsWith('#')) {
    label = lines[0].replace(/^#+\s+/, '');
  }

  if (lines[2]?.startsWith('*') && lines[2]?.endsWith('*')) {
    title = lines[2].slice(1, -1);
  }

  return label && title ? `${label} — ${title}` : label;
}

function getPageBreak() {
  return `
\`\`\`{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
\`\`\`

\`\`\`{=latex}
\\newpage
\`\`\`

\`\`\`{=html}
<div style="page-break-before: always;"></div>
\`\`\`

`;
}

async function build() {
  fs.mkdirSync(OUT_DIR, { recursive: true });

  let mdContent = '';

  if (fs.existsSync(COVER)) {
    mdContent += `![${TITLE}](${COVER})\n\n`;
  }

  mdContent += `# ${TITLE}\n\n*${AUTHOR}*\n\n---\n\n`;

  const chaptersDir = path.join(projectRoot, 'chapters');
  const chapters = fs.readdirSync(chaptersDir)
    .filter(f => fs.statSync(path.join(chaptersDir, f)).isDirectory())
    .sort();

  const tocEntries = [];
  const pageBreak = getPageBreak();

  for (const dir of chapters) {
    if (dir === 'zz-about-the-author' || dir.startsWith('_cut-')) continue;

    const partFile = path.join(chaptersDir, dir, 'part.txt');
    if (fs.existsSync(partFile)) {
      const [partTitle, partSub] = fs.readFileSync(partFile, 'utf-8').trim().split('\n');
      const anchor = makeAnchor(partTitle);

      mdContent += pageBreak;
      mdContent += `---\n\n# ${partTitle} {#${anchor}}\n\n*${partSub}*\n\n---\n\n`;

      tocEntries.push('');
      tocEntries.push(`**[${partTitle}](#${anchor})**`);
    }

    const draft = path.join(chaptersDir, dir, 'draft.md');
    if (fs.existsSync(draft)) {
      mdContent += pageBreak;

      if (!dir.startsWith('00-')) {
        const entry = extractTitle(dir);
        if (entry) {
          const anchor = makeAnchor(entry);
          tocEntries.push(`- **[${entry}](#${anchor})**`);
          mdContent += `[]{#${anchor}}\n\n`;
        }
      }

      mdContent += fs.readFileSync(draft, 'utf-8') + '\n\n';
    }
  }

  const aboutAuthor = path.join(chaptersDir, 'zz-about-the-author', 'draft.md');
  if (fs.existsSync(aboutAuthor)) {
    mdContent += pageBreak;
    mdContent += fs.readFileSync(aboutAuthor, 'utf-8') + '\n\n';
  }

  let toc = '## Contents\n\n';
  for (const entry of tocEntries) {
    toc += entry + '\n';
    if (entry) toc += '\n';
  }
  toc += '---\n\n';

  const headerMatch = mdContent.match(/^(?:.*\n){0,6}/);
  const header = headerMatch ? headerMatch[0] : '';
  const body = mdContent.slice(header.length);

  mdContent = header + toc + body;

  fs.writeFileSync(MD_OUT, mdContent);

  const words = mdContent.split(/\s+/).length;
  console.log(`✓ Markdown built: ${MD_OUT} (${words} words)`);

  try {
    const docxOut = path.join(OUT_DIR, `${SLUG}.docx`);
    const result = await markdownToDocx(MD_OUT, docxOut);
    if (result.success) {
      console.log(`✓ Word built:     ${docxOut}`);
    } else {
      console.warn(`⚠ DOCX generation failed: ${result.error}`);
    }
  } catch (err) {
    console.warn(`⚠ DOCX generation failed: ${err.message}`);
  }

  try {
    const epubOut = path.join(OUT_DIR, `${SLUG}.epub`);
    let epubMd = mdContent;
    epubMd = epubMd.replace(/^!\[.*\]\(assets\/cover\.jpg\)$/gm, '');
    epubMd = epubMd.replace(/```{=openxml}[\s\S]*?```\n*/g, '');
    epubMd = epubMd.replace(/```{=latex}[\s\S]*?```\n*/g, '');
    epubMd = epubMd.replace(/^## Contents\n[\s\S]*?^---$/m, '');

    const epubFile = path.join(OUT_DIR, '.epub-temp.md');
    fs.writeFileSync(epubFile, epubMd);

    const result = await markdownToEpub(epubFile, epubOut);
    fs.unlinkSync(epubFile);
    
    if (result.success) {
      console.log(`✓ EPUB built:     ${epubOut}`);
    } else {
      console.warn(`⚠ EPUB generation failed: ${result.error}`);
    }
  } catch (err) {
    console.warn(`⚠ EPUB generation failed: ${err.message}`);
  }

  try {
    const pdfOut = path.join(OUT_DIR, `${SLUG}.pdf`);
    let pdfMd = mdContent;
    
    pdfMd = pdfMd.replace(/```{=openxml}[\s\S]*?```\n*```{=latex}[\s\S]*?```\n*```{=html}[\s\S]*?```\n*/g, '<div style="page-break-before: always;"></div>\n\n');
    
    pdfMd = pdfMd.replace(/^\[\]{#[^}]*}\n*/gm, '');
    pdfMd = pdfMd.replace(/^!\[.*\]\(assets\/cover\.jpg\)$/gm, '');
    pdfMd = pdfMd.replace(/^## Contents\n[\s\S]*?^---$/m, '');

    const pdf = await mdToPdf({ 
      content: pdfMd,
      stylesheet: ['https://fonts.googleapis.com/css2?family=Crimson+Text:ital@0;1&display=swap'],
      margin: { top: '1in', bottom: '1in', left: '1in', right: '1in' },
      pdf: { format: 'A4' }
    });
    fs.writeFileSync(pdfOut, pdf.content);
    
    console.log(`✓ PDF built:      ${pdfOut}`);
  } catch (err) {
    console.warn(`⚠ PDF generation failed: ${err.message}`);
  }
}

build().catch(err => {
  console.error('✗ Build failed:', err.message);
  process.exit(1);
});
