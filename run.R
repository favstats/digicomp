try(Sys.setlocale("LC_ALL", "en_US.UTF-8"), silent = TRUE)

library(tidyverse)
library(readr)
library(stringr)

# 1. Generate and render Dutch dashboard (uses explicit `slug` in dashboard.R)
nl_env <- new.env(parent = globalenv())
nl_env$lang <- "nl"
source("dashboard.R", local = nl_env)

quarto::quarto_render("qmds", as_job = FALSE)

# 2. Generate and render English dashboard
read_lines("dashboard.R") %>%
  str_replace_all(fixed("../docs"), "../docs/en") %>%
  str_replace_all("circle-flags:uk", "circle-flags:lang-nl") %>%
  str_replace_all("digicomp/en", "digicomp") %>%
  str_replace_all("qmds", "qmds_en") %>%
  str_replace_all("render = F", "render = T") %>%
  write_lines("dashboard_en.R")

en_env <- new.env(parent = globalenv())
en_env$lang <- "en"
source("dashboard_en.R", local = en_env)
