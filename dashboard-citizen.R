# DIGITAL CITIZENSHIP INTERVENTIONS DASHBOARD (WP2) ============================
#
# Inventory of 151 digital citizenship interventions in the Kingdom of the
# Netherlands (WP2: Tulin, Eisele & Starke). Built with dashboardr and styled
# after the DigIQ Monitor (github.com/favstats/digicomp).
#
# Lives in the digicomp repo and publishes to dashboard.dedigiq.nl/citizenship
#
# Run from the repo root (the digicomp.Rproj folder):
#   source("dashboard-citizen.R")
# This builds the Dutch version into docs/citizenship/ and then the English
# version into docs/citizenship/en/ (same layout as the DigIQ Monitor's docs/
# and docs/en/). Set `lang <- "en"` (or "nl") and `build_both <- FALSE` before
# sourcing to build a single language.
#
# Inputs (paths relative to the repo root):
#   data/citizenship/WP2 full data_Dutch.csv   (git-ignored via the `data` rule)
#   citizenship_assets/navbar_fix.css, citizenship_assets/_extensions/
#   bzk.jpg                                    (shared with the DigIQ Monitor)
# Intermediate Quarto projects: qmds_citizen/ (NL) and qmds_citizen_en/ (EN).

options(encoding = "UTF-8")
library(tidyverse)
# readxl is only needed for an .xlsx data_file; loaded on demand below
library(dashboardr)
library(htmltools)

if (!exists("lang")) lang <- "nl"
if (!exists("build_both")) build_both <- TRUE

# 1. SETUP & CONFIGURATION =====================================================

# Same palette as the DigIQ Monitor
the_colors <- c("#3D7271", "#E28D50", "#F5D76E", "#C7E6D5", "#0F6B5A", "#BABACD")
main_color <- "#3D7271"

# Show the full interventions table (page "Interventies" + landing tile)?
# Defaults to TRUE; set `show_table <- FALSE` before sourcing to drop it.
if (!exists("show_table")) show_table <- TRUE

# Output locations (NL at docs/citizenship/, EN at docs/citizenship/en/) —
# mirrors digicomp's docs/ + docs/en/ layout, one level down
out_dir     <- if (lang == "nl") "qmds_citizen" else "qmds_citizen_en"
publish_dir <- if (lang == "nl") "../docs/citizenship" else "../docs/citizenship/en"
assets_dir  <- "citizenship_assets"

# Language toggle link (relative so the site works wherever it is hosted)
other_lang_href <- if (lang == "nl") "en/index.html" else "../index.html"
other_lang_flag <- if (lang == "nl") "circle-flags:uk" else "circle-flags:nl"

# WP2 data: the Dutch file Marina sent on 21 September 2026 — the dataset the
# final report "Grip op Digitaal Burgerschap" is based on (151 interventions).
data_file <- "data/citizenship/WP2 full data_Dutch.csv"

# 2. TRANSLATIONS ==============================================================
# Short labels live in `labels`, longer page texts in `texts`.
# tr("key") returns the string for the active language.

labels <- tribble(
  ~key,                     ~nl,                                   ~en,
  # navigation / pages
  "brand",                  "Digitaal Burgerschap",                "Digital Citizenship",
  "site_title",             "Interventies Digitaal Burgerschap",   "Digital Citizenship Interventions",
  "page_home",              "Welkom bij het Digitaal Burgerschap Dashboard", "Welcome to the Digital Citizenship Dashboard",
  "menu_findings",          "Bevindingen",                         "Findings",
  "page_target",            "Doelgroepen",                         "Target groups",
  "page_problems",          "Problemen",                           "Problems",
  "page_types",             "Vormen",                              "Formats",
  "page_competencies",      "Competenties",                        "Competencies",
  "page_initiators",        "Initiatiefnemers",                    "Initiators",
  "page_recommendations",   "Aanbevelingen",                       "Recommendations",
  "page_overview",          "Interventies",                        "Interventions",
  "menu_more_info",         "Meer info",                           "More info",
  # longer titles for the landing page tiles
  "card_target",            "Doelgroepen",                         "Target groups",
  "card_problems",          "Problemen & Uitkomsten",              "Problems & Outcomes",
  "card_types",             "Vormen & Levensdomeinen",             "Formats & Life Domains",
  "card_competencies",      "Competenties & Participatie",         "Competencies & Participation",
  "card_initiators",        "Initiatiefnemers & Reikwijdte",       "Initiators & Scope",
  "card_recommendations",   "Aanbevelingen",                       "Recommendations",
  "card_overview",          "Alle Interventies",                   "All Interventions",
  "page_about",             "Over",                                "About",
  # tabs
  "tab_overall",            "Algemeen",                            "Overall",
  "tab_primary",            "Primaire doelgroep",                  "Primary target group",
  "tab_secondary",          "Secundaire doelgroep",                "Secondary target group",
  "tab_by_target",          "Naar doelgroep",                      "By target group",
  "tab_by_initiator",       "Naar initiatiefnemer",                "By initiator",
  "tab_by_type",            "Naar type interventie",               "By intervention type",
  "tab_type_primary",       "Primair type",                        "Primary type",
  "tab_type_secondary",     "Secundair type",                      "Secondary type",
  "tab_problem_report",     "Aangepakte problemen",                "Problems addressed",
  "tab_problem_policy",     "Maatschappelijke vraagstukken",       "Policy questions",
  "tab_outcome_report",     "Verwachte uitkomsten",                "Expected outcomes",
  "tab_outcome_codes",      "Uitkomstcategorieën",                 "Outcome categories",
  "tab_initiator",          "Initiatiefnemers",                    "Initiators",
  "tab_scope",              "Regionale reikwijdte",                "Regional scope",
  "tab_runtime",            "Looptijd",                            "Runtime",
  "tab_knowledge",          "Kennis",                              "Knowledge",
  "tab_skills",             "Vaardigheden",                        "Skills",
  "tab_behavior",           "Gedrag",                              "Behaviour",
  "tab_active",             "Actieve participatie",                "Active participation",
  "tab_responsible",        "Verantwoorde participatie",           "Responsible participation",
  # headings
  "h_target",               "Wie worden er bereikt?",              "Who is targeted?",
  "h_inclusive",            "Inclusiviteit",                       "Inclusiveness",
  "h_problems",             "Welke problemen worden aangepakt?",   "Which problems are addressed?",
  "h_outcomes",             "Wat willen de interventies bereiken?", "What do interventions aim to achieve?",
  "h_types",                "Vorm van de interventies",            "Form of the interventions",
  "h_domains",              "Levensdomeinen en digitale contexten", "Life domains and digital contexts",
  "h_competencies",         "Kennis, vaardigheden en gedrag",      "Knowledge, skills and behaviour",
  "h_participation",        "Actieve en verantwoorde participatie", "Active and responsible participation",
  "h_initiators",           "Initiatiefnemers, reikwijdte en looptijd", "Initiators, scope and runtime",
  "h_scope",                "Reikwijdte en looptijd",              "Scope and runtime",
  # chart titles
  "c_target_primary",       "Primaire doelgroep van de interventies", "Primary target group of the interventions",
  "c_target_secondary",     "Secundaire doelgroep van de interventies", "Secondary target group of the interventions",
  "c_inclusive",            "Expliciete poging om ten minste één gemarginaliseerde groep te betrekken", "Explicit effort to include at least one marginalised group",
  "legend_inclusive",       "Expliciete poging om ten minste één gemarginaliseerde groep te betrekken?", "Explicit effort to include at least one marginalised group?",
  "legend_knowledge",       "Gericht op kennis?",                  "Targets knowledge?",
  "legend_skills",          "Gericht op vaardigheden?",            "Targets skills?",
  "legend_behavior",        "Gericht op gedragsverandering?",      "Targets behaviour change?",
  "legend_active",          "Stimuleert actieve participatie?",    "Encourages active participation?",
  "legend_responsible",     "Stimuleert verantwoorde participatie?", "Encourages responsible participation?",
  "legend_comp_overall",    "Is de interventie gericht op deze competentie?", "Does the intervention target this competency?",
  "legend_part_overall",    "Stimuleert de interventie deze vorm van participatie?", "Does the intervention encourage this form of participation?",
  "c_problem_report",       "Aangepakt probleem (inductieve codering, % van interventies)", "Problem addressed (inductive coding, % of interventions)",
  "c_problem_policy",       "Maatschappelijke vraagstukken (max. 3 per interventie)", "Policy questions addressed (max. 3 per intervention)",
  "c_outcome_report",       "Verwachte uitkomst (inductieve codering, % van interventies)", "Expected outcome (inductive coding, % of interventions)",
  "c_outcome_codes",        "Verwachte uitkomsten (max. 2 per interventie)", "Expected outcomes (max. 2 per intervention)",
  "c_type_primary",         "Soort interventie (primair)",         "Type of intervention (primary)",
  "c_type_secondary",       "Soort interventie (secundair)",       "Type of intervention (secondary)",
  "c_domains",              "Levensdomeinen (max. 3 per interventie)", "Life domains (max. 3 per intervention)",
  "c_competencies",         "Interventies gericht op kennis, vaardigheden en gedrag", "Interventions targeting knowledge, skills and behaviour",
  "c_participation",        "Interventies die actieve en verantwoorde participatie stimuleren", "Interventions encouraging active and responsible participation",
  "c_initiators",           "Initiatiefnemers",                    "Initiators",
  "c_scope",                "Regionale reikwijdte (primair)",      "Regional scope (primary)",
  "c_runtime",              "Looptijd van de interventies (% van interventies)", "Runtime of the interventions (% of interventions)",
  # value labels
  "yes",                    "Ja",                                  "Yes",
  "no",                     "Nee",                                 "No",
  "indirect",               "Indirect",                            "Indirect",
  "yes_direct",             "Ja (direct)",                         "Yes (direct)",
  "other_group",            "Overig",                              "Other",
  "n_interventions",        "Aantal interventies",                 "Number of interventions",
  "n_mentions",             "Aantal vermeldingen",                 "Number of mentions",
  "pct_interventions",      "% van interventies",                  "% of interventions",
  "var_knowledge",          "Kennis",                              "Knowledge",
  "var_skills",             "Vaardigheden",                        "Skills",
  "var_behavior",           "Gedrag",                              "Behaviour",
  "var_active",             "Actieve participatie",                "Active participation",
  "var_responsible",        "Verantwoorde participatie",           "Responsible participation",
  # value boxes
  "vb_n",                   "Geanalyseerde interventies",          "Interventions analysed",
  "vb_inclusive",           "Richt zich expliciet op gemarginaliseerde groepen", "Explicitly include marginalised groups",
  "vb_knowledge",           "Gericht op kennis",                   "Target knowledge",
  "vb_skills",              "Gericht op vaardigheden",             "Target skills",
  "vb_behavior",            "Gericht op gedragsverandering",       "Target behavioural change",
  "vb_responsible",         "Stimuleert verantwoorde participatie", "Encourage responsible participation",
  "vb_active",              "Stimuleert actieve participatie",     "Encourage active participation",
  "vb_public",              "Geïnitieerd door de publieke sector", "Initiated by the public sector",
  # table
  "col_title",              "Interventie",                         "Intervention",
  "col_target",             "Doelgroep",                           "Target group",
  "col_type",               "Soort",                               "Type",
  "col_initiator",          "Initiatiefnemer",                     "Initiator",
  "col_scope",              "Reikwijdte",                          "Scope",
  "col_inclusive",          "Inclusief",                           "Inclusive",
  "col_domain",             "Levensdomein",                        "Life domain",
  "source_report",          "Bron: eindrapport 'Grip op Digitaal Burgerschap' (inductieve codering van de probleem-, uitkomst- en looptijdbeschrijvingen).",
                            "Source: final report 'Grip op Digitaal Burgerschap' (inductive coding of the problem, outcome and runtime descriptions).",
  "footer",                 "© 2026 Digitaal Burgerschap Dashboard - ASCoR, Universiteit van Amsterdam",
                            "© 2026 Digital Citizenship Dashboard - ASCoR, University of Amsterdam"
)

tr <- function(key) {
  out <- labels[[lang]][labels$key == key]
  if (length(out) == 0) stop("Missing translation key: ", key)
  out
}

# 3. DATA ======================================================================

raw <- if (str_detect(data_file, "\\.csv$")) {
  read_delim(data_file, delim = ";", col_types = cols(.default = "c"),
             locale = locale(encoding = "windows-1252"), show_col_types = FALSE)
} else {
  readxl::read_excel(data_file, sheet = 1, col_types = "text")
}

# Short, stable column names (the original headers carry long coding notes)
col_map <- c(
  id = "ID", title = "Campaign title", url = "URL",
  relevance = "^Relevance", skills = "Skills\\?", knowledge = "Knowledge\\?",
  behavior = "Behaviors\\?", active = "Active participation", responsible = "Responsible participation",
  target1 = "^Target audience\\s*$", target2 = "^Target audience \\(secondary\\)",
  inclusive = "^Inclusiveness\\? \\(yes, no\\)", inclusive_long = "^Inclusiveness \\(long\\)",
  type1 = "^Intervention type \\(primary\\)", type2 = "^Intervention type \\(secondary\\)",
  initiator = "^Initiators \\(categories\\)", initiator_long = "^Initiators \\(long",
  outcome1 = "^Expected outcome 1", outcome2 = "^Expected outcome 2",
  scope1 = "^Regional scope \\(primary\\)", scope2 = "^Regional scope \\(secondary\\)",
  runtime = "^Runtime", problem1 = "^Social problem 1", problem2 = "^Social problem 2",
  problem3 = "^Social problem 3", domain1 = "^Domain 1", domain2 = "^Domain 2", domain3 = "^Domain 3"
)
col_idx <- map_int(col_map, ~ {
  hit <- which(str_detect(names(raw), .x))
  if (length(hit) == 0) stop("Column not found: ", .x)
  hit[1]
})
wp2 <- raw[, col_idx]
names(wp2) <- names(col_map)

# Keep the final sample: interventions coded as relevant (Relevance == 1)
wp2 <- wp2 %>%
  mutate(across(everything(), ~ str_squish(.x))) %>%
  filter(relevance == "1")

n_total <- nrow(wp2)

## 3.1 Recoding -----------------------------------------------------------------
# Target groups: "Children" + "Youth" merged; "All" + "Unspecified" merged into
# "General population" (as in the updated Dutch report).
target_map <- tribble(
  ~raw,                     ~nl,                          ~en,
  "Youth",                  "Kinderen/jongeren",          "Children & youth",
  "Children",               "Kinderen/jongeren",          "Children & youth",
  "All",                    "Algemene bevolking",         "General population",
  "Unspecified",            "Algemene bevolking",         "General population",
  "Entrepreneurs",          "Ondernemers",                "Entrepreneurs",
  "Elderly",                "Ouderen",                    "Elderly",
  "Low (digital) literacy", "Laag (digitaal) geletterd",  "Low (digital) literacy",
  "Digistarters",           "Laag (digitaal) geletterd",  "Low (digital) literacy",
  "Parents",                "Ouders",                     "Parents",
  "Teachers",               "Leraren",                    "Teachers",
  "Adults",                 "Volwassenen",                "Adults",
  "Civil servants",         "Ambtenaren",                 "Civil servants",
  "Employees",              "Werknemers",                 "Employees",
  "Low income",             "Laag inkomen",               "Low income",
  "Students",               "Studenten",                  "Students",
  "Interest Groups",        "Anders",                     "Other",
  "LGBTQ+",                 "LHBTIQ+",                    "LGBTQ+",
  "Ppl with disabilities",  "Mensen met een beperking",   "People with disabilities",
  # Dutch labels used in the Dutch WP2 file
  "Kinderen/ jongeren",     "Kinderen/jongeren",          "Children & youth",
  "Algemene bevolking",     "Algemene bevolking",         "General population",
  "Ondernemers",            "Ondernemers",                "Entrepreneurs",
  "Laag (digitaal) geletterd", "Laag (digitaal) geletterd", "Low (digital) literacy",
  "Ouderen",                "Ouderen",                    "Elderly",
  "Leraren",                "Leraren",                    "Teachers",
  "Ouders",                 "Ouders",                     "Parents",
  "Ambtenaren",             "Ambtenaren",                 "Civil servants",
  "Volwassene",             "Volwassenen",                "Adults",
  "Laag inkomen",           "Laag inkomen",               "Low income",
  "Werknemer",              "Werknemers",                 "Employees",
  "Anders",                 "Anders",                     "Other",
  "Studenten",              "Studenten",                  "Students"
)

type_map <- tribble(
  ~raw,                       ~nl,                          ~en,
  "Online resources",         "Online bronnen",             "Online resources",
  "Campaign",                 "Campagne",                   "Campaign",
  "Offline training",         "Offline training",           "Offline training",
  "Game",                     "(Serious) game",             "(Serious) game",
  "Online training",          "Online training",            "Online training",
  "(Offline) help desk",      "(Offline) helpdesk",         "(Offline) help desk",
  "Offline help desk",        "(Offline) helpdesk",         "(Offline) help desk",
  "Event/s",                  "Evenement(en)",              "Event(s)",
  "Offline resources",        "Offline bronnen",            "Offline resources",
  "Dialogue or co-creation",  "Dialoog of co-creatie",      "Dialogue or co-creation",
  "Digitale overheid",        "Digitale overheid",          "Digital government",
  "Research",                 "Onderzoek",                  "Research",
  "Individual",               "Individuele ondersteuning",  "Individual support",
  "Infrastructure",           "Infrastructuur",             "Infrastructure",
  "Solve concrete problem",   "Concreet probleem oplossen", "Solving a concrete problem",
  "Subsidy",                  "Subsidie",                   "Subsidy",
  # Dutch labels used in the Dutch WP2 file
  "Online bronnen",           "Online bronnen",             "Online resources",
  "Online hulpbronnen",       "Online bronnen",             "Online resources",
  "Campaigne",                "Campagne",                   "Campaign",
  "(Offline) helpdesk",       "(Offline) helpdesk",         "(Offline) help desk",
  "Offline bronnen",          "Offline bronnen",            "Offline resources",
  "Offline hulpbronnen",      "Offline bronnen",            "Offline resources",
  "Dialoog of co-creatie",    "Dialoog of co-creatie",      "Dialogue or co-creation",
  "Onderzoek",                "Onderzoek",                  "Research",
  "Individuele interventie",  "Individuele ondersteuning",  "Individual support",
  "Infrastructuur",           "Infrastructuur",             "Infrastructure",
  "Probleem oplossen",        "Concreet probleem oplossen", "Solving a concrete problem",
  "Concreet probleem oplossen", "Concreet probleem oplossen", "Solving a concrete problem",
  "Subsidie",                 "Subsidie",                   "Subsidy"
)

domain_map <- tribble(
  ~raw,                   ~nl,                          ~en,
  "Everyday digital use", "Dagelijks digitaal gebruik", "Everyday digital use",
  "Security",             "Online veiligheid",          "Online safety",
  "Critical thinking",    "Kritisch denken",            "Critical thinking",
  "Social",               "Sociale media & sociale relaties", "Social media & social relationships",
  "Education",            "Onderwijs",                  "Education",
  "Work",                 "Werk",                       "Work",
  "Health",               "Gezondheid",                 "Health",
  "AI",                   "AI",                         "AI",
  "News media",           "Nieuwsmedia",                "News media",
  "Digitale overheid",    "Digitale overheid",          "Digital government",
  "Entertainment",        "Entertainment",              "Entertainment",
  "Sustainability",       "Duurzaamheid",               "Sustainability",
  "Innovation and tech",  "Innovatie en technologie",   "Innovation and tech",
  "Searches",             "Online zoeken",              "Online searching",
  "Other",                "Anders",                     "Other",
  # Dutch labels used in the Dutch WP2 file
  "Dagelijks gebruik",    "Dagelijks digitaal gebruik", "Everyday digital use",
  "Online veiligheid",    "Online veiligheid",          "Online safety",
  "Kritisch denken",      "Kritisch denken",            "Critical thinking",
  "Sociale media & sociale relaties", "Sociale media & sociale relaties", "Social media & social relationships",
  "Onderwijs",            "Onderwijs",                  "Education",
  "Werk",                 "Werk",                       "Work",
  "Gezondheid",           "Gezondheid",                 "Health",
  "Nieuwsmedia",          "Nieuwsmedia",                "News media",
  "Duurzaamheid",         "Duurzaamheid",               "Sustainability",
  "Innovatie en tech",    "Innovatie en technologie",   "Innovation and tech",
  "Online zoeken",        "Online zoeken",              "Online searching",
  "Anders",               "Anders",                     "Other"
)

problem_map <- tribble(
  ~raw,                            ~nl,                                ~en,
  "Youth and digital citizenship", "Jongeren en digitaal burgerschap", "Youth and digital citizenship",
  "Prerequisites",                 "Randvoorwaarden",                  "Prerequisites",
  "Algorithms and social media",   "Algoritmes en sociale media",      "Algorithms and social media",
  "Digital rights",                "Digitale rechten",                 "Digital rights",
  "The role of generative AI",     "De rol van generatieve AI",        "The role of generative AI",
  "Other",                         "Anders",                           "Other"
)

simple_map <- tribble(
  ~raw,                             ~nl,                     ~en,
  "Public sector",                  "Publieke sector",       "Public sector",
  "Private sector",                 "Private sector",        "Private sector",
  "Both public and private sector", "Publiek-privaat",       "Public-private",
  "National",                       "Nationaal",             "National",
  "Regional",                       "Regionaal",             "Regional",
  "Online",                         "Online",                "Online",
  "European",                       "Europees",              "European",
  "Global",                         "Internationaal",        "International",
  "Digital competencies",           "Digitale competenties", "Digital competencies",
  "Security",                       "Veiligheid",            "Security",
  "Access",                         "Toegang",               "Access",
  "None",                           "Geen",                  "None",
  # Dutch labels used in the Dutch WP2 file
  "Nationaal",                      "Nationaal",             "National",
  "Regionaal",                      "Regionaal",             "Regional",
  "Europees",                       "Europees",              "European",
  "Globaal",                        "Internationaal",        "International"
)

recode_with <- function(x, map) {
  x <- str_remove(x, "\\s*\\(i\\.e\\..*$")   # "Online resources (i.e., ...)" -> "Online resources"
  out <- map[[lang]][match(x, map$raw)]
  unknown <- unique(x[!is.na(x) & is.na(out)])
  if (length(unknown)) warning("Unmapped values: ", paste(unknown, collapse = ", "))
  out
}

yes_no <- function(x) case_when(x == "1" ~ tr("yes"), x == "0" ~ tr("no"), TRUE ~ NA_character_)

wp2 <- wp2 %>%
  mutate(
    target1_lab    = recode_with(target1, target_map),
    target2_lab    = recode_with(target2, target_map),
    type1_lab      = recode_with(type1, type_map),
    type2_lab      = recode_with(type2, type_map),
    initiator_lab  = recode_with(initiator, simple_map),
    scope1_lab     = recode_with(scope1, simple_map),
    outcome1_lab   = recode_with(outcome1, simple_map),
    outcome2_lab   = recode_with(outcome2, simple_map),
    inclusive_lab  = yes_no(inclusive),
    knowledge_lab  = yes_no(knowledge),
    skills_lab     = yes_no(skills),
    active_lab     = yes_no(active),
    responsible_lab = yes_no(responsible),
    behavior_lab   = case_when(behavior == "0" ~ tr("no"),
                               behavior == "1" ~ tr("indirect"),
                               behavior == "2" ~ tr("yes"),   # directly targeted
                               TRUE ~ NA_character_)
  )

# Condensed grouping variables for cross-tabs (top categories + "Other")
top_or_other <- function(x, n = 5) {
  top <- names(sort(table(x), decreasing = TRUE))[seq_len(n)]
  out <- if_else(is.na(x), NA_character_, if_else(x %in% top, x, tr("other_group")))
  # add group sizes to the labels, e.g. "Ouderen (n=8)"
  counts <- table(out)
  if_else(is.na(out), NA_character_, paste0(out, " (n=", counts[out], ")"))
}
wp2 <- wp2 %>%
  mutate(
    target_group_short = top_or_other(target1_lab, 5),
    type_short         = top_or_other(type1_lab, 5),
    initiator_n        = top_or_other(initiator_lab, 3)
  )

order_by_freq <- function(x) {
  lv <- names(sort(table(x), decreasing = TRUE))
  is_other <- str_starts(lv, fixed(paste0(tr("other_group"), " (n=")))
  c(lv[!is_other], lv[is_other])
}
target_short_order <- order_by_freq(wp2$target_group_short)
type_short_order   <- order_by_freq(wp2$type_short)
initiator_order    <- order_by_freq(wp2$initiator_n)

## 3.2 Long data for multi-response codes ----------------------------------------
to_long <- function(df, vars, map) {
  df %>%
    select(id, all_of(vars)) %>%
    pivot_longer(-id, values_to = "raw_value") %>%
    filter(!is.na(raw_value), raw_value != "") %>%
    mutate(category = recode_with(raw_value, map)) %>%
    distinct(id, category)
}
domains_long  <- to_long(wp2, c("domain1", "domain2", "domain3"), domain_map)
problems_long <- to_long(wp2, c("problem1", "problem2", "problem3"), problem_map)
outcomes_long <- to_long(wp2, c("outcome1", "outcome2"), simple_map) %>%
  filter(category != recode_with("None", simple_map))

## 3.3 Figures that come from the report's inductive coding ----------------------
# (These categories were derived from the long-text descriptions and are not
# separate columns in the coding sheet, so they are taken from the report.)
problems_report <- tribble(
  ~nl,                                      ~en,                                        ~pct,
  "Cybercriminaliteit",                     "Cybercrime",                               36,
  "Veiligheid en welzijn van jongeren",     "Safety and wellbeing of youth",            21,
  "AI en digitale transformatie",           "AI and digital transformation",            14,
  "Digitale inclusie",                      "Digital inclusion",                        10,
  "Digitale geletterdheid",                 "Digital literacy",                         10,
  "Desinformatie, nieuws- en mediawijsheid", "Misinformation, news and media literacy", 6.4
) %>% transmute(category = .data[[lang]], pct)

outcomes_report <- tribble(
  ~nl,                                             ~en,                                          ~pct,
  "Meer online veiligheid",                        "Improved online security",                   34,
  "Digitale geletterdheid bevorderen",             "Promoting digital literacy",                 30,
  "Digitale veiligheid en gezondheid van jongeren", "Digital safety and health of youth",        21,
  "Toegang tot digitale apparaten en diensten",    "Access to digital devices and services",     8,
  "Verantwoorde digitalisering in organisaties",   "Responsible digitalisation in organisations", 4,
  "Bredere sociale risico's",                      "Broader social risks",                       2,
  "Geen concrete uitkomst vermeld",                "No concrete outcome stated",                 1
) %>% transmute(category = .data[[lang]], pct)

runtime_report <- tribble(
  ~nl,                                ~en,                                ~pct,
  "Geen looptijd gespecificeerd",     "No runtime specified",             58,
  "Terugkerend of doorlopend",        "Recurring or ongoing",             31,
  "Expliciete start- en einddatum",   "Explicit start and end date",      9,
  "Expliciet stopgezet",              "Explicitly discontinued",          1
) %>% transmute(category = .data[[lang]], pct)

## 3.4 Key figures (used in the text) --------------------------------------------
pct_of <- function(x, value) {
  x <- x[!is.na(x)]
  round(100 * mean(x == value))
}
n_coded <- sum(!is.na(wp2$knowledge))
# Reproduces the percentage the dashboardr bar labels display: dashboardr rounds to
# 1 decimal, then Highcharts rounds that to 0 decimals (.5 up). E.g. 13/79 = 16.46%
# -> 16.5 -> label "17%". Used where the text quotes numbers shown in a chart.
pct_half_up <- function(x, value) {
  x <- x[!is.na(x)]
  floor(round(100 * mean(x == value), 1) + 0.5)
}
k <- list(
  n          = n_total,
  youth      = pct_of(wp2$target1_lab, recode_with("Youth", target_map)),
  youth_n    = sum(wp2$target1_lab == recode_with("Youth", target_map), na.rm = TRUE),
  general    = pct_of(wp2$target1_lab, recode_with("All", target_map)),
  general_n  = sum(wp2$target1_lab == recode_with("All", target_map), na.rm = TRUE),
  entre      = pct_of(wp2$target1_lab, recode_with("Entrepreneurs", target_map)),
  elderly    = pct_of(wp2$target1_lab, recode_with("Elderly", target_map)),
  lowlit     = pct_of(wp2$target1_lab, recode_with("Low (digital) literacy", target_map)),
  sec_parents  = pct_half_up(wp2$target2_lab, recode_with("Parents", target_map)),   # same base and rounding as the secondary-target chart
  sec_teachers = pct_half_up(wp2$target2_lab, recode_with("Teachers", target_map)),  # (interventions with a secondary target group)
  inclusive  = pct_of(wp2$inclusive, "1"),
  knowledge  = pct_of(wp2$knowledge, "1"),
  skills     = pct_of(wp2$skills, "1"),
  behavior   = pct_of(wp2$behavior, "2"),
  behavior_ind = pct_of(wp2$behavior, "1"),
  active     = pct_of(wp2$active, "1"),
  responsible = pct_of(wp2$responsible, "1"),
  public     = pct_of(wp2$initiator_lab, recode_with("Public sector", simple_map)),
  ppp        = pct_of(wp2$initiator_lab, recode_with("Both public and private sector", simple_map)),
  private    = pct_of(wp2$initiator_lab, recode_with("Private sector", simple_map)),
  national   = pct_of(wp2$scope1_lab, recode_with("National", simple_map)),
  regional   = pct_of(wp2$scope1_lab, recode_with("Regional", simple_map)),
  online     = pct_of(wp2$scope1_lab, recode_with("Online", simple_map)),
  t_online   = pct_of(wp2$type1_lab, recode_with("Online resources", type_map)),
  t_campaign = pct_of(wp2$type1_lab, recode_with("Campaign", type_map)),
  t_offline  = pct_of(wp2$type1_lab, recode_with("Offline training", type_map)),
  t_onlinetr = pct_of(wp2$type1_lab, recode_with("Online training", type_map)),
  t_game     = pct_of(wp2$type1_lab, recode_with("Game", type_map)),
  t_game_n   = sum(wp2$type1_lab == recode_with("Game", type_map), na.rm = TRUE)
)
# Life domains: share of all domain mentions (as in the report)
dom_share <- domains_long %>% count(category) %>% mutate(p = round(100 * n / sum(n)))
dp <- function(raw_label) dom_share$p[dom_share$category == recode_with(raw_label, domain_map)]

# 4. PAGE TEXTS ================================================================

texts <- list(
  nl = list(
    landing = glue::glue(
      "Welkom bij het Digitaal Burgerschap Dashboard, met een overzicht van **{k$n} interventies** die burgers in het Koninkrijk der Nederlanden helpen om actief en verantwoord deel te nemen aan de digitale samenleving.

Dit dashboard presenteert de resultaten van **WP2: Inventarisatie van interventies op het gebied van digitaal burgerschap**. We brachten in kaart op wie deze interventies zich richten, welke problemen ze aanpakken, welke vorm ze hebben en in hoeverre ze kennis, vaardigheden en gedrag bevorderen.

Digitaal burgerschap definiëren we als *een aangeleerde set competenties (vaardigheden, kennis en gedrag) die burgers in staat stellen actief en verantwoord deel te nemen aan de digitale samenleving*."),
    landing_nav = "Klik hieronder op een thema (of gebruik het menu bovenaan) om de resultaten te bekijken. Voor achtergrondinformatie over de methode, zie **Meer info** rechtsboven.",
    target = glue::glue(
      "De interventies zijn ontworpen voor burgers in verschillende levensfasen en vaardigheidsniveaus, zoals kinderen, jongeren, ouderen en mensen met een laag niveau van (digitale) geletterdheid, en voor burgers in hun verschillende rollen in de samenleving, zoals ouders, leraren, werknemers, ambtenaren en ondernemers.

Het merendeel van de interventies, **{k$youth}%** ({k$youth_n} interventies), is gericht op kinderen en jongeren, en nog eens **{k$general}%** ({k$general_n}) op de algemene bevolking. Daarna volgen ondernemers en eigenaren van kleine tot middelgrote bedrijven ({k$entre}%), ouderen ({k$elderly}%) en mensen met een lage (digitale) geletterdheid ({k$lowlit}%). Ouders en leraren zijn ondervertegenwoordigd als primaire doelgroep, maar vormen de belangrijkste **secundaire** doelgroep ({k$sec_parents}% en {k$sec_teachers}% van de interventies met een secundaire doelgroep), vooral bij interventies die zich primair op kinderen of jongeren richten."),
    inclusive = glue::glue(
      "**{k$inclusive}%** van de interventies probeerde expliciet ten minste één gemarginaliseerde groep te betrekken. Dit gebeurde vooral via (1) leeftijdsgerichte ondersteuning, (2) taal- en vaardigheidstoegankelijkheid, zoals eenvoudige taal en meertalige materialen, (3) financiële en praktische toegankelijkheid, zoals gratis aanbod of hulp bij de aanschaf van apparaten, en (4) maatwerk voor specifieke kwetsbare groepen.

Inclusiviteit wordt vooral ingevuld via leeftijd, taal, digitale vaardigheden en betaalbaarheid. Structurele vormen van inclusie, zoals het *samen* ontwikkelen van interventies met gemarginaliseerde groepen, komen minder vaak voor."),
    inclusive_note = "Code omschrijving: *Heeft de interventie expliciet geprobeerd om ten minste één gemarginaliseerde groep te betrekken?*",
    problems = "De meeste interventies richten zich op **cybercriminaliteit** (36%): het verminderen van het risico op fraude, oplichting of identiteitsfraude, beschermende maatregelen tegen cyberaanvallen op mkb's, of weerbaarheidstrainingen voor kwetsbare groepen zoals ouderen. Veel van deze interventies worden geïnitieerd door het Centrum voor Criminaliteitspreventie en Veiligheid (CCV) of de politie.

Het tweede belangrijkste probleem betreft de **veiligheid en het welzijn van jongeren** (21%), zoals cyberpesten, online haat, schending van online seksuele grenzen, socialmediaverslaving en problematisch telefoongebruik. Daarna volgen **AI en digitale transformaties** (14%), **digitale inclusie** (10%), **digitale geletterdheid** (10%) en **desinformatie, nieuws- en mediawijsheid** (6,4%).",
    problems_policy = "Daarnaast codeerden we welke maatschappelijke vraagstukken uit het beleidskader Digitale Samenleving elke interventie aanspreekt (maximaal drie per interventie).",
    outcomes = "Over het algemeen is het doel van de interventies om burgers digitaal vaardiger en veiliger te maken, wat nauw aansluit bij de problemen die ze beogen aan te pakken. 34% verwacht **meer online veiligheid** door verminderde kwetsbaarheid voor cybercriminaliteit, fraude en phishing; 30% wil **digitale geletterdheid** bevorderen (basisvaardigheden, mediawijsheid, AI-geletterdheid); en 21% richt zich specifiek op de **digitale veiligheid en gezondheid van jongeren**. Interventies richten zich minder vaak op toegang tot digitale apparaten en diensten (8%), verantwoorde digitalisering binnen organisaties (4%) en bredere sociale risico's, zoals openbare-ordeverstoringen of verkeersveiligheid (2%). Bij 1% is geen concrete uitkomst vermeld.",
    types = glue::glue(
      "De meest voorkomende vorm waren **online bronnen** ({k$t_online}%), zoals informatie op een website, tips of educatieve video's. **Campagnes** gericht op begrip of bewustzijn kwamen ook veel voor ({k$t_campaign}%). **Offline trainingen** ({k$t_offline}%) en **online trainingen** ({k$t_onlinetr}%) verschillen hiervan doordat het pedagogische programma's zijn die via opeenvolgende modules concrete kennis, vaardigheden of gedrag trainen.

Opvallend is dat {k$t_game_n} interventies **serious games** waren ({k$t_game}%), zoals een cybersecurityspel waarin werknemers van een fictief mkb-bedrijf via interactieve video's moeten reageren op een ransomware-aanval."),
    domains = glue::glue(
      "De meeste interventies richten zich op algemeen **dagelijks digitaal gebruik** ({dp('Everyday digital use')}% van alle vermeldingen), gevolgd door veiligheid ({dp('Security')}%), kritisch denken ({dp('Critical thinking')}%), sociale media of sociale relaties ({dp('Social')}%) en onderwijs ({dp('Education')}%). Verrassend genoeg zijn **werk** ({dp('Work')}%), **gezondheid** ({dp('Health')}%) en **nieuwsmedia** ({dp('News media')}%) ondervertegenwoordigd.

*Dagelijks gebruik betekent bijvoorbeeld e-mailen, een account aanmaken op sociale media, een wachtwoord wijzigen of programma's voor online videobellen leren gebruiken.*"),
    competencies = glue::glue(
      "Omdat digitaal burgerschap bestaat uit kennis, vaardigheden en gedrag, codeerden we in hoeverre interventies zich op deze drie competenties richten. **{k$knowledge}%** richt zich op kennis, **{k$skills}%** op vaardigheden en slechts **{k$behavior}%** direct op gedrag.

Een interventie werd alleen als gericht op gedrag gecodeerd als er *direct* gedragsverandering plaatsvond als onderdeel van de interventie. Interventies die alleen informeerden over gedrag werden als *indirect* gecodeerd; dit gold voor {k$behavior_ind}% van de interventies. In de grafiek staat *Ja* bij gedrag dus voor *direct* gericht op gedragsverandering."),
    participation = glue::glue(
      "**Actieve participatie** werd gestimuleerd wanneer burgers via digitale media, tools of technologieën leren op een zinvolle manier deel te nemen aan belangrijke maatschappelijke domeinen zoals werk of digitale overheid. Dit gebeurde bij ongeveer de helft van de interventies ({k$active}%).

**Verantwoorde participatie** verwijst naar een ethisch gebruik van digitale media om schade aan zichzelf of anderen te beperken, bijvoorbeeld door te informeren over desinformatie, online etiquette of bescherming tegen cybercriminaliteit. Dit werd door de meerderheid van de interventies ({k$responsible}%) aangemoedigd."),
    initiators = glue::glue(
      "De **publieke sector** is het best vertegenwoordigd: {k$public}% van de interventies komt van overheidsinstanties, gemeenten, scholen, bibliotheken en vergelijkbare instellingen. {k$ppp}% is voortgekomen uit een **publiek-private samenwerking**, zoals programma's voor internetveiligheid van ministeries en internetproviders. Actoren uit de **private sector**, zoals zorgverleners, commerciële opleidingscentra of technologiebedrijven, initiëren {k$private}% van de interventies."),
    scope = glue::glue(
      "Het merendeel van de interventies is gericht op **nationaal** niveau ({k$national}%), vaak in combinatie met lokale implementatie. **Regionale** interventies ({k$regional}%) en **online** interventies ({k$online}%) komen ook veel voor.

Slechts 9% van de interventies gaf een expliciete start- en einddatum aan. De meeste interventies (58%) gaven geen looptijd aan, ook al blijven informatie en materialen online beschikbaar; 31% betreft terugkerende of doorlopende interventies, en 1% geeft expliciet aan dat de interventie is stopgezet."),
    recommendations_intro = glue::glue(
      "Het landschap van interventies op het gebied van digitaal burgerschap in het Koninkrijk der Nederlanden is **breed en divers**. Tegelijk laten de interventies zien waar de prioriteiten liggen: ze richten zich vooral op het **voorkomen van schade** en het vergroten van **kennis** over digitale risico's, met relatief minder aandacht voor democratische participatie, vaardigheden en gedrag. De ideale digitale burger wordt grotendeels neergezet als een verantwoordelijke en weerbare gebruiker, terwijl een bredere opvatting van digitaal burgerschap ook actieve participatie en empowerment benadrukt."),
    rec1_title = "Aanbeveling 1: Maak digitale inclusie een structureel uitgangspunt",
    rec1 = glue::glue(
      "Slechts {k$inclusive}% van de interventies stemt de aanpak expliciet af op ten minste één gemarginaliseerde groep. Ontwikkel interventies standaard met aandacht voor de behoeften van gemarginaliseerde groepen: toegankelijke en passende ondersteuning en waar nodig maatwerk, bijvoorbeeld voor mensen met beperkte digitale of taalvaardigheden, een beperking, een laag inkomen of beperkte mobiliteit. Betrek deze groepen bovendien actief bij het ontwerp en de uitvoering."),
    rec2_title = "Aanbeveling 2: Combineer kennisoverdracht met gedragsverandering",
    rec2 = glue::glue(
      "{k$knowledge}% van de interventies richt zich op kennis, maar slechts {k$skills}% op vaardigheden en {k$behavior}% op gedragsverandering. Kennis vormt een noodzakelijke basis, maar krijgt pas waarde wanneer mensen deze kunnen vertalen naar concreet digitaal handelen. Koppel kennis en bewustwording daarom systematisch aan praktische vaardigheidstraining en ondersteuning bij het toepassen van die vaardigheden in uiteenlopende situaties."),
    rec3_title = "Aanbeveling 3: Richt interventies nadrukkelijker op onderbelichte levensdomeinen en actieve participatie",
    rec3 = glue::glue(
      "Werk ({dp('Work')}%), gezondheid ({dp('Health')}%) en nieuwsmedia ({dp('News media')}%) zijn ondervertegenwoordigd, en slechts {k$active}% van de interventies bevordert actieve participatie. Breid interventies uit naar deze domeinen en geef prioriteit aan mediawijsheid, zodat mensen mis- en desinformatie, nepdeskundigen, gemanipuleerde inhoud en misleidende advertenties beter kunnen herkennen. Besteed daarnaast meer aandacht aan het gebruik van digitale middelen om geïnformeerd mee te praten over publieke vraagstukken."),
    justice = "Veel interventies geven prioriteit aan enkele van de meest kwetsbare groepen: kinderen en jongeren, ouderen en mensen met een lage geletterdheid. Bovendien richt 10% van de interventies zich expliciet op de digitale kloof en digitale toegang. In een land waar 99% van de huishoudens een internetverbinding heeft, richten zulke interventies zich op een relatief kleine groep, maar zijn ze hoogst noodzakelijk voor wie anders buitengesloten wordt.",
    overview = "Hieronder vindt u alle interventies uit de inventarisatie. Gebruik het zoekveld of de keuzelijsten per kolom (meerdere categorieën tegelijk mogelijk) om interventies te vinden, en klik op de naam om de website van de interventie te openen.",
    about = glue::glue(
      "### Doel van het onderzoek

De doelstellingen van WP2 waren (1) een overzicht geven van de huidige interventies met betrekking tot digitaal burgerschap in het Koninkrijk der Nederlanden, (2) te verduidelijken hoe deze interventies zich verhouden tot de expertperspectieven in WP1, en (3) onbenut potentieel voor de versterking van digitaal burgerschap te identificeren.

### Selectie van interventies

Interventies moesten zich richten op burgers en digitale competenties of randvoorwaarden voor deelname aan de digitale samenleving bieden, en worden uitgevoerd in (of duidelijk gericht zijn op burgers van) het Koninkrijk der Nederlanden. We raadpleegden overheidswebsites (www.digitaleoverheid.nl), het Ministerie van Binnenlandse Zaken en Koninkrijksrelaties, websites van relevante organisaties en netwerken (bijv. Netwerk Mediawijsheid) en experts op het gebied van digitaal burgerschap.

Deze zoektocht leverde een eerste steekproef van 177 interventies op. Interventies werden uitgesloten als ze zich buiten Nederland bevonden, de website ontoegankelijk was, of als ze niet over digitale participatie gingen, gericht waren op organisaties zonder directe focus op individuen, of een netwerk, onderzoeksproject, database, infrastructuur of subsidie betroffen. (Bijna) identieke interventies die onder een andere naam in meerdere gemeenten zijn uitgerold, zoals inloopspreekuren in buurthuizen of bibliotheken, zijn samengenomen.

### Codering

De uiteindelijke steekproef van {k$n} interventies werd geanalyseerd door drie getrainde codeerders volgens een deductief-inductieve aanpak. Het codeboek was gebaseerd op de definitie van digitaal burgerschap (kennis, vaardigheden, gedrag, actieve en verantwoorde participatie), beschrijvende informatie (type interventie, initiatiefnemer, looptijd) en beleidsrelevante informatie (sociaal probleem, inclusiviteit, verwachte uitkomst), vastgesteld in overleg met het Ministerie van Binnenlandse Zaken. Na een test op een sub-steekproef werd het codeboek verfijnd en uitgebreid. Doelgroepen werden gecodeerd op basis van wie expliciet als doelgroep werd genoemd; zonder expliciete doelgroep werd een interventie gecodeerd als gericht op de algemene bevolking.

### Over de cijfers

De grafieken in dit dashboard zijn rechtstreeks berekend uit het coderingsbestand. Percentages zijn berekend over de gecodeerde interventies. In de doelgroepcodering zijn *kinderen* en *jongeren* samengevoegd tot één categorie, en *alle burgers* en *niet gespecificeerd* tot *algemene bevolking*. De categorieën voor aangepakte problemen, verwachte uitkomsten (inductief) en looptijd komen uit het eindrapport *Grip op Digitaal Burgerschap*.

### Onderzoeksteam

**Marina Tulin**, **Olga Eisele**, **Alain Starke**, **Ernesto de León**, **Christian Burgers** en **Jessica Piotrowski**, Amsterdam School of Communication Research (ASCoR), Universiteit van Amsterdam.")
  ),
  en = list(
    landing = glue::glue(
      "Welcome to the Digital Citizenship Dashboard, presenting an overview of **{k$n} interventions** that help citizens in the Kingdom of the Netherlands participate actively and responsibly in the digital society.

This dashboard presents the results of **WP2: Inventory of Digital Citizenship Interventions**. We mapped whom these interventions target, which problems they address, what form they take, and to what extent they foster knowledge, skills and behaviour.

We define digital citizenship as *a learned set of competencies (skills, knowledge and behaviours) that enable citizens to participate actively and responsibly in the digital society*."),
    landing_nav = "Click a theme below (or use the menu at the top) to explore the results. For background information on the method, see the **More info** menu in the top right.",
    target = glue::glue(
      "The interventions were created for citizens at various life stages and levels of ability, such as children, youth, elderly and those with low levels of (digital) literacy, and for citizens in their various roles in society, such as parents, teachers, employees, civil servants and entrepreneurs.

Most interventions, **{k$youth}%** ({k$youth_n} interventions), target children and youth, and another **{k$general}%** ({k$general_n}) target the general population. They are followed by entrepreneurs and small to medium-sized business owners ({k$entre}%), the elderly ({k$elderly}%) and those with low (digital) literacy ({k$lowlit}%). Parents and teachers are underrepresented as the primary target group, but they are the most prominent **secondary** target group ({k$sec_parents}% and {k$sec_teachers}% of interventions with a secondary target group), especially for interventions that primarily target children or youth."),
    inclusive = glue::glue(
      "**{k$inclusive}%** of the interventions made an explicit effort to include at least one marginalised group. This mostly happened through (1) age-specific support, (2) language and skills accessibility, such as plain language and multilingual materials, (3) financial and practical accessibility, such as free offers or help with acquiring devices, and (4) tailored approaches for specific vulnerable groups.

Inclusiveness is mainly realised through age, language, digital skills and affordability. Structural forms of inclusion, such as *co-developing* interventions with marginalised groups, are less common."),
    inclusive_note = "Code description: *Did the intervention make an explicit effort to include at least one marginalised group?*",
    problems = "The majority of interventions address the problem of **cybercrime** (36%): reducing the risk of fraud, scams or impersonation, promoting protective measures against cyberattacks targeting SMEs, or resilience trainings for vulnerable groups such as seniors. Many of these interventions are initiated by the Centre for Crime Prevention and Safety (CCV) or the police.

The second most important problem concerns the **safety and wellbeing of youth** (21%), such as cyberbullying, online hate, violations of online sexual boundaries, social media addiction and problematic phone use. These are followed by **AI and digital transformation** (14%), **digital inclusion** (10%), **digital literacy** (10%) and **misinformation, news and media literacy** (6.4%).",
    problems_policy = "In addition, we coded which policy questions from the Digital Society policy framework each intervention addresses (up to three per intervention).",
    outcomes = "Overall, the interventions largely expect to make citizens more digitally skilled and secure, which closely corresponds to the problems they seek to address. 34% expect **improved online security** via reduced vulnerability to cybercrime, fraud and phishing; 30% aim to **promote digital literacy** (basic skills, media literacy, AI literacy); and 21% specifically target the **digital safety and health of youth**. Fewer interventions focus on access to digital devices and services (8%), responsible digitalisation within organisations (4%) and broader social risks such as public disorder or road safety (2%). For 1%, no concrete outcome is stated.",
    types = glue::glue(
      "The most common form was **online resources** ({k$t_online}%), such as information on a website, tips or educational videos. **Campaigns** targeting understanding or awareness were also common ({k$t_campaign}%). **Offline trainings** ({k$t_offline}%) and **online trainings** ({k$t_onlinetr}%) differ from these because they are pedagogical programmes that train concrete knowledge, skills or behaviours via consecutive modules.

Notably, {k$t_game_n} interventions were **serious games** ({k$t_game}%), such as a cybersecurity game in which employees of a fictional SME respond to a ransomware attack via interactive videos."),
    domains = glue::glue(
      "Most interventions address general **everyday digital use** ({dp('Everyday digital use')}% of all mentions), followed by security ({dp('Security')}%), critical thinking ({dp('Critical thinking')}%), social media or social relationships ({dp('Social')}%) and education ({dp('Education')}%). Surprisingly, **work** ({dp('Work')}%), **health** ({dp('Health')}%) and **news media** ({dp('News media')}%) are poorly represented.

*Everyday use means, for example, emailing, creating a social media account, changing a password or learning to use online video calling.*"),
    competencies = glue::glue(
      "Because digital citizenship comprises knowledge, skills and behaviour, we coded to what extent interventions targeted these three competencies. **{k$knowledge}%** targeted knowledge, **{k$skills}%** targeted skills and only **{k$behavior}%** directly targeted behaviour.

An intervention was coded as targeting behaviour only if behavioural change was *directly* implemented as part of the intervention. Interventions that merely informed about behaviour were coded as *indirect*; this was the case for {k$behavior_ind}% of the interventions. In the chart, *Yes* for behaviour therefore means *directly* targeting behavioural change."),
    participation = glue::glue(
      "**Active participation** was stimulated when citizens learn to meaningfully engage in key life domains such as work or digital government via digital media, tools or technologies. This was encouraged by about half of the interventions ({k$active}%).

**Responsible participation** refers to an ethical use of digital media that reduces harm to oneself or others, for example by informing citizens about false information, online etiquette or protection against cybercrime. This was encouraged by the majority of interventions ({k$responsible}%)."),
    initiators = glue::glue(
      "The **public sector** is best represented: {k$public}% of interventions come from government agencies, municipalities, schools, libraries and similar institutions. {k$ppp}% emerged from a **public-private collaboration**, such as internet safety programmes by ministries and internet providers. **Private sector** actors, such as health care providers, commercial training centres or tech companies, initiate {k$private}% of the interventions."),
    scope = glue::glue(
      "The majority of interventions is intended for the **national** level ({k$national}%), often combined with local implementation. **Regional** ({k$regional}%) and **online** interventions ({k$online}%) are common as well.

Only 9% of interventions specified an explicit start and end date. Most interventions (58%) did not specify a runtime, even though information and materials remain available online; 31% are recurring or ongoing interventions, and 1% explicitly state that the intervention has been discontinued."),
    recommendations_intro = glue::glue(
      "The landscape of digital citizenship interventions in the Kingdom of the Netherlands is **broad and diverse**. At the same time, the interventions reveal clear priorities: they focus primarily on **avoiding harm** and building **knowledge** about digital risks, with comparatively less attention to democratic participation, skills and behaviour. The digital citizen is largely portrayed as a responsible and resilient user, whereas a broader understanding of digital citizenship would also emphasise active participation and empowerment."),
    rec1_title = "Recommendation 1: Make digital inclusion a structural starting point",
    rec1 = glue::glue(
      "Only {k$inclusive}% of interventions explicitly tailor their approach to at least one marginalised group. Design interventions by default with the needs of marginalised groups in mind: accessible and appropriate support and, where needed, tailored approaches, for example for people with limited digital or language skills, disabilities, low incomes or limited mobility. In addition, actively involve these groups in the design and implementation."),
    rec2_title = "Recommendation 2: Combine knowledge transfer with behavioural change",
    rec2 = glue::glue(
      "{k$knowledge}% of interventions target knowledge, but only {k$skills}% target skills and {k$behavior}% behavioural change. Knowledge is a necessary foundation, but only becomes valuable when people can translate it into concrete digital action. Systematically pair knowledge and awareness with practical skills training and support in applying those skills across situations."),
    rec3_title = "Recommendation 3: Focus more on underrepresented life domains and active participation",
    rec3 = glue::glue(
      "Work ({dp('Work')}%), health ({dp('Health')}%) and news media ({dp('News media')}%) are underrepresented, and only {k$active}% of interventions promote active participation. Extend interventions to these domains and prioritise media literacy, so that people can better recognise mis- and disinformation, fake experts, manipulated content and misleading advertisements. In addition, pay more attention to using digital tools to take part in informed public debate."),
    justice = "Many interventions prioritise some of the most vulnerable groups: children and youth, the elderly and those with low literacy. In addition, 10% of interventions explicitly address the digital divide and digital access. In a country where 99% of households have an internet connection, such interventions target a relatively small group, but they are highly needed for those who would otherwise be excluded.",
    overview = "Below you find all interventions in the inventory. Use the search field or the dropdowns per column (you can tick several categories at once) to find interventions, and click a name to open the intervention's website.",
    about = glue::glue(
      "### Aim of the study

The aims of WP2 were to (1) provide an overview of current interventions regarding digital citizenship in the Kingdom of the Netherlands, (2) clarify how these interventions relate to expert perspectives in WP1, and (3) identify unused potential in strengthening digital citizenship.

### Selecting interventions

Interventions had to focus on citizens and target digital competencies or basic prerequisites for participation in the digital society, and be implemented in (or clearly target citizens of) the Kingdom of the Netherlands. We scouted government websites (www.digitaleoverheid.nl), the Ministry of the Interior and Kingdom Relations, websites of relevant organisations and networks (e.g., Netwerk Mediawijsheid), and consulted experts on digital citizenship.

This search led to an initial sample of 177 interventions. Interventions were excluded if they were located outside the Netherlands, if their website was inaccessible, or if they were not about digital participation, targeted organisations without an immediate focus on individuals, or were a network, research project, database, infrastructure or subsidy. (Nearly) identical interventions rolled out under different names in several municipalities, such as walk-in help sessions in community centres or libraries, were merged.

### Coding

The final sample of {k$n} interventions was analysed by three trained coders following a deductive-inductive approach. The codebook was based on the definition of digital citizenship (knowledge, skills, behaviours, active and responsible participation), descriptive information (type of intervention, initiator, runtime) and policy-relevant information (social problem, inclusiveness, expected outcome), defined after discussion with the Ministry of the Interior. After testing on a subsample, the codebook was refined and expanded. Target groups were coded based on who was explicitly named as the target group; interventions without an explicit target group were coded as aimed at the general population.

### About the figures

The charts in this dashboard are computed directly from the coding sheet. Percentages are based on the coded interventions. In the target group coding, *children* and *youth* were merged into one category, and *all citizens* and *unspecified* into *general population*. The categories for problems addressed, expected outcomes (inductive) and runtime are taken from the final report *Grip op Digitaal Burgerschap*.

### Research team

**Marina Tulin**, **Olga Eisele**, **Alain Starke**, **Ernesto de León**, **Christian Burgers** and **Jessica Piotrowski**, Amsterdam School of Communication Research (ASCoR), University of Amsterdam.")
  )
)

tx <- function(key) texts[[lang]][[key]]

# Iconify tab label helper (same style as digicomp)
ic <- function(icon, label) paste0("{{< iconify ", icon, " >}} ", label)

# 5. VISUALIZATIONS ============================================================

# Shared defaults for single-variable bar charts
bar_defaults <- function(...) {
  create_viz(
    type = "bar",
    horizontal = TRUE,
    bar_type = "percent",
    sort_by_value = TRUE,
    color_palette = main_color,
    x_label = "",
    y_label = tr("pct_interventions"),
    drop_na_vars = TRUE,
    ...
  )
}

yn_order  <- c(tr("yes"), tr("no"))
yn_colors <- the_colors[c(1, 2)]
beh_order <- c(tr("yes"), tr("indirect"), tr("no"))
beh_colors <- the_colors[c(1, 3, 2)]

## 5.1 Target groups ------------------------------------------------------------
target_viz <- bar_defaults() %>%
  add_viz(
    x_var = "target1_lab",
    data = "wp2",
    text_before_tabset = tx("target"),
    title = tr("c_target_primary"),
    icon = "ph:user-focus-fill",
    tabgroup = "target/primary"
  ) %>%
  add_viz(
    x_var = "target2_lab",
    data = "wp2",
    title = tr("c_target_secondary"),
    icon = "ph:users-fill",
    tabgroup = "target/secondary"
  )

inclusive_viz <- create_viz(
  type = "bar",
  horizontal = TRUE,
  bar_type = "percent",
  x_var = "inclusive_lab",
  x_order = yn_order,
  color_palette = main_color,
  x_label = "",
  y_label = tr("pct_interventions"),
  drop_na_vars = TRUE
) %>%
  add_viz(
    title = tr("c_inclusive"),
    data = "wp2",
    text_before_tabset = tx("inclusive"),
    text_after_viz = tx("inclusive_note"),
    height = 260,
    tabgroup = "inclusive/overall"
  )

inclusive_by_viz <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = TRUE,
  stack_var = "inclusive_lab",
  stack_order = yn_order,
  color_palette = yn_colors,
  stack_label = tr("legend_inclusive"),
  x_label = "",
  drop_na_vars = TRUE
) %>%
  add_viz(title = tr("c_inclusive"), data = "wp2", x_var = "target_group_short",
          x_order = target_short_order, tabgroup = "inclusive/by_target") %>%
  add_viz(title = tr("c_inclusive"), data = "wp2", x_var = "initiator_n",
          x_order = initiator_order, tabgroup = "inclusive/by_initiator") %>%
  add_viz(title = tr("c_inclusive"), data = "wp2", x_var = "type_short",
          x_order = type_short_order, tabgroup = "inclusive/by_type")

tab_labels_common <- list(
  overall      = ic("ph users-fill", tr("tab_overall")),
  by_target    = ic("ph user-focus-fill", tr("tab_by_target")),
  by_initiator = ic("ph buildings-fill", tr("tab_by_initiator")),
  by_type      = ic("ph shapes-fill", tr("tab_by_type"))
)

target_content <- (target_viz + inclusive_viz + inclusive_by_viz) %>%
  set_tabgroup_labels(labels = c(
    list(
      target    = tr("h_target"),
      inclusive = tr("h_inclusive"),
      primary   = ic("ph user-focus-fill", tr("tab_primary")),
      secondary = ic("ph users-fill", tr("tab_secondary"))
    ),
    tab_labels_common
  ))

## 5.2 Problems & outcomes ------------------------------------------------------
report_bar <- function(df, title, tabgroup, text_before = NULL) {
  data_name <- deparse(substitute(df))
  create_viz(
    type = "bar",
    horizontal = TRUE,
    x_var = "category",
    y_var = "pct",
    x_order = df$category,
    color_palette = main_color,
    x_label = "",
    y_label = tr("pct_interventions"),
    tooltip_suffix = "%"
  ) %>%
    add_viz(title = title, data = identity(data_name),
            text_before_tabset = text_before,
            height = 140 + 50 * nrow(df),
            text_after_viz = paste0("*", tr("source_report"), "*"),
            tabgroup = tabgroup)
}

problem_viz <- report_bar(problems_report, tr("c_problem_report"), "problems/report", tx("problems")) +
  create_viz(
    type = "bar", horizontal = TRUE, bar_type = "count", x_var = "category",
    sort_by_value = TRUE, color_palette = main_color,
    x_label = "", y_label = tr("n_interventions")
  ) %>%
  add_viz(title = tr("c_problem_policy"), data = "problems_long",
          text_before_viz = tx("problems_policy"), tabgroup = "problems/policy")

outcome_viz <- report_bar(outcomes_report, tr("c_outcome_report"), "outcomes/inductive", tx("outcomes")) +
  create_viz(
    type = "bar", horizontal = TRUE, bar_type = "count", x_var = "category",
    sort_by_value = TRUE, color_palette = main_color,
    x_label = "", y_label = tr("n_interventions")
  ) %>%
  add_viz(title = tr("c_outcome_codes"), data = "outcomes_long", tabgroup = "outcomes/codes")

problems_content <- (problem_viz + outcome_viz) %>%
  set_tabgroup_labels(
    problems = tr("h_problems"),
    outcomes = tr("h_outcomes"),
    report = ic("ph chart-bar-horizontal-fill", tr("tab_problem_report")),
    policy = ic("ph bank-fill", tr("tab_problem_policy")),
    inductive = ic("ph chart-bar-horizontal-fill", tr("tab_outcome_report")),
    codes  = ic("ph target-fill", tr("tab_outcome_codes"))
  )

## 5.3 Intervention types & domains ---------------------------------------------
types_viz <- bar_defaults() %>%
  add_viz(x_var = "type1_lab", data = "wp2", text_before_tabset = tx("types"),
          title = tr("c_type_primary"), tabgroup = "types/primary") %>%
  add_viz(x_var = "type2_lab", data = "wp2", title = tr("c_type_secondary"), tabgroup = "types/secondary")

domains_viz <- create_viz(
  type = "bar", horizontal = TRUE, bar_type = "count", x_var = "category",
  sort_by_value = TRUE, color_palette = main_color,
  x_label = "", y_label = tr("n_mentions")
) %>%
  add_viz(title = tr("c_domains"), data = "domains_long",
          text_before_tabset = tx("domains"), tabgroup = "domains")

types_content <- (types_viz + domains_viz) %>%
  set_tabgroup_labels(
    types     = tr("h_types"),
    domains   = tr("h_domains"),
    primary   = ic("ph shapes-fill", tr("tab_type_primary")),
    secondary = ic("ph squares-four-fill", tr("tab_type_secondary"))
  )

## 5.4 Competencies & participation ---------------------------------------------
# Overall: one stacked battery chart (like the DigIQ skills charts); breakdowns:
# one stacked bar per item by target group / initiator / type.
battery_viz <- function(vars, var_labels, stack_levels, colors, title, tbgrp, text_before = NULL,
                        legend_overall = NULL, legend_items = NULL) {
  overall <- create_viz(
    type = "stackedbars",
    x_vars = vars,
    x_var_labels = var_labels,
    stacked_type = "percent",
    horizontal = TRUE,
    stack_order = stack_levels,
    color_palette = colors,
    x_label = "",
    stack_label = legend_overall,
    drop_na_vars = TRUE
  ) %>%
    add_viz(title = title, data = "wp2", text_before_tabset = text_before,
            height = 120 + 90 * length(vars),
            icon = "ph:chart-bar", tabgroup = glue::glue("{tbgrp}/overall"))

  by <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = TRUE,
    color_palette = colors,
    x_label = "",
    drop_na_vars = TRUE
  )
  groups <- list(
    by_target    = list(var = "target_group_short", order = target_short_order),
    by_initiator = list(var = "initiator_n", order = initiator_order),
    by_type      = list(var = "type_short", order = type_short_order)
  )
  for (g in names(groups)) {
    for (i in seq_along(vars)) {
      by <- by %>%
        add_viz(
          title = var_labels[[i]],
          data = "wp2",
          x_var = groups[[g]]$var,
          x_order = groups[[g]]$order,
          stack_var = vars[[i]],
          stack_order = if (vars[[i]] == "behavior_lab") beh_order else yn_order,
          color_palette = if (vars[[i]] == "behavior_lab") beh_colors else yn_colors,
          stack_label = legend_items[[i]],
          tabgroup = glue::glue("{tbgrp}/{g}/{vars[[i]]}")
        )
    }
  }
  overall %>% combine_viz(by)
}

# Behaviour has three levels, so the battery uses a common 3-level scale
competencies_viz <- battery_viz(
  vars = c("knowledge_lab", "skills_lab", "behavior_lab"),
  var_labels = c(tr("var_knowledge"), tr("var_skills"), tr("var_behavior")),
  stack_levels = beh_order,
  colors = beh_colors,
  title = tr("c_competencies"),
  tbgrp = "comp",
  text_before = tx("competencies"),
  legend_overall = tr("legend_comp_overall"),
  legend_items = c(tr("legend_knowledge"), tr("legend_skills"), tr("legend_behavior"))
)

participation_viz <- battery_viz(
  vars = c("active_lab", "responsible_lab"),
  var_labels = c(tr("var_active"), tr("var_responsible")),
  stack_levels = yn_order,
  colors = yn_colors,
  title = tr("c_participation"),
  tbgrp = "part",
  text_before = tx("participation"),
  legend_overall = tr("legend_part_overall"),
  legend_items = c(tr("legend_active"), tr("legend_responsible"))
)

competencies_content <- (competencies_viz + participation_viz) %>%
  set_tabgroup_labels(labels = c(
    list(comp = tr("h_competencies"), part = tr("h_participation")),
    tab_labels_common,
    list(
      knowledge_lab   = ic("ph book-open-fill", tr("tab_knowledge")),
      skills_lab      = ic("ph lightning-fill", tr("tab_skills")),
      behavior_lab    = ic("ph person-simple-walk-fill", tr("tab_behavior")),
      active_lab      = ic("ph hand-waving-fill", tr("tab_active")),
      responsible_lab = ic("ph shield-check-fill", tr("tab_responsible"))
    )
  ))

## 5.5 Initiators, scope & runtime ----------------------------------------------
initiator_viz <- bar_defaults() %>%
  add_viz(x_var = "initiator_lab", data = "wp2", height = 320,
          text_before_tabset = paste0(tx("initiators"), "\n\n", tx("scope")), title = tr("c_initiators"), tabgroup = "org/initiator") %>%
  add_viz(x_var = "scope1_lab", data = "wp2", height = 360, title = tr("c_scope"), tabgroup = "org/scope")

runtime_viz <- report_bar(runtime_report, tr("c_runtime"), "org/runtime")

initiators_content <- (initiator_viz + runtime_viz) %>%
  set_tabgroup_labels(
    org       = tr("h_initiators"),
    initiator = ic("ph buildings-fill", tr("tab_initiator")),
    scope     = ic("ph map-trifold-fill", tr("tab_scope")),
    runtime   = ic("ph calendar-fill", tr("tab_runtime"))
  )

## 5.6 Recommendations ----------------------------------------------------------
recommendations_content <- create_content() %>%
  add_text(tx("recommendations_intro")) %>%
  add_value_box_row() %>%
    add_value_box(title = tr("vb_inclusive"), value = paste0(k$inclusive, "%"), bg_color = the_colors[1]) %>%
    add_value_box(title = tr("vb_behavior"), value = paste0(k$behavior, "%"), bg_color = the_colors[2]) %>%
    add_value_box(title = tr("vb_active"), value = paste0(k$active, "%"), bg_color = the_colors[5]) %>%
  end_value_box_row() %>%
  add_callout(tx("rec1"), type = "note", title = tx("rec1_title")) %>%
  add_callout(tx("rec2"), type = "note", title = tx("rec2_title")) %>%
  add_callout(tx("rec3"), type = "note", title = tx("rec3_title")) %>%
  add_text(paste0("## ", if (lang == "nl") "Digitale rechtvaardigheid" else "Digital justice")) %>%
  add_text(tx("justice"))

## 5.7 Overview table -----------------------------------------------------------
overview_tbl <- wp2 %>%
  transmute(
    title = coalesce(title, "—"),
    url = str_extract(url, "https?://\\S+"),
    target = target1_lab,
    type = type1_lab,
    initiator = initiator_lab,
    scope = scope1_lab,
    inclusive = inclusive_lab,
    domain = recode_with(domain1, domain_map)
  ) %>%
  arrange(title)

# Multi-select dropdown filter for a column: a small dropdown with one checkbox
# per category (with counts); ticking several shows rows matching any of them.
table_id <- paste0("interventions-table-", lang)
lbl_all  <- if (lang == "nl") "Alle" else "All"
lbl_n_sel <- if (lang == "nl") "geselecteerd" else "selected"

# Position the open menu with position:fixed so the table does not clip it,
# and close any other open dropdown
dd_toggle_js <- "if(this.open){document.querySelectorAll('details.dc-dd[open]').forEach(function(d){if(d!==this)d.open=false;},this);
  var r=this.getBoundingClientRect();var m=this.querySelector('.dc-dd-menu');
  m.style.top=(r.bottom+2)+'px';m.style.left=Math.min(r.left,window.innerWidth-240)+'px';}"

dropdown_filter <- function(values, name) {
  vals <- sort(table(values[!is.na(values) & values != ""]), decreasing = TRUE)
  js_update <- sprintf(
    "var box=this.closest('.dc-dd');var v=Array.from(box.querySelectorAll('input:checked')).map(function(x){return x.value;});
     box.querySelector('summary span').textContent=v.length===0?'%s':(v.length===1?v[0]:v.length+' %s');
     Reactable.setFilter('%s','%s',v.length?v:undefined);",
    lbl_all, lbl_n_sel, table_id, name)
  htmltools::tags$details(
    class = "dc-dd",
    ontoggle = dd_toggle_js,
    htmltools::tags$summary(htmltools::tags$span(lbl_all)),
    htmltools::tags$div(
      class = "dc-dd-menu",
      lapply(names(vals), function(v) {
        htmltools::tags$label(
          htmltools::tags$input(type = "checkbox", value = v, onchange = js_update),
          paste0(v, " (", vals[[v]], ")")
        )
      })
    )
  )
}
multi_filter_method <- reactable::JS(
  "function(rows, columnId, filterValue) {
     return rows.filter(function(row) { return filterValue.indexOf(row.values[columnId]) !== -1; });
   }"
)
dd_col <- function(name_key, minWidth, ...) {
  reactable::colDef(name = tr(name_key), minWidth = minWidth,
                    filterInput = dropdown_filter, filterMethod = multi_filter_method, ...)
}

dropdown_css <- "```{=html}
<style>
  .dc-dd { position: relative; font-size: 12px; }
  .dc-dd summary { list-style: none; cursor: pointer; border: 1px solid #ccc; border-radius: 4px;
                   padding: 3px 22px 3px 6px; background: #fff; white-space: nowrap; overflow: hidden;
                   text-overflow: ellipsis; position: relative; }
  .dc-dd summary::-webkit-details-marker { display: none; }
  .dc-dd summary::after { content: '\\25BE'; position: absolute; right: 6px; top: 3px; color: #666; }
  .dc-dd-menu { position: fixed; z-index: 2000; min-width: 220px; max-height: 280px;
                overflow-y: auto; background: #fff; border: 1px solid #ccc; border-radius: 4px;
                box-shadow: 0 6px 18px rgba(0,0,0,.15); padding: 6px 8px; }
  .dc-dd-menu label { display: flex; gap: 6px; align-items: center; font-weight: normal; margin: 3px 0;
                      white-space: nowrap; cursor: pointer; }
</style>
<script>
document.addEventListener('click', function(e) {
  document.querySelectorAll('details.dc-dd[open]').forEach(function(d) { if (!d.contains(e.target)) d.open = false; });
});
window.addEventListener('scroll', function() {
  document.querySelectorAll('details.dc-dd[open]').forEach(function(d) { d.open = false; });
}, { passive: true });
</script>
```"

overview_rt <- reactable::reactable(
  overview_tbl,
  elementId = table_id,
  searchable = TRUE, filterable = TRUE, striped = TRUE, highlight = TRUE,
  compact = TRUE, borderless = TRUE, defaultPageSize = 20,
  showPageSizeOptions = TRUE, pageSizeOptions = c(20, 50, 200),
  language = if (lang == "nl") reactable::reactableLang(
    searchPlaceholder = "Zoeken...", filterPlaceholder = "Filter",
    pageInfo = "{rowStart}–{rowEnd} van {rows} interventies",
    pagePrevious = "Vorige", pageNext = "Volgende", pageSizeOptions = "Toon {rows}",
    noData = "Geen interventies gevonden"
  ) else reactable::reactableLang(pageInfo = "{rowStart}–{rowEnd} of {rows} interventions"),
  theme = reactable::reactableTheme(
    headerStyle = list(background = main_color, color = "white", fontWeight = "bold", fontSize = "13px"),
    cellStyle = list(fontSize = "13px"),
    searchInputStyle = list(width = "100%")
  ),
  columns = list(
    title = reactable::colDef(
      name = tr("col_title"), minWidth = 240,
      cell = function(value, index) {
        u <- overview_tbl$url[index]
        if (is.na(u)) value else htmltools::tags$a(href = u, target = "_blank", value)
      }
    ),
    url = reactable::colDef(show = FALSE),
    target = dd_col("col_target", 150),
    type = dd_col("col_type", 140),
    initiator = dd_col("col_initiator", 130),
    scope = dd_col("col_scope", 110),
    inclusive = dd_col("col_inclusive", 90, align = "center"),
    domain = dd_col("col_domain", 150)
  )
)

overview_content <- create_content() %>%
  add_text(tx("overview")) %>%
  add_text(dropdown_css) %>%
  add_reactable(overview_rt)

# 6. DASHBOARD CREATION =========================================================

## 6.1 Navigation menus ----
more_info_menu <- navbar_menu(
  text = tr("menu_more_info"),
  pages = c(tr("page_about")),
  icon = "ph:info-fill",
  align = "right"
)

page_data <- list(
  wp2 = wp2,
  domains_long = domains_long,
  problems_long = problems_long,
  outcomes_long = outcomes_long,
  problems_report = problems_report,
  outcomes_report = outcomes_report,
  runtime_report = runtime_report
)


## 6.1b Landing page links ----
# Clickable tiles linking to each results page (replaces the value boxes)
landing_pages <- tribble(
  ~slug,                 ~icon,                    ~title_key,             ~nl,                                                                 ~en,
  "target_groups",       "ph users-three-fill",    "card_target",          "Op wie richten de interventies zich, en hoe inclusief zijn ze?",    "Whom do the interventions target, and how inclusive are they?",
  "problems_outcomes",   "ph warning-circle-fill", "card_problems",        "Welke problemen pakken ze aan en wat willen ze bereiken?",          "Which problems do they address and what do they aim to achieve?",
  "intervention_types",  "ph shapes-fill",         "card_types",           "Welke vorm hebben de interventies en welke levensdomeinen raken ze?", "What form do the interventions take and which life domains do they cover?",
  "competencies",        "ph lightning-fill",      "card_competencies",    "Kennis, vaardigheden, gedrag en actieve en verantwoorde participatie", "Knowledge, skills, behaviour, and active and responsible participation",
  "initiators_scope",    "ph buildings-fill",      "card_initiators",      "Wie neemt het initiatief, op welk niveau en hoe lang?",             "Who takes the initiative, at what level and for how long?",
  "recommendations",     "ph lightbulb-fill",      "card_recommendations", "Conclusies en aanbevelingen uit het onderzoek",                     "Conclusions and recommendations from the study",
  "interventions",       "ph list-magnifying-glass", "card_overview",      "Doorzoek en filter de volledige inventarisatie",                    "Search and filter the full inventory"
)
if (!show_table) landing_pages <- dplyr::filter(landing_pages, slug != "interventions")

landing_links <- paste0(
  "```{=html}\n",
  "<style>
  .dc-links { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1rem; margin: 1.5rem 0; }
  .dc-link { display: block; padding: 1.1rem 1.2rem; border-radius: 10px; border: 1px solid #d9e3e2;
             border-left: 6px solid ", main_color, "; background: #f7faf9; color: inherit !important;
             text-decoration: none !important; transition: transform .15s ease, box-shadow .15s ease; }
  .dc-link:hover { transform: translateY(-2px); box-shadow: 0 4px 14px rgba(0,0,0,.08); }
  .dc-link-title { font-weight: 700; color: ", main_color, "; font-size: 1.05rem; margin-bottom: .3rem; }
  .dc-link-text { font-size: .92rem; color: #444; }
  </style>\n",
  "<div class='dc-links'>\n",
  paste0(
    "<a class='dc-link' href='", landing_pages$slug, ".html'>",
    "<div class='dc-link-title'><iconify-icon inline icon='", str_replace(landing_pages$icon, " ", ":"), "'></iconify-icon> ",
    map_chr(landing_pages$title_key, tr), "</div>",
    "<div class='dc-link-text'>", landing_pages[[lang]], "</div></a>",
    collapse = "\n"
  ),
  "\n</div>\n```\n"
)

## 6.2 Dashboard pages & configuration ----
# add_page() only when `cond` is TRUE (used for the optional interventions table)
add_page_if <- function(proj, cond, ...) if (isTRUE(cond)) add_page(proj, ...) else proj

dashboard <- create_dashboard(
  ## Descriptions
  title = tr("site_title"),
  output_dir = out_dir,
  publish_dir = publish_dir,
  author = "Marina Tulin, Olga Eisele, Alain Starke, Ernesto de León, Christian Burgers, Jessica Piotrowski",
  description = tr("site_title"),
  page_footer = tr("footer"),
  date = format(Sys.Date()),
  ## Themes / Styles (as in the DigIQ Monitor)
  page_layout = "full",
  theme = "flatly",
  tabset_theme = "underline",
  mobile_toc = TRUE,
  search = TRUE,
  code_overflow = "wrap",
  #### Navbar settings
  navbar_sections = list(more_info_menu),
  navbar_style = "dark",
  navbar_brand = tr("brand"),
  navbar_toggle = "collapse",
  navbar_bg_color = "#f0f0f0",
  navbar_text_color = "#3A1B00E6",
  navbar_text_hover_color = "lightgrey",
  breadcrumbs = FALSE,
  page_navigation = TRUE,
  back_to_top = TRUE,
  self_contained = FALSE,
  code_tools = FALSE,
  code_folding = NULL,
  metrics_style = "bootstrap",
  backend = "echarts4r",
  custom_css = file.path(assets_dir, "navbar_fix.css")   # navbar: no truncated title, icons inline, gap before right menu
) %>%
  # Landing page
  add_page(
    name = tr("page_home"),
    icon = "ph:house-fill",
    is_landing_page = TRUE,
    text = md_text(
      "<div style='text-align: center;'>",
      tx("landing"),
      "</div>"
    ),
    content = create_content() %>%
      add_text(paste0("<div style='text-align: center;'>\n\n", tx("landing_nav"), "\n\n</div>")) %>%
      add_text(landing_links) %>%
      add_text("<br><center><img src='bzk.jpg' width='360'></center>")
  ) %>%
  add_page(
    name = tr("page_target"),
    slug = "target_groups",
    icon = "ph:users-three-fill",
    data = page_data,
    visualizations = target_content
  ) %>%
  add_page(
    name = tr("page_problems"),
    slug = "problems_outcomes",
    icon = "ph:warning-circle-fill",
    data = page_data,
    visualizations = problems_content
  ) %>%
  add_page(
    name = tr("page_types"),
    slug = "intervention_types",
    icon = "ph:shapes-fill",
    data = page_data,
    visualizations = types_content
  ) %>%
  add_page(
    name = tr("page_competencies"),
    slug = "competencies",
    icon = "ph:lightning-fill",
    data = page_data,
    visualizations = competencies_content
  ) %>%
  add_page(
    name = tr("page_initiators"),
    slug = "initiators_scope",
    icon = "ph:buildings-fill",
    data = page_data,
    visualizations = initiators_content
  ) %>%
  add_page(
    name = tr("page_recommendations"),
    navbar_align = "right",
    slug = "recommendations",
    icon = "ph:lightbulb-fill",
    content = recommendations_content
  ) %>%
  add_page_if(show_table,
    name = tr("page_overview"),
    navbar_align = "right",
    slug = "interventions",
    icon = "ph:list-magnifying-glass",
    content = overview_content
  ) %>%
  add_page(
    name = tr("page_about"),
    slug = "about",
    icon = "ph:info-fill",
    text = md_text(
      "<div style='text-align: justify;'>",
      tx("about"),
      "</div>",
      "",
      "<br><center><img src='bzk.jpg' width='360'></center>"
    )
  ) %>%
  add_powered_by_dashboardr(style = "badge", size = "large") %>%
  add_navbar_element(
    text = if (lang == "nl") "en" else "nl",
    icon = other_lang_flag,
    href = other_lang_href,
    align = "right"
  )

print(dashboard)

# Copy the image used on the landing and about pages, plus a bundled copy of the
# Quarto iconify extension (used when `quarto add` cannot reach GitHub)
dir.create(out_dir, showWarnings = FALSE)
file.copy("bzk.jpg", file.path(out_dir, "bzk.jpg"), overwrite = TRUE)
file.copy(file.path(assets_dir, "navbar_fix.css"), file.path(out_dir, "navbar_fix.css"), overwrite = TRUE)  # fallback; dashboardr also copies custom_css
if (dir.exists(file.path(assets_dir, "_extensions")) && !dir.exists(file.path(out_dir, "_extensions"))) {
  file.copy(file.path(assets_dir, "_extensions"), out_dir, recursive = TRUE)
}

## 6.3 Generate dashboard ----
# Generate the .qmd files first, fix the navbar order, then render with Quarto.
generate_dashboard(dashboard, render = FALSE, open = FALSE)

# dashboardr always lists right-aligned menus before right-aligned pages. Move the
# "Meer info / More info" menu so the right side reads:
# Aanbevelingen, Interventies, Meer info, language switch.
yml_path <- file.path(out_dir, "_quarto.yml")
yml <- readLines(yml_path, encoding = "UTF-8")
info_start <- grep("^      - text: .*ph info-fill", yml)[1]
stopifnot(!is.na(info_start),
          grepl("^        menu:", yml[info_start + 1]),
          grepl("about\\.qmd", yml[info_start + 2]))
info_block <- yml[info_start:(info_start + 3)]   # text, menu:, - href: about.qmd, text
yml <- yml[-(info_start:(info_start + 3))]
lang_line <- grep("^      - text: .*circle-flags", yml)[1]
yml <- append(yml, info_block, after = lang_line - 1)
writeLines(yml, yml_path, useBytes = TRUE)

# Without the table, remove leftovers from earlier builds so the page is not rendered or published
if (!show_table) {
  unlink(file.path(out_dir, "interventions.qmd"))
  unlink(file.path(out_dir, publish_dir, "interventions.html"))
}

quarto::quarto_render(out_dir, as_job = FALSE)
file.copy(file.path(assets_dir, "navbar_fix.css"), file.path(out_dir, publish_dir, "navbar_fix.css"), overwrite = TRUE)

# 7. ENGLISH VERSION ===========================================================
# After the Dutch build, run this script again in a fresh environment for English
if (isTRUE(build_both) && lang == "nl") {
  en_env <- new.env(parent = globalenv())
  en_env$lang <- "en"
  en_env$show_table <- show_table
  en_env$build_both <- FALSE
  source("dashboard-citizen.R", local = en_env)
}
