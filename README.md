# DigIQ Monitor (Project CID) 📊

> **Interactive dashboard monitoring digital competence in the Netherlands across 11 key dimensions.**  
> 🌐 **Live Website:** [dashboard.dedigiq.nl](https://dashboard.dedigiq.nl) (or [digiqmonitor.nl](https://digiqmonitor.nl))

---

## 📌 About the Project

**Project CID** (Competency Insight Dashboard) is a national initiative to measure, track, and strengthen the digital competence of citizens in the Netherlands aged 10 to 100.

Building upon the validated **DigIQ** framework and its **DigIQ 2.0** extension, the monitor investigates three main pillars:
- ⚡ **Skills (*Vaardigheden*)**: Self-reported confidence across everyday digital tasks.
- 📖 **Knowledge (*Kennis*)**: Conceptual understanding of technologies and online environments.
- 📋 **Performance (*Prestaties*)**: Objective practical tasks testing actual digital abilities (e.g. recognizing phishing scams, identifying AI-generated media, safely configuring settings).

Data is collected across 6 waves between 2024 and 2027 by **Ipsos I&O** using mixed sampling (online panel + address-based postal sampling weighted against the MOA Golden Standard), funded by the **Ministry of the Interior and Kingdom Relations (BZK)**.

---

## 🚀 Quickstart: Running the Dashboard

The dashboard is generated with the R package [`dashboardr`](https://github.com/favstats/dashboardr) and rendered into static HTML with [Quarto](https://quarto.org/).

### Prerequisites

Ensure you have **R** (≥ 4.2) and **Quarto** installed. Then install the required R packages:

```r
install.packages(c("tidyverse", "remotes", "quarto", "readr", "dplyr", "stringr"))
remotes::install_github("favstats/dashboardr")
```

### Build the Full Website (Dutch & English)

To regenerate all pages and render the site:

```bash
Rscript run.R
```

Or open `digicomp.Rproj` in RStudio, open `run.R`, and run it interactively.

This pipeline will:
1. Run `dashboard.R` to generate Dutch Quarto pages into `qmds/`.
2. Render `qmds/` into the `docs/` folder (Dutch site).
3. Synchronize `dashboard_en.R` and generate English Quarto pages into `qmds_en/`.
4. Render `qmds_en/` into `docs/en/` (English site).

---

## 📁 Repository Structure

```text
├── dashboard.R              # Main dashboard generator script (Dutch)
├── dashboard_en.R           # English dashboard generator script
├── run.R                    # Master runner: builds and renders NL and EN sites
├── translations.csv         # Dictionary of UI and question translations
├── upload_translations.R    # Helper to sync local translations to Google Sheets
├── qmds/                    # Generated Quarto source files for Dutch site
├── qmds_en/                 # Generated Quarto source files for English site
├── docs/                    # Static website output deployed to GitHub Pages
│   └── en/                  # English site output
├── data/                    # Survey datasets (wave1.csv, wave2.csv, etc.)
├── scripts/                 # Data recoding and preparation scripts
├── img/                     # Active images, competence infobox graphics, and icons
├── logo.png                 # DigIQ Monitor logo
├── bzk.jpg                  # Ministry of BZK logo
├── PSCS1.jpg                # Modal graphic for the phishing performance task
├── archive/                 # Historical scripts, previous iterations, and early prototypes
└── README.md
```

---

## 🌐 Multilingual Support & Translations

Translations are managed collaboratively via a Google Sheet and mirrored locally in `translations.csv`:
- To update translations offline, edit `translations.csv` and run `upload_translations.R` to push changes back to the sheet.
- `dashboard.R` and `dashboard_en.R` can read directly from the published Google Sheet or local `translations.csv`.

---

## 👥 Research Team & Partners

- **Project Lead & Daily Management:** Dr. Annemarie van Oosten (University of Amsterdam)
- **Junior Researcher:** Roos Korderijnk, MSc. (University of Amsterdam)
- **Principal Investigator:** Prof. Dr. Jessica Taylor Piotrowski (University of Amsterdam)
- **Co-Investigators:** Dr. Dian A. de Vries (HU University of Applied Sciences), Prof. Dr. Claes H. de Vreese (University of Amsterdam)
- **Dashboard Development & Data Architecture:** Dr. Fabio Votta
- **Fieldwork & Sampling:** Ipsos I&O
- **Funding & Support:** Ministerie van Binnenlandse Zaken en Koninkrijksrelaties (BZK)

For more information on survey development and methodology, visit the [OSF repository](https://osf.io/d5c7n/).
