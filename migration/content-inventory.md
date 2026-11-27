# Content inventory — legacy site → new content model

Source: `wget --mirror` of http://quantum.phys.uni-sofia.bg (in `Сайт КЕ/quantum.phys.uni-sofia.bg/`, outside the repository).
Page-level mapping of all 224 HTML pages: [`inventory.csv`](inventory.csv) (columns: old path, title, language, encoding, text size, target, action, note).
Analysis date: 2026-11-27. Related: ARCHITECTURE.md §7 (content model), §10 (media), §17 phase 2.

## 1. Summary

| | Count | Size |
|---|---|---|
| Files | 668 | 606 MB |
| HTML pages | 224 (98 of them paper-abstract pages in `dreischuh/`) | 3 MB |
| PDF | 282 | 226 MB — 258 of them (194 MB) are paper PDFs on personal sites (`dreischuh/`, `saltiel/`) |
| Video | 24 files = 8 clips × (mp4, ogv, webm) | 374 MB; mp4 only: 131 MB; referenced clips, mp4 only: 104 MB |
| Images | 53 (gif, png, jpg) | 3 MB — mostly decoration; content images only in `fslab/` and `InMemoriam/` |
| Other | 7 `.thmx`, 1 `.ppt`, Word-export `*_files/*.xml` | — |

Actions over the 224 pages: **convert 100**, **decide 98** (paper abstracts, D3), **archive 9**, **pending 9** (video, D1), **drop 8** (frameset/navigation).

All 282 PDFs are referenced from some page; 38 internal links point to files missing from the mirror (§6).

## 2. Legacy structure → new structure

Legacy site: frameset (`index.html` = `bul/menu.html` + `bul/home.html`; English: `index-en.html` = `menu-en.html` + `homedept.html`). Menu: History · Staff · Curricula · Photonics and Laser Physics · Publications · Labs · Projects · Collaborations · Links · Archive.

| Legacy | BG | EN | New target | Action |
|---|---|---|---|---|
| Frameset, menus, home frames | ✓ | ✓ | `layouts/` (header, nav); address/e-mail → `contact.md` | drop |
| `bul/intro.html` / `intro.html` | ✓ | ✓ | `about/history.md` | convert |
| `bul/staff.html` / `staff.html` | ✓ | ✓ | `people/<slug>.md` (9 current) + `people/_index.md` (former staff, defended PhDs) | convert |
| `Programs/UPS-2.HTML` | ✓ | | `education/_index.md` | convert |
| `fotonika.html` | ✓ | | `education/photonics-laser-physics.md` (curriculum per year → tables linking course pages) | convert |
| `Programs/BS/*/UP-2.HTML` | ✓ | | `education/bachelor-physics-laser-block.md`, `education/bachelor-engineering-physics-qe-block.md` | convert |
| `Programs/MS/KELT-2.HTML`, `UPMKELT-2.HTML` | ✓ | | `education/master-quantum-electronics-laser-technology.md` | convert (merge) |
| `photonics/programs/*.html` (26), `Programs/MS/UPRG-2/*.HTML` (15) | ✓ | | `courses/<slug>.md` — 40 courses (§3) | convert |
| `courses-en.html` | | ✓ | `en/courses/_index.md` + minimal EN course pages | convert |
| `bul/publications.html` / `publicationsdept.html` | ✓ | ✓ | `research/publications.md` | convert |
| `bul/projects.html` / `projectsdept.html` | ✓ | ✓ | `research/projects.md` | convert |
| `bul/collaborators.html` / `collaborators.html` | ✓ | ✓ | `research/collaborations.md` | convert |
| `bul/researchlabs.html` / `researchlabs.html` | ✓ | ✓ | `research/_index.md` | convert |
| `fslab/` (index, team, projects; BG + EN) | ✓ | ✓ | `research/femtosecond-photonics.md` (one page per language) | convert |
| Lab „Нелинейна оптика и твърдотелни лазери“ | | | `research/nonlinear-optics-solid-state-lasers.md` — link to external `buchvarov.phys.uni-sofia.bg` | new |
| `ELI-BG/` (2007–08, 6 PDFs, 7.7 MB) | | ✓ | section in `research/projects.md` or archive (D5) | convert |
| `bul/links.html` / `links.html` | ✓ | ✓ | `about/links.md` (check external links) | convert |
| `bul/archive.html` / `archive.html` | ✓ | ✓ | `about/archive.md` | convert |
| `InMemoriam/` (Stamenov memorial, 18 condolence pages, memorial fund) | | ✓ | `about/in-memoriam-stamenov.md` (one page) | convert |
| `UFNO2009/` (conference 2009) | | ✓ | `news/2009-09-14-ufno-2009.md` or archive entry (D5) | archive |
| `Programs/MS/LFO/*` (programme 2003–2006) | ✓ | | archive entry (D5) | archive |
| `photonics/AV/` (8 clips) | ✓ | | multimedia section of the programme page (D1) | pending |
| `photonics/Lasers/` („Интересно“, 6 PDFs, 21.5 MB) | ✓ | | `education/lasers-reading.md` (check PDF rights, D3) | convert |
| `dreischuh/` (personal site, 99 pages, 123 PDFs, 144 MB) | | ✓ | `people/dreischuh.md` body (D3) | convert |
| `saltiel/` (personal site, 7 pages, 135 PDFs, 50 MB) | | ✓ | `people/saltiel.md`, `active: false` (D3) | convert |
| `lstoyanov/` (publication list) | | ✓ | `people/stoyanov.md` body | convert |

## 3. Courses (40)

Extracted from the syllabi (Хорариум, ECTS, Лектор). `*` = lecturer not in the current staff list (D4). ECTS is missing on MSc syllabi.

| Slug | Title (BG) | Level | Lecturer | Hours (L + S + P) | ECTS | Source |
|---|---|---|---|---|---|---|
| `high-resolution-atomic-molecular-spectroscopy` | Атомна и молекулна спектроскопия с висока разделителна способност | BSc | pashov* | 30 + 0 + 15 = 45 | 3,5 | `photonics/programs/amsvrs-H149.html` |
| `experimental-photonics` | Експериментална фотоника | BSc | stoyanov | 45 + 0 + 45 = 90 | 7,0 | `photonics/programs/ef-H014.html` |
| `photovoltaic-devices-systems` | Фотоволтаични устройства и системи | BSc | buchvarov | 45 + 15 + 0 = 60 | 4,0 | `photonics/programs/fvus.html` |
| `computer-modelling` | Компютърно моделиране | BSc | yordanova* | 15 + 0 + 30 = 45 | 4,0 | `photonics/programs/km-H152.html` |
| `computational-methods-optics` | Компютърни методи в оптиката | BSc | gaydardzhiev | 15 + 0 + 30 = 45 | 4,0 | `photonics/programs/kmo-H145.html` |
| `labview-experiment-control` | Увод в системата за управление на експеримента LabView | BSc | dimitrov | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/labview-H144.html` |
| `laser-physics-fundamentals` | Лазерна физика: основи | BSc | dreischuh | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/lf_o-H040.html` |
| `laser-physics-laser-sources` | Лазерна физика: Видове лазери | BSc | dreischuh | 30 + 0 + 45 = 75 | 7,0 | `photonics/programs/lf_vl-H039.html` |
| `laser-technique-1` | Лазерна техника 1 | BSc | stoyanov | 45 + 0 + 45 = 90 | 7,0 | `photonics/programs/lt1-H038.html` |
| `laser-technique-1` | Лазерна техника 1 | BSc | stoyanov | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/lt1_l-H038.html` |
| `laser-technique-1-lab` | Лазерна техника 1 - практикум | BSc | stoyanov | 0 + 0 + 45 = 45 | 4,5 | `photonics/programs/lt1_p-H038.html` |
| `matrix-optics` | Матрична оптика | BSc | gaydardzhiev | 30 + 0 + 0 = 30 | 2,0 | `photonics/programs/mo-H050.html` |
| `matrix-optics-lab` | Матрична оптика – лабораторен практикум | BSc | gorunski | 0 + 0 + 30 = 30 | 3,0 | `photonics/programs/mo_p-E344.html` |
| `acoustics-fundamentals` | Основи на акустиката | BSc | aleksieva* | 30 + 0 + 0 = 30 | 2,0 | `photonics/programs/oa-H147.html` |
| `optoelectronics-integrated-optics` | Оптоелектроника и интегрална оптика | BSc | zhekova | 60 + 0 + 30 = 90 | 6,5 | `photonics/programs/oeio-H076.html` |
| `nonlinear-optics-fundamentals` | Основи на нелинейната оптика | BSc | stoyanov | 60 + 0 + 0 = 60 | 4,5 | `photonics/programs/ono-H086.html` |
| `organic-optoelectronics` | Органична оптоелектроника | BSc | baluschev* | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/ooe-H148.html` |
| `optical-information-processing` | Оптична обработка на информация | BSc | buchvarov | 45 + 15 + 0 = 60 | 4,5 | `photonics/programs/ooi.html` |
| `optical-waves-linear-nonlinear-media` | Оптични вълни в линейни и нелинейни среди | BSc | dreischuh | 60 + 0 + 0 = 60 | 4,0 | `photonics/programs/ovlns-H073.html` |
| `lasers-in-medicine` | Приложение на лазерите в медицината | BSc | dimitrov | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/plm-H089.html` |
| `low-temperature-plasma-spectroscopy` | Спектроскопия на нискотемпературна плазма | BSc | yordanova* | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/sntp-H146.html` |
| `spectral-optical-instruments` | Спектрални оптични уреди | BSc | pashov* | 30 + 0 + 15 = 45 | 3,5 | `photonics/programs/sou-H096.html` |
| `technological-applications-lasers` | Технологични приложения на лазерите | BSc | gaydardzhiev | 30 + 0 + 30 = 60 | 4,0 | `photonics/programs/tpl-H109.html` |
| `introduction-optics-instruments-1` | Увод в оптиката и оптичните уреди – част 1 | BSc | gorunski | 30 + 0 + 0 = 30 | 2,0 | `photonics/programs/uoou1-H116.html` |
| `introduction-optics-instruments-2` | Увод в оптиката и оптичните уреди – част 2 | BSc | gorunski | 15 + 15 + 30 = 60 | 4,5 | `photonics/programs/uoou2-H117.html` |
| `laser-power-supplies` | Захранващи устройства за лазери | BSc | gorunski | 45 + 0 + 0 = 45 | 3,0 | `photonics/programs/zul-H150.html` |
| `diode-pumped-fiber-lasers` | Диодно напомвани и влакнести лазери | MSc | buchvarov | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/DNVL.HTML` |
| `high-intensity-optical-fields` | Физика на мощните оптични полета | MSc | dimitrov | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/FMOP.HTML` |
| `physical-fundamentals-laser-technologies` | Физични основи на лазерните технологии | MSc | gaydardzhiev | 45 + 15 + 0 = 60 | — | `Programs/MS/UPRG-2/FOLT.HTML` |
| `photonic-structures` | Фотонни структури | MSc | zhekova | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/FS.HTML` |
| `laser-beam-parameter-measurement` | Измерване на параметрите на лазерното лъчение | MSc | gaydardzhiev | 30 + 0 + 15 = 45 | — | `Programs/MS/UPRG-2/IPLL.HTML` |
| `laser-diagnostics-control` | Лазерни методи за диагностика и контрол | MSc | stoyanov | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/LMDK.HTML` |
| `laser-spectroscopy` | Лазерна спектроскопия | MSc | zhekova | 60 + 0 + 0 = 60 | — | `Programs/MS/UPRG-2/LS.HTML` |
| `laser-technique-2` | Лазерна техника ii част | MSc | stoyanov | 45 + 0 + 45 = 90 | — | `Programs/MS/UPRG-2/LT2.HTML` |
| `high-power-solid-state-lasers` | Мощни твърдотелни лазери | MSc | gorunski | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/MTTL.HTML` |
| `nonlinear-optical-waves-solitons` | Нелинейни оптични вълни и солитони | MSc | dreischuh | 60 + 15 + 0 = 75 | — | `Programs/MS/UPRG-2/NLOVS.HTML` |
| `optical-communication-networks` | Оптични комуникационни мрежи | MSc | gorunski | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/OKM.HTML` |
| `optical-parametric-devices` | Оптични параметрични устройства | MSc | gaydardzhiev | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/OPU.HTML` |
| `applied-nonlinear-optics` | Приложна нелинейна оптика | MSc | buchvarov | 60 + 15 + 0 = 75 | — | `Programs/MS/UPRG-2/PNO.HTML` |
| `polarization-optics` | Поляризационна оптика | MSc | gorunski | 45 + 0 + 0 = 45 | — | `Programs/MS/UPRG-2/PO.HTML` |
| `wave-quantum-optics` | Вълнова и квантова оптика | MSc | christov | 90 + 0 + 0 = 90 | — | `Programs/MS/UPRG-2/VKO.HTML` |

Notes:
- `lt1-H038` and `lt1_l-H038` are the same course (full vs lecture-only version) → one page `laser-technique-1`; the practicum is separate (`laser-technique-1-lab`).
- `ooi.html` and `fvus.html` are cp1251 and not linked from the programme page — check whether they are still taught.
- Syllabus sections present: Анотация, Предварителни изисквания, Програма, Литература (some: оценяване). Map to the course body as `##` headings; hours → new field `hours`, ECTS → `ects`.

## 4. People

Current staff (BG staff page, without commented-out entries; page dated 2025-12-24):

| Slug | Name | Position |
|---|---|---|
| `dreischuh` | Александър Драйшу | акад. проф. дфзн, ръководител |
| `buchvarov` | Иван Бъчваров | доц. д-р |
| `stoyanov` | Любомир Стоянов | доц. д-р |
| `gaydardzhiev` | Александър Гайдарджиев | гл. ас. д-р |
| `dimitrov` | Николай Димитров | гл. ас. д-р |
| `gorunski` | Наско Горунски | гл. ас. д-р |
| `zhekova` | Мая Жекова | гл. ас. д-р |
| `v-saltiel` | Веселина Салтиел | физик |
| — | Златко Колев | физик — appears in both current (commented out) and former lists |

Lecturers of department courses not on the staff list: Асен Пашов, Снежана Йорданова, Гергана Алексиева, Станислав Балушев, Иван Христов (former staff, fslab head) — D4.

Former staff: 29 names; defended PhDs: 47 names (lists only) — D2.

## 5. Encoding

Measured per file (126 scanned pages; the 98 abstract pages are uniform Word exports):

| Bytes are | Pages | Note |
|---|---|---|
| UTF-8 | 99 | 3 of them declare `windows-1251` in `<meta>` — wrong declaration |
| cp1251 | 20 | Cyrillic pages (InMemoriam, UFNO, old programmes, `ooi`, `fvus`, ELI-BG) |
| cp1252 | 7 | `saltiel/*`, `lstoyanov/` — French/German accents (Chériaux, Université, Frühjahrstagung) |

**A blanket `iconv -f cp1251` (ARCHITECTURE §17 phase 2) would corrupt the cp1252 pages** (é → й, ü → ь). Conversion rule for the migration script:
1. If the bytes decode as strict UTF-8 → UTF-8 (ignore `<meta charset>`).
2. Else if `<meta>` declares `windows-1252` → cp1252.
3. Else → cp1251.
4. Check: BG pages must be mostly Cyrillic; EN pages must contain no Cyrillic letters inside Latin words.

Source HTML: hand-written HTML 4, FrontPage and Word exports (`mso-*` styles, `*_files/` folders) — strip all styling, keep headings, lists, tables, links.

## 6. Data issues to verify (with the people concerned)

1. **Staff list**: commented-out entries in the source (Иван Стефанов, Стоян Куртев, Любомир Стоянов as гл. ас., Златко Колев); Стефанов and Куртев also appear under former staff. Confirm the current list and the head of department before publishing.
2. **Lecturers differ between EN and BG**:
   - Matrix optics: EN `courses-en.html` says Горунски, BG syllabus says Гайдарджиев (the practicum is Горунски's).
   - Polarization optics: EN says Димитров, BG MSc syllabus says Горунски.
   - Optical communications: EN says Бъчваров, BG MSc syllabus (Оптични комуникационни мрежи) says Горунски. These may be different courses.
   - Fourier optics and applications (EN, Бъчваров): no BG syllabus; possibly = Оптична обработка на информация.
3. **Missing from the mirror** (38 links, probably dead on the live site too): 16 pages of the 2003–2006 LFO programme (`Programs/MS/LFO/UPRG/*`), 8 UFNO 2009 sub-pages, 9 `.avi` animations in `dreischuh/`, 3 PDFs in `saltiel/`, 2 handouts in `Programs/Handouts/`, 1 ELI-BG PDF.
4. Contact data on the old home page: address бул. „Джеймс Баучер“ 5, 1164 София; fax; webmaster e-mail — confirm for `contact.md`.

## 7. Decisions needed

| # | Question | Options | Recommendation |
|---|---|---|---|
| D1 | Legacy video (8 clips, 374 MB in 3 formats) | YouTube channel (separate task) · archive on the faculty server (§16 #4) · mp4 in the repo (2 clips exceed 25 MB, need re-encoding) | Wait for the YouTube decision; keep only mp4 (all current browsers play it); 2 clips (`stoyan2`, `stoyan3`) are not linked anywhere |
| D2 | Former staff (29) and defended PhDs (47) | Lists in `people/_index.md` · one person file each (`active: false`) | Lists; person files only where there is content (Saltiel, Stamenov) |
| D3 | Personal sites and 258 paper PDFs (194 MB) | Re-host PDFs · link by DOI · keep the publication lists only | Publication lists with DOI links; do not re-host publisher PDFs (copyright). Keep only files the authors may share (talks, preprints). Needs agreement from Prof. Dreischuh and Assoc. Prof. Stoyanov; Saltiel = memorial page |
| D4 | Course lecturers outside the department | Person file for each · free-text field | Optional free-text field `external_lecturers` on courses (content model change, §7.2) |
| D5 | Archive material (UFNO 2009, LFO 2003–06, advertising PDFs, ELI-BG 2007–08) | Archive page with short entries + PDFs · drop | Archive page with one-line entries; keep PDFs < 3 MB |
| D6 | English coverage | Full translation · minimal EN pages | EN: history, people, labs, research, course list; EN course pages with front matter only (title, lecturers, hours, ECTS) until translated |

## 8. Migration order

1. Script `scripts/migrate/` (local only, not run in CI): decode per §5, strip Word/FrontPage markup, HTML → Markdown, write front matter.
2. People (after the staff check) → courses (40, generated from §3) → education pages → research → about.
3. Materials: the legacy site has almost no course materials (one PDF in `Programs/BS/MISC/`, handouts missing); lecturers upload them via Pages CMS (phase 3).
4. Images: `fslab/` and `InMemoriam/ks.jpg` → `assets/images/`; gif decorations dropped.
5. After each step: `hugo` build, `check-files.sh`, review on the staging preview.
