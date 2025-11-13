
library(tidyverse)

# run Dutch
nl_env <- new.env(parent = globalenv())
nl_env$lang <- "nl"
source("dashboard.R", local = nl_env)

library(readr)
library(stringr)
library(dplyr)

read_lines("qmds/_quarto.yml") %>%
  
  # navbar labels
  # str_replace_all("Dimensies", "Dimensions") %>%
  # str_replace_all("Strategische Informatie", "Strategic Information") %>%
  # str_replace_all("Kritische Informatie", "Critical Information") %>%
  # str_replace_all("Netiquette", "Netiquette") %>%
  # str_replace_all("Digitale Inhoudscreatie", "Digital Content Creation") %>%
  # str_replace_all("Veiligheid", "Safety") %>%
  # str_replace_all("Digitale Gezondheid", "Digital Health") %>%
  # str_replace_all("Groene Digitaal", "Green Digital") %>%
  # str_replace_all("Digitaal Probleemoplossen", "Digital Problem Solving") %>%
  # str_replace_all("Transactioneel", "Transactional") %>%
  # str_replace_all("Vaardigheden", "Skills") %>%
  # str_replace_all("Prestatie", "Performance") %>%
  # str_replace_all("Kennis", "Knowledge") %>%
  # str_replace_all("Hoogtepunten", "Highlights") %>%
  # str_replace_all("Over", "About") %>%
  
  # link targets (.qmd)
  str_replace_all("strategische_informatie.qmd", "strategic_information.qmd") %>%
  str_replace_all("kritische_informatie.qmd", "critical_information.qmd") %>%
  str_replace_all("netiquette.qmd", "netiquette.qmd") %>%
  str_replace_all("digitale_inhoudscreatie.qmd", "digital_content_creation.qmd") %>%
  str_replace_all("veiligheid.qmd", "safety.qmd") %>%
  str_replace_all("digitale_gezondheid.qmd", "digital_health.qmd") %>%
  str_replace_all("groene_digitaal.qmd", "green_digital.qmd") %>%
  str_replace_all("digitaal_probleemoplossen.qmd", "digital_problem_solving.qmd") %>%
  str_replace_all("transactioneel.qmd", "transactional.qmd") %>%
  str_replace_all("vaardigheden.qmd", "skills.qmd") %>%
  str_replace_all("prestatie.qmd", "performance.qmd") %>%
  str_replace_all("kennis.qmd", "knowledge.qmd") %>%
  str_replace_all("hoogtepunten.qmd", "highlights.qmd") %>%
  str_replace_all("over.qmd", "about.qmd") %>%
  
  write_lines("qmds/_quarto.yml")


# directory with your files
dir <- "qmds"  # change if needed, e.g. "docs" or "."

# map Dutch -> English
name_map <- c(
  "kennis"                 = "knowledge",
  "kritische_informatie"   = "critical_information",
  "strategische_informatie"= "strategic_information",
  "netiquette"             = "netiquette",
  "digitale_inhoudscreatie"= "digital_content_creation",
  "veiligheid"             = "safety",
  "digitale_gezondheid"    = "digital_health",
  "groene_digitaal"        = "green_digital",
  "digitaal_probleemoplossen" = "digital_problem_solving",
  "transactioneel"         = "transactional",
  "vaardigheden"           = "skills",
  "prestatie"              = "performance",
  "hoogtepunten"           = "highlights",
  "over"                   = "about",
  "ai"                     = "ai",        # stays the same
  "index"                  = "index"      # stays the same
)

files <- list.files(dir, full.names = TRUE)

for (f in files) {
  # skip directories
  if (dir.exists(f)) next
  
  base <- tools::file_path_sans_ext(basename(f))
  ext  <- tools::file_ext(f)
  
  new_base <- base  # default: unchanged
  
  # try to match each Dutch prefix
  for (dutch in names(name_map)) {
    if (startsWith(base, dutch)) {
      # keep any suffix, e.g. "_p2", "_p3"
      suffix <- sub(paste0("^", dutch), "", base)
      new_base <- paste0(name_map[[dutch]], suffix)
      break
    }
  }
  
  # if changed, rename
  if (!identical(new_base, base)) {
    new_path <- file.path(dir, paste0(new_base, if (nzchar(ext)) paste0(".", ext) else ""))
    message("Renaming: ", f, " -> ", new_path)
    file.rename(f, new_path)
  }
}

# renders every .qmd in qmds/ per its _quarto.yml
quarto::quarto_render("qmds", as_job = F)

read_lines("dashboard.R") %>% 
  str_replace_all("\\.\\./docs", "../docs/en") %>% 
  str_replace_all("circle-flags:uk", "circle-flags:lang-nl") %>% 
  # str_replace_all('"nl"', '"en"')  %>% 
  str_replace_all('digicomp/en', 'digicomp') %>% 
  str_replace_all('qmds', 'qmds_en') %>% 
  str_replace_all('render = F', 'render = T') %>% 
  
  write_lines("dashboard_en.R")




# run English
en_env <- new.env(parent = globalenv())
en_env$lang <- "en"
source("dashboard_en.R", local = en_env)



gert::git_add(".")
gert::git_commit("update")
gert::git_push()