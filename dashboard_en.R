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




# Using create_viz + add_viz
knowledge_viz <- create_viz(
  type = "bar",
  horizontal = TRUE,
  bar_type = "percent",
  icon = "ph:chart-bar",
  text_before_tabset = knowledge_tex,
  drop_na_vars = F,
  text_position = "above",
  color_palette = the_colors,
  drop_na_vars = F,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "Knowledge Scores",
    x_var = "MeanKnowledge",
    title_tabset = "Wave 1",
    filter = ~ wave == 1,
    x_breaks = knowledge_breaks,
    x_bin_labels = knowledge_labs,
    x_order = knowledge_labs,
    tabgroup = "knowledge/wave1/overall"
  ) %>%
  add_viz(
    title = "Knowledge Scores",
    x_var = "MeanKnowledge",
    title_tabset = "Wave 2",
    filter = ~ wave == 2,
    x_breaks = knowledge_breaks,
    x_bin_labels = knowledge_labs,
    x_order = knowledge_labs,
    tabgroup = "knowledge/wave2/overall"
  ) 

# Wave 1 by demographics
knowledge_subvizzes_wave1 <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = knowledge_breaks,
  stack_bin_labels = knowledge_labs,
  stack_order = knowledge_labs,
  filter = ~ wave == 1,
  drop_na_vars = F,
  weight_var = "weging_GAMO",
  color_palette = the_colors
) |>
  add_viz(
    title = qs,
    x_var = "AgeGroup",
    stack_var = vs,
    tabgroup = "knowledge/wave1/age"
  ) |>
  add_viz(
    title = qs,
    x_var = "geslacht",
    stack_var = vs,
    tabgroup = "knowledge/wave1/gender"
  ) |>
  add_viz(
    title = qs,
    x_var = "Education",
    stack_var = vs,
    tabgroup = "knowledge/wave1/edu"
  ) |>
  add_viz(
    title = qs,
    x_var = "MigrationBackground",
    stack_var = vs,
    tabgroup = "knowledge/wave1/mig"
  )

# Wave 2 by demographics
knowledge_subvizzes_wave2 <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = knowledge_breaks,
  stack_bin_labels = knowledge_labs,
  stack_order = knowledge_labs,
  filter = ~ wave == 2,
  drop_na_vars = F,
  weight_var = "weging_GAMO",
  color_palette = the_colors
) |>
  add_viz(
    title = qs,
    x_var = "AgeGroup",
    stack_var = vs,
    tabgroup = "knowledge/wave2/age"
  ) |>
  add_viz(
    title = qs,
    x_var = "geslacht",
    stack_var = vs,
    tabgroup = "knowledge/wave2/gender"
  ) |>
  add_viz(
    title = qs,
    x_var = "Education",
    stack_var = vs,
    tabgroup = "knowledge/wave2/edu"
  ) |>
  add_viz(
    title = qs,
    x_var = "MigrationBackground",
    stack_var = vs,
    tabgroup = "knowledge/wave2/mig"
  )

# Over Time - Overall (timeline without group_var)
knowledge_overtime_overall <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  y_var = "MeanKnowledge",
  response_breaks = knowledge_breaks,  # Bin the knowledge scores
  response_bin_labels = knowledge_labs,
  y_min = 0,
  y_max = 100,
  drop_na_vars = F,
  weight_var = "weging_GAMO"
) |>
  add_viz(
    title = "Knowledge Scores Over Time",
    tabgroup = "knowledge/overtime/overall"  # ← Timeline for overall!
  )

# Over Time - by demographics (timeline with group_var)
knowledge_overtime_demographics <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  y_var = "MeanKnowledge",
  response_breaks = knowledge_breaks,
  y_min = 0,
  y_max = 100,
  response_bin_labels = knowledge_labs,
  drop_na_vars = F
) |>
  add_viz(
    group_var = "AgeGroup",
    tabgroup = "knowledge/overtime/age"
  ) |>
  add_viz(
    group_var = "geslacht",
    tabgroup = "knowledge/overtime/gender"
  ) |>
  add_viz(
    group_var = "Education",
    tabgroup = "knowledge/overtime/edu"
  ) |>
  add_viz(
    group_var = "MigrationBackground",
    tabgroup = "knowledge/overtime/mig"
  )

# Combine all
knowledge_viz <- knowledge_viz %>%
  combine_viz(knowledge_subvizzes_wave1) %>%
  combine_viz(knowledge_subvizzes_wave2) %>%
  combine_viz(knowledge_overtime_overall) %>%
  combine_viz(knowledge_overtime_demographics)


## 3.2 Strategic Information Knowledge (kinfo_viz) ----

kinfo_questions <- c(
  transl("KInfo1", lang),
  transl("KInfo2", lang)
)

kinfo_vars <- c("KInfo1RC", "KInfo2RC")

# keep the order from your original code: rev(c("Incorrectly", "Correctly", "X"))
kinfo_labs <- c(transl("label_correctly_answered", lang), transl("label_incorrectly_answered", lang), transl("dunno_understand", lang))

kinfo_info_text <- transl("strategic_info_description", lang)

kinfo_tex_link <- md_text(
  kinfo_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_strategic", lang), "](strategic_information.html)")
)

kinfo_viz <- create_vizzes2(
  breaks = knowledge_breaks,
  kinfo_questions,
  kinfo_vars,
  kinfo_labs,
  "",
  tbgrp   = "kinfo",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kinfo_tex_link,
  lang = lang
)


## 3.3 Critical Information Knowledge (critinfo_viz) ----

# TODO: Supposedly there is ANOTHER question here but where?

critinfo_questions <- c(
  transl("KInfo3", lang)
)

critinfo_vars <- c("KInfo3RC")

critinfo_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

critinfo_info_text <- transl("critical_info_description", lang)

critinfo_tex_link <- md_text(
  critinfo_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_critical", lang), "](critical_information.html)")
)

critinfo_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  critinfo_questions,
  critinfo_vars,
  critinfo_labs,
  "",
  tbgrp        = "critinfo",
  graph_title  = critinfo_questions, 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = critinfo_tex_link,
  lang = lang
)


## 3.4 Netiquette Knowledge (knet_viz) ----

knet_questions <- c(
  transl("KCom3", lang)
)

knet_vars <- c("KCom3RC")

knet_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

knet_info_text <- transl("netiquette_description", lang)

knet_tex_link <- md_text(
  knet_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_netiquette", lang), "](netiquette.html)")
)

knet_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  knet_questions,
  knet_vars,
  knet_labs,
  "",
  tbgrp        = "knet",
  graph_title  = knet_questions,
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = knet_tex_link,
  lang = lang
)



## 3.5 Creative / Content Creation Knowledge (kcrea_viz) ----

kcrea_questions <- c(
  transl("KCrea2", lang),
  transl("KCrea3", lang)
)

kcrea_vars <- c("KCrea2RC", "KCrea3RC")

kcrea_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

kcrea_info_text <- transl("content_creation_description", lang)

kcrea_tex_link <- md_text(
  kcrea_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_content_creation", lang), "](digital_content_creation.html)")
)

kcrea_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kcrea_questions,
  kcrea_vars,
  kcrea_labs,
  "",
  tbgrp        = "kcrea",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kcrea_tex_link,
  lang = lang
)



## 3.6 Safety & Control of Devices Knowledge (ksafety_viz) ----

ksafety_questions <- c(
  transl("KSafDev2", lang),
  transl("KPriv1", lang),
  transl("KPriv2", lang)
)

ksafety_vars <- c(
  "KSafDev2RC",
  "KPriv1RC",
  "KPriv2RC"
)

ksafety_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

ksafety_info_text <- transl("safety_description", lang)

ksafety_tex_link <- md_text(
  ksafety_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_safety", lang), "](safety.html)")
)

ksafety_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  ksafety_questions,
  ksafety_vars,
  ksafety_labs,
  "",
  tbgrp        = "ksafety",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = ksafety_tex_link,
  lang = lang
)



## 3.7 Health & Wellbeing Knowledge (khealth_viz) ----

khealth_questions <- c(
  transl("KHealth2", lang),
  transl("KHealth3", lang)
)

khealth_vars <- c("KHealth2RC", "KHealth3RC")

khealth_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

khealth_info_text <- transl("health_description", lang)

khealth_tex_link <- md_text(
  khealth_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_health", lang), "](digital_health.html)")
)

khealth_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  khealth_questions,
  khealth_vars,
  khealth_labs,
  "",
  tbgrp        = "khealth",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = khealth_tex_link,
  lang = lang
)



## 3.8 Green / Sustainable Digital Knowledge (kgreen_viz) ----

kgreen_questions <- c(
  transl("KEnv2", lang),
  transl("KEnv3", lang)
)

kgreen_vars <- c("KEnv2RC", "KEnv3RC")

kgreen_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

kgreen_info_text <- transl("green_description", lang)

kgreen_tex_link <- md_text(
  kgreen_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_green", lang), "](green_digital.html)")
)

kgreen_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgreen_questions,
  kgreen_vars,
  kgreen_labs,
  "",
  tbgrp        = "kgreen",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kgreen_tex_link,
  lang = lang
)



## 3.9 Transactional Knowledge (ktrans_viz) ----

ktrans_questions <- c(
  transl("Ktrans2", lang),
  transl("Ktrans3", lang)
)

ktrans_vars <- c("Ktrans2RC", "Ktrans3RC")

ktrans_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

ktrans_info_text <- transl("transactional_description", lang)

ktrans_tex_link <- md_text(
  ktrans_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_transactional", lang), "](transactional.html)")
)

ktrans_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  ktrans_questions,
  ktrans_vars,
  ktrans_labs,
  "",
  tbgrp        = "ktrans",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = ktrans_tex_link,
  lang = lang
)



## 3.10 AI Knowledge (kai_viz) ----

kai_questions <- c(
  transl("KAI1", lang),
  transl("KAI2", lang),
  transl("KAI3", lang),
  transl("KAI4", lang)
)

kai_vars <- c("KAI1RC", "KAI2RC", "KAI3RC", "KAI4RC")

kai_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

kai_info_text <- transl("ai_description", lang)

kai_tex_link <- md_text(
  kai_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_ai", lang), "](ai.html)")
)

kai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kai_questions,
  kai_vars,
  kai_labs,
  "",
  tbgrp        = "kai",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kai_tex_link,
  lang = lang
)



## 3.11 Generative AI Knowledge (kgai_viz) ----

kgai_questions <- c(
  transl("KGAI1", lang),
  transl("KGAI2", lang),
  transl("KGAI3", lang),
  transl("KGAI4", lang),
  transl("KGAI5", lang)
)

kgai_vars <- c("KGAI1RC", "KGAI2RC", "KGAI3RC", "KGAI4RC", "KGAI5RC")

kgai_labs <- c(
  # transl("label_dont_know", lang),
  transl("label_correctly_answered", lang),
  transl("label_incorrectly_answered", lang), transl("dunno_understand", lang)
)

kgai_info_text <- transl("genai_description", lang)

kgai_tex_link <- md_text(
  kgai_info_text,
  "",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_genai", lang), "](gen_ai.html)")
)

kgai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgai_questions,
  kgai_vars,
  kgai_labs,
  "",
  tbgrp        = "kgai",
  graph_title  = "", map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kgai_tex_link,
  lang = lang
)


## 3.12 Knowledge Collection ----
knowledge_collection <- #knowledge_viz %>% 
  # combine_viz(kinfo_viz) %>%
  create_content() %>% 
  add_accordion(title = transl("intro_text_knowledge", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_knowledge", lang), "\", preset = \"question\")"), 
                  "```")) %>% 
  combine_viz(kinfo_viz) %>% 
  combine_viz(critinfo_viz) %>%
  combine_viz(knet_viz)  %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_knowledge", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_knowledge", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(kcrea_viz) %>%
  combine_viz(ksafety_viz) %>%
  combine_viz(khealth_viz) %>%
  combine_viz(kgreen_viz)  %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_knowledge", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_knowledge", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(ktrans_viz) %>%
  combine_viz(kai_viz) %>%
  combine_viz(kgai_viz) %>%
  set_tabgroup_labels(
    knowledge = "{{< iconify ph chart-bar-fill >}} Knowledge Score",
    kinfo     = "{{< iconify ph magnifying-glass >}} Strategic Information",
    critinfo  = "{{< iconify ph detective-fill >}} Critical Information",
    knet      = "{{< iconify ph chats-fill >}} Netiquette",
    kcrea     = "{{< iconify ph palette-fill >}} Digital Content Creation",
    ksafety   = "{{< iconify ph shield-check-fill >}} Safety",
    khealth   = "{{< iconify ph heart-fill >}} Digital Health",
    kgreen    = "{{< iconify ph recycle-fill >}} Green Digital",
    ktrans    = "{{< iconify ph wallet-fill >}} Transactional",
    kai       = "{{< iconify ph robot-fill >}} AI",
    kgai      = "{{< iconify ph magic-wand-fill >}} Gen AI",
    age    = "{{< iconify mdi:human-male-male-child >}} Age",
    gender = "{{< iconify mdi gender-transgender >}} Gender",
    edu    = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime   = "{{< iconify ph chart-line-fill >}} Over Time",
    mig = "{{< iconify ph globe-hemisphere-east >}} Migration Background",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1",
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    wave3 = "{{< iconify ph number-circle-three-fill >}} Wave 3",
    overall = "{{< iconify ph users-fill >}} Overall",
    item1  = "{{< iconify ph chat-circle-fill >}} Question 1",
    item2  = "{{< iconify ph chat-circle-fill >}} Question 2",
    item3  = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4  = "{{< iconify ph chat-circle-fill >}} Question 4",
    item5  = "{{< iconify ph chat-circle-fill >}} Question 5",
    item6  = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7  = "{{< iconify ph chat-circle-fill >}} Question 7",
    item8  = "{{< iconify ph chat-circle-fill >}} Question 8"
  )



# Generate dashboard
# proj <- create_dashboard(output_dir = "my_dashboard") %>%
#   add_dashboard_page("page1", visualizations = viz_collection, data_path = "data.rds")
# 
# generate_dashboard(proj)

# 4. SKILLS VISUALIZATIONS =====================================================

## 4.1 Strategic Information Skills (sis_viz) ----

sis_questions <- c(
  transl("SInfo1", lang),
  transl("SInfo3_V2", lang),
  transl("SInfo4", lang)
)

sis_vars <- c("SInfo1", "SInfo3_V2", "SInfo4")

sis_labs <- c(
  transl("scale_completely_untrue", lang), 
  transl("scale_neither", lang), 
  transl("scale_completely_true", lang)
) #%>% rev()

sis_info_text <- transl("strategic_info_description", lang)

sis_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)


sys_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_strategic", lang), "](strategic_information.html)")



sis_tex_complete <- paste0(
  sis_info_text, "\n",
  sys_tex_more_link
)





sis_viz <- create_vizzes(sis_questions, 
                         sis_vars, sis_labs, 
                         "",#sis_tex2, 
                         breaks = c(0.5, 2.5, 3.5, 5.5), 
                         tbgrp = "sis", 
                         text_b_tabset = sis_tex_complete,
                         graph_title = transl("title_strategic_information_skills", lang))


## 4.2 Critical Information Skills (cis_viz) ----

cis_vars <- c("SInfo5", "SInfo6", "SInfo7")


cis_questions <- c(transl("SInfo5", lang), 
                   transl("SInfo6", lang),
                   transl("SInfo7", lang)) 

cis_info_text <- transl("critical_info_description", lang)

cis_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

cis_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_critical", lang), "](critical_information.html)")

cis_tex_complete <- paste0(
  cis_info_text, "\n",
  cis_tex_more_link
)

cis_viz <- create_vizzes(cis_questions, 
                         cis_vars, sis_labs, 
                         "",#cis_tex_link, 
                         breaks = c(0.5, 2.5, 3.5, 5.5), 
                         tbgrp = "cis",
                         text_b_tabset = cis_tex_complete,
                         graph_title = transl("title_critical_information_skills", lang))

## 4.3 Netiquette Skills (nskills_viz) ----


nskills_questions <- c(transl("SCom1_V2", lang), transl("SCom2", lang), transl("SCom4_V2", lang), transl("SCom5", lang))


nskills_vars <- c("SCom1_V2", "SCom2", "SCom4_V2", "SCom5")

nskills_info_text <- transl("netiquette_description", lang)

nskills_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

nskills_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_netiquette", lang), "](netiquette.html)")

nskills_tex_complete <- paste0(
  nskills_info_text, "\n",
  nskills_tex_more_link
)

nskills_viz  <- create_vizzes(nskills_questions, 
                              nskills_vars, sis_labs, 
                              "",#nskills_tex_link, 
                              breaks = c(0.5, 2.5, 3.5, 5.5), 
                              tbgrp = "nskills",
                              text_b_tabset = nskills_tex_complete,
                              graph_title = transl("title_netiquette_skills", lang))



## 4.4 Digital Content Creation Skills (dccs_viz) ----

dccs_questions <- c(transl("SCrea2", lang), transl("SCrea3", lang), transl("SCrea4", lang), transl("SCrea5", lang))


dccs_vars <- c("SCrea2", "SCrea3", "SCrea4", "SCrea5")

dccs_info_text <- transl("content_creation_description", lang)

dccs_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

dccs_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_content_creation", lang), "](digital_content_creation.html)")

dccs_tex_complete <- paste0(
  dccs_info_text, "\n",
  dccs_tex_more_link
)

dccs_viz  <- create_vizzes(dccs_questions, 
                           dccs_vars, sis_labs, 
                           "",#dccs_tex_link, 
                           breaks = c(0.5, 2.5, 3.5, 5.5), 
                           tbgrp = "dccs",
                           text_b_tabset = dccs_tex_complete,
                           graph_title = transl("title_digital_content_creation_skills", lang))



## 4.5 Safety & Control of Devices (safety_viz) ----
safety_questions <- c(
  transl("SSafDev1", lang),
  transl("SSafDev2", lang),
  transl("SPriv1", lang),
  transl("SPriv2", lang),
  transl("SPriv3", lang),
  transl("SPriv4", lang),
  transl("SCom3", lang)
)
safety_vars <- c("SSafDev1", "SSafDev2", "SPriv1", "SPriv2", "SPriv3", "SPriv4", "SCom3")

safety_info_text <- transl("safety_description", lang)

safety_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

safety_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_safety", lang), "](safety.html)")

safety_tex_complete <- paste0(
  safety_info_text, "\n",
  safety_tex_more_link
)

safety_viz <- create_vizzes(
  safety_questions, safety_vars, sis_labs,
  "",#safety_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "safety",
  text_b_tabset = safety_tex_complete,
  graph_title = transl("title_safety_control_skills", lang))


## 4.6 Digital Health & Wellbeing (dhealth_viz) ----
dhealth_questions <- c(
  transl("SHealth1", lang),
  transl("SHealth2_V2", lang),
  transl("SHealth3_V2", lang)
)
dhealth_vars <- c("SHealth1", "SHealth2_V2", "SHealth3_V2")

dhealth_info_text <- transl("digital_health_description", lang)

dhealth_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

dhealth_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_digital_health", lang), "](digital_health.html)")

dhealth_tex_complete <- paste0(
  dhealth_info_text, "\n",
  dhealth_tex_more_link
)

dhealth_viz <- create_vizzes(
  dhealth_questions, dhealth_vars, sis_labs,
  "",#dhealth_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dhealth",
  text_b_tabset = dhealth_tex_complete,
  graph_title = transl("title_digital_health_wellbeing_skills", lang))


## 4.7 Green / Sustainable Digital (green_viz) ----
green_questions <- c(
  transl("SEnv1", lang),
  transl("SEnv2", lang),
  transl("SEnv3", lang)
)
green_vars <- c("SEnv1", "SEnv2", "SEnv3")

green_info_text <- transl("green_description", lang)

green_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

green_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_green", lang), "](green_digital.html)")

green_tex_complete <- paste0(
  green_info_text, "\n",
  green_tex_more_link
)

green_viz <- create_vizzes(
  green_questions, green_vars, sis_labs,
  "",#green_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "green",
  text_b_tabset = green_tex_complete,
  graph_title = transl("title_sustainable_green_digital_skills", lang))


## 4.8 Digital Problem Solving (dprob_viz) ----
dprob_questions <- c(
  transl("SProbl1", lang),
  transl("SProbl2", lang)
)
dprob_vars <- c("SProbl1", "SProbl2")

dprob_info_text <- transl("problem_solving_description", lang)

dprob_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

dprob_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_problem_solving", lang), "](digital_problem_solving.html)")

dprob_tex_complete <- paste0(
  dprob_info_text, "\n",
  dprob_tex_more_link
)

dprob_viz <- create_vizzes(
  dprob_questions, dprob_vars, sis_labs,
  "",#dprob_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dprob",
  text_b_tabset = dprob_tex_complete,
  graph_title = transl("title_digital_problem_solving_skills", lang)
)


## 4.9 Transactional Skills (trans_viz) ----
trans_questions <- c(
  transl("Strans1", lang),
  transl("Strans2", lang),
  transl("Strans3", lang),
  transl("Strans4", lang),
  transl("Strans5", lang)
)
trans_vars <- c("Strans1", "Strans2", "Strans3", "Strans4", "Strans5")

trans_info_text <- transl("transactional_description", lang)

trans_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

trans_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_transactional", lang), "](transactional.html)")

trans_tex_complete <- paste0(
  trans_info_text, "\n",
  trans_tex_more_link
)

trans_viz <- create_vizzes(
  trans_questions, trans_vars, sis_labs,
  "",#trans_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "trans",
  text_b_tabset = trans_tex_complete,
  graph_title = transl("title_transactional_skills", lang)
)


## 4.10 AI Skills (ai_viz) ----
ai_questions <- c(
  transl("SAI1", lang),
  transl("SAI2", lang)
)

# digicom_data$sai3 %>% count(SAI)

ai_vars <- c("SAI1", "SAI2")

ai_info_text <- transl("ai_description", lang)

ai_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

ai_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_ai", lang), "](ai.html)")

ai_tex_complete <- paste0(
  ai_info_text, "\n",
  ai_tex_more_link
)

ai_viz <- create_vizzes(
  ai_questions, ai_vars, sis_labs,
  "",#ai_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "ai",
  text_b_tabset = ai_tex_complete,
  graph_title = transl("title_ai_skills", lang)
)


## 4.11 Generative AI Skills (genai_viz) ----
# SGAI4 and SGAI5 are only in wave 2+
# Define all possible questions/vars
genai_questions_all <- c(
  transl("SGAI1", lang),
  transl("SGAI2", lang),
  transl("SGAI3", lang),
  transl("SGAI4", lang),
  transl("SGAI5", lang)
)
genai_vars_all <- c("SGAI1", "SGAI2", "SGAI3", "SGAI4", "SGAI5")

# Wave 1: only SGAI1-3 exist
genai_questions_w1 <- genai_questions_all[1:3]
genai_vars_w1 <- genai_vars_all[1:3]

# Wave 2+: all SGAI1-5 exist
genai_questions_w2 <- genai_questions_all
genai_vars_w2 <- genai_vars_all

genai_info_text <- transl("genai_description", lang)

genai_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"),
  "```"
)

genai_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_genai", lang), "](gen_ai.html)")

genai_tex_complete <- paste0(
  genai_info_text, "\n",
  genai_tex_more_link
)

# Manually construct genai viz to handle different vars per wave
# Wave 1 has SGAI1-3, Wave 2 has SGAI1-5, but same tabgroup structure

# Wave 1 visualizations (only SGAI1-3)
genai_viz_w1 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w1,
  x_var_labels = genai_questions_w1,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 1,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 1",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave1/overall"
  )

# Wave 2 visualizations (all SGAI1-5)
genai_viz_w2 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w2,
  x_var_labels = genai_questions_w2,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 2,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 2",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave2/overall"
  )

# Wave 3 visualizations (all SGAI1-5)
genai_viz_w3 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w2,
  x_var_labels = genai_questions_w2,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 3,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 3",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave3/overall"
  )

# Over Time Overall (timeline without group_var) - SGAI1-3 across W1-W3, SGAI4-5 across W2-W3
genai_overtime_overall <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  text_before_tabset = genai_tex_complete,
  y_filter = 4:5, 
  y_filter_label = "Percentage who answered (Completely) True (4-5)",
  y_filter_combine = T,
  x_label = "", 
  y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors,
  y_min = 0,
  y_max = 100,
  y_filter_label = NULL,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline_single(genai_vars_w2, "genai", "overall", wave_label = "Over Time", questions = genai_questions_w2)

# Wave 1 by Age/Gender/Education/Migration - only SGAI1-3
genai_demo_w1 <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  text_before_tabset = genai_tex_complete,
  stack_order = rev(sis_labs),
  filter = ~ wave == 1,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "AgeGroup", "genai", "age", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "geslacht", "genai", "gender", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "Education", "genai", "edu", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "MigrationBackground", "genai", "mig", wave_label = "Wave 1")

# Wave 2 by Age/Gender/Education/Migration - all SGAI1-5
genai_demo_w2 <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  text_before_tabset = genai_tex_complete,
  filter = ~ wave == 2,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "AgeGroup", "genai", "age", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "geslacht", "genai", "gender", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "Education", "genai", "edu", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "MigrationBackground", "genai", "mig", wave_label = "Wave 2")

# Wave 3 by Age/Gender/Education/Migration - all SGAI1-5
genai_demo_w3 <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  text_before_tabset = genai_tex_complete,
  filter = ~ wave == 3,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "AgeGroup", "genai", "age", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "geslacht", "genai", "gender", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "Education", "genai", "edu", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "MigrationBackground", "genai", "mig", wave_label = "Wave 3")

# Over Time by Age/Gender/Education/Migration - SGAI1-3 across W1-W3, SGAI4-5 across W2-W3
genai_overtime_demo <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  y_filter = 4:5, 
  text_before_tabset = genai_tex_complete,
  x_label = "", 
  y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors,
  y_min = 0,
  y_max = 100,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline(genai_vars_w2, "AgeGroup", "genai", "age", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "geslacht", "genai", "gender", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "Education", "genai", "edu", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "MigrationBackground", "genai", "mig", wave_label = "Over Time", questions = genai_questions_w2)

# Combine them all
genai_viz <- genai_viz_w1 %>% 
  combine_viz(genai_viz_w2) %>%
  combine_viz(genai_viz_w3) %>%
  combine_viz(genai_overtime_overall) %>%
  combine_viz(genai_demo_w1) %>%
  combine_viz(genai_demo_w2) %>%
  combine_viz(genai_demo_w3) %>%
  combine_viz(genai_overtime_demo)




## 4.12 Skills Collection ----
skills_viz <- create_content() %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>% 
  combine_viz(sis_viz) %>% 
  combine_viz(cis_viz) %>% 
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(nskills_viz) %>%
  combine_viz(dccs_viz)  %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  # new ones
  combine_viz(safety_viz) %>%
  combine_viz(dhealth_viz) %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(green_viz) %>%
  combine_viz(dprob_viz)  %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(trans_viz) %>%
  combine_viz(ai_viz) %>%
  add_pagination()  %>% 
  add_accordion(title = transl("intro_text_skills", lang), 
                text = md_text(
                  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
                  paste0("create_blockquote(\"", transl("blockquote_skills", lang), "\", preset = \"question\")"), 
                  "```")) %>%
  combine_viz(genai_viz) %>%
  # labels for ALL tabgroups - using dimension-specific icons
  set_tabgroup_labels(
    sis     = "{{< iconify ph magnifying-glass >}} Strategic Information",
    cis     = "{{< iconify ph detective-fill >}} Critical Information",
    nskills = "{{< iconify ph chats-fill >}} Netiquette",
    dccs    = "{{< iconify ph palette-fill >}} Digital Content Creation",
    safety  = "{{< iconify ph shield-check-fill >}} Safety",
    dhealth = "{{< iconify ph heart-fill >}} Digital Health",
    green   = "{{< iconify ph recycle-fill >}} Green Digital",
    dprob   = "{{< iconify ph lightbulb-fill >}} Digital Problem Solving",
    trans   = "{{< iconify ph wallet-fill >}} Transactional",
    ai      = "{{< iconify ph robot-fill >}} AI",
    genai   = "{{< iconify ph magic-wand-fill >}} Gen AI",
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)),
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age    = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)),
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)),
    edu    = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime   = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)),
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 1"),
    item2  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 2"),
    item3  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 3"),
    item4  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 4"),
    item5  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 5"),
    item6  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 6"),
    item7  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 7"),
    item8  = paste0("{{< iconify ph chat-circle-fill >}} ", transl("tab_question", lang), " 8")
  )



# 5. PERFORMANCE VISUALIZATIONS ================================================

## 5.0 Performance Setup: Shared Labels ----
perf_correct_labs <- c(transl("label_incorrect", lang), transl("label_correct", lang))
perf_selected_labs <- c(transl("label_not_selected", lang), transl("label_selected", lang))

# suggested text block (mirror your knowledge_tex style)
performance_tex <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance", lang), '", preset = "question")'),
  "```"
)


## 5.1 Performance: Strategic Information (perf_sis_viz) -----
perf_sis_questions <- c(
  transl("PSIS1", lang),
  transl("PSIS2", lang)
)

perf_sis_vars <- c("PSIS1RC", "PSIS2R")

perf_sis_info_text <- transl("strategic_info_description", lang)

perf_sis_tex_link <- md_text(
  perf_sis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_sis", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_strategic", lang), "](strategic_information.html)")
)

perf_sis_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_sis_questions,
  perf_sis_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_sis",
  graph_title  = "",
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_sis_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PSIS1RC",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("strategic_info_perf_q1_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PSIS2R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("strategic_info_infobox_image", lang)),
    image_width = "50%"
  )



## 5.2 Performance: Critical Information (perf_cis_viz) ----
perf_cis_questions <- c(
  transl("PCIS1", lang),
  transl("PCIS2", lang),
  transl("PCIS3", lang)
)

perf_cis_vars <- c("PCIS1R", "PCIS2R", "PCIS3R")

perf_cis_info_text <- transl("critical_info_description", lang)

perf_cis_tex_link <- md_text(
  perf_cis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_cis", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_critical", lang), "](critical_information.html)")
)

perf_cis_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_cis_questions,
  perf_cis_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_cis",
  graph_title  = "",
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_cis_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PCIS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q1_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PCIS2R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q2_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PCIS3R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q3_infobox_image", lang)),
    image_width = "50%"
  )


## 5.3 Performance: Netiquette (perf_netiquette_viz) ----
perf_n_questions <- c(
  transl("PNS1", lang)
)

perf_n_vars <- c("PNS1R")

perf_n_info_text <- transl("netiquette_description", lang)

perf_n_tex_link <- md_text(
  perf_n_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_netiquette", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_netiquette", lang), "](netiquette.html)")
)

perf_netiquette_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_n_questions,
  perf_n_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_netiquette",
  graph_title  = perf_n_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_n_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PNS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("netiquette_competence_infobox_image", lang)),
    image_width = "50%"
  )



## 5.4 Performance: Digital Content Creation (perf_dccs_viz) ----
perf_dccs_questions <- c(
  transl("PDCCS1", lang)
)

perf_dccs_vars <- c("PDCCS1R")

perf_dccs_info_text <- transl("content_creation_description", lang)

perf_dccs_tex_link <- md_text(
  perf_dccs_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  # Use the actual question text (PDCCS1) which now has the modal link embedded
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_dccs", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_content_creation", lang), "](digital_content_creation.html)")
) 


perf_dccs_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_dccs_questions,
  perf_dccs_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_dccs",
  graph_title  = perf_dccs_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_dccs_tex_link,
  lang = lang
)  %>%
  add_modal(
    modal_id = "PDCCS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("digital_content_creation_competence_infobox_image", lang)),
    image_width = "50%"
  )



## 5.5 Performance: Safety & Control of Devices (perf_safety_viz) ----
perf_safety_questions <- c(
  transl("PSCS3_1", lang),
  transl("PSCS3_2", lang),
  transl("PSCS3_3", lang),
  transl("PSCS3_4", lang),
  transl("PSCS3_5", lang),
  transl("PSCS3_6", lang),
  transl("PSCS3_7", lang),
  transl("PSCS3_8", lang),
  transl("PSCS3_9", lang),
  transl("PSCS3_10", lang)
)

# TODO: *Privacy, Safety & Control:* PSCS1R (dichotomous correct/incorrect)
# PSCS3R (dichotomous doing behavior yes/no) (BEHAVIORAL item) PSCS3C
# (dichotomous incorrect answer yes/no)
# digicom_data %>% count(PSCS3_10)
perf_safety_vars <- c(
  "PSCS3_1","PSCS3_2","PSCS3_3","PSCS3_4","PSCS3_5",
  "PSCS3_6","PSCS3_7","PSCS3_8","PSCS3_9", "PSCS3_10"
)

perf_safety_info_text <- transl("safety_description", lang)

perf_safety_tex_link <- md_text(
  perf_safety_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_safety", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_safety", lang), "](safety.html)")
)

perf_safety_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_safety_questions,
  perf_safety_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_safety",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  text_b_tabset = perf_safety_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PSCS3_1",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("safety_competence_infobox_image", lang)),
    image_width = "50%"
  )


## 5.5b Performance: Online Safety - Phishing Recognition (perf_pscs1_viz) ----
perf_pscs1_questions <- c(
  transl("PSCS1", lang)
)

perf_pscs1_vars <- c("PSCS1R")

perf_pscs1_tex_link <- md_text(
  transl("safety_description", lang),
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_pscs1", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_safety", lang), "](safety.html)")
)

perf_pscs1_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_pscs1_questions,
  perf_pscs1_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_pscs1",
  graph_title  = perf_pscs1_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_pscs1_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PSCS1R",
    title = transl("more_info", lang),
    image = "PSCS1.jpg",
    image_width = "80%"
  )


## 5.6 Performance: Health & Wellbeing (perf_health_viz) ----
perf_health_questions <- c(
  transl("PDHWS1_1", lang),
  transl("PDHWS1_2", lang),
  transl("PDHWS1_3", lang),
  transl("PDHWS1_4", lang),
  transl("PDHWS1_5", lang),
  transl("PDHWS1_6", lang),
  transl("PDHWS1_7", lang),
  transl("PDHWS1_8", lang)
)

perf_health_vars <- c(
  "PDHWS1_1","PDHWS1_2","PDHWS1_3","PDHWS1_4",
  "PDHWS1_5","PDHWS1_6","PDHWS1_7","PDHWS1_8"
)

perf_health_info_text <- transl("digital_health_description", lang)

perf_health_tex_link <- md_text(
  perf_health_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_health", lang), '", preset = "question")'),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_digital_health", lang), "](digital_health.html)")
)

perf_health_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_health_questions,
  perf_health_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_health",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  text_b_tabset = perf_health_tex_link,
  lang = lang
)



## 5.7 Performance: Green Skills (perf_green_viz) ----
perf_green_questions <- c(
  transl("PSGDS1_1", lang),
  transl("PSGDS1_2", lang),
  transl("PSGDS1_3", lang),
  transl("PSGDS1_4", lang),
  transl("PSGDS1_5", lang),
  transl("PSGDS1_6", lang),
  transl("PSGDS1_7", lang),
  transl("PSGDS1_8", lang),
  transl("PSGDS1_9", lang)
)

perf_green_vars <- c(
  "PSGDS1_1","PSGDS1_2","PSGDS1_3","PSGDS1_4",
  "PSGDS1_5","PSGDS1_6","PSGDS1_7","PSGDS1_8","PSGDS1_9"
)

perf_green_info_text <- transl("green_description", lang)

perf_green_tex_link <- md_text(
  perf_green_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_green", lang), '", preset = "question")'),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_green", lang), "](green_digital.html)")
)

perf_green_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_green_questions,
  perf_green_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_green",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  text_b_tabset = perf_green_tex_link,
  lang = lang
)



## 5.8 Performance: Problem Solving (perf_ps_viz) ----
perf_ps_questions <- c(
  transl("SourceHelp_1", lang),
  transl("SourceHelp_2", lang),
  transl("SourceHelp_3", lang),
  transl("SourceHelp_4", lang),
  transl("SourceHelp_5", lang),
  transl("SourceHelp_6", lang),
  transl("SourceHelp_7", lang),
  transl("SourceHelp_8", lang),
  transl("SourceHelp_9", lang)
)

perf_ps_vars <- c(
  "SourceHelp_1","SourceHelp_2","SourceHelp_3","SourceHelp_4",
  "SourceHelp_5","SourceHelp_6","SourceHelp_7","SourceHelp_8","SourceHelp_9"
)

perf_ps_info_text <- transl("problem_solving_description", lang)

perf_ps_tex_link <- md_text(
  perf_ps_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_problem_solving", lang), '", preset = "question")'),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_problem_solving", lang), "](digital_problem_solving.html)")
)

perf_ps_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_ps_questions,
  perf_ps_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_ps",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  text_b_tabset = perf_ps_tex_link,
  lang = lang
)



## 5.9 Performance: Transactional (perf_trans_viz) ----
perf_trans_questions <- c(
  transl("PTS1", lang)
)
# digicom_data %>% count(PTS1R)
perf_trans_vars <- c("PTS1R")

perf_trans_info_text <- transl("transactional_description", lang)

perf_trans_tex_link <- md_text(
  perf_trans_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_trans", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_transactional", lang), "](transactional.html)")
)

perf_trans_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_trans_questions,
  perf_trans_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_trans",
  graph_title  = perf_trans_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_trans_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PTS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("transactional_competence_infobox_image", lang)),
    image_width = "50%"
  )



## 5.10 Performance: AI (perf_ai_viz) ----
perf_ai_questions <- c(
  transl("PAIS2_1", lang),
  transl("PAIS2_2", lang),
  transl("PAIS2_3", lang),
  transl("PAIS2_4", lang),
  transl("PAIS2_5", lang),
  transl("PAIS2_6", lang),
  transl("PAIS2_7", lang),
  transl("PAIS2_8", lang),
  transl("PAIS2_9", lang)
)

perf_ai_vars <- c(
  "PAIS2_1","PAIS2_2","PAIS2_3","PAIS2_4","PAIS2_5",
  "PAIS2_6","PAIS2_7","PAIS2_8","PAIS2_9"
)

perf_ai_info_text <- transl("ai_description", lang)

perf_ai_tex_link <- md_text(
  perf_ai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_ai", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_ai", lang), "](ai.html)")
)

perf_ai_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_ai_questions,
  perf_ai_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_ai",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  text_b_tabset = perf_ai_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PAIS2_1",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("ai_competence_infobox_image", lang)),
    image_width = "50%"
  )



## 5.11 Performance: GenAI (perf_genai_viz) ----
perf_genai_questions <- c(
  transl("PGAIS1", lang),
  transl("PAIS1", lang)
)

perf_genai_vars <- c("PGAIS1RC", "PAIS1R")

perf_genai_info_text <- transl("genai_description", lang)

perf_genai_tex_link <- md_text(
  perf_genai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_genai", lang))), "', preset = 'question')"),
  "```",
  paste0("[{{< iconify ph cards >}} ", transl("link_see_all_genai", lang), "](gen_ai.html)")
)

perf_genai_viz <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_genai_questions,
  perf_genai_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_genai",
  graph_title  = "",
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  text_b_tabset = perf_genai_tex_link,
  lang = lang
) %>%
  add_modal(
    modal_id = "PGAIS1RC",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("genai_perf_q1_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PAIS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("genai_competence_infobox_image", lang)),
    image_width = "50%"
  )



# 6. VISUALIZATION COLLECTIONS =================================================

## 6.1 Performance Collection ----
performance_collection <- perf_sis_viz %>%
  combine_viz(perf_cis_viz) %>%
  add_pagination() %>% 
  combine_viz(perf_dccs_viz) %>%
  combine_viz(perf_netiquette_viz) %>%
  add_pagination() %>% 
  combine_viz(perf_safety_viz) %>%
  combine_viz(perf_pscs1_viz) %>%
  add_pagination() %>% 
  combine_viz(perf_health_viz) %>%
  combine_viz(perf_green_viz) %>%
  add_pagination() %>%
  combine_viz(perf_ps_viz)  %>%
  combine_viz(perf_trans_viz) %>%
  add_pagination() %>%
  combine_viz(perf_ai_viz) %>%
  combine_viz(perf_genai_viz) %>%
  set_tabgroup_labels(
    perf_sis    = paste0("{{< iconify ph magnifying-glass >}} ", transl("dimension_strategic_info", lang)),
    perf_cis    = paste0("{{< iconify ph detective-fill >}} ", transl("dimension_critical_info", lang)),
    perf_netiquette = paste0("{{< iconify ph chats-fill >}} ", transl("dimension_netiquette", lang)),
    perf_dccs   = paste0("{{< iconify ph palette-fill >}} ", transl("dimension_content_creation", lang)),
    perf_safety = paste0("{{< iconify ph shield-check-fill >}} ", transl("dimension_safety", lang)),
    perf_pscs1  = paste0("{{< iconify ph warning-fill >}} ", transl("dimension_phishing", lang)),
    perf_health = paste0("{{< iconify ph heart-fill >}} ", transl("dimension_digital_health", lang)),
    perf_green  = paste0("{{< iconify ph recycle-fill >}} ", transl("dimension_green", lang)),
    perf_ps     = paste0("{{< iconify ph lightbulb-fill >}} ", transl("dimension_problem_solving", lang)),
    perf_trans  = paste0("{{< iconify ph wallet-fill >}} ", transl("dimension_transactional", lang)),
    perf_ai     = paste0("{{< iconify ph robot-fill >}} ", transl("dimension_ai", lang)),
    perf_genai  = paste0("{{< iconify ph magic-wand-fill >}} ", transl("dimension_genai", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)),
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age    = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)),
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)),
    edu    = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime   = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)),
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")),
    item2  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")),
    item3  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")),
    item5  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")),
    item6  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")),
    item8  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8")),
    item9  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 9")),
    item10  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 10"))
  )

# 7. DIMENSION-SPECIFIC COMBINED VISUALIZATIONS ================================

suppressWarnings(library(htmltools))

## 7.0 Setup: Icon System ----
# Create combined visualizations for dimension pages with proper labels
# Consistent icon system:
# 💪 Skills = ph:lightning-fill (abilities/capabilities)
# 📚 Knowledge = ph:book-open-fill (understanding/learning)
# 🏆 Performance = ph:trophy-fill (achievement/testing)



# Removed [See all Skills/Knowledge/Performance results] links on dimension pages
performance_tex_more_link <- ""

knowledge_tex_more_link <- ""

skills_tex_more_link <- ""


skills_short <- transl("page_text_skills_short", lang)
performance_short <- transl("page_text_performance_short", lang)
knowledge_short <- transl("page_text_knowledge_short", lang)


sis_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)


## Knowledge _wo_link vizzes ----

kinfo_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

kinfo_viz_wo_link <- create_vizzes2(
  breaks = knowledge_breaks,
  kinfo_questions,
  kinfo_vars,
  kinfo_labs,
  "",
  tbgrp   = "kinfo",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kinfo_tex_wo_complete,
  lang = lang
)

critinfo_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

critinfo_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  critinfo_questions,
  critinfo_vars,
  critinfo_labs,
  "",
  tbgrp        = "critinfo",
  graph_title  = critinfo_questions,
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = critinfo_tex_wo_complete,
  lang = lang
)

knet_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

knet_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  knet_questions,
  knet_vars,
  knet_labs,
  "",
  tbgrp        = "knet",
  graph_title  = knet_questions, 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = knet_tex_wo_complete,
  lang = lang
)

kcrea_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

kcrea_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kcrea_questions,
  kcrea_vars,
  kcrea_labs,
  "",
  tbgrp        = "kcrea",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kcrea_tex_wo_complete,
  lang = lang
)

ksafety_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

ksafety_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  ksafety_questions,
  ksafety_vars,
  ksafety_labs,
  "",
  tbgrp        = "ksafety",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = ksafety_tex_wo_complete,
  lang = lang
)

khealth_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

khealth_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  khealth_questions,
  khealth_vars,
  khealth_labs,
  "",
  tbgrp        = "khealth",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = khealth_tex_wo_complete,
  lang = lang
)

kgreen_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

kgreen_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgreen_questions,
  kgreen_vars,
  kgreen_labs,
  "",
  tbgrp        = "kgreen",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kgreen_tex_wo_complete,
  lang = lang
)

ktrans_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

ktrans_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  ktrans_questions,
  ktrans_vars,
  ktrans_labs,
  "",
  tbgrp        = "ktrans",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = ktrans_tex_wo_complete,
  lang = lang
)

kai_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

kai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kai_questions,
  kai_vars,
  kai_labs,
  "",
  tbgrp        = "kai",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kai_tex_wo_complete,
  lang = lang
)

kgai_tex_wo_complete <- paste0(
  knowledge_short, "\n",
  knowledge_tex, "\n",
  knowledge_tex_more_link
)

kgai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgai_questions,
  kgai_vars,
  kgai_labs,
  "",
  tbgrp        = "kgai",
  graph_title  = "", 
  map_values = list("1" = transl("label_correctly_answered", lang), "0" = transl("label_incorrectly_answered", lang)),
  text_b_tabset = kgai_tex_wo_complete,
  lang = lang
)

## Skills _wo_link vizzes ----

sis_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

sis_viz_wo_link <- create_vizzes(sis_questions, 
                                 sis_vars, sis_labs, 
                                 sis_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                 tbgrp = "sis", text_b_tabset = sis_tex_wo_complete,
                                 graph_title = transl("title_strategic_information_skills", lang))

cis_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

cis_viz_wo_link <- create_vizzes(cis_questions, 
                                 cis_vars, sis_labs, 
                                 cis_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                 tbgrp = "cis",
                                 text_b_tabset = cis_tex_wo_complete,
                                 graph_title = transl("title_critical_information_skills", lang))

nskills_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

nskills_viz_wo_link  <- create_vizzes(nskills_questions, 
                                      nskills_vars, sis_labs, 
                                      nskills_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                      tbgrp = "nskills",
                                      text_b_tabset = nskills_tex_wo_complete,
                                      graph_title = transl("title_netiquette_skills", lang))

dccs_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

dccs_viz_wo_link  <- create_vizzes(dccs_questions, 
                                   dccs_vars, sis_labs, 
                                   dccs_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                   tbgrp = "dccs",
                                   text_b_tabset = dccs_tex_wo_complete,
                                   graph_title = transl("title_digital_content_creation_skills", lang))

safety_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

safety_viz_wo_link <- create_vizzes(
  safety_questions, safety_vars, sis_labs,
  safety_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "safety",
  text_b_tabset = safety_tex_wo_complete,
  graph_title = transl("title_safety_control_skills", lang))

dhealth_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

dhealth_viz_wo_link <- create_vizzes(
  dhealth_questions, dhealth_vars, sis_labs,
  dhealth_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dhealth",
  text_b_tabset = dhealth_tex_wo_complete,
  graph_title = transl("title_digital_health_wellbeing_skills", lang))

green_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

green_viz_wo_link <- create_vizzes(
  green_questions, green_vars, sis_labs,
  green_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "green",
  text_b_tabset = green_tex_wo_complete,
  graph_title = transl("title_sustainable_green_digital_skills", lang))

dprob_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

dprob_viz_wo_link <- create_vizzes(
  dprob_questions, dprob_vars, sis_labs,
  dprob_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dprob",
  text_b_tabset = dprob_tex_wo_complete,
  graph_title = transl("title_digital_problem_solving_skills", lang)
)

trans_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

trans_viz_wo_link <- create_vizzes(
  trans_questions, trans_vars, sis_labs,
  trans_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "trans",
  text_b_tabset = trans_tex_wo_complete,
  graph_title = transl("title_transactional_skills", lang)
)

ai_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

ai_viz_wo_link <- create_vizzes(
  ai_questions, ai_vars, sis_labs,
  ai_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "ai",
  text_b_tabset = ai_tex_wo_complete,
  graph_title = transl("title_ai_skills", lang)
)

genai_tex_wo_complete <- paste0(
  skills_short, "\n",
  sis_tex_question, "\n",
  skills_tex_more_link
)

# Wave 1 visualizations (only SGAI1-3)
genai_viz_wo_link_w1 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w1,
  x_var_labels = genai_questions_w1,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_wo_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 1,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 1",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave1/overall"
  )

# Wave 2 visualizations (all SGAI1-5)
genai_viz_wo_link_w2 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w2,
  x_var_labels = genai_questions_w2,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_wo_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 2,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 2",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave2/overall"
  )

# Wave 3 visualizations (all SGAI1-5)
genai_viz_wo_link_w3 <- create_viz(
  type = "stackedbars",
  x_vars = genai_vars_w2,
  x_var_labels = genai_questions_w2,
  stacked_type = "percent",
  color_palette = the_colors,
  horizontal = TRUE,
  x_label = "", 
  text_before_tabset = genai_tex_wo_complete,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  drop_na_vars = F,
  stack_label = NULL,
  filter = ~ wave == 3,
  weight_var = "weging_GAMO"
) %>%
  add_viz(
    title = "GenAI Skills", 
    title_tabset = "Wave 3",
    icon = "ph:chart-bar",
    tabgroup = "genai/wave3/overall"
  )

# Over Time Overall (timeline without group_var) - SGAI1-3 across W1-W3, SGAI4-5 across W2-W3
genai_overtime_overall_wo_link <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  text_before_tabset = genai_tex_wo_complete,
  y_filter = 4:5, 
  y_filter_label = "Percentage who answered (Completely) True (4-5)",
  y_filter_combine = T,
  x_label = "", 
  y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors,
  y_min = 0,
  y_max = 100,
  y_filter_label = NULL,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline_single(genai_vars_w2, "genai", "overall", wave_label = "Over Time", questions = genai_questions_w2)

# Wave 1 by Age/Gender/Education/Migration - only SGAI1-3
genai_demo_w1_wo_link <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  text_before_tabset = genai_tex_wo_complete,
  stack_order = rev(sis_labs),
  filter = ~ wave == 1,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "AgeGroup", "genai", "age", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "geslacht", "genai", "gender", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "Education", "genai", "edu", wave_label = "Wave 1") |>
  add_all_viz_stackedbar(genai_vars_w1, genai_questions_w1, "MigrationBackground", "genai", "mig", wave_label = "Wave 1")

# Wave 2 by Age/Gender/Education/Migration - all SGAI1-5
genai_demo_w2_wo_link <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  text_before_tabset = genai_tex_wo_complete,
  filter = ~ wave == 2,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "AgeGroup", "genai", "age", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "geslacht", "genai", "gender", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "Education", "genai", "edu", wave_label = "Wave 2") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "MigrationBackground", "genai", "mig", wave_label = "Wave 2")

# Wave 3 by Age/Gender/Education/Migration - all SGAI1-5
genai_demo_w3_wo_link <- create_viz(
  type = "stackedbar",
  stacked_type = "percent",
  horizontal = T,
  stack_breaks = c(0.5, 2.5, 3.5, 5.5),
  stack_bin_labels = sis_labs,
  stack_order = rev(sis_labs),
  text_before_tabset = genai_tex_wo_complete,
  filter = ~ wave == 3,
  drop_na_vars = F,
  color_palette = the_colors,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "AgeGroup", "genai", "age", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "geslacht", "genai", "gender", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "Education", "genai", "edu", wave_label = "Wave 3") |>
  add_all_viz_stackedbar(genai_vars_w2, genai_questions_w2, "MigrationBackground", "genai", "mig", wave_label = "Wave 3")

# Over Time by Age/Gender/Education/Migration - SGAI1-3 across W1-W3, SGAI4-5 across W2-W3
genai_overtime_demo_wo_link <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  y_filter = 4:5, 
  text_before_tabset = genai_tex_wo_complete,
  x_label = "", 
  y_label = "Percentage who answered (Completely) True (4-5)",
  color_palette = the_colors,
  y_min = 0,
  y_max = 100,
  weight_var = "weging_GAMO"
) |>
  add_all_viz_timeline(genai_vars_w2, "AgeGroup", "genai", "age", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "geslacht", "genai", "gender", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "Education", "genai", "edu", wave_label = "Over Time", questions = genai_questions_w2) |>
  add_all_viz_timeline(genai_vars_w2, "MigrationBackground", "genai", "mig", wave_label = "Over Time", questions = genai_questions_w2)

# Combine them all
genai_viz_wo_link <- genai_viz_wo_link_w1 %>% 
  combine_viz(genai_viz_wo_link_w2) %>%
  combine_viz(genai_viz_wo_link_w3) %>%
  combine_viz(genai_overtime_overall_wo_link) %>%
  combine_viz(genai_demo_w1_wo_link) %>%
  combine_viz(genai_demo_w2_wo_link) %>%
  combine_viz(genai_demo_w3_wo_link) %>%
  combine_viz(genai_overtime_demo_wo_link)

## Performance _wo_link vizzes ----

perf_sis_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_sis", lang))), "', preset = 'question')"),
  "```"
)

perf_sis_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_sis_blockquote, "\n",
  performance_tex_more_link
)

perf_sis_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_sis_questions,
  perf_sis_vars,
  perf_correct_labs,
  text_b_tabset = perf_sis_tex_wo_complete,
  tbgrp        = "perf_sis",
  graph_title  = "",  # TODO: restore perf_sis_questions once dashboardr allows vector titles
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PSIS2R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("strategic_info_infobox_image", lang)),
    image_width = "50%"
  )

perf_cis_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_cis", lang))), "', preset = 'question')"),
  "```"
)

perf_cis_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_cis_blockquote, "\n",
  performance_tex_more_link
)

perf_cis_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_cis_questions,
  perf_cis_vars,
  perf_correct_labs,
  text_b_tabset = perf_cis_tex_wo_complete,
  tbgrp        = "perf_cis",
  graph_title  = "",
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PCIS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q1_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PCIS2R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q2_infobox_image", lang)),
    image_width = "50%"
  ) %>%
  add_modal(
    modal_id = "PCIS3R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("critical_info_competence_q3_infobox_image", lang)),
    image_width = "50%"
  )

perf_n_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_netiquette", lang))), "', preset = 'question')"),
  "```"
)

perf_n_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_n_blockquote, "\n",
  performance_tex_more_link
)

perf_netiquette_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_n_questions,
  perf_n_vars,
  perf_correct_labs,
  text_b_tabset = perf_n_tex_wo_complete,
  tbgrp        = "perf_netiquette",
  graph_title  = perf_n_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PNS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("netiquette_competence_infobox_image", lang)),
    image_width = "50%"
  )

perf_dccs_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_dccs", lang))), "', preset = 'question')"),
  "```"
)

perf_dccs_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_dccs_blockquote, "\n",
  performance_tex_more_link
)

perf_dccs_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_dccs_questions,
  perf_dccs_vars,
  perf_correct_labs,
  text_b_tabset = perf_dccs_tex_wo_complete,
  tbgrp        = "perf_dccs",
  graph_title  = perf_dccs_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
)  %>%
  add_modal(
    modal_id = "PDCCS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("digital_content_creation_competence_infobox_image", lang)),
    image_width = "50%"
  )

perf_safety_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_safety", lang))), "', preset = 'question')"),
  "```"
)

perf_safety_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_safety_blockquote, "\n",
  performance_tex_more_link
)

perf_safety_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_safety_questions,
  perf_safety_vars,
  perf_selected_labs,
  text_b_tabset = perf_safety_tex_wo_complete,
  tbgrp        = "perf_safety",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PSCS3_1",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("safety_competence_infobox_image", lang)),
    image_width = "50%"
  )

# PSCS1 Phishing Recognition (without link for dimension page)
perf_pscs1_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_pscs1", lang))), "', preset = 'question')"),
  "```"
)

perf_pscs1_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_pscs1_blockquote, "\n",
  performance_tex_more_link
)

perf_pscs1_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_pscs1_questions,
  perf_pscs1_vars,
  perf_correct_labs,
  text_b_tabset = perf_pscs1_tex_wo_complete,
  tbgrp        = "perf_pscs1",
  graph_title  = perf_pscs1_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PSCS1R",
    title = transl("more_info", lang),
    image = "PSCS1.jpg",
    image_width = "80%"
  )

perf_health_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_health", lang), '", preset = "question")'),
  "```"
)

perf_health_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_health_blockquote, "\n",
  performance_tex_more_link
)

perf_health_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_health_questions,
  perf_health_vars,
  perf_selected_labs,
  text_b_tabset = perf_health_tex_wo_complete,
  tbgrp        = "perf_health",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  lang = lang
)

perf_green_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_green", lang), '", preset = "question")'),
  "```"
)

perf_green_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_green_blockquote, "\n",
  performance_tex_more_link
)

perf_green_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_green_questions,
  perf_green_vars,
  perf_selected_labs,
  text_b_tabset = perf_green_tex_wo_complete,
  tbgrp        = "perf_green",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  lang = lang
)

perf_ps_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0('create_blockquote("', transl("blockquote_performance_problem_solving", lang), '", preset = "question")'),
  "```"
)

perf_ps_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_ps_blockquote, "\n",
  performance_tex_more_link
)

perf_ps_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_ps_questions,
  perf_ps_vars,
  perf_selected_labs,
  text_b_tabset = perf_ps_tex_wo_complete,
  tbgrp        = "perf_ps",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  lang = lang
)

perf_trans_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_trans", lang))), "', preset = 'question')"),
  "```"
)

perf_trans_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_trans_blockquote, "\n",
  performance_tex_more_link
)

perf_trans_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_trans_questions,
  perf_trans_vars,
  perf_correct_labs,
  text_b_tabset = perf_trans_tex_wo_complete,
  tbgrp        = "perf_trans",
  graph_title  = perf_trans_questions,
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PTS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("transactional_competence_infobox_image", lang)),
    image_width = "50%"
  )

perf_ai_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_ai", lang))), "', preset = 'question')"),
  "```"
)

perf_ai_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_ai_blockquote, "\n",
  performance_tex_more_link
)

perf_ai_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_ai_questions,
  perf_ai_vars,
  perf_selected_labs,
  text_b_tabset = perf_ai_tex_wo_complete,
  tbgrp        = "perf_ai",
  graph_title  = "",
  map_values   = list("1" = transl("label_selected", lang), "0" = transl("label_not_selected", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PAIS2_1",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("ai_competence_infobox_image", lang)),
    image_width = "50%"
  )

perf_genai_blockquote <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  paste0("create_blockquote('", gsub('"', '\\\\"', gsub("'", "\\\\'", transl("blockquote_performance_genai", lang))), "', preset = 'question')"),
  "```"
)

perf_genai_tex_wo_complete <- paste0(
  performance_short, "\n",
  perf_genai_blockquote, "\n",
  performance_tex_more_link
)

perf_genai_viz_wo_link <- create_vizzes3(
  breaks       = knowledge_breaks,
  perf_genai_questions,
  perf_genai_vars,
  perf_correct_labs,
  text_b_tabset = perf_genai_tex_wo_complete,
  tbgrp        = "perf_genai",
  graph_title  = "",  # TODO: restore perf_genai_questions once dashboardr allows vector titles
  map_values   = list("1" = transl("label_correct", lang), "0" = transl("label_incorrect", lang)),
  lang = lang
) %>%
  add_modal(
    modal_id = "PAIS1R",
    title = transl("more_info", lang),
    image = paste0("https://raw.githubusercontent.com/favstats/digicomp/refs/heads/main/img/", transl("genai_competence_infobox_image", lang)),
    image_width = "50%"
  )

## 7.1 Strategic Information Dimension ----
strategic_visualizations <- (sis_viz_wo_link + kinfo_viz_wo_link + perf_sis_viz_wo_link)  %>%
  set_tabgroup_labels(
    sis = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_skills", lang)),
    kinfo = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_knowledge", lang)),
    perf_sis = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)),
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)),
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3"))
  )

## 7.2 Critical Information Dimension ----
critical_info_visualizations <- (cis_viz_wo_link + critinfo_viz_wo_link + perf_cis_viz_wo_link) %>%
  set_tabgroup_labels(
    cis = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_critical_info_skills", lang)),
    critinfo = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_critical_info_knowledge", lang)),
    perf_cis = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_critical_info_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3"))
  )

## 7.3 Netiquette Dimension ----
netiquette_visualizations <- (nskills_viz_wo_link + knet_viz_wo_link + perf_netiquette_viz_wo_link) %>%
  set_tabgroup_labels(
    nskills = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_netiquette_skills", lang)),
    knet = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_netiquette_knowledge", lang)),
    perf_netiquette = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_netiquette_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")), 
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4"))
  )

## 7.4 Digital Content Creation Dimension ----
content_creation_visualizations <- (dccs_viz_wo_link + kcrea_viz_wo_link + perf_dccs_viz_wo_link) %>%
  set_tabgroup_labels(
    dccs = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_content_creation_skills", lang)),
    kcrea = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_content_creation_knowledge", lang)),
    perf_dccs = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_content_creation_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")), 
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4"))
  )

## 7.5 Safety & Control Dimension ----
safety_visualizations <- (safety_viz_wo_link + ksafety_viz_wo_link + perf_safety_viz_wo_link + perf_pscs1_viz_wo_link) %>%
  set_tabgroup_labels(
    safety = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_safety_skills", lang)),
    ksafety = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_safety_knowledge", lang)),
    perf_safety = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_safety_performance", lang)),
    perf_pscs1 = paste0("{{< iconify ph warning-fill >}} ", transl("tab_phishing_recognition", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")), 
    item6 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")), 
    item8 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8")), 
    item9 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 9"))
  )

## 7.6 Digital Health & Wellbeing Dimension ----
health_visualizations <- (dhealth_viz_wo_link + khealth_viz_wo_link + perf_health_viz_wo_link) %>%
  set_tabgroup_labels(
    dhealth = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_digital_health_skills", lang)),
    khealth = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_digital_health_knowledge", lang)),
    perf_health = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_digital_health_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")), 
    item6 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")), 
    item7 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7"))
  )

## 7.7 Green / Sustainable Digital Dimension ----
green_visualizations <- (green_viz_wo_link + kgreen_viz_wo_link + perf_green_viz_wo_link) %>%
  set_tabgroup_labels(
    green = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_green_skills", lang)),
    kgreen = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_green_knowledge", lang)),
    perf_green = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_green_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")), 
    item6 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")), 
    item8 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8"))
  )

## 7.8 Digital Problem Solving Dimension ----
problem_solving_visualizations <- (dprob_viz_wo_link + perf_ps_viz_wo_link) %>%
  set_tabgroup_labels(
    dprob = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_problem_solving_skills", lang)),
    perf_ps = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_problem_solving_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")), 
    item6 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")), 
    item8 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8")), 
    item9 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 9"))
  )

## 7.9 Transactional Dimension ----
transactional_visualizations <- (trans_viz_wo_link + ktrans_viz_wo_link + perf_trans_viz_wo_link) %>%
  set_tabgroup_labels(
    trans = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_transactional_skills", lang)),
    ktrans = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_transactional_knowledge", lang)),
    perf_trans = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_transactional_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5"))
  )

## 7.10 AI Dimension ----
ai_visualizations <- (ai_viz_wo_link + kai_viz_wo_link + perf_ai_viz_wo_link) %>%
  set_tabgroup_labels(
    ai = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_ai_skills", lang)),
    kai = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_ai_knowledge", lang)),
    perf_ai = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_ai_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")), 
    item6 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")), 
    item8 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8")), 
    item9 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 9"))
  )

## 7.11 Generative AI Dimension ----
genai_combined_visualizations <- (genai_viz_wo_link + kgai_viz_wo_link + perf_genai_viz_wo_link) %>%
  set_tabgroup_labels(
    genai = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_genai_skills", lang)),
    kgai = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_genai_knowledge", lang)),
    perf_genai = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_genai_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)), 
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)), 
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)), 
    edu = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)), 
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")), 
    item2 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")), 
    item3 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")), 
    item5 = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5"))
  )

strategic_visualizations <- (sis_viz_wo_link + kinfo_viz_wo_link + perf_sis_viz_wo_link)  %>%
  set_tabgroup_labels(
    sis = paste0("{{< iconify ph lightning-fill >}} ", transl("tab_skills", lang)),
    kinfo = paste0("{{< iconify ph book-open-fill >}} ", transl("tab_knowledge", lang)),
    perf_sis = paste0("{{< iconify ph clipboard-text >}} ", transl("tab_performance", lang)),
    wave1 = paste0("{{< iconify ph number-circle-one-fill >}} ", transl("tab_wave1", lang)),
    wave2 = paste0("{{< iconify ph number-circle-two-fill >}} ", transl("tab_wave2", lang)),
    wave3 = paste0("{{< iconify ph number-circle-three-fill >}} ", transl("tab_wave3", lang)),
    age    = paste0("{{< iconify mdi:human-male-male-child >}} ", transl("tab_age", lang)),
    gender = paste0("{{< iconify mdi gender-transgender >}} ", transl("tab_gender", lang)),
    edu    = paste0("{{< iconify ph graduation-cap-fill >}} ", transl("tab_education", lang)),
    mig = paste0("{{< iconify ph globe-hemisphere-east >}} ", transl("tab_migration", lang)),
    overtime   = paste0("{{< iconify ph chart-line-fill >}} ", transl("tab_overtime", lang)),
    overall = paste0("{{< iconify ph users-fill >}} ", transl("tab_overall", lang)),
    item1  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 1")),
    item2  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 2")),
    item3  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 3")),
    item4  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 4")),
    item5  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 5")),
    item6  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 6")),
    item7  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 7")),
    item8  = paste0("{{< iconify ph chat-circle-fill >}} ", paste0(transl("tab_question", lang), " 8"))
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
    transl("page_name_ronde1", lang)
    # Future: transl("page_name_ronde2", lang)
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
  /* DigIQ Unified Theme & Color Palette Overrides */
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

  /* Question blockquotes in DigIQ Teal & Soft Mint */
  blockquote.blockquote {
    border-left: 5px solid #3D7271 !important;
    background: linear-gradient(90deg, #f2f8f6 0%, #f9fbfb 100%) !important;
    color: #243b3a !important;
    border-radius: 0 10px 10px 0 !important;
    padding: 14px 22px !important;
    box-shadow: 0 2px 6px rgba(61, 114, 113, 0.06) !important;
  }

  /* Clickable modal links inside question blockquotes */
  a.modal-link {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background-color: #e4f2ee;
    color: #0F6B5A !important;
    padding: 2px 9px;
    border-radius: 6px;
    border: 1px solid #b5ded2;
    font-weight: 600;
    text-decoration: none !important;
    transition: all 0.18s ease;
  }
  a.modal-link:hover {
    background-color: #3D7271;
    color: #ffffff !important;
    border-color: #3D7271;
    transform: translateY(-1px);
  }

  /* Wave 3 missing-data callout note on Performance sections */
  .dc-wave3-note {
    display: flex;
    align-items: flex-start;
    gap: 0.6rem;
    border-left: 4px solid #E28D50;
    background-color: #fdf6ef;
    color: #6e3b14;
    padding: 0.7rem 1.05rem;
    border-radius: 0 8px 8px 0;
    margin: 0.75rem 0 1rem 0;
    font-size: 0.93rem;
    line-height: 1.5;
  }
  .dc-wave3-note iconify-icon {
    color: #E28D50;
    font-size: 1.2rem;
    flex-shrink: 0;
    margin-top: 0.12rem;
  }

  /* Landing page hero & info banner */
  .dc-hero {
    max-width: 920px;
    margin: 0.5rem auto 1.75rem auto;
    padding: 1.5rem 2rem;
    background: linear-gradient(135deg, #f4f9f7 0%, #ebf4f1 100%);
    border: 1px solid #d5e5e1;
    border-top: 4px solid #3D7271;
    border-radius: 14px;
    text-align: center;
    color: #243b3a;
    box-shadow: 0 4px 16px rgba(31, 63, 62, 0.05);
  }
  .dc-hero p:first-child {
    font-size: 1.18rem;
    font-weight: 600;
    color: #0F6B5A;
    margin-bottom: 0.65rem;
  }
  .dc-hero p:last-child {
    font-size: 1.01rem;
    line-height: 1.65;
    color: #334e4d;
    margin-bottom: 0;
  }

  /* Landing page 11-tile grid */
  .dc-links {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.15rem;
    margin: 1.5rem 0 2rem 0;
  }
  @media (min-width: 1100px) {
    .dc-links {
      grid-template-columns: repeat(6, minmax(0, 1fr));
    }
    .dc-links > .dc-link {
      grid-column: span 2;
    }
    /* Center the final 2 cards (10 & 11) on the bottom row */
    .dc-links > .dc-link:nth-child(10) {
      grid-column: 2 / span 2;
    }
    .dc-links > .dc-link:nth-child(11) {
      grid-column: 4 / span 2;
    }
  }
  .dc-link {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 1.25rem 1.35rem;
    border-radius: 13px;
    border: 1px solid #d5e3e0;
    border-left: 6px solid #3D7271;
    background: #ffffff;
    color: inherit !important;
    text-decoration: none !important;
    text-align: left;
    box-shadow: 0 2px 10px rgba(31, 63, 62, 0.05);
    transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease, background-color 0.2s ease;
  }
  .dc-link:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 24px rgba(31, 63, 62, 0.12);
    border-color: #3D7271;
    border-left-color: #E28D50;
    background: #fbfdfc;
  }
  .dc-card-header {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 0.6rem;
  }
  .dc-card-icon {
    width: 42px;
    height: 42px;
    border-radius: 11px;
    background: linear-gradient(135deg, #e6f4f0 0%, #c7e6d5 100%);
    color: #0F6B5A;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 1.35rem;
    flex-shrink: 0;
    transition: background 0.2s ease, color 0.2s ease, transform 0.2s ease;
  }
  .dc-link:hover .dc-card-icon {
    background: #3D7271;
    color: #ffffff;
    transform: scale(1.05);
  }
  .dc-link-title {
    font-weight: 700;
    color: #1f3f3e;
    font-size: 1.06rem;
    line-height: 1.25;
    flex-grow: 1;
    transition: color 0.2s ease;
  }
  .dc-link:hover .dc-link-title {
    color: #0F6B5A;
  }
  .dc-card-arrow {
    color: #9ab3b0;
    font-size: 1.05rem;
    transition: transform 0.2s ease, color 0.2s ease;
    flex-shrink: 0;
  }
  .dc-link:hover .dc-card-arrow {
    transform: translateX(4px);
    color: #E28D50;
  }
  .dc-link-text {
    font-size: 0.91rem;
    line-height: 1.5;
    color: #4a5b5a;
    margin-bottom: 0.9rem;
    flex-grow: 1;
  }
  .dc-card-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem;
    padding-top: 0.65rem;
    border-top: 1px solid #edf3f2;
  }
  .dc-tag {
    display: inline-flex;
    align-items: center;
    gap: 0.28rem;
    font-size: 0.74rem;
    font-weight: 600;
    padding: 0.2rem 0.55rem;
    border-radius: 999px;
    letter-spacing: 0.01em;
  }
  .dc-tag-skills {
    background-color: #e6f4f0;
    color: #0F6B5A;
    border: 1px solid #bfe3d7;
  }
  .dc-tag-knowledge {
    background-color: #fef6dc;
    color: #825600;
    border: 1px solid #f0d57d;
  }
  .dc-tag-perf {
    background-color: #fdede2;
    color: #9c4215;
    border: 1px solid #eeb998;
  }

  /* Dimension page intro card & clickable measurement jump-pills */
  .dc-dim-intro {
    background: linear-gradient(135deg, #f6faf9 0%, #ecf4f2 100%);
    border: 1px solid #d3e3e0;
    border-left: 6px solid #3D7271;
    border-radius: 13px;
    padding: 1.25rem 1.5rem;
    margin: 0.75rem 0 1.75rem 0;
    box-shadow: 0 3px 12px rgba(31, 63, 62, 0.05);
  }
  .dc-dim-intro > p {
    font-size: 1.03rem;
    line-height: 1.65;
    color: #243b3a;
    margin-bottom: 0.85rem;
  }
  .dc-jump-row {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.45rem;
    padding-top: 0.75rem;
    border-top: 1px solid rgba(61, 114, 113, 0.15);
    font-size: 0.96rem;
    color: #2f4b4a;
  }
  .dc-jump-label {
    font-weight: 600;
    color: #1f3f3e;
    margin-right: 0.15rem;
  }
  .dc-jump-sep {
    color: #546e6d;
    margin-right: 0.1rem;
  }
  a.dc-jump-pill {
    display: inline-flex;
    align-items: center;
    gap: 0.38rem;
    padding: 0.32rem 0.82rem;
    border-radius: 999px;
    font-size: 0.89rem;
    font-weight: 600;
    text-decoration: none !important;
    transition: transform 0.18s ease, box-shadow 0.18s ease, background-color 0.18s ease, color 0.18s ease, border-color 0.18s ease;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
  }
  a.dc-jump-pill:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 12px rgba(31, 63, 62, 0.15);
  }
  .dc-jump-arrow {
    font-size: 0.8rem;
    opacity: 0.8;
    transition: transform 0.18s ease;
  }
  a.dc-jump-pill:hover .dc-jump-arrow {
    transform: translateY(2px);
    opacity: 1;
  }
  a.dc-jump-skills {
    background-color: #e6f4f0;
    color: #0F6B5A !important;
    border: 1px solid #b3ddd0;
  }
  a.dc-jump-skills:hover {
    background-color: #3D7271;
    color: #ffffff !important;
    border-color: #3D7271;
  }
  a.dc-jump-knowledge {
    background-color: #fef6dc;
    color: #7d5200 !important;
    border: 1px solid #ebd076;
  }
  a.dc-jump-knowledge:hover {
    background-color: #c98f12;
    color: #ffffff !important;
    border-color: #c98f12;
  }
  a.dc-jump-perf {
    background-color: #fdede2;
    color: #9c4215 !important;
    border: 1px solid #ebb491;
  }
  a.dc-jump-perf:hover {
    background-color: #E28D50;
    color: #ffffff !important;
    border-color: #E28D50;
  }
"

tag_skills_label <- transl("tab_skills", lang)
tag_knowledge_label <- transl("tab_knowledge", lang)
tag_perf_label <- transl("tab_performance", lang)

landing_cards_html <- pmap_chr(
  landing_pages,
  function(slug, icon, title_key, card_key, has_knowledge) {
    tags_html <- paste0(
      "<div class='dc-card-tags'>",
      "<span class='dc-tag dc-tag-skills'><iconify-icon inline icon='ph:lightning-fill'></iconify-icon> ", tag_skills_label, "</span>",
      if (has_knowledge) paste0("<span class='dc-tag dc-tag-knowledge'><iconify-icon inline icon='ph:book-open-fill'></iconify-icon> ", tag_knowledge_label, "</span>") else "",
      "<span class='dc-tag dc-tag-perf'><iconify-icon inline icon='ph:clipboard-text'></iconify-icon> ", tag_perf_label, "</span>",
      "</div>"
    )
    paste0(
      "<a class='dc-link' href='", slug, ".html'>",
      "<div>",
      "<div class='dc-card-header'>",
      "<div class='dc-card-icon'><iconify-icon icon='", icon, "'></iconify-icon></div>",
      "<div class='dc-link-title'>", transl(title_key, lang), "</div>",
      "<span class='dc-card-arrow'><iconify-icon inline icon='ph:arrow-right-bold'></iconify-icon></span>",
      "</div>",
      "<div class='dc-link-text'>", transl(card_key, lang), "</div>",
      "</div>",
      tags_html,
      "</a>"
    )
  }
)

landing_links <- paste0(
  "```{=html}\n",
  "<style>", digiq_shared_css, "</style>\n",
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

  s_pill <- paste0(
    "<a class='dc-jump-pill dc-jump-skills' href='", s_anchor, "'>",
    "<iconify-icon inline icon='ph:lightning-fill'></iconify-icon> ",
    "<span>", s_label, "</span> <span class='dc-jump-arrow'>&#8595;</span></a>"
  )
  p_pill <- paste0(
    "<a class='dc-jump-pill dc-jump-perf' href='", p_anchor, "'>",
    "<iconify-icon inline icon='ph:clipboard-text'></iconify-icon> ",
    "<span>", p_label, "</span> <span class='dc-jump-arrow'>&#8595;</span></a>"
  )

  if (!is.null(knowledge_key)) {
    k_anchor <- paste0("#", slugify_anchor(transl(knowledge_key, lang)))
    k_pill <- paste0(
      "<a class='dc-jump-pill dc-jump-knowledge' href='", k_anchor, "'>",
      "<iconify-icon inline icon='ph:book-open-fill'></iconify-icon> ",
      "<span>", k_label, "</span> <span class='dc-jump-arrow'>&#8595;</span></a>"
    )
    intro_label <- if (lang == "nl") "Dit wordt op drie manieren gemeten:" else "It is measured in three ways:"
    and_sep <- if (lang == "nl") ", en" else ", and"
    jump_html <- paste0(
      "<div class='dc-jump-row'>",
      "<span class='dc-jump-label'>", intro_label, "</span> ",
      s_pill, "<span class='dc-jump-sep'>,</span> ",
      k_pill, "<span class='dc-jump-sep'>", and_sep, "</span> ",
      p_pill, "<span class='dc-jump-sep'>.</span>",
      "</div>"
    )
  } else {
    intro_label <- if (lang == "nl") "Dit wordt op twee manieren gemeten:" else "It is measured in two ways:"
    and_sep <- if (lang == "nl") " en" else " and"
    jump_html <- paste0(
      "<div class='dc-jump-row'>",
      "<span class='dc-jump-label'>", intro_label, "</span> ",
      s_pill, "<span class='dc-jump-sep'>", and_sep, "</span> ",
      p_pill, "<span class='dc-jump-sep'>.</span>",
      "</div>"
    )
  }

  md_text(
    "```{=html}",
    paste0("<style>", digiq_shared_css, "</style>"),
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
  output_dir = "qmds_en", 
  publish_dir = "../docs/en",
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
  # Landing page with icon and 11 clickable dimension tiles
  add_page(
    name = transl("dashboard_title", lang),
    text = md_text(
      "::: {.dc-hero}",
      transl("landing_page_text", lang),
      ":::",
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
  # COMMENTED OUT: Top-level Skills, Performance, and Knowledge pages (removed from navbar per feasibility testing feedback)
  # add_page(
  #   overlay = T,
  #   overlay_duration = 1,
  #   name = transl("page_name_skills", lang),
  #   data = digicom_data,
  #   visualizations = skills_viz,
  #   icon = "ph:lightning-fill",
  #   text = md_text(
  #     # transl("mockup_warning", lang),
  #     # "",
  #     transl("page_text_skills", lang)
  #   )
  # ) %>%
  # add_page(
  #   overlay = T,
  #   overlay_duration = 1,
  #   name = transl("page_name_performance", lang),
  #   data = digicom_data,
  #   visualizations = performance_collection,
  #   icon = "ph:clipboard-text",
  #   text = md_text(
  #     # transl("mockup_warning", lang),
  #     # "",
  #     transl("page_text_performance", lang)
  #   )
  # ) %>%
  # add_page(
  #   overlay = T,
  #   overlay_duration = 1,
  #   name = transl("page_name_knowledge", lang),
  #   data = digicom_data,
  #   visualizations = knowledge_collection,
  #   icon = "ph:book-open-fill",
  #   text = md_text(
  #     # transl("mockup_warning", lang),
  #     # "",
  #     transl("page_text_knowledge", lang)
  #   )
  # ) %>%
  # COMMENTED OUT: Hoogtepunten/Highlights page
#   add_page(
#     name = transl("page_name_highlights", lang),
#     data = digicom_data,
#     icon = "ph:star-fill",
#     # visualizations = genai_viz,
#     text = md_text(
#       "<div style='text-align: justify;'>",
#       paste0("### ", transl("highlights_wave1_title", lang)),
#       transl("highlights_intro", lang),
#       "",
#       transl("key_finding_1", lang),
#       "",
#       transl("key_finding_2", lang),
#       "",
#       transl("key_finding_3", lang),
#       "</div>"
#     )
#   )%>%
  # Analysis page with data and visualizations
  add_page(
    name = transl("page_name_strategic_info", lang),
    icon = "ph:magnifying-glass",
    data = digicom_data,
    visualizations = strategic_visualizations,
    text = dim_page_intro("strategic_info_description", "tab_skills", "tab_knowledge", "tab_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_critical_info", lang),
    icon = "ph:detective-fill",
    data = digicom_data,
    visualizations = critical_info_visualizations,
    text = dim_page_intro("critical_info_description", "tab_critical_info_skills", "tab_critical_info_knowledge", "tab_critical_info_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_netiquette", lang),
    icon = "ph:chats-fill",
    data = digicom_data,
    visualizations = netiquette_visualizations,
    text = dim_page_intro("netiquette_description", "tab_netiquette_skills", "tab_netiquette_knowledge", "tab_netiquette_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_content_creation", lang),
    icon = "ph:palette-fill",
    data = digicom_data,
    visualizations = content_creation_visualizations,
    text = dim_page_intro("content_creation_description", "tab_content_creation_skills", "tab_content_creation_knowledge", "tab_content_creation_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_safety", lang),
    icon = "ph:shield-check-fill",
    data = digicom_data,
    visualizations = safety_visualizations,
    text = dim_page_intro("safety_description", "tab_safety_skills", "tab_safety_knowledge", "tab_safety_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_digital_health", lang),
    icon = "ph:heart-fill",
    data = digicom_data,
    visualizations = health_visualizations,
    text = dim_page_intro("health_description", "tab_digital_health_skills", "tab_digital_health_knowledge", "tab_digital_health_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_green", lang),
    icon = "ph:recycle-fill",
    data = digicom_data,
    visualizations = green_visualizations,
    text = dim_page_intro("green_description", "tab_green_skills", "tab_green_knowledge", "tab_green_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_problem_solving", lang),
    icon = "ph:lightbulb-fill",
    data = digicom_data,
    visualizations = problem_solving_visualizations,
    text = dim_page_intro("problem_solving_description", "tab_problem_solving_skills", NULL, "tab_problem_solving_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_transactional", lang),
    icon = "ph:wallet-fill",
    data = digicom_data,
    visualizations = transactional_visualizations,
    text = dim_page_intro("transactional_description", "tab_transactional_skills", "tab_transactional_knowledge", "tab_transactional_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_ai", lang),
    icon = "ph:robot-fill",
    data = digicom_data,
    visualizations = ai_visualizations,
    text = dim_page_intro("ai_description", "tab_ai_skills", "tab_ai_knowledge", "tab_ai_performance", lang)
  ) %>%

  add_page(
    name = transl("page_name_genai", lang),
    icon = "ph:magic-wand-fill",
    data = digicom_data,
    visualizations = genai_combined_visualizations,
    text = dim_page_intro("genai_description", "tab_genai_skills", "tab_genai_knowledge", "tab_genai_performance", lang)
  ) %>%
  # About page (now in More Info dropdown)
  add_page(
    name = transl("page_name_about", lang),
    icon = "ph:info-fill",
    text = md_text(
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
      "      class = 'col-md-2',",
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
      "        class = 'col-md-2',",
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

# 7. WAVE 1 PAGE: Pre-compute demographics & correlations =====================

wave1_data_page <- digicom_data %>% filter(wave == 1)
w1_n_total <- nrow(wave1_data_page)

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
  reactable::reactable(df,
    compact = TRUE, borderless = TRUE, striped = TRUE,
    defaultPageSize = nrow(df), pagination = FALSE,
    theme = reactable::reactableTheme(
      headerStyle = list(background = "#3D7271", color = "white", fontWeight = "bold", fontSize = "13px"),
      cellStyle = list(fontSize = "13px")
    ),
    columns = list(
      Category = reactable::colDef(name = "Category", minWidth = 180),
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

# 1. Age group (PDF spec: 10-15, 16-30, 31-60, 61-110)
wave1_data_page$AgeGroupW1 <- cut(wave1_data_page$Age, breaks = c(10, 16, 31, 61, 110),
  right = FALSE, labels = c("10-15", "16-30", "31-60", "61-110"))
w1_age_df <- w1_make_freq(wave1_data_page, "AgeGroupW1")

# 2. Gender (values are text in digicom_data: "Female", "Male", etc.)
w1_gender_df <- w1_make_freq(wave1_data_page, "Gender",
  labels_map = c("Male" = transl("label_male", lang),
                 "Female" = transl("label_female", lang),
                 "X" = "X",
                 "I'd rather not say" = transl("scale_prefer_not_answer", lang)))

# 3. Education level (Education column is already translated & factored)
w1_edu_df <- w1_make_freq(wave1_data_page, "Education")

# 4. Migration background
w1_mig_df <- w1_make_freq(wave1_data_page, "MigrationBackground")

# 5. Panel type
wave1_data_page$SampleRW1 <- ifelse(wave1_data_page$Sample %in% c(1, 2, "Panel adults", "Panel children"),
  transl("w1_panel", lang),
  ifelse(wave1_data_page$Sample %in% c(3, 4, "Address sample"),
    transl("w1_address", lang), NA))
w1_sample_df <- w1_make_freq(wave1_data_page, "SampleRW1")

# 6. Use of Devices
w1_device_labels <- setNames(
  c(transl("w1_device_never", lang), transl("w1_device_almost_never", lang),
    transl("w1_device_sometimes", lang), transl("w1_device_often", lang),
    transl("w1_device_very_often", lang)),
  c("1", "2", "3", "4", "5"))
w1_comp_df <- w1_make_freq(wave1_data_page, "UseComp", labels_map = w1_device_labels, exclude_vals = c("66", "99"))
w1_tablet_df <- w1_make_freq(wave1_data_page, "UseTablet", labels_map = w1_device_labels, exclude_vals = c("66", "99"))
w1_phone_df <- w1_make_freq(wave1_data_page, "UsePhone", labels_map = w1_device_labels, exclude_vals = c("66", "99"))

# 7. General Literacy
w1_lit_labels <- setNames(
  c(transl("w1_lit_never", lang), transl("w1_lit_almost_never", lang),
    transl("w1_lit_sometimes", lang), transl("w1_lit_often", lang),
    transl("w1_lit_very_often", lang)),
  c("1", "2", "3", "4", "5"))
w1_lit_df <- w1_make_freq(wave1_data_page, "Literacy", labels_map = w1_lit_labels, exclude_vals = c("66", "99"))

# 8. Work status
w1_work_labels <- setNames(
  c(transl("w1_work_student", lang), transl("w1_work_employed", lang),
    transl("w1_work_housekeeper", lang), transl("w1_work_unemployed", lang),
    transl("w1_work_retired", lang), transl("w1_work_volunteer", lang),
    transl("w1_work_other", lang)),
  c("1", "2", "3", "4", "5", "6", "7"))
w1_work_df <- w1_make_freq(wave1_data_page, "Work", labels_map = w1_work_labels, exclude_vals = c("99"))

# 9. Hours of work with computer (employed only)
w1_employed <- wave1_data_page %>% filter(Work == 2 | Work == "2" | Work == "Employed")
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
w1_fin_df <- w1_make_freq(wave1_data_page, "FinancialInsecurity", labels_map = w1_fin_labels, exclude_vals = c("66", "99"))

# -- Correlation heatmap (Spearman, 19 variables per PDF spec) --

# Compute TotalPerformance
w1_perf_items <- c("PSIS1RC", "PSIS2R", "PCIS1R", "PCIS2R", "PCIS3R", "PNS1R",
  "PDCCS1R", "PSCS1R", "PSCS3R", "PDHWS1R", "PSGDS1R", "SourceHelpR",
  "PAIS2R", "PAIS1R", "PGAIS1RC", "PTS1R")
w1_avail_perf <- intersect(w1_perf_items, names(wave1_data_page))
if (length(w1_avail_perf) > 0) {
  wave1_data_page$TotalPerformance <- rowSums(wave1_data_page[, w1_avail_perf], na.rm = FALSE)
}

# Compute demographic dummies per PDF spec
wave1_data_page$GenderN <- ifelse(wave1_data_page$Gender == 1 | wave1_data_page$Gender == "Male", 1,
  ifelse(wave1_data_page$Gender == 2 | wave1_data_page$Gender == "Female", 0, NA))
wave1_data_page$EducationN <- ifelse(wave1_data_page$EducationR == "Low" | wave1_data_page$EducationR == 1, 1,
  ifelse(wave1_data_page$EducationR == "Middle" | wave1_data_page$EducationR == 2, 2,
  ifelse(wave1_data_page$EducationR == "High" | wave1_data_page$EducationR == 3, 3, NA)))
wave1_data_page$MigrationBackgroundN <- ifelse(wave1_data_page$MigrationBackground == transl("label_no", lang), 0,
  ifelse(wave1_data_page$MigrationBackground == transl("label_yes", lang), 1, NA))
wave1_data_page$SampleN <- ifelse(wave1_data_page$Sample %in% c(1, 2, "Panel adults", "Panel children"), 1,
  ifelse(wave1_data_page$Sample %in% c(3, 4, "Address sample"), 0, NA))
wave1_data_page$Work_Werk <- ifelse(wave1_data_page$Work == 2 | wave1_data_page$Work == "2", 1, 0)
wave1_data_page$Work_Stud <- ifelse(wave1_data_page$Work == 1 | wave1_data_page$Work == "1", 1, 0)
wave1_data_page$LiteracyN <- as.numeric(wave1_data_page$Literacy)
wave1_data_page$LiteracyN[wave1_data_page$LiteracyN %in% c(66, 99)] <- NA
wave1_data_page$FinancialInsecurityN <- as.numeric(wave1_data_page$FinancialInsecurity)
wave1_data_page$FinancialInsecurityN[wave1_data_page$FinancialInsecurityN %in% c(66, 99)] <- NA
if ("MeanKnowledge" %in% names(wave1_data_page)) {
  wave1_data_page$TotalKnowledge <- wave1_data_page$MeanKnowledge
}

# Full variable set (19 variables per PDF spec)
w1_cor_vars <- c("MeanStratInfo", "MeanCritInfo", "MeanNet", "MeanCrea",
  "MeanSaf", "MeanHealth", "MeanTrans", "MeanGreen", "MeanProbl",
  "MeanAI", "MeangenAI", "TotalKnowledge", "TotalPerformance",
  "GenderN", "Work_Werk", "Work_Stud", "Work_2", "LiteracyN", "FinancialInsecurityN")
w1_avail_vars <- intersect(w1_cor_vars, names(wave1_data_page))

w1_cor_plot <- NULL
if (length(w1_avail_vars) >= 2) {
  if ("Work_2" %in% w1_avail_vars) {
    wave1_data_page$Work_2 <- as.numeric(wave1_data_page$Work_2)
  }
  w1_cor_data <- wave1_data_page[, w1_avail_vars]
  w1_cor_matrix <- cor(w1_cor_data, method = "spearman", use = "pairwise.complete.obs")

  w1_display_names <- c("MeanStratInfo" = "Strat. Info", "MeanCritInfo" = "Crit. Info",
    "MeanNet" = "Netiquette", "MeanCrea" = "Creativity", "MeanSaf" = "Safety",
    "MeanHealth" = "Health", "MeanTrans" = "Transactional", "MeanGreen" = "Green",
    "MeanProbl" = "Problem Solv.", "MeanAI" = "AI", "MeangenAI" = "GenAI",
    "TotalKnowledge" = "Tot. Knowledge", "TotalPerformance" = "Tot. Performance",
    "GenderN" = "Gender", "Work_Werk" = "Employed", "Work_Stud" = "Student",
    "Work_2" = "Work Hours", "LiteracyN" = "Literacy", "FinancialInsecurityN" = "Fin. Insecurity")
  rownames(w1_cor_matrix) <- w1_display_names[rownames(w1_cor_matrix)]
  colnames(w1_cor_matrix) <- w1_display_names[colnames(w1_cor_matrix)]

  w1_cor_melted <- reshape2::melt(w1_cor_matrix)
  names(w1_cor_melted) <- c("Var1", "Var2", "Correlation")
  w1_cor_melted$Var1 <- factor(w1_cor_melted$Var1, levels = w1_display_names[w1_avail_vars])
  w1_cor_melted$Var2 <- factor(w1_cor_melted$Var2, levels = rev(w1_display_names[w1_avail_vars]))
  w1_cor_melted$Correlation[as.numeric(w1_cor_melted$Var1) < as.numeric(factor(w1_cor_melted$Var2, levels = levels(w1_cor_melted$Var1)))] <- NA

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
      x = "", y = "", fill = "Correlation")
}

# Build Wave 1 content collection using dashboardr functions
wave1_content <- create_content() %>%
  add_text(paste0("**N = ", format(w1_n_total, big.mark = ","),
    " | ", transl("w1_label_mean_age", lang), ": ",
    round(mean(wave1_data_page$Age, na.rm = TRUE), 1), "**")) %>%
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
  add_text(paste0("### ", transl("w1_header_device_computer", lang))) %>%
  add_reactable(w1_styled_reactable(w1_comp_df)) %>%
  add_text(paste0("### ", transl("w1_header_device_tablet", lang))) %>%
  add_reactable(w1_styled_reactable(w1_tablet_df)) %>%
  add_text(paste0("### ", transl("w1_header_device_phone", lang))) %>%
  add_reactable(w1_styled_reactable(w1_phone_df)) %>%
  add_text(paste0("### ", transl("w1_header_literacy", lang))) %>%
  add_reactable(w1_styled_reactable(w1_lit_df)) %>%
  add_text(paste0("### ", transl("w1_header_work", lang))) %>%
  add_reactable(w1_styled_reactable(w1_work_df))

if (!is.null(w1_work2_df)) {
  w1_work2_rt <- reactable::reactable(w1_work2_df,
    compact = TRUE, borderless = TRUE, striped = TRUE,
    defaultPageSize = nrow(w1_work2_df), pagination = FALSE,
    theme = reactable::reactableTheme(
      headerStyle = list(background = "#3D7271", color = "white", fontWeight = "bold", fontSize = "13px"),
      cellStyle = list(fontSize = "13px")
    ),
    columns = list(
      Statistic = reactable::colDef(minWidth = 180),
      Value = reactable::colDef(align = "right", minWidth = 80)
    )
  )
  wave1_content <- wave1_content %>%
    add_text(paste0("### ", transl("w1_header_work_hours", lang))) %>%
    add_reactable(w1_work2_rt)
}

wave1_content <- wave1_content %>%
  add_text(paste0("### ", transl("w1_header_financial", lang))) %>%
  add_reactable(w1_styled_reactable(w1_fin_df))

if (!is.null(w1_cor_plot)) {
  wave1_content <- wave1_content %>%
    add_text(paste0("## ", transl("w1_header_correlations", lang))) %>%
    add_ggplot(w1_cor_plot, width = 14, height = 12)
}

# Resume dashboard pipeline
dashboard <- dashboard %>%

  # Ronde 1 / Wave 1 page (in More Info dropdown)
  add_page(
    name = transl("page_name_ronde1", lang),
    icon = "ph:number-circle-one-fill",
    data = digicom_data,
    text = md_text(
      "<div style='text-align: justify;'>",
      transl("ronde1_page_text", lang),
      "</div>",
      "",
      paste0("## ", transl("w1_header_demographics", lang))
    ),
    visualizations = wave1_content
  ) %>%
  add_powered_by_dashboardr(style = "badge", size = "large") %>%
  # Add a "Powered by" link with icon and text
  add_navbar_element(
    text = lang_change(lang),
    icon = "circle-flags:lang-nl",
    # circle-flags:lang-nl
    href = "https://favstats.github.io/digicomp",
    align = "right"
  )  

# Test the print methods
cat("=== Dashboard Project Summary ===\n")
print(dashboard)

cat("\n=== Visualization Collection Summary ===\n")
# print(skills_viz)

# cat("\n=== Summary Visualizations ===\n")
# print(summary_vizzes)

files_to_delete <- dir("qmds_en", pattern = "\\.markdown$", full.names = TRUE)
file.remove(files_to_delete)

files_to_delete <- dir("qmds_en", pattern = "\\.markdown$", full.names = TRUE)
file.remove(files_to_delete)
# generate_dashboard(dashboard, render = T,  open = "browser")


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
generate_dashboard(dashboard, render = T, open = FALSE)


