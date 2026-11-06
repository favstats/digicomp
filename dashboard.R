# DIGITAL COMPETENCE DASHBOARD ====================================================

try(Sys.setlocale("LC_ALL", "en_US.UTF-8"), silent = TRUE)

library(tidyverse)
library(dashboardr)



# Read translations from local CSV (updated for Wave 3 / landing page overhaul):
translation <- read_csv("translations.csv", show_col_types = FALSE) %>%
  select(variable, en, nl, note)


transl <- function(x, lang) {
  translation %>% filter(variable == x) %>% 
    pull(lang)
}

# transl("SInfo1", "en")

if(!exists("lang")){
  lang <- "en"
}

lang_change <- function(lang) {
  if(lang == "en"){
    return("nl")
  } else {
    return("en")
  }
}

# 1. SETUP & CONFIGURATION =====================================================

# the_colors <- c("#F5D76E", "#E28D50", "#3D7271", "#C7E6D5", "#0F6B5A", "#BABACD")
the_colors <- c("#3D7271",  "#E28D50",  "#F5D76E", "#C7E6D5", "#0F6B5A", "#BABACD")

recode_survey <- function(df) {
  
  
  # 1) SKILL ITEMS: coerce to numeric IN PLACE and set 66/99 -> NA
  skill_vars <- c(
    "SInfo1","SInfo3_V2","SInfo4","SInfo5","SInfo6","SInfo7",
    "SCom1_V2","SCom2","SCom3","SCom4_V2","SCom5",
    "SCrea2","SCrea3","SCrea4","SCrea5",
    "SSafDev1","SSafDev2",
    "SPriv1","SPriv2","SPriv3","SPriv4",
    "SHealth1","SHealth2_V2","SHealth3_V2",
    "SEnv1","SEnv2","SEnv3",
    "SProbl1","SProbl2",
    "Strans1","Strans2","Strans3","Strans4","Strans5",
    "SAI1","SAI2",
    "SGAI1","SGAI2","SGAI3","SGAI4","SGAI5",
    # optionally already-numeric helper mentioned in your code
    "GetHelp_V2N"
  )
  skill_present <- intersect(names(df), skill_vars)
  
  # coerce to numeric in place
  df <- df |> mutate(across(all_of(skill_present), ~ suppressWarnings(as.numeric(.x))))
  # set 66/99 to NA
  df <- df |> mutate(across(all_of(skill_present), ~ replace(.x, .x %in% c(66, 99), NA_real_)))
  
  true_set  <- c("KInfo3","KCom1","KCrea1","KCrea2","KSafDev2","KSafDev_new",
                 "KPriv2","KPriv3_V2","KHealth2","KHealth3","KEnv1","KEnv2",
                 "Ktrans1","KAI1","KAI3","KAI4","KGAI3","KGAI4","KGAI5")
  false_set <- c("KInfo1","KInfo2","KCom3","KCrea3","KPriv1","KHealth1","KEnv3",
                 "Ktrans2","Ktrans3","KAI2","KGAI1","KGAI2")
  knowledge_items <- c(true_set, false_set)
  
  map_true  <- c(`1`="Correct", `2`="Incorrect", `3`="Don't know", `66`="Don't understand")
  map_false <- c(`1`="Incorrect", `2`="Correct", `3`="Don't know", `66`="Don't understand")
  
  recode_by_col <- function(x, col) {
    m <- if (col %in% true_set) map_true else map_false
    dplyr::recode_factor(as.character(x), !!!m, .default = NA_character_)
  }
  
  df <- df |>
    mutate(
      across(contains(knowledge_items),
             ~ recode_by_col(.x, cur_column()),
             .names = "{.col}R"
      )
    ) |>
    mutate(
      across(ends_with("R"),
             ~ as.integer(.x == "Correct"),
             .names = "{.col}C"
      )
    )
  
  # 3) SUBSCALES (using IN-PLACE skill vars; no ...N names)
  
  # helper to rowMeans over present columns (keeps NA handling identical to base: na.rm = FALSE)
  rm_mean <- function(d, vars) {
    v <- intersect(names(d), vars)
    if (length(v) == 0) return(rep(NA_real_, nrow(d)))
    rowMeans(d[v])
  }
  
  df$MeanStratInfo <- rm_mean(df, c("SInfo1","SInfo3_V2","SInfo4"))
  df$MeanCritInfo  <- rm_mean(df, c("SInfo5","SInfo6","SInfo7"))
  df$MeanNet       <- rm_mean(df, c("SCom1_V2","SCom2","SCom4_V2","SCom5"))
  df$MeanCrea      <- rm_mean(df, c("SCrea2","SCrea3","SCrea4","SCrea5"))
  df$MeanSaf       <- rm_mean(df, c("SSafDev1","SSafDev2","SPriv1","SPriv2","SPriv3","SPriv4","SCom3"))
  df$MeanHealth    <- rm_mean(df, c("SHealth1","SHealth2_V2","SHealth3_V2"))
  df$MeanGreen     <- rm_mean(df, c("SEnv1","SEnv2","SEnv3"))
  df$MeanTrans     <- rm_mean(df, c("Strans1","Strans2","Strans3","Strans4","Strans5"))
  df$MeanProbl     <- rm_mean(df, c("SProbl1","SProbl2"))
  df$MeanAI        <- rm_mean(df, c("SAI1","SAI2"))
  df$MeangenAI     <- rm_mean(df, c("SGAI1","SGAI2","SGAI3","SGAI4","SGAI5"))
  
  
  
  # 4) TOTAL KNOWLEDGE SCORE (sum of *RC columns you listed)
  
  knowledge_rc_order <- c(
    "KInfo1RC","KInfo2RC","KInfo3RC",
    "KCom1RC","KCom3RC",
    "KCrea1RC","KCrea2RC","KCrea3RC",
    "KSafDev2RC",
    "KPriv1RC","KPriv2RC","KPriv3_V2RC",
    "KHealth1RC","KHealth2RC","KHealth3RC",
    "KEnv1RC","KEnv2RC","KEnv3RC",
    "Ktrans1RC","Ktrans2RC","Ktrans3RC",
    "KAI1RC","KAI2RC","KAI3RC", "KAI4RC",
    "KGAI1RC","KGAI2RC","KGAI3RC","KGAI4RC","KGAI5RC"
  )
  # df <- data
  present_rc <- intersect(knowledge_rc_order, names(df))
  if (length(present_rc)) {
    # match your explicit + ... + behavior (NA if any NA)
    df$MeanKnowledge <- rowSums(df[present_rc], na.rm = T)
  } else {
    df$MeanKnowledge <- NA_real_
  }
  
  # 5) PSCS1 Performance: Online Safety - Phishing recognition
  # Correct answer is 4 (Phishing mail), 5/6 (don't know/understand) become NA
  if ("PSCS1N" %in% names(df)) {
    df <- df |> mutate(PSCS1R = ifelse(PSCS1N == 4, 1, ifelse(PSCS1N == 5 | PSCS1N == 6, NA, 0)))
  }

  # 6) PSIS1RC: Strategic Info - manually coded from open-ended search task
  # PSIS1R: 0=incorrect/missing, 1=correct(basic), 2=correct(elaborate), 55=don't understand -> NA
  if ("PSIS1R" %in% names(df)) {
    df <- df |> mutate(PSIS1R = suppressWarnings(as.numeric(PSIS1R))) |>
      mutate(PSIS1RC = case_when(
        is.na(PSIS1R) | PSIS1R == 55 ~ NA_real_,
        PSIS1R == 0 ~ 0,
        TRUE ~ 1
      ))
  } else if ("PSIS1_codes" %in% names(df)) {
    df <- df |> mutate(PSIS1RC = ifelse(PSIS1_codes == 66, NA, ifelse(PSIS1_codes == 1, 1, 0)))
  }

  # 7) PGAIS1RC: GenAI - manually coded from open-ended task
  # PGAIS1R: 0=incorrect/missing, 1=correct(basic), 2=correct(elaborate), 55=don't understand -> NA
  if ("PGAIS1R" %in% names(df)) {
    df <- df |> mutate(PGAIS1R = suppressWarnings(as.numeric(PGAIS1R))) |>
      mutate(PGAIS1RC = case_when(
        is.na(PGAIS1R) | PGAIS1R == 55 ~ NA_real_,
        PGAIS1R == 0 ~ 0,
        TRUE ~ 1
      ))
  } else if ("PGAIS1_codes" %in% names(df)) {
    df <- df |> mutate(PGAIS1RC = ifelse(PGAIS1_codes == 66, NA, ifelse(PGAIS1_codes == 1, 1, 0)))
  }

  df %>% 
    mutate(
      across(
        any_of(knowledge_rc_order),
        ~ ifelse(is.na(.x),   transl("dunno_understand", lang), .x)
      )
    )
}
# read_csv2("data/wave1.csv") -> wads
# wads <- read_csv("data/wave1.csv")
# wads %>% count(geslacht)
# data_w1 <- read_csv2("data/DigCom24CompleteWithWeights.csv") %>% #table()
# mutate(AgeGroup = case_when(
#   Age %in% 16:17 ~ "16-17",
#   Age %in% 18:24 ~ "18-24",
#   Age %in% 25:34 ~ "25-34",
#   Age %in% 35:44 ~ "35-44",
#   Age %in% 45:54 ~ "45-54",
#   Age %in% 55:64 ~ "55-64",
#   Age %in% 65:150 ~ "65+",
# )) %>%
# Load manually coded open items (PSIS1 and PGAIS1) from Roos's coded files
df_opencodes_r1 <- read_csv("data/coding_open_items_r1.csv") %>%
  select(PSIS1R, PGAIS1R)
df_opencodes_r2 <- read_csv("data/coding_open_items_r2.csv") %>%
  select(id, PSIS1R, PGAIS1R)

data_w1 <- read_csv("data/wave1.csv") %>% #table()
  # Merge manually coded open items by row order (Round 1 has no id's)
  bind_cols(df_opencodes_r1) %>%
  mutate(weging_GAMO = str_replace(weging_GAMO, ",", ".") %>% as.numeric) %>%
  mutate(geslacht = case_when(
    geslacht == 1 ~ transl("label_male", lang),
    geslacht == 2 ~ transl("label_female", lang),
    T ~ NA_character_
  )) %>%
  mutate(Education = EducationR) %>%
  mutate(Education = case_when(
    Education == "Low" ~ transl("label_low_education", lang),
    Education == "Middle" ~ transl("label_middle_education", lang),
    Education == "High" ~ transl("label_high_education", lang),
    T ~ Education
  )) %>%
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>%
  recode_survey()
# getwd()
# data <- read_csv2("data/DigCom25CompleteWithWeights.csv") %>% #table()
data <- read_csv("data/wave2.csv") %>%
  # Fix duplicate id for Round 2 merge (one respondent has same id on Smartphone and Paper)
  mutate(id = if_else(id == "ZHB3QJSWCD" & Device == "Smartphone", "ZHB3QJSWCD1", id)) %>%
  # Merge manually coded open items by id (Round 2)
  left_join(df_opencodes_r2, by = "id") %>%
  mutate(weging_GAMO = str_replace(weging_GAMO, ",", ".") %>% as.numeric) %>%
  mutate(geslacht = case_when(
    Gender == 1 | Gender == "Male" ~ transl("label_male", lang),
    Gender == 2 | Gender == "Female" ~ transl("label_female", lang),
    T ~ NA_character_
  )) %>%
  mutate(Education = EducationR)  %>%
  mutate(Education = case_when(
    Education == "Low" ~ transl("label_low_education", lang),
    Education == "Middle" ~ transl("label_middle_education", lang),
    Education == "High" ~ transl("label_high_education", lang),
    T ~ Education
  )) %>%
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>%
  recode_survey()

data_w3 <- read_csv("data/wave3.csv", show_col_types = FALSE) %>%
  mutate(weging_GAMO = str_replace(as.character(weging_GAMO), ",", ".") %>% as.numeric) %>%
  mutate(geslacht = case_when(
    Gender == 1 | Gender == "Male" ~ transl("label_male", lang),
    Gender == 2 | Gender == "Female" ~ transl("label_female", lang),
    T ~ NA_character_
  )) %>%
  mutate(Education = EducationR) %>%
  mutate(Education = case_when(
    Education == "Low" ~ transl("label_low_education", lang),
    Education == "Middle" ~ transl("label_middle_education", lang),
    Education == "High" ~ transl("label_high_education", lang),
    Education == "NA" ~ NA_character_,
    T ~ Education
  )) %>%
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>%
  recode_survey()

smart_bind_rows <- function(...) {
  dfs <- list(...)
  
  # names per df
  cols_list <- lapply(dfs, names)
  
  # columns that appear in at least 2 dfs
  all_cols <- unlist(cols_list, use.names = FALSE)
  overlap_cols <- names(which(table(all_cols) > 1))
  
  # for each overlapping col, check classes per df
  for (col in overlap_cols) {
    # get classes for this col in each df (NA if missing)
    classes <- map_chr(dfs, ~ if (col %in% names(.x)) class(.x[[col]])[1] else NA_character_)
    
    # do we have >1 non-NA class?
    non_na_classes <- unique(na.omit(classes))
    if (length(non_na_classes) > 1) {
      # coerce this column to character in every df that has it
      dfs <- lapply(dfs, function(.x) {
        if (col %in% names(.x)) {
          .x[[col]] <- as.character(.x[[col]])
        }
        .x
      })
    }
  }
  
  bind_rows(dfs)
}



w1_time_lab <- paste0("Dec. 24 (", transl("tab_wave1", lang), ")")
w2_time_lab <- paste0("Jun. 25 (", transl("tab_wave2", lang), ")")
w3_time_lab <- paste0("Dec. 25 (", transl("tab_wave3", lang), ")")

# digicom_data$
digicom_data <- data_w3 %>% 
  mutate(wave = 3) %>% 
  smart_bind_rows(
    data %>% mutate(wave = 2),
    data_w1 %>% mutate(wave = 1)
  ) %>% 
  mutate_at(vars(PSCS3_1, PSCS3_2, PSCS3_3, PSCS3_4, PSCS3_5, PSCS3_6, PSCS3_7, PSCS3_8, PSCS3_9, PDHWS1_1, PDHWS1_3), as.numeric) %>% 
  mutate(wave_time_label = case_when(
    wave == 1 ~ w1_time_lab,
    wave == 2 ~ w2_time_lab,
    wave == 3 ~ w3_time_lab
  )) %>% 
  mutate(wave_time_label = factor(wave_time_label, levels = c(w1_time_lab, w2_time_lab, w3_time_lab))) %>% 
  mutate(Education = case_when(
    Education == "66" ~ NA_character_,
    Education == "99" ~ NA_character_,
    T ~ Education
  )) %>% 
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>% 
  mutate(MigrationBackground = case_when(
    MigrationBackground == "yes" ~ transl("label_yes", lang),
    MigrationBackground == "no" ~ transl("label_no", lang),
    T ~ MigrationBackground
  )) %>% 
  mutate(AgeGroup = case_when(
    Age %in% 10:15 ~ "10-15",
    Age %in% 16:30 ~ "16-30",
    Age %in% 31:64 ~ "31-64",
    Age %in% 65:150 ~ "65+",
  ))

# digicom_data %>% count(Age, sort =T)

std.error <- function(x) sd(x, na.rm =T)/sqrt(length(x))

# digicom_data %>% count(MigrationBackground, wave)

# 2. HELPER FUNCTIONS & DATA PREPARATION =======================================

# Translation mapping functions for common demographic values
get_gender_map <- function(lang) {
  list(
    "Male" = transl("label_male", lang),
    "Female" = transl("label_female", lang)
  )
}

get_education_map <- function(lang) {
  list(
    "Low" = transl("label_low_education", lang),
    "Middle" = transl("label_middle_education", lang),
    "High" = transl("label_high_education", lang)
  )
}

get_yes_no_map <- function(lang) {
  list(
    "Yes" = transl("label_yes", lang),
    "No" = transl("label_no", lang)
  )
}

get_y_label_percentage <- function(lang) {
  transl("label_percentage_respondents", lang)
}

get_y_label_number <- function(lang) {
  transl("label_number_respondents", lang)
}

education_levels <- c("Primary (basisonderwijs)", 
                      "Pre-Vocational (vmbo)", 
                      "Secondary (havo/vwo)", 
                      "Vocational (mbo)", 
                      "Applied Sciences (hbo)", 
                      "University (wo)") %>% 
  tibble(eng = ., oplcat = c("basisonderwijs",
                             "vmbo",
                             "havo/vwo",
                             "mbo",
                             "hbo",
                             "wo"))



# Helper functions for creating multiple visualizations
add_all_viz_timeline <- function(viz, vars, grp_var, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  for (i in seq_along(vars)) {
    # When there's only 1 question, don't add item{i} to avoid single subtab
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    
    # Use identity() to prevent NSE from converting symbols to strings
    viz <- viz |>
      add_viz(
        title        = questions[[i]],
        y_var = identity(vars[[i]]),
        group_var    = identity(grp_var),
        tabgroup     = tabgroup_path
      )
  }
  viz
}

add_all_viz_timeline_single <- function(viz, vars, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  for (i in seq_along(vars)) {
    # When there's only 1 question, don't add item{i} to avoid single subtab
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    
    # Use identity() to prevent NSE from converting symbols to strings
    viz <- viz |>
      add_viz(
        title        = questions[[i]],
        y_var = identity(vars[[i]]),
        tabgroup     = tabgroup_path
      )
  }
  viz
}

add_all_viz_stackedbar <- function(viz, vars, questions, grp_var,
                                   tbgrp, demographic, wave_label) {
  
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  # map demographic -> translation key
  label_keys <- c(
    age    = "tab_age",
    gender = "tab_gender",
    edu    = "tab_education",
    mig    = "tab_migration"
  )
  
  label_key <- label_keys[[demographic]]
  
  for (i in seq_along(vars)) {
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    
    # Use identity() to prevent NSE from converting symbols to strings
    viz <- viz |>
      add_viz(
        title     = questions[[i]],
        x_var     = identity(grp_var),
        x_label   = transl(label_key, lang),
        stack_var = identity(vars[[i]]),
        tabgroup  = tabgroup_path
      )
  }
  viz
}
# stack_map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang))

# Main function
create_vizzes <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                          colors = the_colors, 
                          tbgrp, graph_title, high_values = 4:5, 
                          text_b_tabset = "ADD TEXT BEFORE TABSET", 
                          aggr_lab = get_y_label_percentage(lang),
                          lang = "en") {
  
  # Wave 1, 2 & 3 Overall (stackedbars)
  sis_viz <- create_viz(
    type = "stackedbars",
    x_vars = vs,
    x_var_labels = qs,
    stacked_type = "percent",
    color_palette = colors,
    horizontal = TRUE,
    x_label = "", 
    text_before_tabset = text_b_tabset,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = rev(lbs),
    drop_na_vars = F,
    stack_label = NULL,
    weight_var = "weging_GAMO"
  ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 1",
      filter = ~ wave == 1,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave1/overall")
    ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 2",
      filter = ~ wave == 2,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave2/overall")
    ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 3",
      filter = ~ wave == 3,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave3/overall")
    )
  
  # Over Time Overall (timeline without group_var)
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    text_before_tabset = text_b_tabset,
    y_filter = high_values, 
    y_filter_label = aggr_lab,
    y_filter_combine = T,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_min = 0,
    y_max = 100,
    y_filter_label = NULL,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline_single(vs, tbgrp, "overall", wave_label = "Over Time", questions = qs)  # Pass tbgrp!
  
  # Wave 1 by Age/Gender/Education
  sis_subvizzes <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    text_before_tabset = text_b_tabset,
    stack_order = rev(lbs),
    filter = ~ wave == 1,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>       # Pass tbgrp AND "age"
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1")  |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 1")
  # Pass tbgrp AND "edu"
  
  # Wave 2 by Age/Gender/Education
  sis_subvizzes2 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = rev(lbs),
    text_before_tabset = text_b_tabset,
    filter = ~ wave == 2,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2")|>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 2")
  
  # Wave 3 by Age/Gender/Education
  sis_subvizzes_w3 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = rev(lbs),
    text_before_tabset = text_b_tabset,
    filter = ~ wave == 3,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 3")
  
  # Over Time by Age/Gender/Education
  sis_subvizzes3 <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    y_filter = high_values, 
    text_before_tabset = text_b_tabset,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_min = 0,
    y_max = 100,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline(vs, "AgeGroup", tbgrp, "age", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "geslacht", tbgrp, "gender", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "Education", tbgrp, "edu", wave_label = "Over Time", questions = qs)|>
    add_all_viz_timeline(vs, "MigrationBackground", tbgrp, "mig", wave_label = "Over Time", questions = qs)
  
  # Combine all
  sis_viz %>% 
    combine_viz(sis_subvizzes_time) %>%
    combine_viz(sis_subvizzes) %>%
    combine_viz(sis_subvizzes2) %>%
    combine_viz(sis_subvizzes_w3) %>%
    combine_viz(sis_subvizzes3)
}

create_vizzes2 <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                           colors = the_colors, 
                           tbgrp, graph_title, high_values = 1, map_values, 
                           text_b_tabset = "ADD TEXT BEFORE TABSET", 
                           aggr_lab = transl("label_percentage_correct", lang),
                           lang = "en") {
  
  # Force all parameters to avoid NSE issues with dashboardr
  force(qs); force(vs); force(lbs); force(breaks); force(colors)
  force(map_values); force(tbgrp); force(graph_title); force(high_values)
  force(text_b_tabset); force(aggr_lab)
  
  # Wave 1, 2 & 3 Overall (stackedbars)
  sis_viz <- create_viz(
    type = "stackedbars",
    x_vars = vs,
    x_var_labels = qs,
    stacked_type = "percent",
    color_palette = colors,
    horizontal = TRUE,
    x_label = "",
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = lbs,
    text = "", 
    text_before_tabset = text_b_tabset,
    drop_na_vars = F,
    stack_label = NULL,
    weight_var = "weging_GAMO"
  ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 1",
      filter = ~ wave == 1,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave1/overall")
    ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 2",
      filter = ~ wave == 2,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave2/overall")
    ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 3",
      filter = ~ wave == 3,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave3/overall")
    )
  
  # Over Time Overall (timeline without group_var)
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    y_filter = high_values, 
    y_min = 0,
    y_max = 100,
    y_filter_label = aggr_lab,
    y_filter_combine = T,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline_single(vs, tbgrp, "overall", wave_label = "Over Time", questions = qs)
  
  # Wave 1 by Age/Gender/Education
  sis_subvizzes <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = lbs,
    filter = ~ wave == 1,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 1")
  
  # Wave 2 by Age/Gender/Education
  sis_subvizzes2 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = lbs,
    filter = ~ wave == 2,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 2")
  
  # Wave 3 by Age/Gender/Education
  sis_subvizzes_w3 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = lbs,
    filter = ~ wave == 3,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 3") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 3")
  
  # Over Time by Age/Gender/Education
  sis_subvizzes3 <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    y_filter = high_values, 
    y_min = 0,
    y_max = 100,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_filter_label = NULL,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline(vs, "AgeGroup", tbgrp, "age", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "geslacht", tbgrp, "gender", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "Education", tbgrp, "edu", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "MigrationBackground", tbgrp, "mig", wave_label = "Over Time", questions = qs)
  
  # Combine all
  sis_viz %>% 
    combine_viz(sis_subvizzes_time) %>%
    combine_viz(sis_subvizzes) %>%
    combine_viz(sis_subvizzes2) %>%
    combine_viz(sis_subvizzes_w3) %>%
    combine_viz(sis_subvizzes3)
}



create_vizzes3 <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                           colors = the_colors, 
                           tbgrp, graph_title, high_values = 1, map_values, 
                           text_b_tabset = "ADD TEXT BEFORE TABSET", 
                           aggr_lab = transl("label_percentage_correct", lang),
                           lang = "en") {
  
  # Wave 1 & 2 Overall (stackedbars) - Wave 3 performance items excluded per design
  sis_viz <- create_viz(
    type = "stackedbars",
    x_vars = vs,
    x_var_labels = qs,
    stacked_type = "percent",
    color_palette = colors,
    horizontal = TRUE,
    x_label = "",
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = rev(lbs),
    text = "", 
    text_before_tabset = text_b_tabset,
    drop_na_vars = F,
    stack_label = NULL,
    weight_var = "weging_GAMO"
  ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 1",
      filter = ~ wave == 1,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave1/overall")
    ) %>%
    add_viz(
      title = graph_title, 
      title_tabset = "Wave 2",
      filter = ~ wave == 2,
      icon = "ph:chart-bar",
      tabgroup = glue::glue("{tbgrp}/wave2/overall")
    )
  
  # Over Time Overall (timeline without group_var) - restricted to Waves 1 & 2
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    filter = ~ wave %in% c(1, 2),
    y_filter = high_values, 
    y_min = 0,
    y_max = 100,
    y_filter_label = aggr_lab,
    y_filter_combine = T,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline_single(vs, tbgrp, "overall", wave_label = "Over Time", questions = qs)  # Pass tbgrp!
  
  # Wave 1 by Age/Gender/Education
  sis_subvizzes <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = rev(lbs),
    filter = ~ wave == 1,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>       # Pass tbgrp AND "age"
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1")  |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 1")         # Pass tbgrp AND "edu"
  
  # Wave 2 by Age/Gender/Education
  sis_subvizzes2 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_map_values = map_values,
    stack_order = rev(lbs),
    filter = ~ wave == 2,
    drop_na_vars = F,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2")|>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 2")
  
  # Over Time by Age/Gender/Education - restricted to Waves 1 & 2
  sis_subvizzes3 <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    filter = ~ wave %in% c(1, 2),
    y_filter = high_values, 
    y_min = 0,
    y_max = 100,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_filter_label = NULL,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline(vs, "AgeGroup", tbgrp, "age", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "geslacht", tbgrp, "gender", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "Education", tbgrp, "edu", wave_label = "Over Time", questions = qs)|>
    add_all_viz_timeline(vs, "MigrationBackground", tbgrp, "mig", wave_label = "Over Time", questions = qs)
  
  # Combine all
  sis_viz %>% 
    combine_viz(sis_subvizzes_time) %>%
    combine_viz(sis_subvizzes) %>%
    combine_viz(sis_subvizzes2) %>%
    combine_viz(sis_subvizzes3)
}


# 3. KNOWLEDGE VISUALIZATIONS ==================================================

## 3.1 Knowledge Tabs Setup ----

knowledge_labs <- c("Low (0-9)", "Middle (10-19)", "High (20-29)")
knowledge_breaks <- c(0, 10, 20, 30)
vs <- "MeanKnowledge"
qs <- "Knowledge Score"
tbgrp <- "knowledge"

knowledge_tex <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_knowledge", lang), "\", preset = \"question\")"),
  "```"
)



# Shared labels & question blockquotes for Knowledge, Skills, and Performance
knowledge_item_labs <- c(
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang),
  transl("dunno_understand", lang)
)
knowledge_map_values <- list(
  "1" = transl("label_correctly_answered", lang),
  "0" = transl("label_incorrectly_answered", lang)
)

sis_labs <- c(
  transl("scale_completely_untrue", lang),
  transl("scale_neither", lang),
  transl("scale_completely_true", lang)
)
sis_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

perf_correct_labs  <- c(transl("label_incorrect", lang), transl("label_correct", lang))
perf_selected_labs <- c(transl("label_not_selected", lang), transl("label_selected", lang))
perf_correct_map   <- list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang))
perf_selected_map  <- list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang))

skills_short      <- transl("page_text_skills_short", lang)
knowledge_short   <- transl("page_text_knowledge_short", lang)
performance_short <- transl("page_text_performance_short", lang)

skills_intro_text    <- paste0(skills_short, "\n", sis_tex_question, "\n")
knowledge_intro_text <- paste0(knowledge_short, "\n", knowledge_tex, "\n")

make_perf_intro <- function(blockquote_key) {
  bq <- md_text(
    "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
    paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl(blockquote_key, lang))), "', preset = 'question')"),
    "```"
  )
  paste0(performance_short, "\n", bq, "\n")
}

build_knowledge_viz <- function(q_keys, vars, tbgrp, graph_title = "") {
  qs <- vapply(q_keys, transl, character(1), lang = lang, USE.NAMES = FALSE)
  if (identical(graph_title, "QUESTIONS")) graph_title <- qs
  create_vizzes2(
    breaks        = knowledge_breaks,
    qs            = qs,
    vs            = vars,
    lbs           = knowledge_item_labs,
    tex           = "",
    tbgrp         = tbgrp,
    graph_title   = graph_title,
    map_values    = knowledge_map_values,
    text_b_tabset = knowledge_intro_text,
    lang          = lang
  )
}

build_skills_viz <- function(q_keys, vars, tbgrp, title_key) {
  qs <- vapply(q_keys, transl, character(1), lang = lang, USE.NAMES = FALSE)
  create_vizzes(
    qs            = qs,
    vs            = vars,
    lbs           = sis_labs,
    tex           = sis_tex_question,
    breaks        = c(0.5, 2.5, 3.5, 5.5),
    tbgrp         = tbgrp,
    text_b_tabset = skills_intro_text,
    graph_title   = transl(title_key, lang)
  )
}

build_perf_viz <- function(q_keys, vars, tbgrp, blockquote_key, type = c("correct", "selected"), graph_title = "") {
  type <- match.arg(type)
  qs <- vapply(q_keys, transl, character(1), lang = lang, USE.NAMES = FALSE)
  if (identical(graph_title, "QUESTIONS")) graph_title <- qs
  create_vizzes3(
    breaks        = knowledge_breaks,
    qs            = qs,
    vs            = vars,
    lbs           = if (type == "correct") perf_correct_labs else perf_selected_labs,
    text_b_tabset = make_perf_intro(blockquote_key),
    tbgrp         = tbgrp,
    graph_title   = graph_title,
    map_values    = if (type == "correct") perf_correct_map else perf_selected_map,
    lang          = lang
  )
}

# 3. KNOWLEDGE VISUALIZATIONS ==================================================
kinfo_viz_wo_link    <- build_knowledge_viz(c("KInfo1", "KInfo2"), c("KInfo1RC", "KInfo2RC"), "kinfo")
critinfo_viz_wo_link <- build_knowledge_viz("KInfo3", "KInfo3RC", "critinfo", "QUESTIONS")
knet_viz_wo_link     <- build_knowledge_viz("KCom3", "KCom3RC", "knet", "QUESTIONS")
kcrea_viz_wo_link    <- build_knowledge_viz(c("KCrea2", "KCrea3"), c("KCrea2RC", "KCrea3RC"), "kcrea")
ksafety_viz_wo_link  <- build_knowledge_viz(c("KSafDev2", "KPriv1", "KPriv2"), c("KSafDev2RC", "KPriv1RC", "KPriv2RC"), "ksafety")
khealth_viz_wo_link  <- build_knowledge_viz(c("KHealth2", "KHealth3"), c("KHealth2RC", "KHealth3RC"), "khealth")
kgreen_viz_wo_link   <- build_knowledge_viz(c("KEnv2", "KEnv3"), c("KEnv2RC", "KEnv3RC"), "kgreen")
ktrans_viz_wo_link   <- build_knowledge_viz(c("Ktrans2", "Ktrans3"), c("Ktrans2RC", "Ktrans3RC"), "ktrans")
kai_viz_wo_link      <- build_knowledge_viz(c("KAI1", "KAI2", "KAI3", "KAI4"), c("KAI1RC", "KAI2RC", "KAI3RC", "KAI4RC"), "kai")
kgai_viz_wo_link     <- build_knowledge_viz(c("KGAI1", "KGAI2", "KGAI3", "KGAI4", "KGAI5"), c("KGAI1RC", "KGAI2RC", "KGAI3RC", "KGAI4RC", "KGAI5RC"), "kgai")

# 4. SKILLS VISUALIZATIONS =====================================================
sis_viz_wo_link     <- build_skills_viz(c("SInfo1", "SInfo3_V2", "SInfo4"), c("SInfo1", "SInfo3_V2", "SInfo4"), "sis", "title_strategic_information_skills")
cis_viz_wo_link     <- build_skills_viz(c("SInfo5", "SInfo6", "SInfo7"), c("SInfo5", "SInfo6", "SInfo7"), "cis", "title_critical_information_skills")
nskills_viz_wo_link <- build_skills_viz(c("SCom1_V2", "SCom2", "SCom4_V2", "SCom5"), c("SCom1_V2", "SCom2", "SCom4_V2", "SCom5"), "nskills", "title_netiquette_skills")
dccs_viz_wo_link    <- build_skills_viz(c("SCrea2", "SCrea3", "SCrea4", "SCrea5"), c("SCrea2", "SCrea3", "SCrea4", "SCrea5"), "dccs", "title_digital_content_creation_skills")
safety_viz_wo_link  <- build_skills_viz(c("SSafDev1", "SSafDev2", "SPriv1", "SPriv2", "SPriv3", "SPriv4", "SCom3"), c("SSafDev1", "SSafDev2", "SPriv1", "SPriv2", "SPriv3", "SPriv4", "SCom3"), "safety", "title_safety_control_skills")
dhealth_viz_wo_link <- build_skills_viz(c("SHealth1", "SHealth2_V2", "SHealth3_V2"), c("SHealth1", "SHealth2_V2", "SHealth3_V2"), "dhealth", "title_digital_health_wellbeing_skills")
green_viz_wo_link   <- build_skills_viz(c("SEnv1", "SEnv2", "SEnv3"), c("SEnv1", "SEnv2", "SEnv3"), "green", "title_sustainable_green_digital_skills")
dprob_viz_wo_link   <- build_skills_viz(c("SProbl1", "SProbl2"), c("SProbl1", "SProbl2"), "dprob", "title_digital_problem_solving_skills")
trans_viz_wo_link   <- build_skills_viz(c("Strans1", "Strans2", "Strans3", "Strans4", "Strans5"), c("Strans1", "Strans2", "Strans3", "Strans4", "Strans5"), "trans", "title_transactional_skills")
ai_viz_wo_link      <- build_skills_viz(c("SAI1", "SAI2"), c("SAI1", "SAI2"), "ai", "title_ai_skills")

# Generative AI Skills (Wave 1 has SGAI1-3; Waves 2-3 have SGAI1-5)
genai_questions_w2 <- vapply(c("SGAI1", "SGAI2", "SGAI3", "SGAI4", "SGAI5"), transl, character(1), lang = lang, USE.NAMES = FALSE)
genai_vars_w2      <- c("SGAI1", "SGAI2", "SGAI3", "SGAI4", "SGAI5")
genai_questions_w1 <- genai_questions_w2[1:3]
genai_vars_w1      <- genai_vars_w2[1:3]

build_genai_wave_overall <- function(w_num, vs, qs) {
  create_viz(
    type = "stackedbars", x_vars = vs, x_var_labels = qs, stacked_type = "percent",
    color_palette = the_colors, horizontal = TRUE, x_label = "",
    text_before_tabset = skills_intro_text, stack_breaks = c(0.5, 2.5, 3.5, 5.5),
    stack_bin_labels = sis_labs, stack_order = rev(sis_labs), drop_na_vars = FALSE,
    stack_label = NULL, filter = as.formula(paste0("~ wave == ", w_num)), weight_var = "weging_GAMO"
  ) %>%
    add_viz(
      title = "GenAI Skills", title_tabset = paste0("Wave ", w_num),
      icon = "ph:chart-bar", tabgroup = paste0("genai/wave", w_num, "/overall")
    )
}

build_genai_wave_demo <- function(w_num, vs, qs) {
  w_lbl <- paste0("Wave ", w_num)
  create_viz(
    type = "stackedbar", stacked_type = "percent", horizontal = TRUE,
    stack_breaks = c(0.5, 2.5, 3.5, 5.5), stack_bin_labels = sis_labs,
    stack_order = rev(sis_labs), text_before_tabset = skills_intro_text,
    filter = as.formula(paste0("~ wave == ", w_num)), drop_na_vars = FALSE,
    color_palette = the_colors, weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", "genai", "age", wave_label = w_lbl) |>
    add_all_viz_stackedbar(vs, qs, "geslacht", "genai", "gender", wave_label = w_lbl) |>
    add_all_viz_stackedbar(vs, qs, "Education", "genai", "edu", wave_label = w_lbl) |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", "genai", "mig", wave_label = w_lbl)
}

genai_overtime_overall_wo_link <- create_viz(
  type = "timeline", time_var = "wave_time_label", chart_type = "line",
  text_before_tabset = skills_intro_text, y_filter = 4:5, y_filter_combine = TRUE,
  x_label = "", y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors, y_min = 0, y_max = 100, y_filter_label = NULL, weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline_single(genai_vars_w2, "genai", "overall", wave_label = "Over Time", questions = genai_questions_w2)

genai_overtime_demo_wo_link <- create_viz(
  type = "timeline", time_var = "wave_time_label", chart_type = "line",
  y_filter = 4:5, text_before_tabset = skills_intro_text, x_label = "",
  y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors, y_min = 0, y_max = 100, weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline(genai_vars_w2, "AgeGroup", "genai", "age", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "geslacht", "genai", "gender", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "Education", "genai", "edu", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "MigrationBackground", "genai", "mig", wave_label = "Over Time", questions = genai_questions_w2)

genai_viz_wo_link <- build_genai_wave_overall(1, genai_vars_w1, genai_questions_w1) %>%
  combine_viz(build_genai_wave_overall(2, genai_vars_w2, genai_questions_w2)) %>%
  combine_viz(build_genai_wave_overall(3, genai_vars_w2, genai_questions_w2)) %>%
  combine_viz(genai_overtime_overall_wo_link) %>%
  combine_viz(build_genai_wave_demo(1, genai_vars_w1, genai_questions_w1)) %>%
  combine_viz(build_genai_wave_demo(2, genai_vars_w2, genai_questions_w2)) %>%
  combine_viz(build_genai_wave_demo(3, genai_vars_w2, genai_questions_w2)) %>%
  combine_viz(genai_overtime_demo_wo_link)

# 5. PERFORMANCE VISUALIZATIONS ================================================
gh_img <- function(key) paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl(key, lang))

perf_sis_viz_wo_link <- build_perf_viz(c("PSIS1", "PSIS2"), c("PSIS1RC", "PSIS2R"), "perf_sis", "blockquote_performance_sis", "correct") %>%
  add_modal(modal_id = "PSIS2R", title = transl("more_info", lang), image = gh_img("strategic_info_infobox_image"), image_width = "50%")

perf_cis_viz_wo_link <- build_perf_viz(c("PCIS1", "PCIS2", "PCIS3"), c("PCIS1R", "PCIS2R", "PCIS3R"), "perf_cis", "blockquote_performance_cis", "correct") %>%
  add_modal(modal_id = "PCIS1R", title = transl("more_info", lang), image = gh_img("critical_info_competence_q1_infobox_image"), image_width = "50%") %>%
  add_modal(modal_id = "PCIS2R", title = transl("more_info", lang), image = gh_img("critical_info_competence_q2_infobox_image"), image_width = "50%") %>%
  add_modal(modal_id = "PCIS3R", title = transl("more_info", lang), image = gh_img("critical_info_competence_q3_infobox_image"), image_width = "50%")

perf_netiquette_viz_wo_link <- build_perf_viz("PNS1", "PNS1R", "perf_netiquette", "blockquote_performance_netiquette", "correct", "QUESTIONS") %>%
  add_modal(modal_id = "PNS1R", title = transl("more_info", lang), image = gh_img("netiquette_competence_infobox_image"), image_width = "50%")

perf_dccs_viz_wo_link <- build_perf_viz("PDCCS1", "PDCCS1R", "perf_dccs", "blockquote_performance_dccs", "correct", "QUESTIONS") %>%
  add_modal(modal_id = "PDCCS1R", title = transl("more_info", lang), image = gh_img("digital_content_creation_competence_infobox_image"), image_width = "50%")

perf_safety_viz_wo_link <- build_perf_viz(paste0("PSCS3_", 1:10), paste0("PSCS3_", 1:10), "perf_safety", "blockquote_performance_safety", "selected") %>%
  add_modal(modal_id = "PSCS3_1", title = transl("more_info", lang), image = gh_img("safety_competence_infobox_image"), image_width = "50%")

perf_pscs1_viz_wo_link <- build_perf_viz("PSCS1", "PSCS1R", "perf_pscs1", "blockquote_performance_pscs1", "correct", "QUESTIONS") %>%
  add_modal(modal_id = "PSCS1R", title = transl("more_info", lang), image = "PSCS1.jpg", image_width = "80%")

perf_health_viz_wo_link <- build_perf_viz(paste0("PDHWS1_", 1:8), paste0("PDHWS1_", 1:8), "perf_health", "blockquote_performance_health", "selected")
perf_green_viz_wo_link  <- build_perf_viz(paste0("PSGDS1_", 1:9), paste0("PSGDS1_", 1:9), "perf_green", "blockquote_performance_green", "selected")
perf_ps_viz_wo_link     <- build_perf_viz(paste0("SourceHelp_", 1:9), paste0("SourceHelp_", 1:9), "perf_ps", "blockquote_performance_problem_solving", "selected")

perf_trans_viz_wo_link <- build_perf_viz("PTS1", "PTS1R", "perf_trans", "blockquote_performance_trans", "correct", "QUESTIONS") %>%
  add_modal(modal_id = "PTS1R", title = transl("more_info", lang), image = gh_img("transactional_competence_infobox_image"), image_width = "50%")

perf_ai_viz_wo_link <- build_perf_viz(paste0("PAIS2_", 1:9), paste0("PAIS2_", 1:9), "perf_ai", "blockquote_performance_ai", "selected") %>%
  add_modal(modal_id = "PAIS2_1", title = transl("more_info", lang), image = gh_img("ai_competence_infobox_image"), image_width = "50%")

perf_genai_viz_wo_link <- build_perf_viz(c("PGAIS1", "PAIS1"), c("PGAIS1RC", "PAIS1R"), "perf_genai", "blockquote_performance_genai", "correct") %>%
  add_modal(modal_id = "PAIS1R", title = transl("more_info", lang), image = gh_img("genai_competence_infobox_image"), image_width = "50%")

# 6. DIMENSION-SPECIFIC COMBINED VISUALIZATIONS ================================
suppressWarnings(library(htmltools))

label_dim_tabs <- function(viz, ...) {
  extra_labels <- list(...)
  base_labels <- list(
    wave1    = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)),
    wave2    = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3    = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age      = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)),
    gender   = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)),
    edu      = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig      = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)),
    overall  = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang))
  )
  for (k in 1:9) {
    base_labels[[paste0("item", k)]] <- paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " ", k)
  }
  do.call(set_tabgroup_labels, c(list(viz), extra_labels, base_labels))
}

strategic_visualizations <- label_dim_tabs(
  sis_viz_wo_link + kinfo_viz_wo_link + perf_sis_viz_wo_link,
  sis      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_skills", lang)),
  kinfo    = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_knowledge", lang)),
  perf_sis = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_performance", lang))
)

critical_info_visualizations <- label_dim_tabs(
  cis_viz_wo_link + critinfo_viz_wo_link + perf_cis_viz_wo_link,
  cis      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_critical_info_skills", lang)),
  critinfo = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_critical_info_knowledge", lang)),
  perf_cis = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_critical_info_performance", lang))
)

netiquette_visualizations <- label_dim_tabs(
  nskills_viz_wo_link + knet_viz_wo_link + perf_netiquette_viz_wo_link,
  nskills         = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_netiquette_skills", lang)),
  knet            = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_netiquette_knowledge", lang)),
  perf_netiquette = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_netiquette_performance", lang))
)

content_creation_visualizations <- label_dim_tabs(
  dccs_viz_wo_link + kcrea_viz_wo_link + perf_dccs_viz_wo_link,
  dccs      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_content_creation_skills", lang)),
  kcrea     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_content_creation_knowledge", lang)),
  perf_dccs = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_content_creation_performance", lang))
)

safety_visualizations <- label_dim_tabs(
  safety_viz_wo_link + ksafety_viz_wo_link + perf_safety_viz_wo_link + perf_pscs1_viz_wo_link,
  safety      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_safety_skills", lang)),
  ksafety     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_safety_knowledge", lang)),
  perf_safety = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_safety_performance", lang)),
  perf_pscs1  = paste0("{{< iconify ph warning-fill >}} ", transl("tab_phishing_recognition", lang))
)

health_visualizations <- label_dim_tabs(
  dhealth_viz_wo_link + khealth_viz_wo_link + perf_health_viz_wo_link,
  dhealth     = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_digital_health_skills", lang)),
  khealth     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_digital_health_knowledge", lang)),
  perf_health = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_digital_health_performance", lang))
)

green_visualizations <- label_dim_tabs(
  green_viz_wo_link + kgreen_viz_wo_link + perf_green_viz_wo_link,
  green      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_green_skills", lang)),
  kgreen     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_green_knowledge", lang)),
  perf_green = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_green_performance", lang))
)

problem_solving_visualizations <- label_dim_tabs(
  dprob_viz_wo_link + perf_ps_viz_wo_link,
  dprob   = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_problem_solving_skills", lang)),
  perf_ps = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_problem_solving_performance", lang))
)

transactional_visualizations <- label_dim_tabs(
  trans_viz_wo_link + ktrans_viz_wo_link + perf_trans_viz_wo_link,
  trans      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_transactional_skills", lang)),
  ktrans     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_transactional_knowledge", lang)),
  perf_trans = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_transactional_performance", lang))
)

ai_visualizations <- label_dim_tabs(
  ai_viz_wo_link + kai_viz_wo_link + perf_ai_viz_wo_link,
  ai      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_ai_skills", lang)),
  kai     = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_ai_knowledge", lang)),
  perf_ai = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_ai_performance", lang))
)

genai_combined_visualizations <- label_dim_tabs(
  genai_viz_wo_link + kgai_viz_wo_link + perf_genai_viz_wo_link,
  genai      = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_genai_skills", lang)),
  kgai       = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_genai_knowledge", lang)),
  perf_genai = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_genai_performance", lang))
)

# 8. DASHBOARD CREATION ========================================================

## 8.1 Navigation Menus ----
dimensions_menu <- navbar_menu(
  text = transl("menu_dimensions", lang),
  pages = c(transl("page_name_strategic_info", lang), transl("page_name_critical_info", lang), 
            transl("page_name_netiquette", lang), transl("page_name_content_creation", lang),
            transl("page_name_safety", lang), transl("page_name_digital_health", lang), 
            transl("page_name_green", lang),
            transl("page_name_problem_solving", lang), transl("page_name_transactional", lang),
            transl("page_name_ai", lang), transl("page_name_genai", lang)),
  icon = "ph:books-fill"
)

# More Info dropdown menu with About and Wave pages (aligned right)
more_info_menu <- navbar_menu(
  text = transl("menu_more_info", lang),
  pages = c(
    transl("page_name_about", lang),
    transl("page_name_ronde1", lang),
    transl("page_name_ronde2", lang),
    transl("page_name_ronde3", lang)
  ),
  icon = "ph:info-fill",
  align = "right"
)




# transl("landing_page_text", "en") %>% md_text()

## 8.1b Landing Page Dimension Tiles & Dimension Jump Links ----
main_color <- "#3D7271"

landing_pages <- tribble(
  ~slug,                      ~icon,                  ~title_key,                   ~card_key,               ~has_knowledge,
  "strategic_information",    "ph:magnifying-glass",  "page_name_strategic_info",   "card_strategic_info",   TRUE,
  "critical_information",     "ph:detective-fill",    "page_name_critical_info",    "card_critical_info",    TRUE,
  "netiquette",               "ph:chats-fill",        "page_name_netiquette",       "card_netiquette",       TRUE,
  "digital_content_creation", "ph:palette-fill",      "page_name_content_creation", "card_content_creation", TRUE,
  "safety",                   "ph:shield-check-fill", "page_name_safety",           "card_safety",           TRUE,
  "digital_health",           "ph:heart-fill",        "page_name_digital_health",   "card_digital_health",   TRUE,
  "green_digital",            "ph:recycle-fill",      "page_name_green",            "card_green",            TRUE,
  "digital_problem_solving",  "ph:lightbulb-fill",    "page_name_problem_solving",  "card_problem_solving",  FALSE,
  "transactional",            "ph:wallet-fill",       "page_name_transactional",    "card_transactional",    TRUE,
  "ai",                       "ph:robot-fill",        "page_name_ai",               "card_ai",               TRUE,
  "gen_ai",                   "ph:magic-wand-fill",   "page_name_genai",            "card_genai",            TRUE
)

digiq_shared_css <- "
  /* DigIQ Unified Theme & Editorial Observatory Styling */
  html { scroll-behavior: smooth; }
  section.level2 { scroll-margin-top: 85px; }

  /* Navbar hover readability */
  .navbar a:hover, .navbar .navbar-brand:hover, .navbar .navbar-nav .nav-link:hover {
    color: #3D7271 !important;
  }
  .navbar a:hover svg, .navbar .aa-DetachedSearchButton:hover svg, .navbar button:hover svg {
    fill: #3D7271 !important;
    stroke: #3D7271 !important;
  }

  /* Underline tabsets in DigIQ Teal & Terracotta instead of default royal blue */
  .panel-tabset .nav-item a::after {
    background-color: #E28D50 !important;
  }
  .panel-tabset .nav-tabs .nav-link.active {
    color: #0F6B5A !important;
    font-weight: 700 !important;
  }
  .panel-tabset .nav-tabs .nav-link.active::after {
    background-color: #3D7271 !important;
    height: 3px !important;
  }

  /* Question blockquotes in clean DigIQ Teal */
  blockquote.blockquote {
    border-left: 4px solid #3D7271 !important;
    background: linear-gradient(90deg, #f4f9f8 0%, #fafcfc 100%) !important;
    color: #1e3332 !important;
    border-radius: 0 8px 8px 0 !important;
    padding: 13px 20px !important;
    box-shadow: 0 1px 4px rgba(15, 45, 43, 0.04) !important;
  }

  /* Clickable modal links inside question blockquotes */
  a.modal-link {
    color: #0F6B5A !important;
    font-weight: 600;
    text-decoration: underline !important;
    text-decoration-color: rgba(15, 107, 90, 0.45) !important;
    text-underline-offset: 3px;
    transition: color 0.15s ease, text-decoration-color 0.15s ease;
  }
  a.modal-link:hover {
    color: #E28D50 !important;
    text-decoration-color: #E28D50 !important;
  }

  /* Wave 3 missing-data callout note on Performance sections */
  .dc-wave3-note {
    display: flex;
    align-items: flex-start;
    gap: 0.65rem;
    border: 1px solid #ebd5c3;
    border-left: 4px solid #E28D50;
    background: linear-gradient(90deg, #fdf8f3 0%, #fffcfa 100%);
    color: #5c3314;
    padding: 0.7rem 1.05rem;
    border-radius: 0 8px 8px 0;
    margin: 0.75rem 0 1.1rem 0;
    font-size: 0.92rem;
    line-height: 1.5;
  }
  .dc-wave3-note iconify-icon {
    color: #E28D50;
    font-size: 1.15rem;
    flex-shrink: 0;
    margin-top: 0.14rem;
  }

  /* Landing page: hide redundant Quarto title header & style Editorial Observatory Hero */
  body:has(.dc-observatory-hero) #title-block-header {
    display: none;
  }
  .dc-observatory-hero {
    position: relative;
    overflow: hidden;
    margin: 0.5rem 0 2rem 0;
    padding: 2.2rem 2.5rem 1.75rem 2.5rem;
    border-radius: 16px;
    background:
      radial-gradient(circle at 96% 8%, rgba(61, 114, 113, 0.11) 0%, transparent 45%),
      radial-gradient(circle at 4% 95%, rgba(226, 141, 80, 0.08) 0%, transparent 40%),
      linear-gradient(180deg, #ffffff 0%, #f7fbfa 100%);
    border: 1px solid #d5e3e0;
    box-shadow: 0 1px 3px rgba(15, 45, 43, 0.03), 0 10px 30px -8px rgba(15, 45, 43, 0.07);
  }
  .dc-observatory-hero::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, #0F6B5A 0%, #3D7271 62%, #E28D50 100%);
  }
  .dc-hero-eyebrow {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.75rem;
    font-weight: 700;
    letter-spacing: 0.09em;
    text-transform: uppercase;
    color: #0F6B5A;
    background: #eaf4f1;
    border: 1px solid #cbe2dc;
    padding: 0.28rem 0.75rem;
    border-radius: 999px;
    margin-bottom: 0.95rem;
  }
  .dc-hero-dot {
    width: 7px;
    height: 7px;
    border-radius: 50%;
    background-color: #E28D50;
    box-shadow: 0 0 0 3px rgba(226, 141, 80, 0.22);
  }
  .dc-hero-title {
    font-size: 2rem;
    font-weight: 800;
    letter-spacing: -0.025em;
    color: #122928;
    margin: 0 0 0.75rem 0;
    line-height: 1.2;
  }
  .dc-hero-lead p {
    font-size: 1.03rem;
    line-height: 1.65;
    color: #364f4d;
    max-width: 880px;
    margin: 0 0 0.55rem 0;
  }
  .dc-hero-lead p:first-child {
    font-weight: 600;
    color: #1c3b39;
  }
  .dc-hero-metrics {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(195px, 1fr));
    gap: 0.9rem;
    margin-top: 1.45rem;
    padding-top: 1.25rem;
    border-top: 1px solid #e1ecea;
  }
  .dc-metric-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.65rem 0.9rem;
    background: rgba(255, 255, 255, 0.85);
    border: 1px solid #e2ecea;
    border-radius: 10px;
  }
  .dc-metric-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: #eef6f4;
    color: #3D7271;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    flex-shrink: 0;
  }
  .dc-metric-val {
    font-size: 0.98rem;
    font-weight: 700;
    color: #142d2c;
    line-height: 1.2;
  }
  .dc-metric-sub {
    font-size: 0.78rem;
    color: #5b7472;
    margin-top: 0.1rem;
  }

  /* Landing page 11-tile Bento Grid */
  .dc-links {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(285px, 1fr));
    gap: 1.15rem;
    margin: 1.25rem 0 2.25rem 0;
  }
  @media (min-width: 1100px) {
    .dc-links {
      grid-template-columns: repeat(6, minmax(0, 1fr));
    }
    .dc-links > .dc-link {
      grid-column: span 2;
    }
    /* Center the final 2 AI cards (10 & 11) on the bottom row */
    .dc-links > .dc-link:nth-child(10) {
      grid-column: 2 / span 2;
    }
    .dc-links > .dc-link:nth-child(11) {
      grid-column: 4 / span 2;
    }
  }
  .dc-link {
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 1.35rem 1.4rem 1.15rem 1.4rem;
    border-radius: 13px;
    border: 1px solid #dce7e5;
    border-left: 4px solid #3D7271;
    background: #ffffff;
    color: inherit !important;
    text-decoration: none !important;
    text-align: left;
    box-shadow: 0 1px 2px rgba(15, 40, 38, 0.03), 0 6px 18px -4px rgba(15, 40, 38, 0.05);
    transition: transform 0.22s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.22s cubic-bezier(0.16, 1, 0.3, 1), border-color 0.2s ease;
  }
  .dc-link::after {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, #3D7271, #E28D50);
    opacity: 0;
    transition: opacity 0.22s ease;
  }
  .dc-link:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 8px rgba(15, 40, 38, 0.04), 0 16px 32px -6px rgba(15, 40, 38, 0.11);
    border-color: #b8cfcc;
    border-left-color: #E28D50;
  }
  .dc-link:hover::after {
    opacity: 1;
  }
  .dc-card-watermark {
    position: absolute;
    right: -10px;
    bottom: -14px;
    font-size: 5.4rem;
    color: #3D7271;
    opacity: 0.04;
    pointer-events: none;
    transition: transform 0.3s ease, opacity 0.3s ease, color 0.3s ease;
  }
  .dc-link:hover .dc-card-watermark {
    transform: scale(1.08) rotate(-5deg);
    opacity: 0.075;
    color: #0F6B5A;
  }
  .dc-card-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.75rem;
    margin-bottom: 0.75rem;
  }
  .dc-card-title-group {
    display: flex;
    align-items: center;
    gap: 0.7rem;
    min-width: 0;
  }
  .dc-card-emblem {
    width: 38px;
    height: 38px;
    border-radius: 9px;
    background: #eef5f3;
    border: 1px solid #d5e6e2;
    color: #0F6B5A;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 1.22rem;
    flex-shrink: 0;
    transition: background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease, transform 0.2s ease;
  }
  .dc-link:hover .dc-card-emblem {
    background: #3D7271;
    border-color: #3D7271;
    color: #ffffff;
    transform: scale(1.04);
  }
  .dc-link-title {
    font-weight: 700;
    color: #142c2b;
    font-size: 1.05rem;
    letter-spacing: -0.01em;
    line-height: 1.25;
    transition: color 0.2s ease;
  }
  .dc-link:hover .dc-link-title {
    color: #0F6B5A;
  }
  .dc-card-num {
    font-family: 'Fira Code', monospace;
    font-size: 0.73rem;
    font-weight: 600;
    color: #7c9694;
    background: #f3f7f6;
    border: 1px solid #e3ecea;
    padding: 0.14rem 0.48rem;
    border-radius: 6px;
    flex-shrink: 0;
    transition: color 0.2s ease, border-color 0.2s ease, background-color 0.2s ease;
  }
  .dc-link:hover .dc-card-num {
    color: #9c4215;
    background: #fdf3eb;
    border-color: #f0cdb4;
  }
  .dc-link-text {
    position: relative;
    z-index: 1;
    font-size: 0.91rem;
    line-height: 1.54;
    color: #495e5d;
    margin-bottom: 1rem;
    flex-grow: 1;
  }
  .dc-card-footer {
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-top: 0.65rem;
    border-top: 1px solid #eff4f3;
    font-size: 0.8rem;
    font-weight: 600;
    color: #3D7271;
    letter-spacing: 0.01em;
    transition: color 0.2s ease;
  }
  .dc-card-cta-arrow {
    display: inline-flex;
    align-items: center;
    font-size: 0.95rem;
    color: #88a3a0;
    transition: transform 0.2s ease, color 0.2s ease;
  }
  .dc-link:hover .dc-card-footer {
    color: #0F6B5A;
  }
  .dc-link:hover .dc-card-cta-arrow {
    transform: translateX(4px);
    color: #E28D50;
  }

  /* Dimension page intro panel & unified architectural jump-chips */
  .dc-dim-intro {
    background: #ffffff;
    border: 1px solid #d8e4e2;
    border-left: 5px solid #3D7271;
    border-radius: 12px;
    padding: 1.2rem 1.45rem;
    margin: 0.65rem 0 1.65rem 0;
    box-shadow: 0 2px 12px rgba(15, 45, 43, 0.04);
  }
  .dc-dim-intro > p {
    font-size: 1.01rem;
    line-height: 1.65;
    color: #213736;
    margin-bottom: 0.8rem;
  }
  .dc-jump-row {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.45rem;
    padding-top: 0.7rem;
    border-top: 1px solid #e7f0ee;
    font-size: 0.92rem;
    color: #425958;
    margin: 0;
  }
  .dc-jump-label {
    font-weight: 600;
    color: #1b3332;
    margin-right: 0.15rem;
  }
  a.dc-jump-link {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    padding: 0.24rem 0.7rem;
    border-radius: 7px;
    background: #f3f8f7;
    border: 1px solid #cde0dd;
    color: #0F6B5A !important;
    font-size: 0.86rem;
    font-weight: 600;
    text-decoration: none !important;
    transition: all 0.16s ease;
  }
  a.dc-jump-link:hover {
    background: #3D7271;
    border-color: #3D7271;
    color: #ffffff !important;
    transform: translateY(-1px);
    box-shadow: 0 3px 8px rgba(61, 114, 113, 0.18);
  }
"

digiq_shared_js <- "
<script>
(function() {
  function initDigIQNavEnhancements() {
    // Page-aware Language Switcher (preserves current page filename & #hash)
    var langLinks = document.querySelectorAll('a.nav-link[href*=\"favstats.github.io/digicomp\"]');
    var path = window.location.pathname || '';
    var parts = path.split('/').filter(Boolean);
    var lastPart = parts.length ? parts[parts.length - 1] : 'index.html';
    var pageFile = (lastPart.indexOf('.html') !== -1) ? lastPart : 'index.html';
    var isEN = path.indexOf('/en/') !== -1 || (parts.length && parts[parts.length - 1] === 'en');

    function updateLangHrefs() {
      var hash = window.location.hash || '';
      langLinks.forEach(function(link) {
        if (isEN) {
          link.setAttribute('href', '../' + pageFile + hash);
          link.setAttribute('title', 'Bekijk deze pagina in het Nederlands');
        } else {
          link.setAttribute('href', './en/' + pageFile + hash);
          link.setAttribute('title', 'View this page in English');
        }
      });
    }
    updateLangHrefs();
    window.addEventListener('hashchange', updateLangHrefs);
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initDigIQNavEnhancements);
  } else {
    initDigIQNavEnhancements();
  }
})();
</script>
"

explore_cta_label <- if (lang == "nl") "Bekijk dimensie" else "Explore dimension"

landing_cards_html <- imap_chr(
  transpose(landing_pages),
  function(row, idx) {
    num_str <- sprintf("%02d", idx)
    paste0(
      "<a class='dc-link' href='", row$slug, ".html'>",
      "<iconify-icon class='dc-card-watermark' icon='", row$icon, "'></iconify-icon>",
      "<div>",
      "<div class='dc-card-top'>",
      "<div class='dc-card-title-group'>",
      "<span class='dc-card-emblem'><iconify-icon icon='", row$icon, "'></iconify-icon></span>",
      "<span class='dc-link-title'>", transl(row$title_key, lang), "</span>",
      "</div>",
      "<span class='dc-card-num'>", num_str, "</span>",
      "</div>",
      "<div class='dc-link-text'>", transl(row$card_key, lang), "</div>",
      "</div>",
      "<div class='dc-card-footer'>",
      "<span>", explore_cta_label, "</span>",
      "<span class='dc-card-cta-arrow'><iconify-icon inline icon='ph:arrow-right-bold'></iconify-icon></span>",
      "</div>",
      "</a>"
    )
  }
)

hero_eyebrow <- if (lang == "nl") "Project CID · Nationale Monitor Digitale Competentie" else "Project CID · National Digital Competence Monitor"
hero_m1_val  <- if (lang == "nl") "5.307 Respondenten" else "5,307 Respondents"
hero_m1_sub  <- if (lang == "nl") "Gewogen nationale steekproef (10–100 jaar)" else "Weighted national sample (aged 10–100)"
hero_m2_val  <- if (lang == "nl") "3 Datarondes" else "3 Survey Waves"
hero_m2_sub  <- "Dec '24 · Jun '25 · Dec '25"
hero_m3_val  <- if (lang == "nl") "11 Dimensies" else "11 Dimensions"
hero_m3_sub  <- if (lang == "nl") "Van informatie & veiligheid tot GenAI" else "From information & safety to GenAI"
hero_m4_val  <- if (lang == "nl") "3 Meetpijlers" else "3 Measurement Pillars"
hero_m4_sub  <- if (lang == "nl") "Vaardigheden · Kennis · Prestatie" else "Skills · Knowledge · Performance"

unified_theme_css <- paste0(
  "```{=html}\n",
  "<style>", digiq_shared_css, "</style>\n",
  digiq_shared_js, "\n",
  "```\n"
)

landing_hero_html <- paste0(
  "```{=html}\n",
  "<style>", digiq_shared_css, "</style>\n",
  digiq_shared_js, "\n",
  "<div class='dc-observatory-hero'>\n",
  "  <div class='dc-hero-eyebrow'><span class='dc-hero-dot'></span> ", hero_eyebrow, "</div>\n",
  "  <h1 class='dc-hero-title'>", transl("dashboard_title", lang), "</h1>\n",
  "  <div class='dc-hero-lead'>\n",
  "    <p>", gsub("\\*\\*(.*?)\\*\\*", "<strong>\\1</strong>", gsub("\n\n", "</p><p>", transl("landing_page_text", lang), fixed = TRUE)), "</p>\n",
  "  </div>\n",
  "  <div class='dc-hero-metrics'>\n",
  "    <div class='dc-metric-item'><div class='dc-metric-icon'><iconify-icon icon='ph:users-three-fill'></iconify-icon></div><div><div class='dc-metric-val'>", hero_m1_val, "</div><div class='dc-metric-sub'>", hero_m1_sub, "</div></div></div>\n",
  "    <div class='dc-metric-item'><div class='dc-metric-icon'><iconify-icon icon='ph:chart-line-up-bold'></iconify-icon></div><div><div class='dc-metric-val'>", hero_m2_val, "</div><div class='dc-metric-sub'>", hero_m2_sub, "</div></div></div>\n",
  "    <div class='dc-metric-item'><div class='dc-metric-icon'><iconify-icon icon='ph:squares-four-fill'></iconify-icon></div><div><div class='dc-metric-val'>", hero_m3_val, "</div><div class='dc-metric-sub'>", hero_m3_sub, "</div></div></div>\n",
  "    <div class='dc-metric-item'><div class='dc-metric-icon'><iconify-icon icon='ph:compass-tool-fill'></iconify-icon></div><div><div class='dc-metric-val'>", hero_m4_val, "</div><div class='dc-metric-sub'>", hero_m4_sub, "</div></div></div>\n",
  "  </div>\n",
  "</div>\n```\n"
)

landing_links <- paste0(
  "```{=html}\n",
  "<div class='dc-links'>\n",
  paste(landing_cards_html, collapse = "\n"),
  "\n</div>\n```\n"
)

slugify_anchor <- function(x) {
  tolower(gsub(" +", "-", trimws(x)))
}

dim_page_intro <- function(desc_key, skills_key, knowledge_key = NULL, perf_key, lang) {
  s_anchor <- paste0("#", slugify_anchor(transl(skills_key, lang)))
  p_anchor <- paste0("#", slugify_anchor(transl(perf_key, lang)))

  s_label <- if (lang == "nl") "zelfingeschatte vaardigheden" else "self-assessed skills"
  k_label <- if (lang == "nl") "items die kennis testen" else "items testing knowledge"
  p_label <- if (lang == "nl") "prestaties/gedrag" else "performance/behavior"

  s_link <- paste0("<a class='dc-jump-link' href='", s_anchor, "'><iconify-icon inline icon='ph:lightning-fill'></iconify-icon> <span>", s_label, "</span> &#8595;</a>")
  p_link <- paste0("<a class='dc-jump-link' href='", p_anchor, "'><iconify-icon inline icon='ph:clipboard-text'></iconify-icon> <span>", p_label, "</span> &#8595;</a>")

  if (!is.null(knowledge_key)) {
    k_anchor <- paste0("#", slugify_anchor(transl(knowledge_key, lang)))
    k_link <- paste0("<a class='dc-jump-link' href='", k_anchor, "'><iconify-icon inline icon='ph:book-open-fill'></iconify-icon> <span>", k_label, "</span> &#8595;</a>")
    intro_label <- if (lang == "nl") "Dit wordt op drie manieren gemeten:" else "It is measured in three ways:"
    and_sep <- if (lang == "nl") "en" else "and"
    jump_html <- paste0(
      "<div class='dc-jump-row'>",
      "<span class='dc-jump-label'>", intro_label, "</span> ",
      s_link, " ", k_link, " <span>", and_sep, "</span> ", p_link,
      "</div>"
    )
  } else {
    intro_label <- if (lang == "nl") "Dit wordt op twee manieren gemeten:" else "It is measured in two ways:"
    and_sep <- if (lang == "nl") "en" else "and"
    jump_html <- paste0(
      "<div class='dc-jump-row'>",
      "<span class='dc-jump-label'>", intro_label, "</span> ",
      s_link, " <span>", and_sep, "</span> ", p_link,
      "</div>"
    )
  }

  md_text(
    "```{=html}",
    paste0("<style>", digiq_shared_css, "</style>"),
    digiq_shared_js,
    "```",
    "",
    "::: {.dc-dim-intro}",
    transl(desc_key, lang),
    "",
    "```{=html}",
    jump_html,
    "```",
    ":::"
  )
}

## 8.2 Dashboard Pages & Configuration ----
# Create comprehensive dashboard with ALL features
dashboard <- create_dashboard(
  ## Descriptions
  title = "DigIQ Monitor", 
  output_dir = if (lang == "nl") "qmds" else "qmds_en", 
  publish_dir = if (lang == "nl") "../docs" else "../docs/en",
  author = "Fabio Votta",
  description = "DigIQ Monitor",
  page_footer = "© 2025 DigIQ Monitor - All Rights Reserved",
  date = "2025-11-20",
  logo = "logo.png",
  ## Themes / Styles
  page_layout = "full",
  theme = "flatly",  # Options: cosmo, flatly, darkly, minty, pulse, etc.
  tabset_theme = "underline",  # This is YOUR style! 
  math = "katex",
  mobile_toc = T,
  search = TRUE,
  code_overflow = "wrap",        # ← From your original
  html_math_method = "mathjax",  # ← From your original
  #### Navbar settings
  navbar_sections = list(dimensions_menu, more_info_menu),  # Dimensions + More Info menus
  navbar_style = "dark",
  navbar_brand = "Digital Competence Insights Dashboard",
  navbar_toggle = "collapse",
  navbar_bg_color = "#f0f0f0",
  navbar_text_color = "#3A1B00E6", 
  navbar_text_hover_color = "#3D7271",
  ## pagination settings
  pagination_position = "both",
  pagination_separator = "/", 
  # github = "https://github.com/favstats/dashboardr",
  # linkedin = "https://linkedin.com/in/username",
  # email = "user@example.com",
  # website = "https://www.dedigiq.nl/",
  breadcrumbs = FALSE,
  page_navigation = TRUE,
  back_to_top = TRUE,
  # repo_url = "https://github.com/username/dashboardr",
  self_contained = F,        # ← From your original
  # viewport_width = 1200,
  # viewport_scale = 0.3,
  # toc = "floating",
  # toc_depth = 3,
  code_tools = FALSE,  # ← Add this to explicitly disable the Code button
  code_folding = NULL, # ← Make sure this is NULL or FALSE too
  plausible = "pa-UnPiJwxFi8TS-XAvCdgQx",
  metrics_style = "bootstrap",
  backend = "echarts4r"
) %>%
  # Landing page with Editorial Observatory Hero and 11 Bento Dimension Cards
  add_page(
    name = transl("dashboard_title", lang),
    text = md_text(
      landing_hero_html,
      "",
      landing_links,
      "",
      "<div style='text-align: center; color: #4a5b5a; font-size: 0.96rem; margin-top: 0.5rem;'>",
      transl("landing_more_info", lang),
      "",
      "<br>",
      "<br>",
      "<center><img src='bzk.jpg' width='360'></center>",
      "</div>"
    ),
    icon = "line-md:monitor-mutlple",
    is_landing_page = TRUE
  ) %>%
  # Analysis page with data and visualizations
  add_page(
    name = transl("page_name_strategic_info", lang),
    slug = "strategic_information",
    icon = "ph:magnifying-glass",
    data = digicom_data,
    visualizations = strategic_visualizations,
    text = dim_page_intro("strategic_info_description", "tab_skills", "tab_knowledge", "tab_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_critical_info", lang),
    slug = "critical_information",
    icon = "ph:detective-fill",
    data = digicom_data,
    visualizations = critical_info_visualizations,
    text = dim_page_intro("critical_info_description", "tab_critical_info_skills", "tab_critical_info_knowledge", "tab_critical_info_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_netiquette", lang),
    slug = "netiquette",
    icon = "ph:chats-fill",
    data = digicom_data,
    visualizations = netiquette_visualizations,
    text = dim_page_intro("netiquette_description", "tab_netiquette_skills", "tab_netiquette_knowledge", "tab_netiquette_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_content_creation", lang),
    slug = "digital_content_creation",
    icon = "ph:palette-fill",
    data = digicom_data,
    visualizations = content_creation_visualizations,
    text = dim_page_intro("content_creation_description", "tab_content_creation_skills", "tab_content_creation_knowledge", "tab_content_creation_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_safety", lang),
    slug = "safety",
    icon = "ph:shield-check-fill",
    data = digicom_data,
    visualizations = safety_visualizations,
    text = dim_page_intro("safety_description", "tab_safety_skills", "tab_safety_knowledge", "tab_safety_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_digital_health", lang),
    slug = "digital_health",
    icon = "ph:heart-fill",
    data = digicom_data,
    visualizations = health_visualizations,
    text = dim_page_intro("health_description", "tab_digital_health_skills", "tab_digital_health_knowledge", "tab_digital_health_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_green", lang),
    slug = "green_digital",
    icon = "ph:recycle-fill",
    data = digicom_data,
    visualizations = green_visualizations,
    text = dim_page_intro("green_description", "tab_green_skills", "tab_green_knowledge", "tab_green_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_problem_solving", lang),
    slug = "digital_problem_solving",
    icon = "ph:lightbulb-fill",
    data = digicom_data,
    visualizations = problem_solving_visualizations,
    text = dim_page_intro("problem_solving_description", "tab_problem_solving_skills", NULL, "tab_problem_solving_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_transactional", lang),
    slug = "transactional",
    icon = "ph:wallet-fill",
    data = digicom_data,
    visualizations = transactional_visualizations,
    text = dim_page_intro("transactional_description", "tab_transactional_skills", "tab_transactional_knowledge", "tab_transactional_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_ai", lang),
    slug = "ai",
    icon = "ph:robot-fill",
    data = digicom_data,
    visualizations = ai_visualizations,
    text = dim_page_intro("ai_description", "tab_ai_skills", "tab_ai_knowledge", "tab_ai_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_genai", lang),
    slug = "gen_ai",
    icon = "ph:magic-wand-fill",
    data = digicom_data,
    visualizations = genai_combined_visualizations,
    text = dim_page_intro("genai_description", "tab_genai_skills", "tab_genai_knowledge", "tab_genai_performance", lang)
  ) %>%
  # About page (now in More Info dropdown)
  add_page(
    name = transl("page_name_about", lang),
    slug = "about",
    icon = "ph:info-fill",
    text = md_text(
      unified_theme_css,
      "<div style='text-align: justify;'>",
      transl("about_page_text_v2", lang),
      "",
      "::: {.panel-tabset}",
      "",
      "#### Fabio Votta",
      "",
      "```{r, echo=FALSE}",
      "suppressWarnings(library(htmltools))",
      "",
      "card <- div(",
      "  class = 'card',",
      "  div(",
      "    class = 'row no-gutters align-items-center',",
      "    div(",
      "      class = 'col-md-2',",
      "      div(",
      "        style = 'display: flex; justify-content: center;',",
      "        img(",
      "          class = 'card-img',",
      "          src = 'https://algosoc.org/uploads/_card/fabio-votta-1.jpg',",
      "          style = 'max-width: 500px;'",
      "        )",
      "      )",
      "    ),",
      "    div(",
      "      class = 'col-md-10',",
      "      div(",
      "        class = 'card-body',",
      "        p(",
      "          class = 'card-text',",
      "          'Fabio Votta is a Postdoc at the University of Amsterdam who studies digital political campaigns and the role of ad delivery algorithms. He is particularly interested in how political actors use targeted campaign messages to reach specific voters and how social media platforms enable these practices.'",
      "        ),",
      "        div(",
      "          style = 'display: flex; justify-content: flex-end',",
      "          a(href = 'https://www.favstats.eu/', 'Website: favstats.eu')",
      "        )",
      "      )",
      "    )",
      "  )",
      ")",
      "",
      "card",
      "```",
      "",
      "#### Ernesto de León",
      "",
      "```{r, echo=FALSE}",
      "card <- shiny::fluidPage(",
      "  tags$head(",
      "    tags$link(rel = 'stylesheet', href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css')",
      "  ),",
      "  div(",
      "    class = 'card',",
      "    div(",
      "      class = 'row no-gutters align-items-center',",
      "      div(",
      "        class = 'col-md-2',",
      "        div(",
      "          style = 'display: flex; justify-content: center;',",
      "          img(",
      "            class = 'card-img',",
      "            src = 'https://algosoc.org/uploads/_card/Ernesto-de-Leon.jpeg',",
      "            style = 'max-width: 500px;'",
      "          )",
      "        )",
      "      ),",
      "      div(",
      "        class = 'col-md-10',",
      "        div(",
      "          class = 'card-body',",
      "          p(",
      "            class = 'card-text',",
      "            'Ernesto de León focuses on political information flows in a digital age and its effects on political attitudes. In these projects, he makes use of computational methodologies to explore web behaviour, use of algorithmic intermediaries to news (such as social media and search engines), and to conduct large-scale automated content analyses through text-as-data approaches.'",
      "          ),",
      "          div(",
      "            style = 'display: flex; justify-content: flex-end',",
      "            a(href = 'https://www.ernesto-deleon.com/', 'Website: ernesto-deleon.com')",
      "          )",
      "        )",
      "      )",
      "    )",
      "  )",
      ")",
      "",
      "card",
      "```",
      "",
      ":::",
      "",
      "<br>",
      "<br>",
      "<center><img src='bzk.jpg' width='360'></center>",
      "</div>"
    )
  )

# 7. WAVE SAMPLE PAGES (Ronde 1, 2, 3): Pre-compute demographics & correlations ==

# Helper: create a frequency table for a variable
w1_make_freq <- function(data, var_name, labels_map = NULL, exclude_vals = NULL) {
  vals <- data[[var_name]]
  if (!is.null(exclude_vals)) {
    vals[as.character(vals) %in% as.character(exclude_vals)] <- NA
  }
  if (!is.null(labels_map)) {
    vals <- as.character(vals)
    for (k in names(labels_map)) vals[vals == k] <- labels_map[[k]]
  }
  tbl <- table(vals, useNA = "no")
  df <- data.frame(Category = names(tbl), N = as.integer(tbl), stringsAsFactors = FALSE)
  df$Pct <- round(100 * df$N / sum(df$N), 1)
  if (!is.null(labels_map)) {
    df$Category <- factor(df$Category, levels = unname(labels_map))
    df <- df[order(df$Category), ]
  }
  df
}

# Helper: create a styled reactable from a freq table
w1_styled_reactable <- function(df) {
  max_pct <- max(df$Pct, na.rm = TRUE)
  cat_header <- if (lang == "nl") "Categorie" else "Category"
  reactable::reactable(df,
    compact = TRUE, borderless = TRUE, striped = TRUE,
    defaultPageSize = nrow(df), pagination = FALSE,
    theme = reactable::reactableTheme(
      headerStyle = list(background = "#3D7271", color = "white", fontWeight = "bold", fontSize = "13px"),
      cellStyle = list(fontSize = "13px")
    ),
    columns = list(
      Category = reactable::colDef(name = cat_header, minWidth = 180),
      N = reactable::colDef(name = "N", align = "right", minWidth = 60),
      Pct = reactable::colDef(name = "%", align = "left", minWidth = 200,
        cell = function(value) {
          if (is.na(value)) return(htmltools::span("—"))
          bar_width <- paste0(round(value / max_pct * 100), "%")
          htmltools::div(style = "display: flex; align-items: center;",
            htmltools::div(style = paste0("background: #E28D50; height: 16px; width: ", bar_width, "; border-radius: 3px; margin-right: 8px;")),
            htmltools::span(paste0(value, "%"))
          )
        }
      )
    )
  )
}

build_wave_sample_content <- function(w_num) {
  wave_data_page <- digicom_data %>% filter(wave == w_num)
  w_n_total <- nrow(wave_data_page)

  # 1. Age group (PDF spec: 10-15, 16-30, 31-60, 61-110)
  wave_data_page$AgeGroupW1 <- cut(wave_data_page$Age, breaks = c(10, 16, 31, 61, 110),
    right = FALSE, labels = c("10-15", "16-30", "31-60", "61-110"))
  w1_age_df <- w1_make_freq(wave_data_page, "AgeGroupW1")

  # 2. Gender (normalize numeric/string codes from Wave 3 alongside text labels)
  wave_data_page$GenderNorm <- as.character(wave_data_page$Gender)
  wave_data_page$GenderNorm[wave_data_page$GenderNorm == "1"] <- "Male"
  wave_data_page$GenderNorm[wave_data_page$GenderNorm == "2"] <- "Female"
  wave_data_page$GenderNorm[wave_data_page$GenderNorm == "4"] <- "X"
  wave_data_page$GenderNorm[wave_data_page$GenderNorm == "99"] <- "I'd rather not say"

  w1_gender_df <- w1_make_freq(wave_data_page, "GenderNorm",
    labels_map = c("Male" = transl("label_male", lang),
                   "Female" = transl("label_female", lang),
                   "X" = "X",
                   "I'd rather not say" = transl("scale_prefer_not_answer", lang)))

  # 3. Education level (Education column is already translated & factored)
  w1_edu_df <- w1_make_freq(wave_data_page, "Education")

  # 4. Migration background
  w1_mig_df <- w1_make_freq(wave_data_page, "MigrationBackground")

  # 5. Panel type
  wave_data_page$SampleRW1 <- ifelse(wave_data_page$Sample %in% c(1, 2, "1", "2", "Panel adults", "Panel children"),
    transl("w1_panel", lang),
    ifelse(wave_data_page$Sample %in% c(3, 4, "3", "4", "Address sample"),
      transl("w1_address", lang), NA))
  w1_sample_df <- w1_make_freq(wave_data_page, "SampleRW1")

  # 6. Use of Devices
  w1_device_labels <- setNames(
    c(transl("w1_device_never", lang), transl("w1_device_almost_never", lang),
      transl("w1_device_sometimes", lang), transl("w1_device_often", lang),
      transl("w1_device_very_often", lang)),
    c("1", "2", "3", "4", "5"))
  w1_comp_df <- w1_make_freq(wave_data_page, "UseComp", labels_map = w1_device_labels, exclude_vals = c("66", "99"))
  w1_tablet_df <- w1_make_freq(wave_data_page, "UseTablet", labels_map = w1_device_labels, exclude_vals = c("66", "99"))
  w1_phone_df <- w1_make_freq(wave_data_page, "UsePhone", labels_map = w1_device_labels, exclude_vals = c("66", "99"))

  # 7. General Literacy
  w1_lit_labels <- setNames(
    c(transl("w1_lit_never", lang), transl("w1_lit_almost_never", lang),
      transl("w1_lit_sometimes", lang), transl("w1_lit_often", lang),
      transl("w1_lit_very_often", lang)),
    c("1", "2", "3", "4", "5"))
  w1_lit_df <- w1_make_freq(wave_data_page, "Literacy", labels_map = w1_lit_labels, exclude_vals = c("66", "99"))

  # 8. Work status
  w1_work_labels <- setNames(
    c(transl("w1_work_student", lang), transl("w1_work_employed", lang),
      transl("w1_work_housekeeper", lang), transl("w1_work_unemployed", lang),
      transl("w1_work_retired", lang), transl("w1_work_volunteer", lang),
      transl("w1_work_other", lang)),
    c("1", "2", "3", "4", "5", "6", "7"))
  w1_work_df <- w1_make_freq(wave_data_page, "Work", labels_map = w1_work_labels, exclude_vals = c("99"))

  # 9. Hours of work with computer (employed only)
  w1_employed <- wave_data_page %>% filter(Work == 2 | Work == "2" | Work == "Employed")
  w1_work2_df <- NULL
  if (nrow(w1_employed) > 0 && "Work_2" %in% names(w1_employed)) {
    w1_work2_hours <- as.numeric(w1_employed$Work_2)
    w1_work2_hours <- w1_work2_hours[!is.na(w1_work2_hours)]
    w1_work2_df <- data.frame(
      Statistic = c(transl("w1_work2_n", lang), transl("w1_work2_mean", lang),
                    transl("w1_work2_median", lang)),
      Value = c(length(w1_work2_hours),
                round(mean(w1_work2_hours, na.rm = TRUE), 1),
                round(median(w1_work2_hours, na.rm = TRUE), 1)),
      stringsAsFactors = FALSE
    )
  }

  # 10. Financial insecurity
  w1_fin_labels <- setNames(
    c(transl("w1_fin_completely_untrue", lang), transl("w1_fin_slightly_untrue", lang),
      transl("w1_fin_neither", lang), transl("w1_fin_slightly_true", lang),
      transl("w1_fin_completely_true", lang)),
    c("1", "2", "3", "4", "5"))
  w1_fin_df <- w1_make_freq(wave_data_page, "FinancialInsecurity", labels_map = w1_fin_labels, exclude_vals = c("66", "99"))

  # -- Correlation heatmap (Spearman, 19 variables per PDF spec) --

  # Compute TotalPerformance
  w1_perf_items <- c("PSIS1RC", "PSIS2R", "PCIS1R", "PCIS2R", "PCIS3R", "PNS1R",
    "PDCCS1R", "PSCS1R", "PSCS3R", "PDHWS1R", "PSGDS1R", "SourceHelpR",
    "PAIS2R", "PAIS1R", "PGAIS1RC", "PTS1R")
  w1_avail_perf <- intersect(w1_perf_items, names(wave_data_page))
  if (length(w1_avail_perf) > 0) {
    wave_data_page$TotalPerformance <- rowSums(wave_data_page[, w1_avail_perf], na.rm = FALSE)
  }

  # Compute demographic dummies per PDF spec
  wave_data_page$GenderN <- ifelse(wave_data_page$Gender %in% c(1, "1", "Male"), 1,
    ifelse(wave_data_page$Gender %in% c(2, "2", "Female"), 0, NA))
  wave_data_page$EducationN <- ifelse(wave_data_page$EducationR == "Low" | wave_data_page$EducationR == 1, 1,
    ifelse(wave_data_page$EducationR == "Middle" | wave_data_page$EducationR == 2, 2,
    ifelse(wave_data_page$EducationR == "High" | wave_data_page$EducationR == 3, 3, NA)))
  wave_data_page$MigrationBackgroundN <- ifelse(wave_data_page$MigrationBackground == transl("label_no", lang), 0,
    ifelse(wave_data_page$MigrationBackground == transl("label_yes", lang), 1, NA))
  wave_data_page$SampleN <- ifelse(wave_data_page$Sample %in% c(1, 2, "1", "2", "Panel adults", "Panel children"), 1,
    ifelse(wave_data_page$Sample %in% c(3, 4, "3", "4", "Address sample"), 0, NA))
  wave_data_page$Work_Werk <- ifelse(wave_data_page$Work == 2 | wave_data_page$Work == "2", 1, 0)
  wave_data_page$Work_Stud <- ifelse(wave_data_page$Work == 1 | wave_data_page$Work == "1", 1, 0)
  wave_data_page$LiteracyN <- as.numeric(wave_data_page$Literacy)
  wave_data_page$LiteracyN[wave_data_page$LiteracyN %in% c(66, 99)] <- NA
  wave_data_page$FinancialInsecurityN <- as.numeric(wave_data_page$FinancialInsecurity)
  wave_data_page$FinancialInsecurityN[wave_data_page$FinancialInsecurityN %in% c(66, 99)] <- NA
  if ("MeanKnowledge" %in% names(wave_data_page)) {
    wave_data_page$TotalKnowledge <- wave_data_page$MeanKnowledge
  }

  # Full variable set (19 variables per PDF spec; filter to columns with >= 2 non-NA observations)
  w1_cor_vars <- c("MeanStratInfo", "MeanCritInfo", "MeanNet", "MeanCrea",
    "MeanSaf", "MeanHealth", "MeanTrans", "MeanGreen", "MeanProbl",
    "MeanAI", "MeangenAI", "TotalKnowledge", "TotalPerformance",
    "GenderN", "Work_Werk", "Work_Stud", "Work_2", "LiteracyN", "FinancialInsecurityN")
  w1_avail_vars <- intersect(w1_cor_vars, names(wave_data_page))
  if ("Work_2" %in% w1_avail_vars) {
    wave_data_page$Work_2 <- as.numeric(wave_data_page$Work_2)
  }
  w1_avail_vars <- w1_avail_vars[sapply(w1_avail_vars, function(v) sum(!is.na(wave_data_page[[v]])) >= 2)]

  w1_cor_plot <- NULL
  if (length(w1_avail_vars) >= 2) {
    w1_cor_data <- wave_data_page[, w1_avail_vars]
    w1_cor_matrix <- suppressWarnings(cor(w1_cor_data, method = "spearman", use = "pairwise.complete.obs"))

    w1_display_names <- if (lang == "nl") {
      c("MeanStratInfo" = "Strat. Info", "MeanCritInfo" = "Krit. Info",
        "MeanNet" = "Netiquette", "MeanCrea" = "Inhoudscreatie", "MeanSaf" = "Veiligheid",
        "MeanHealth" = "Gezondheid", "MeanTrans" = "Transactioneel", "MeanGreen" = "Groen Digitaal",
        "MeanProbl" = "Probleemopl.", "MeanAI" = "AI", "MeangenAI" = "GenAI",
        "TotalKnowledge" = "Tot. Kennis", "TotalPerformance" = "Tot. Prestatie",
        "GenderN" = "Geslacht", "Work_Werk" = "Werkend", "Work_Stud" = "Scholier/Student",
        "Work_2" = "Werkuren", "LiteracyN" = "Geletterdheid", "FinancialInsecurityN" = "Fin. Onzekerheid")
    } else {
      c("MeanStratInfo" = "Strat. Info", "MeanCritInfo" = "Crit. Info",
        "MeanNet" = "Netiquette", "MeanCrea" = "Creativity", "MeanSaf" = "Safety",
        "MeanHealth" = "Health", "MeanTrans" = "Transactional", "MeanGreen" = "Green",
        "MeanProbl" = "Problem Solv.", "MeanAI" = "AI", "MeangenAI" = "GenAI",
        "TotalKnowledge" = "Tot. Knowledge", "TotalPerformance" = "Tot. Performance",
        "GenderN" = "Gender", "Work_Werk" = "Employed", "Work_Stud" = "Student",
        "Work_2" = "Work Hours", "LiteracyN" = "Literacy", "FinancialInsecurityN" = "Fin. Insecurity")
    }
    rownames(w1_cor_matrix) <- w1_display_names[rownames(w1_cor_matrix)]
    colnames(w1_cor_matrix) <- w1_display_names[colnames(w1_cor_matrix)]

    w1_cor_melted <- reshape2::melt(w1_cor_matrix)
    names(w1_cor_melted) <- c("Var1", "Var2", "Correlation")
    w1_cor_melted$Var1 <- factor(w1_cor_melted$Var1, levels = w1_display_names[w1_avail_vars])
    w1_cor_melted$Var2 <- factor(w1_cor_melted$Var2, levels = rev(w1_display_names[w1_avail_vars]))
    w1_cor_melted$Correlation[as.numeric(w1_cor_melted$Var1) < as.numeric(factor(w1_cor_melted$Var2, levels = levels(w1_cor_melted$Var1)))] <- NA

    cor_legend_label <- if (lang == "nl") "Correlatie" else "Correlation"
    w1_cor_plot <- ggplot(w1_cor_melted, aes(x = Var1, y = Var2, fill = Correlation)) +
      geom_tile(color = "white") +
      geom_text(aes(label = ifelse(is.na(Correlation), "", sprintf("%.2f", Correlation))),
        color = "black", size = 2.5) +
      scale_fill_gradient2(low = "#E28D50", mid = "white", high = "#3D7271",
        midpoint = 0, limits = c(-1, 1), na.value = "white") +
      theme_minimal(base_size = 12) +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        axis.text.y = element_text(size = 10),
        plot.title = element_text(size = 14, face = "bold", color = "#3D7271"),
        legend.position = "right"
      ) +
      labs(title = transl("w1_cor_title", lang),
        x = "", y = "", fill = cor_legend_label)
  }

  # Build Wave sample content collection using dashboardr functions
  dev_section_hdr <- if (lang == "nl") "Gebruik van apparaten" else "Use of Devices"
  tab_comp_lbl <- if (lang == "nl") "Computer" else "Computer"
  tab_tab_lbl  <- if (lang == "nl") "Tablet" else "Tablet"
  tab_phn_lbl  <- if (lang == "nl") "Telefoon" else "Phone"

  wave_content <- create_content() %>%
    add_text(paste0("**N = ", format(w_n_total, big.mark = ","),
      " | ", transl("w1_label_mean_age", lang), ": ",
      round(mean(wave_data_page$Age, na.rm = TRUE), 1), "**")) %>%
    add_text(paste0("### ", transl("w1_header_age_group", lang))) %>%
    add_reactable(w1_styled_reactable(w1_age_df)) %>%
    add_text(paste0("### ", transl("w1_header_gender", lang))) %>%
    add_reactable(w1_styled_reactable(w1_gender_df)) %>%
    add_text(paste0("### ", transl("w1_header_education", lang))) %>%
    add_reactable(w1_styled_reactable(w1_edu_df)) %>%
    add_text(paste0("### ", transl("w1_header_migration", lang))) %>%
    add_reactable(w1_styled_reactable(w1_mig_df)) %>%
    add_text(paste0("### ", transl("w1_header_panel", lang))) %>%
    add_reactable(w1_styled_reactable(w1_sample_df)) %>%
    add_text(paste0("### ", dev_section_hdr)) %>%
    add_reactable(w1_styled_reactable(w1_comp_df), tabgroup = tab_comp_lbl) %>%
    add_reactable(w1_styled_reactable(w1_tablet_df), tabgroup = tab_tab_lbl) %>%
    add_reactable(w1_styled_reactable(w1_phone_df), tabgroup = tab_phn_lbl) %>%
    add_text(paste0("### ", transl("w1_header_literacy", lang))) %>%
    add_reactable(w1_styled_reactable(w1_lit_df)) %>%
    add_text(paste0("### ", transl("w1_header_work", lang))) %>%
    add_reactable(w1_styled_reactable(w1_work_df))

  if (!is.null(w1_work2_df)) {
    stat_hdr <- if (lang == "nl") "Statistiek" else "Statistic"
    val_hdr <- if (lang == "nl") "Waarde" else "Value"
    w1_work2_rt <- reactable::reactable(w1_work2_df,
      compact = TRUE, borderless = TRUE, striped = TRUE,
      defaultPageSize = nrow(w1_work2_df), pagination = FALSE,
      theme = reactable::reactableTheme(
        headerStyle = list(background = "#3D7271", color = "white", fontWeight = "bold", fontSize = "13px"),
        cellStyle = list(fontSize = "13px")
      ),
      columns = list(
        Statistic = reactable::colDef(name = stat_hdr, minWidth = 180),
        Value = reactable::colDef(name = val_hdr, align = "right", minWidth = 80)
      )
    )
    wave_content <- wave_content %>%
      add_text(paste0("### ", transl("w1_header_work_hours", lang))) %>%
      add_reactable(w1_work2_rt)
  }

  wave_content <- wave_content %>%
    add_text(paste0("### ", transl("w1_header_financial", lang))) %>%
    add_reactable(w1_styled_reactable(w1_fin_df))

  if (!is.null(w1_cor_plot)) {
    wave_content <- wave_content %>%
      add_text(paste0("## ", transl("w1_header_correlations", lang))) %>%
      add_ggplot(w1_cor_plot, width = 14, height = 12)
  }

  wave_content
}

wave_page_intro_html <- function(text_key) {
  samp_lbl <- if (lang == "nl") "Steekproef" else "Sample"
  demo_lbl <- transl("w1_header_demographics", lang)
  dev_lbl  <- if (lang == "nl") "Gebruik van apparaten" else "Use of Devices"
  cor_lbl  <- transl("w1_header_correlations", lang)
  jump_lbl <- if (lang == "nl") "Ga direct naar:" else "Jump to section:"

  s_anch <- paste0("#", slugify_anchor(samp_lbl))
  d_anch <- paste0("#", slugify_anchor(demo_lbl))
  v_anch <- paste0("#", slugify_anchor(dev_lbl))
  c_anch <- paste0("#", slugify_anchor(cor_lbl))

  jump_bar <- paste0(
    "<div class='dc-dim-intro' style='margin-bottom: 1.4rem;'>",
    "<div class='dc-jump-row' style='border-top: none; padding-top: 0;'>",
    "<span class='dc-jump-label'>", jump_lbl, "</span> ",
    "<a class='dc-jump-link' href='", s_anch, "'><iconify-icon inline icon='ph:users-three-fill'></iconify-icon> <span>", samp_lbl, "</span> &#8595;</a> ",
    "<a class='dc-jump-link' href='", d_anch, "'><iconify-icon inline icon='ph:chart-bar-fill'></iconify-icon> <span>", demo_lbl, "</span> &#8595;</a> ",
    "<a class='dc-jump-link' href='", v_anch, "'><iconify-icon inline icon='ph:devices-fill'></iconify-icon> <span>", dev_lbl, "</span> &#8595;</a> ",
    "<a class='dc-jump-link' href='", c_anch, "'><iconify-icon inline icon='ph:squares-four-fill'></iconify-icon> <span>", cor_lbl, "</span> &#8595;</a>",
    "</div></div>"
  )

  md_text(
    unified_theme_css,
    "```{=html}",
    jump_bar,
    "```",
    "<div style='text-align: justify;'>",
    transl(text_key, lang),
    "</div>",
    "",
    paste0("## ", demo_lbl)
  )
}

wave1_content <- build_wave_sample_content(1)
wave2_content <- build_wave_sample_content(2)
wave3_content <- build_wave_sample_content(3)

# Resume dashboard pipeline
dashboard <- dashboard %>%

  # Ronde 1 / Wave 1 page (in More Info dropdown)
  add_page(
    name = transl("page_name_ronde1", lang),
    slug = "wave_1",
    icon = "ph:number-circle-one-fill",
    data = digicom_data,
    text = wave_page_intro_html("ronde1_page_text"),
    visualizations = wave1_content
  ) %>%

  # Ronde 2 / Wave 2 page (in More Info dropdown)
  add_page(
    name = transl("page_name_ronde2", lang),
    slug = "wave_2",
    icon = "ph:number-circle-two-fill",
    data = digicom_data,
    text = wave_page_intro_html("ronde2_page_text"),
    visualizations = wave2_content
  ) %>%

  # Ronde 3 / Wave 3 page (in More Info dropdown)
  add_page(
    name = transl("page_name_ronde3", lang),
    slug = "wave_3",
    icon = "ph:number-circle-three-fill",
    data = digicom_data,
    text = wave_page_intro_html("ronde3_page_text"),
    visualizations = wave3_content
  ) %>%
  add_powered_by_dashboardr(style = "badge", size = "large") %>%
  # Add a "Powered by" link with icon and text
  add_navbar_element(
    text = lang_change(lang),
    icon = if (lang == "nl") "circle-flags:uk" else "circle-flags:lang-nl",
    href = if (lang == "nl") "https://favstats.github.io/digicomp/en" else "https://favstats.github.io/digicomp",
    align = "right"
  )  

# Test the print methods
cat("=== Dashboard Project Summary ===\n")
print(dashboard)

cat("\n=== Visualization Collection Summary ===\n")
# print(skills_viz)

# cat("\n=== Summary Visualizations ===\n")
# print(summary_vizzes)

files_to_delete <- dir("qmds", pattern = "\\.markdown$", full.names = TRUE)
file.remove(files_to_delete)

files_to_delete <- dir("qmds", pattern = "\\.markdown$", full.names = TRUE)
file.remove(files_to_delete)
# generate_dashboard(dashboard, render = F,  open = "browser")


# Create minimal dashboard with just this page
# test_dashboard <- create_dashboard(
#   title = "Test - Green Digital Page",
#   output_dir = "test_output"
# ) %>% 
#   add_page(name = "HI", visualizations = green_viz, data = digicom_data)
# 
# generate_dashboard(test_dashboard)
## 8.3 Generate Dashboard ----
# Generate the dashboard
cat("\n=== Generating Dashboard ===\n")
generate_dashboard(dashboard, render = F, open = FALSE)


