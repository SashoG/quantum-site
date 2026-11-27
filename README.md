# quantum-site

Website of the Department of Quantum Electronics, Faculty of Physics, Sofia University —
https://quantum.phys.uni-sofia.bg

Static site: **Hugo** + **Pages CMS** + **GitHub Actions**, served as plain files by the faculty's Apache server.
Design decisions and the security model are in [ARCHITECTURE.md](ARCHITECTURE.md).

## Repository layout

| Path | Contents |
|---|---|
| `content/bg/`, `content/en/` | Pages (Markdown + YAML front matter). BG is served at `/`, EN at `/en/` |
| `layouts/` | Custom theme (Hugo templates) |
| `assets/css`, `assets/js` | Styles and front-end JS (minified + fingerprinted by Hugo) |
| `assets/images/` | Photos (jpg/png/webp only; resized by Hugo) |
| `static/materials/<person-slug>/` | Lecture materials (pdf, zip, docx, pptx, xlsx, mp4, webm, jpg, png; ≤ 25 MB) |
| `i18n/` | UI strings |
| `scripts/check-files.sh` | File policy check, run in CI before and after every build |
| `server/` | Reference vhost fragment and deploy script for the faculty sysadmin |

## Content model (front matter)

- **Person** `content/<lang>/people/<slug>.md` — `title`, `position`, `degree`, `photo`, `email`, `office`, `phone`,
  `research_interests`, `links.scholar`, `links.orcid`, `weight`, `active`.
  The file name (`<slug>`) is the key used by courses.
- **Course** `content/<lang>/courses/<slug>.md` — `title`, `lecturers` (person slugs), `external_lecturers` (free text),
  `level` (bachelor/master), `programme`, `course_type`, `semester`, `hours` (`lectures`, `seminars`, `labs`), `ects`,
  `assessment`, `materials` (`title`, `file`, `date`). EN course files: front matter only until translated.
  Note: `type` is reserved by Hugo (it selects the layout) — use `course_type`.
- **News** `content/<lang>/news/<yyyy-mm-dd>-<slug>.md` — `title`, `date`, `summary`, `image`.

Raw HTML inside Markdown is not rendered (`markup.goldmark.renderer.unsafe = false`).

## Local preview

Install the same Hugo version as CI (`HUGO_VERSION` in `.github/workflows/build.yml`, extended edition), then:

```sh
hugo server            # http://localhost:1313/
sh scripts/check-files.sh
```

## Build and deploy

Every push to `main`:

1. `scripts/check-files.sh` — fails the build on symlinks, server-side files, disallowed types, files > 25 MB.
2. `hugo --minify` — production build (`https://quantum.phys.uni-sofia.bg/`) and staging build (GitHub Pages URL).
3. Build output is checked again.
4. Staging preview → **GitHub Pages** (`noindex`, `robots.txt: Disallow: /`).
5. Production build → branch **`deploy`** (single commit, force-pushed). The faculty server pulls it with
   `server/server-pull.sh` from cron.

One-time GitHub settings: **Settings → Pages → Source: GitHub Actions**.

## Security rules for maintainers

- Never commit `.htaccess`, symlinks, server-side scripts, or HTML/SVG/JS under `static/` or `content/`.
- Third-party GitHub Actions are not used; first-party actions are pinned by commit SHA.
- 2FA is required for every account with write access.
