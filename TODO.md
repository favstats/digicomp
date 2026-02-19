# Dashboard TODO - February 2026 Updates

## Completed

- [x] **Fix AgeGroup bug**: Changed `15:30` to `16:30` in `dashboard.R` line 267 to avoid overlap with 10:15 group
- [x] **Add PSIS1RC to Strategic Info performance**: Added as first question/variable in `perf_sis_questions` / `perf_sis_vars` (lines 2036-2041)
- [x] **Add PGAIS1RC to GenAI performance**: Added as first question/variable in `perf_genai_questions` / `perf_genai_vars` (lines 2518-2523)
- [x] **Recode PSIS1RC from `PSIS1_codes`**: Added to `recode_survey()` — `1`=correct→1, `55`=incorrect→0, `66`=don't understand→NA
- [x] **Recode PGAIS1RC from `PGAIS1_codes`**: Added to `recode_survey()` — same coding as PSIS1RC
- [x] **PSCS1R recoding** (from Action Points PDF): `PSCS1N == 4` → 1 (correct), `5|6` → NA, else → 0. Already in `recode_survey()`.
- [x] **Expand Wave 1 demographics tables**: 10 full distribution tables using `create_content()` + `add_reactable()` (Age, Gender, Education, Migration, Panel, Devices x3, Literacy, Work, Work hours, Financial Insecurity)
- [x] **Fix correlation heatmap**: Spearman method, 19 variables (11 skill means + TotalKnowledge + TotalPerformance + 6 demographic dummies), lower-triangle display
- [x] **Fix `gen_ai_perf_infobox_image` placeholder**: Updated from `image_name` to `GenAI_competence_infobox_image.png` in `translations.csv` line 420
- [x] **Add "More Info" mention to landing page**: Added EN (line 204) and NL (line 222) text directing users to the More Info dropdown
- [x] **Translate demographics section headers**: All `### Header` strings now use `transl()` for NL/EN support (16 keys added to translations.csv)
- [x] **Translate demographics category labels**: Device scale, Literacy scale, Work status, Financial Insecurity scale, Panel type, Work hours summary all translated via `transl()` (29 keys added)
- [x] **Add modal placeholders for PSIS1RC and PGAIS1RC**: Modals added with placeholder image filenames
- [x] **Fix Gender demographics labels**: Changed from numeric keys to text keys matching actual data values ("Male"/"Female")
- [x] **Fix MigrationBackgroundN correlation dummy**: Was checking for "yes"/"no" but values are already translated; now uses `transl("label_yes/no", lang)`
- [x] **Fix Education demographics**: Uses already-translated `Education` column instead of `EducationR` with English-only labels
- [x] **Fix work hours summary table**: Separate `Statistic`/`Value` reactable instead of broken bar-chart format
- [x] **Fix `w1_styled_reactable` NA handling**: Added NA guard in Pct cell renderer
- [x] **Fix `w1_make_freq` type coercion**: `exclude_vals` now compares via `as.character()` to handle numeric/character mismatch
- [x] **Update blockquote texts**: `blockquote_performance_sis` and `blockquote_performance_genai` mention both Q1 and Q2
- [x] **Fix `transcational` typo**: Fixed to `transactional_competence_infobox_image` in `dashboard.R` line 2467

## Bug: dashboardr v0.5.0 `graph_title` validation

- [ ] **`add_viz` rejects length>1 vector as `title`**: `create_vizzes3` passes multi-element question vectors (e.g. `perf_sis_questions`, `perf_genai_questions`) as `graph_title` → `title`, but `add_viz.default` now requires `length(title) == 1`. Workaround: set `graph_title = ""` for affected calls. Fix should go in dashboardr (relax validation or collapse vector).

## Awaiting from Others

- [ ] **PSIS1RC modal image** (`PSIS1RC_infobox_image.png`): Placeholder in `translations.csv` (`strategic_info_perf_q1_infobox_image`). Replace with actual image from Annemarie once available.
- [ ] **PGAIS1RC modal image** (`PGAIS1RC_infobox_image.png`): Placeholder in `translations.csv` (`genai_perf_q1_infobox_image`). Replace with actual image from Annemarie once available.
- [ ] **Health/Green/Problem-Solving performance modal images**: Awaiting from Annemarie
- [ ] **Research team photos** on About page: Awaiting from Annemarie
- [ ] **Full Dutch bios** for research team in `translations.csv` (`about_page_text_v2` NL section): Currently abbreviated, awaiting full text from Annemarie
- [ ] **Wave 2 page content**: Awaiting from Annemarie (Action Points PDF item 2)

## Future Milestones

- [ ] **Shiny app alpha** (May): Add breakdown variables region and sample, custom age groups, more categories. Annemarie/Roos looking into CBS and MOA Golden Standard age brackets.
- [ ] **Report concept & shiny app demo** for government in May, final version before summer holiday
- [ ] **Cognitive interviews & usability testing** (Feb 23-26): 4 interviews (1 academic, 3 policy users). Insights may lead to Prolific survey in March.
- [ ] **Wave 3 data**: Meeting end of April about adding wave 3 data (incl changed performance items)

## To Verify (Run Build)

- [ ] Run `Rscript run.R` from `/Users/favstats/Dropbox/digicomp/digicomp/` and confirm:
  - [ ] NL build completes without errors
  - [ ] EN build completes without errors
  - [ ] Landing page mentions "More Info" / "Meer informatie"
  - [ ] Wave 1 page shows all 10 demographics tables with translated labels
  - [ ] Wave 1 correlation heatmap renders with 19 variables (Spearman)
  - [ ] Strategic Info performance page shows both PSIS1RC and PSIS2R bars
  - [ ] GenAI performance page shows both PGAIS1RC and PAIS1R bars
  - [ ] PSIS1RC and PGAIS1RC modals open (will show broken image until real images added)
  - [ ] AgeGroup fix (16:30) doesn't break existing dimension breakdowns

## Files Modified

| File | What changed |
|------|-------------|
| `dashboard.R` | AgeGroup fix, PSIS1RC/PGAIS1RC recoding from `_codes` columns in `recode_survey()`, PSIS1RC/PGAIS1RC in performance sections + modals, `graph_title` workaround for dashboardr bug, `transcational` typo fix, Wave 1 demographics + correlation heatmap, all translated |
| `translations.csv` | Fixed `gen_ai_perf_infobox_image`, added More Info landing page text, added 45+ new translation keys for Wave 1 page, added modal image placeholders |
