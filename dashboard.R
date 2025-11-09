# DIGITAL COMPETENCE DASHBOARD ====================================================

library(tidyverse)
library(dashboardr)

# 1. SETUP & CONFIGURATION =====================================================

## TODO check if the recoding is actually correct please
## TODO in dimension Skills, Performance, and Knowledge aggegration?
## TODO in Dimsension also over time?
## TODO add by survey type?? 
## TODO create timeline and stackedbar dont create the same value!
## TODO pimp the graphs??
## TODO mix between text and graphs needs to be possible!
## TODO: Knowledge question seem perhaps incorrect and are missing sometimes across waves

the_colors <- c("#3D7271", "#E28D50", "#F5D76E", "#C7E6D5", "#0F6B5A", "#BABACD")

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
    "SGAI1","SGAI2","SGAI3",
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
  df$MeangenAI     <- rm_mean(df, c("SGAI1","SGAI2","SGAI3"))
  
  
  
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
    "KAI1RC","KAI2RC","KAI3RC",
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
  
  df
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
data_w1 <- read_csv("data/wave1.csv") %>% #table()
  mutate(weging_GAMO = str_replace(weging_GAMO, ",", ".") %>% as.numeric) %>% 
  mutate(geslacht = case_when(
    geslacht == 1 ~"Male",
    geslacht == 2 ~"Female",
    T ~ NA_character_
  )) %>% 
  mutate(Education = EducationR) %>% 
  mutate(Education = fct_relevel(Education, c("Low", "Middle", "High"))) %>% 
  recode_survey()
# getwd()
# data <- read_csv2("data/DigCom25CompleteWithWeights.csv") %>% #table()
data <- read_csv("data/wave2.csv") %>% 
  # mutate(AgeGroup = case_when(
  #   Age %in% 16:17 ~ "16-17",
  #   Age %in% 18:24 ~ "18-24",
  #   Age %in% 25:34 ~ "25-34",
  #   Age %in% 35:44 ~ "35-44",
  #   Age %in% 45:54 ~ "45-54",
  #   Age %in% 55:64 ~ "55-64",
  #   Age %in% 65:150 ~ "65+",
  # )) %>%
  mutate(weging_GAMO = str_replace(weging_GAMO, ",", ".") %>% as.numeric) %>% 
  mutate(geslacht = case_when(
    Gender == 1 | Gender == "Male" ~"Male",
    Gender == 2 | Gender == "Female" ~"Female",
    T ~ NA_character_
  )) %>% 
  mutate(Education = EducationR)  %>% 
  mutate(Education = fct_relevel(Education, c("Low", "Middle", "High"))) %>% 
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



# digicom_data$
digicom_data <- data %>% 
  mutate(wave = 2) %>% 
  # mutate_all(as.character) %>% 
  # mutate_at(vars(Sample, Time, QR, PSCS3_1), as.character) %>% 
  smart_bind_rows(data_w1 %>% 
                    mutate(wave = 1)) %>% 
  mutate_at(vars(PSCS3_1, PSCS3_2, PSCS3_3, PSCS3_4, PSCS3_5, PSCS3_6, PSCS3_7, PSCS3_8, PSCS3_9, PDHWS1_1, PDHWS1_3), as.numeric) %>% 
  mutate(wave_time_label = ifelse(wave == 1, "Dec. 24 (Wave 1)", "Jun. 24 (Wave 2)")) %>% 
  mutate(wave_time_label = factor(wave_time_label, levels = c("Dec. 24 (Wave 1)", "Jun. 24 (Wave 2)"))) %>% 
  mutate(Education = case_when(
    Education == "66" ~ NA_character_,
    Education == "99" ~ NA_character_,
    T ~ Education
  )) %>% 
  mutate(Education = fct_relevel(Education, c("Low", "Middle", "High")))

std.error <- function(x) sd(x, na.rm =T)/sqrt(length(x))

# 2. HELPER FUNCTIONS & DATA PREPARATION =======================================

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
add_all_viz_timeline <- function(viz, vars, group_var, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  for (i in seq_along(vars)) {
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        response_var = vars[[i]],
        group_var    = group_var,
        tabgroup     = glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
      )
  }
  viz
}

add_all_viz_timeline_single <- function(viz, vars, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  for (i in seq_along(vars)) {
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        response_var = vars[[i]],
        tabgroup     = glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
      )
  }
  viz
}

add_all_viz_stackedbar <- function(viz, vars, questions, stack_var, tbgrp, demographic, wave_label) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  
  for (i in seq_along(vars)) {
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        x_var = stack_var,
        stack_var = vars[[i]],
        tabgroup = glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
      )
  }
  viz
}

# stack_map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered")

# Main function
create_vizzes <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                          colors = the_colors, 
                          tbgrp, graph_title, high_values = 4:5, 
                          text_b_tabset = "ADD TEXT BEFORE TABSET", aggr_lab = "Percentage who answered (Completely) True (4-5)") {
  
  # Wave 1 & 2 Overall (stackedbars)
  sis_viz <- create_viz(
    type = "stackedbars",
    questions = vs,
    question_labels = qs,
    stacked_type = "percent",
    color_palette = colors,
    horizontal = TRUE,
    x_label = "", 
    text_before_tabset = text_b_tabset,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = lbs,
    drop_na_vars = T,
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
  
  # Over Time Overall (timeline without group_var)
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    text_before_tabset = text_b_tabset,
    response_filter = high_values, 
    response_filter_label = aggr_lab,
    response_filter_combine = T,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_min = 0,
    y_max = 100,
    response_filter_label = NULL
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
    stack_order = lbs,
    filter = ~ wave == 1,
    drop_na_vars = T,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>       # Pass tbgrp AND "age"
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>   # Pass tbgrp AND "gender"
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1")        # Pass tbgrp AND "edu"
  
  # Wave 2 by Age/Gender/Education
  sis_subvizzes2 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = T,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = lbs,
    text_before_tabset = text_b_tabset,
    filter = ~ wave == 2,
    drop_na_vars = T,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2")
  
  # Over Time by Age/Gender/Education
  sis_subvizzes3 <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    response_filter = high_values, 
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
    add_all_viz_timeline(vs, "Education", tbgrp, "edu", wave_label = "Over Time", questions = qs)
  
  # Combine all
  sis_viz %>% 
    combine_viz(sis_subvizzes_time) %>%
    combine_viz(sis_subvizzes) %>%
    combine_viz(sis_subvizzes2) %>%
    combine_viz(sis_subvizzes3)
}

create_vizzes2 <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                           colors = the_colors, 
                           tbgrp, graph_title, high_values = 1, map_values, 
                           text_b_tabset = "ADD TEXT BEFORE TABSET", aggr_lab = "Percentage who selected/answered correctly") {
  
  # Wave 1 & 2 Overall (stackedbars)
  sis_viz <- create_viz(
    type = "stackedbars",
    questions = vs,
    question_labels = qs,
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
    drop_na_vars = T,
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
  
  # Over Time Overall (timeline without group_var)
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    response_filter = high_values, 
    y_min = 0,
    y_max = 100,
    response_filter_label = aggr_lab,
    response_filter_combine = T,
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
    stack_order = lbs,
    filter = ~ wave == 1,
    drop_na_vars = T,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>       # Pass tbgrp AND "age"
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>   # Pass tbgrp AND "gender"
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1")        # Pass tbgrp AND "edu"
  
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
    drop_na_vars = T,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2")
  
  # Over Time by Age/Gender/Education
  sis_subvizzes3 <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    response_filter = high_values, 
    y_min = 0,
    y_max = 100,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    response_filter_label = NULL,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline(vs, "AgeGroup", tbgrp, "age", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "geslacht", tbgrp, "gender", wave_label = "Over Time", questions = qs) |>
    add_all_viz_timeline(vs, "Education", tbgrp, "edu", wave_label = "Over Time", questions = qs)
  
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
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)




# Using create_viz + add_viz
knowledge_viz <- create_viz(
  type = "bar",
  horizontal = TRUE,
  bar_type = "percent",
  icon = "ph:chart-bar",
  text_before_tabset = knowledge_tex,
  drop_na_vars = T,
  text_position = "above",
  color_palette = the_colors,
  drop_na_vars = TRUE,
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
  drop_na_vars = T,
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
  drop_na_vars = T,
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
  )

# Over Time - Overall (timeline without group_var)
knowledge_overtime_overall <- create_viz(
  type = "timeline",
  time_var = "wave_time_label",
  chart_type = "line",
  response_var = "MeanKnowledge",
  response_breaks = knowledge_breaks,  # Bin the knowledge scores
  response_bin_labels = knowledge_labs,
  y_min = 0,
  y_max = 100,
  drop_na_vars = TRUE,
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
  response_var = "MeanKnowledge",
  response_breaks = knowledge_breaks,
  y_min = 0,
  y_max = 100,
  response_bin_labels = knowledge_labs,
  drop_na_vars = TRUE
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
  )

# Combine all
knowledge_viz <- knowledge_viz %>%
  combine_viz(knowledge_subvizzes_wave1) %>%
  combine_viz(knowledge_subvizzes_wave2) %>%
  combine_viz(knowledge_overtime_overall) %>%
  combine_viz(knowledge_overtime_demographics)


## 3.2 Strategic Information Knowledge (kinfo_viz) ----

kinfo_questions <- c(
  "The first search result is always the best information source.",
  "Everyone gets the same information when they search for the same things online."
)

kinfo_vars <- c("KInfo1RC", "KInfo2RC")

# keep the order from your original code: rev(c("Incorrectly", "Correctly", "X"))
kinfo_labs <- c("X", "Correctly Answered", "Incorrectly Answered")

kinfo_info_text <- "**Strategic Information Skills** assess the ability to effectively search for and locate information online. This includes choosing good keywords, using search functions, and finding answers to questions on the internet."

kinfo_tex_link <- md_text(
  kinfo_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Strategic Information results](strategic_information.html)"
)

kinfo_viz <- create_vizzes2(
  breaks = knowledge_breaks,
  kinfo_questions,
  kinfo_vars,
  kinfo_labs,
  "",
  tbgrp   = "kinfo",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kinfo_tex_link
)

kinfo_tex_wo_link <- md_text(
  kinfo_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

kinfo_viz_wo_link <- create_vizzes2(
  breaks = knowledge_breaks,
  kinfo_questions,
  kinfo_vars,
  kinfo_labs,
  "",
  tbgrp   = "kinfo",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kinfo_tex_wo_link
)

## 3.3 Critical Information Knowledge (critinfo_viz) ----

# TODO: Supposedly there is ANOTHER question here but where?

critinfo_questions <- c(
  "Some people make money by spreading fake news on the internet."
)

critinfo_vars <- c("KInfo3RC")

critinfo_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

critinfo_info_text <- "**Critical Information Skills** measure the ability to evaluate online information: checking whether information is true, assessing website reliability, and understanding the purpose of online content (to inform, influence, entertain, or sell)."

critinfo_tex_link <- md_text(
  critinfo_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Critical Information results](critical_information.html)"
)

critinfo_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  critinfo_questions,
  critinfo_vars,
  critinfo_labs,
  "",
  tbgrp        = "critinfo",
  graph_title  = critinfo_questions, 
  map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = critinfo_tex_link
)

critinfo_tex_wo_link <- md_text(
  critinfo_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

critinfo_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  critinfo_questions,
  critinfo_vars,
  critinfo_labs,
  "",
  tbgrp        = "critinfo",
  graph_title  = critinfo_questions,
  map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = critinfo_tex_wo_link
)


## 3.4 Netiquette Knowledge (knet_viz) ----

knet_questions <- c(
  "Negative comments hurt people less when you say them online than when you say them to their face."
)

knet_vars <- c("KCom3RC")

knet_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

knet_info_text <- "**Netiquette** refers to proper online communication etiquette: knowing when to ask permission before sharing, choosing the right communication tool, understanding what not to share online, and using emoticons appropriately."

knet_tex_link <- md_text(
  knet_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Netiquette results](netiquette.html)"
)

knet_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  knet_questions,
  knet_vars,
  knet_labs,
  "",
  tbgrp        = "knet",
  graph_title  = knet_questions,
  map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = knet_tex_link
)

knet_tex_wo_link <- md_text(
  knet_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

knet_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  knet_questions,
  knet_vars,
  knet_labs,
  "",
  tbgrp        = "knet",
  graph_title  = knet_questions, 
  map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = knet_tex_wo_link
)


## 3.5 Creative / Content Creation Knowledge (kcrea_viz) ----

kcrea_questions <- c(
  "Some people are paid to use products in the videos they make.",
  "You can change and share existing videos, as long as you do not make money by doing it."
)

kcrea_vars <- c("KCrea2RC", "KCrea3RC")

kcrea_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

kcrea_info_text <- "**Digital Content Creation** skills cover the ability to create and modify digital content: making presentations, combining different media, editing images/music/video, and understanding copyright rules around digital content."

kcrea_tex_link <- md_text(
  kcrea_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Digital Content Creation results](digital_content_creation.html)"
)

kcrea_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kcrea_questions,
  kcrea_vars,
  kcrea_labs,
  "",
  tbgrp        = "kcrea",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kcrea_tex_link
)

kcrea_tex_wo_link <- md_text(
  kcrea_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

kcrea_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kcrea_questions,
  kcrea_vars,
  kcrea_labs,
  "",
  tbgrp        = "kcrea",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kcrea_tex_wo_link
)


## 3.6 Safety & Control of Devices Knowledge (ksafety_viz) ----

ksafety_questions <- c(
  "To keep your devices safer, you should always install updates immediately.",
  "It's best to have the same password for each account.",
  "What you do online is used by companies to advertise their products and services."
)

ksafety_vars <- c(
  "KSafDev2RC",
  "KPriv1RC",
  "KPriv2RC"
)

ksafety_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

ksafety_info_text <- "**Safety & Control of Information and Devices** encompasses protecting devices and personal information: using security measures, managing privacy settings, identifying phishing, and controlling what information is shared online."

ksafety_tex_link <- md_text(
  ksafety_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Safety results](safety.html)"
)

ksafety_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  ksafety_questions,
  ksafety_vars,
  ksafety_labs,
  "",
  tbgrp        = "ksafety",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = ksafety_tex_link
)

ksafety_tex_wo_link <- md_text(
  ksafety_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

ksafety_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  ksafety_questions,
  ksafety_vars,
  ksafety_labs,
  "",
  tbgrp        = "ksafety",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = ksafety_tex_wo_link
)


## 3.7 Health & Wellbeing Knowledge (khealth_viz) ----

khealth_questions <- c(
  "Platforms like YouTube or Netflix are designed to keep people watching as long as possible.",
  "You sleep worse if you use a smartphone or computer just before you go to bed."
)

khealth_vars <- c("KHealth2RC", "KHealth3RC")

khealth_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

khealth_info_text <- "**Digital Health & Wellbeing** skills relate to managing healthy digital habits: controlling screen time, minimizing distractions, taking digital breaks, and understanding how technology affects sleep and wellbeing."

khealth_tex_link <- md_text(
  khealth_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Digital Health results](digital_health.html)"
)

khealth_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  khealth_questions,
  khealth_vars,
  khealth_labs,
  "",
  tbgrp        = "khealth",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = khealth_tex_link
)

khealth_tex_wo_link <- md_text(
  khealth_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

khealth_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  khealth_questions,
  khealth_vars,
  khealth_labs,
  "",
  tbgrp        = "khealth",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = khealth_tex_wo_link
)


## 3.8 Green / Sustainable Digital Knowledge (kgreen_viz) ----

kgreen_questions <- c(
  "Phones contain materials that mineworkers extract from mines.",
  "The amount of data and WiFi you use does not affect CO2-emissions or the climate."
)

kgreen_vars <- c("KEnv2RC", "KEnv3RC")

kgreen_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

kgreen_info_text <- "**Sustainable/Green Digital Skills** focus on environmentally conscious technology use: reducing energy consumption, buying sustainable devices, recycling electronics, and understanding the environmental impact of digital activities."

kgreen_tex_link <- md_text(
  kgreen_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Green Digital results](green_digital.html)"
)

kgreen_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgreen_questions,
  kgreen_vars,
  kgreen_labs,
  "",
  tbgrp        = "kgreen",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kgreen_tex_link
)

kgreen_tex_wo_link <- md_text(
  kgreen_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

kgreen_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgreen_questions,
  kgreen_vars,
  kgreen_labs,
  "",
  tbgrp        = "kgreen",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kgreen_tex_wo_link
)


## 3.9 Transactional Knowledge (ktrans_viz) ----

ktrans_questions <- c(
  "In case of a medical emergency, you make an online appointment with your healthcare provider.",
  "A webshop is trustworthy when you can pay with iDeal"
)

ktrans_vars <- c("Ktrans2RC", "Ktrans3RC")

ktrans_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

ktrans_info_text <- "**Transactional Skills** cover the ability to complete official tasks online: handling tax matters, making digital payments, arranging healthcare, using digital identification (DigID), and uploading documents for online services."

ktrans_tex_link <- md_text(
  ktrans_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Transactional results](transactional.html)"
)

ktrans_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  ktrans_questions,
  ktrans_vars,
  ktrans_labs,
  "",
  tbgrp        = "ktrans",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = ktrans_tex_link
)

ktrans_tex_wo_link <- md_text(
  ktrans_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

ktrans_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  ktrans_questions,
  ktrans_vars,
  ktrans_labs,
  "",
  tbgrp        = "ktrans",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = ktrans_tex_wo_link
)


## 3.10 AI Knowledge (kai_viz) ----

kai_questions <- c(
  "Some websites and apps for news and entertainment use artificial intelligence (AI).",
  "Websites and apps for news and entertainment show the same content to everyone.",
  "Some decisions about the content of websites and apps for news and entertainment are automatic, without a human doing something.",
  "Your online behavior determines what is shown to you on websites and apps for news and entertainment."
)

kai_vars <- c("KAI1RC", "KAI2RC", "KAI3RC", "KAI4RC")

kai_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

kai_info_text <- "**AI Skills** assess understanding and recognition of artificial intelligence in everyday applications: recognizing when websites/apps use AI, identifying AI-recommended content, and understanding how AI personalizes digital experiences."

kai_tex_link <- md_text(
  kai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all AI results](ai.html)"
)

kai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kai_questions,
  kai_vars,
  kai_labs,
  "",
  tbgrp        = "kai",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kai_tex_link
)

kai_tex_wo_link <- md_text(
  kai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

kai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kai_questions,
  kai_vars,
  kai_labs,
  "",
  tbgrp        = "kai",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kai_tex_wo_link
)


## 3.11 Generative AI Knowledge (kgai_viz) ----

kgai_questions <- c(
  "Because GenAI, such as ChatGPT, searches through many websites on the internet, the information it gives is reliable.",
  "The usage of GenAI, such as ChatGPT, has almost no impact on the environment.",
  "Someone else can also get access to the information you give to GenAI, such as ChatGPT.",
  "People can use genAI to create images, videos or audio-fragments of events or people who do not really exist or that have not actually taken place (for example 'deepfakes').",
  "GenAI, such as ChatGPT, can produce different results when asked the same question multiple times."
)

kgai_vars <- c("KGAI1RC", "KGAI2RC", "KGAI3RC", "KGAI4RC", "KGAI5RC")

kgai_labs <- c(
  "Don't Know",
  "Correctly Answered",
  "Incorrectly Answered"
)

kgai_info_text <- "**Generative AI Skills** measure competencies with AI tools like ChatGPT: knowing how to verify AI-generated information, writing effective prompts, detecting AI-generated content, and understanding GenAI's capabilities and limitations."

kgai_tex_link <- md_text(
  kgai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```",
  "[{{< iconify ph cards >}} See all Gen AI results](gen_ai.html)"
)

kgai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgai_questions,
  kgai_vars,
  kgai_labs,
  "",
  tbgrp        = "kgai",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kgai_tex_link
)

kgai_tex_wo_link <- md_text(
  kgai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"The following statements are about the internet. Please indicate if the sentence is true or untrue, according to you. If you don't know, please choose 'I don't know'. You don't have to guess. If you don't understand the question, please choose 'I don't understand the question.' Nearly everyone will not know or understand questions. This is normal and something that we want to know.\", preset = \"question\")",
  "```"
)

kgai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  kgai_questions,
  kgai_vars,
  kgai_labs,
  "",
  tbgrp        = "kgai",
  graph_title  = "", map_values = list("1" = "Correctly Answered", "0" = "Incorrectly Answered"),
  text_b_tabset = kgai_tex_wo_link
)

## 3.12 Knowledge Collection ----
knowledge_collection <- #knowledge_viz %>% 
  # combine_viz(kinfo_viz) %>%
  kinfo_viz %>% 
  combine_viz(critinfo_viz) %>%
  combine_viz(knet_viz)  %>%
  add_pagination() %>%
  combine_viz(kcrea_viz) %>%
  combine_viz(ksafety_viz) %>%
  combine_viz(khealth_viz) %>%
  combine_viz(kgreen_viz)  %>%
  add_pagination() %>%
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
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1",
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
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
  "I know how to choose good keywords for online searches (for example with Google).",
  "I know how I can find answers to my questions on the internet.",
  "I know how I can use search functions in search engines (for example with Google)."
)

sis_vars <- c("SInfo1", "SInfo3_V2", "SInfo4")

sis_labs <- c(
  "(Completely) Untrue (1-2)", 
  "Not true and not untrue (3)", 
  "(Completely) True (4-5)"
)

sis_info_text <- "**Strategic Information Skills** assess the ability to effectively search for and locate information online. This includes choosing good keywords, using search functions, and finding answers to questions on the internet."

sis_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

sys_tex_more_link <- "[{{< iconify ph cards >}} See all Strategic Information results](strategic_information.html)"

sis_tex_complete <- paste0(
  sis_info_text, "\n",
  sis_tex_question, "\n",
  sys_tex_more_link
)



sis_viz <- create_vizzes(sis_questions, 
                         sis_vars, sis_labs, 
                         "",#sis_tex2, 
                         breaks = c(0.5, 2.5, 3.5, 5.5), 
                         tbgrp = "sis", 
                         text_b_tabset = sis_tex_complete,
                         graph_title = "Strategic Information Skills")


## 4.2 Critical Information Skills (cis_viz) ----

cis_vars <- c("SInfo5", "SInfo6", "SInfo7")


cis_questions <- c("I know how I can check if the information I find on the internet is true.", 
                   "I know how I can check if a website is reliable.",
                   "I can assess what the goal of online information is (e.g., to inform, influence, entertain or sell).") 

cis_info_text <- "**Critical Information Skills** measure the ability to evaluate online information: checking whether information is true, assessing website reliability, and understanding the purpose of online content (to inform, influence, entertain, or sell)."

cis_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

cis_tex_more_link <- "[{{< iconify ph cards >}} See all Critical Information results](critical_information.html)"

cis_tex_complete <- paste0(
  cis_info_text, "\n",
  cis_tex_question, "\n",
  cis_tex_more_link
)

cis_viz <- create_vizzes(cis_questions, 
                         cis_vars, sis_labs, 
                         "",#cis_tex_link, 
                         breaks = c(0.5, 2.5, 3.5, 5.5), 
                         tbgrp = "cis",
                         text_b_tabset = cis_tex_complete,
                         graph_title = "Critical Information Skills")

cis_viz_wo_link <- create_vizzes(cis_questions, 
                                 cis_vars, sis_labs, 
                                 cis_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                 tbgrp = "cis",
                                 graph_title = "Critical Information Skills")

## 4.3 Netiquette Skills (nskills_viz) ----


nskills_questions <- c("I know when I should ask for permission to share something online.", "I know which communication tool best fits which situation  (for example: call, send a WhatsApp-message, send an e-mail).", "I know which things I should not share online.", "I know when it is appropriate and when it is not appropriate to use emoticons (for example smileys ☺ or emoji's).")


nskills_vars <- c("SCom1_V2", "SCom2", "SCom4_V2", "SCom5")

nskills_info_text <- "**Netiquette** refers to proper online communication etiquette: knowing when to ask permission before sharing, choosing the right communication tool, understanding what not to share online, and using emoticons appropriately."

nskills_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

nskills_tex_more_link <- "[{{< iconify ph cards >}} See all Netiquette results](netiquette.html)"

nskills_tex_complete <- paste0(
  nskills_info_text, "\n",
  nskills_tex_question, "\n",
  nskills_tex_more_link
)

nskills_viz  <- create_vizzes(nskills_questions, 
                              nskills_vars, sis_labs, 
                              "",#nskills_tex_link, 
                              breaks = c(0.5, 2.5, 3.5, 5.5), 
                              tbgrp = "nskills",
                              text_b_tabset = nskills_tex_complete,
                              graph_title = "Netiquette Skills")

nskills_viz_wo_link  <- create_vizzes(nskills_questions, 
                                      nskills_vars, sis_labs, 
                                      nskills_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                      tbgrp = "nskills",
                                      graph_title = "Netiquette Skills")


## 4.4 Digital Content Creation Skills (dccs_viz) ----

dccs_questions <- c("I can make a presentation on the computer (for example in Powerpoint)", "I can make something that combines different digital media (for example a movie with music).", "I can change existing digital images, music, and video.", "I can make a photo or video more attractive (for example with a filter or Photoshop).")


dccs_vars <- c("SCrea2", "SCrea3", "SCrea4", "SCrea5")

dccs_info_text <- "**Digital Content Creation** skills cover the ability to create and modify digital content: making presentations, combining different media, editing images/music/video, and understanding copyright rules around digital content."

dccs_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

dccs_tex_more_link <- "[{{< iconify ph cards >}} See all Digital Content Creation results](digital_content_creation.html)"

dccs_tex_complete <- paste0(
  dccs_info_text, "\n",
  dccs_tex_question, "\n",
  dccs_tex_more_link
)

dccs_viz  <- create_vizzes(dccs_questions, 
                           dccs_vars, sis_labs, 
                           "",#dccs_tex_link, 
                           breaks = c(0.5, 2.5, 3.5, 5.5), 
                           tbgrp = "dccs",
                           text_b_tabset = dccs_tex_complete,
                           graph_title = "Digital Content Creation Skills")

dccs_viz_wo_link  <- create_vizzes(dccs_questions, 
                                   dccs_vars, sis_labs, 
                                   dccs_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                   tbgrp = "dccs",
                                   graph_title = "Digital Content Creation Skills")


## 4.5 Safety & Control of Devices (safety_viz) ----
safety_questions <- c(
  "I know how to protect a device against access (e.g. a PIN code or fingerprint).",
  "I know how to protect devices against viruses.",
  "I know how to adjust the privacy settings on a mobile phone or tablet.",
  "I know how to change the location settings on a mobile phone or tablet.",
  "I know how to identify suspicious e-mail messages that try to get my personal data.",
  "I know how to delete the history of websites that I have visited before.",
  "I know how to block messages from someone that I don't want to hear from."
)
safety_vars <- c("SSafDev1", "SSafDev2", "SPriv1", "SPriv2", "SPriv3", "SPriv4", "SCom3")

safety_info_text <- "**Safety & Control of Information and Devices** encompasses protecting devices and personal information: using security measures, managing privacy settings, identifying phishing, and controlling what information is shared online."

safety_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

safety_tex_more_link <- "[{{< iconify ph cards >}} See all Safety results](safety.html)"

safety_tex_complete <- paste0(
  safety_info_text, "\n",
  safety_tex_question, "\n",
  safety_tex_more_link
)

safety_viz <- create_vizzes(
  safety_questions, safety_vars, sis_labs,
  "",#safety_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "safety",
  text_b_tabset = safety_tex_complete,
  graph_title = "Safety and Control of Information and Devices Skills")

safety_viz_wo_link <- create_vizzes(
  safety_questions, safety_vars, sis_labs,
  safety_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "safety",
  graph_title = "Safety and Control of Information and Devices Skills")

## 4.6 Digital Health & Wellbeing (dhealth_viz) ----
dhealth_questions <- c(
  "I know how to control how much time I spend on the internet.",
  "I know how to make sure my phone does not distract me.",
  "I know how I can stop using my phone and computer for a while, if I want to."
)
dhealth_vars <- c("SHealth1", "SHealth2_V2", "SHealth3_V2")

dhealth_info_text <- "**Digital Health & Wellbeing** skills relate to managing healthy digital habits: controlling screen time, minimizing distractions, taking digital breaks, and understanding how technology affects sleep and wellbeing."

dhealth_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

dhealth_tex_more_link <- "[{{< iconify ph cards >}} See all Digital Health results](digital_health.html)"

dhealth_tex_complete <- paste0(
  dhealth_info_text, "\n",
  dhealth_tex_question, "\n",
  dhealth_tex_more_link
)

dhealth_viz <- create_vizzes(
  dhealth_questions, dhealth_vars, sis_labs,
  "",#dhealth_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dhealth",
  text_b_tabset = dhealth_tex_complete,
  graph_title = "Digital Health and Wellbeing Skills")

dhealth_viz_wo_link <- create_vizzes(
  dhealth_questions, dhealth_vars, sis_labs,
  dhealth_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dhealth",
  graph_title = "Digital Health and Wellbeing Skills")

## 4.7 Green / Sustainable Digital (green_viz) ----
green_questions <- c(
  "I know how to reduce the battery use of a phone or computer.",
  "I know how I can buy a phone or computer in a 'green' or sustainable way.",
  "I know how to have a phone or computer recycled."
)
green_vars <- c("SEnv1", "SEnv2", "SEnv3")

green_info_text <- "**Sustainable/Green Digital Skills** focus on environmentally conscious technology use: reducing energy consumption, buying sustainable devices, recycling electronics, and understanding the environmental impact of digital activities."

green_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

green_tex_more_link <- "[{{< iconify ph cards >}} See all Green Digital results](green_digital.html)"

green_tex_complete <- paste0(
  green_info_text, "\n",
  green_tex_question, "\n",
  green_tex_more_link
)

green_viz <- create_vizzes(
  green_questions, green_vars, sis_labs,
  "",#green_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "green",
  text_b_tabset = green_tex_complete,
  graph_title = "Sustainable/Green Digital Skills")

green_viz_wo_link <- create_vizzes(
  green_questions, green_vars, sis_labs,
  green_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "green",
  graph_title = "Sustainable/Green Digital Skills")

## 4.8 Digital Problem Solving (dprob_viz) ----
dprob_questions <- c(
  "I know where or from whom I can get help to improve my digital skills.",
  "I know where or from whom I can get help if I'm unable to do something on the internet."
)
dprob_vars <- c("SProbl1", "SProbl2")

dprob_info_text <- "**Digital Problem Solving** measures the ability to find help and solutions for digital challenges: knowing where to get help to improve digital skills and who to turn to when facing technical difficulties."

dprob_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

dprob_tex_more_link <- "[{{< iconify ph cards >}} See all Digital Problem Solving results](digital_problem_solving.html)"

dprob_tex_complete <- paste0(
  dprob_info_text, "\n",
  dprob_tex_question, "\n",
  dprob_tex_more_link
)

dprob_viz <- create_vizzes(
  dprob_questions, dprob_vars, sis_labs,
  "",#dprob_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dprob",
  text_b_tabset = dprob_tex_complete,
  graph_title = "Digital Problem Solving Skills"
)

dprob_viz_wo_link <- create_vizzes(
  dprob_questions, dprob_vars, sis_labs,
  dprob_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "dprob",
  graph_title = "Digital Problem Solving Skills"
)

## 4.9 Transactional Skills (trans_viz) ----
trans_questions <- c(
  "I know how to handle things online for the tax authority ('belastingdienst') (for example file my tax returns or apply for a wage tax for my (part-time) job.",
  "I know how to do digital payments on the computer or smartphone (for example online banking, online shopping, using iDeal).",
  "I know how to arrange my healthcare online (for example take out a health insurance or make an online appointment with the general practitioner).",
  "I know how to apply for a DigID and how to use it.",
  "I know how to upload documents and images when needed to arrange things online (for example when requesting an OV chip card)."
)
trans_vars <- c("Strans1", "Strans2", "Strans3", "Strans4", "Strans5")

trans_info_text <- "**Transactional Skills** cover the ability to complete official tasks online: handling tax matters, making digital payments, arranging healthcare, using digital identification (DigID), and uploading documents for online services."

trans_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

trans_tex_more_link <- "[{{< iconify ph cards >}} See all Transactional results](transactional.html)"

trans_tex_complete <- paste0(
  trans_info_text, "\n",
  trans_tex_question, "\n",
  trans_tex_more_link
)

trans_viz <- create_vizzes(
  trans_questions, trans_vars, sis_labs,
  "",#trans_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "trans",
  text_b_tabset = trans_tex_complete,
  graph_title = "Transactional Skills"
)

trans_viz_wo_link <- create_vizzes(
  trans_questions, trans_vars, sis_labs,
  trans_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "trans",
  graph_title = "Transactional Skills"
)

## 4.10 AI Skills (ai_viz) ----
ai_questions <- c(
  "I recognize when a website or app uses AI to adjust the content to me.",
  "I recognize when specific content is recommended to me by AI."
)

# digicom_data$sai3 %>% count(SAI)

ai_vars <- c("SAI1", "SAI2")

ai_info_text <- "**AI Skills** assess understanding and recognition of artificial intelligence in everyday applications: recognizing when websites/apps use AI, identifying AI-recommended content, and understanding how AI personalizes digital experiences."

ai_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

ai_tex_more_link <- "[{{< iconify ph cards >}} See all AI results](ai.html)"

ai_tex_complete <- paste0(
  ai_info_text, "\n",
  ai_tex_question, "\n",
  ai_tex_more_link
)

ai_viz <- create_vizzes(
  ai_questions, ai_vars, sis_labs,
  "",#ai_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "ai",
  text_b_tabset = ai_tex_complete,
  graph_title = "AI Skills"
)

ai_viz_wo_link <- create_vizzes(
  ai_questions, ai_vars, sis_labs,
  ai_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "ai",
  graph_title = "AI Skills"
)

## 4.11 Generative AI Skills (genai_viz) ----
genai_questions <- c(
  "I usually know when the content created for me by GenAI, such as ChatGPT, contains correct information.",
  "I know which questions (or 'prompts') I should ask GenAI, such as ChatGPT, to receive a useful result.",
  "I know how to check whether a text or picture is created by GenAI, such as ChatGPT, instead of a person"
)
genai_vars <- c("SGAI1", "SGAI2", "SGAI3")

genai_info_text <- "**Generative AI Skills** measure competencies with AI tools like ChatGPT: knowing how to verify AI-generated information, writing effective prompts, detecting AI-generated content, and understanding GenAI's capabilities and limitations."

genai_tex_question <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote(\"Think about the extent to which each sentence applies to you, if you would have to do this activity now and without help. Please be honest. It is very normal that you never do some things. We'd like to know this. If you don't understand what the question means, please choose 'I don't understand the question.' Do you recognize yourself in the following statements?\", preset = \"question\")",
  "```"
)

genai_tex_more_link <- "[{{< iconify ph cards >}} See all Gen AI results](gen_ai.html)"

genai_tex_complete <- paste0(
  genai_info_text, "\n",
  genai_tex_question, "\n",
  genai_tex_more_link
)

genai_viz <- create_vizzes(
  genai_questions, genai_vars, sis_labs,
  "",#genai_tex_link,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "genai",
  text_b_tabset = genai_tex_complete,
  graph_title = "GenAI Skills"
)

genai_viz_wo_link <- create_vizzes(
  genai_questions, genai_vars, sis_labs,
  genai_tex_question,
  breaks = c(0.5, 2.5, 3.5, 5.5),
  tbgrp  = "genai",
  graph_title = "GenAI Skills"
)

## 4.12 Skills Collection ----
skills_viz <- sis_viz %>% 
  combine_viz(cis_viz) %>% 
  combine_viz(nskills_viz) %>%
  combine_viz(dccs_viz)  %>%
  add_pagination() %>%
  # new ones
  combine_viz(safety_viz) %>%
  combine_viz(dhealth_viz) %>%
  combine_viz(green_viz) %>%
  combine_viz(dprob_viz)  %>%
  add_pagination() %>%
  combine_viz(trans_viz) %>%
  combine_viz(ai_viz) %>%
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
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1",
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age    = "{{< iconify mdi:human-male-male-child >}} Age",
    gender = "{{< iconify mdi gender-transgender >}} Gender",
    edu    = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime   = "{{< iconify ph chart-line-fill >}} Over Time",
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



# 5. PERFORMANCE VISUALIZATIONS ================================================

## 5.0 Performance Setup: Shared Labels ----
perf_correct_labs <- c("Incorrect", "Correct")
perf_selected_labs <- c("Not selected", "Selected")

# suggested text block (mirror your knowledge_tex style)
performance_tex <- md_text(
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)


## 5.1 Performance: Strategic Information (perf_sis_viz) -----
perf_sis_questions <- c(
  "Restrict Google to Dutch sources (correct/incorrect)"
)
## TODO: its missing PSIS1RC??
# digicom_data %>% count(PSIS1)
# digicom_data$PCIS1R <- ifelse(digicom_data$PCIS1N == 2, 1, ifelse (digicom_data$PCIS1N == 5 | digicom_data$PCIS1N == 6, NA, 0))
perf_sis_vars <- c("PSIS2R")

perf_sis_info_text <- "**Strategic Information Skills** assess the ability to effectively search for and locate information online. This includes choosing good keywords, using search functions, and finding answers to questions on the internet."

perf_sis_tex_link <- md_text(
  perf_sis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Strategic Information results](strategic_information.html)"
)

perf_sis_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_sis_questions,
  perf_sis_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_sis",
  graph_title  = perf_sis_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_sis_tex_link
)

perf_sis_tex_wo_link <- md_text(
  perf_sis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_sis_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_sis_questions,
  perf_sis_vars,
  perf_correct_labs,
  perf_sis_tex_wo_link,
  tbgrp        = "perf_sis",
  graph_title  = perf_sis_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)


## 5.2 Performance: Critical Information (perf_cis_viz) ----
perf_cis_questions <- c(
  "Classify a social media post (task 1)",
  "Classify a social media post (task 2)",
  "What to check for fake news"
)

perf_cis_vars <- c("PCIS1R", "PCIS2R", "PCIS3R")

perf_cis_info_text <- "**Critical Information Skills** measure the ability to evaluate online information: checking whether information is true, assessing website reliability, and understanding the purpose of online content (to inform, influence, entertain, or sell)."

perf_cis_tex_link <- md_text(
  perf_cis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Look closely at this post on social media. What kind of post do you think this is?", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Critical Information results](critical_information.html)"
)

perf_cis_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_cis_questions,
  perf_cis_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_cis",
  graph_title  = "",
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_cis_tex_link
)

perf_cis_tex_wo_link <- md_text(
  perf_cis_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Look closely at this post on social media. What kind of post do you think this is?", preset = "question")',
  "```"
)

perf_cis_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_cis_questions,
  perf_cis_vars,
  perf_correct_labs,
  perf_cis_tex_wo_link,
  tbgrp        = "perf_cis",
  graph_title  = "",
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)

## 5.3 Performance: Netiquette (perf_netiquette_viz) ----
perf_n_questions <- c(
  "Ask for Permission to Share"
)

perf_n_vars <- c("PNS1R")

perf_n_info_text <- "**Netiquette** refers to proper online communication etiquette: knowing when to ask permission before sharing, choosing the right communication tool, understanding what not to share online, and using emoticons appropriately."

perf_n_tex_link <- md_text(
  perf_n_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Netiquette results](netiquette.html)"
)

perf_netiquette_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_n_questions,
  perf_n_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_netiquette",
  graph_title  = perf_n_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_n_tex_link
)

perf_n_tex_wo_link <- md_text(
  perf_n_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_netiquette_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_n_questions,
  perf_n_vars,
  perf_correct_labs,
  perf_n_tex_wo_link,
  tbgrp        = "perf_netiquette",
  graph_title  = perf_n_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)


## 5.4 Performance: Digital Content Creation (perf_dccs_viz) ----
perf_dccs_questions <- c(
  "Identify crop icon"
)

perf_dccs_vars <- c("PDCCS1R")

perf_dccs_info_text <- "**Digital Content Creation** skills cover the ability to create and modify digital content: making presentations, combining different media, editing images/music/video, and understanding copyright rules around digital content."

perf_dccs_tex_link <- md_text(
  perf_dccs_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote('Which of the <a href=\"#PDCCS1R\" class=\"modal-link\">following icons</a> refer to the function for cutting or removing parts of a picture (\\\"cropping\\\")?', preset = 'question')",
  "```",
  "[{{< iconify ph cards >}} See all Digital Content Creation results](digital_content_creation.html)"
) 


perf_dccs_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_dccs_questions,
  perf_dccs_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_dccs",
  graph_title  = perf_dccs_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_dccs_tex_link
)  %>%
  # Modal 2: With image
  add_modal(
    modal_id = "PDCCS1R",
    title = "Digital Content Creation: Performance Questions", 
    image = "https://placehold.co/600x400/EEE/31343C",
    modal_content = "Information literacy scores were highest at 85%.
                     Participants excelled at search strategies and
                     source evaluation."
  )

perf_dccs_tex_wo_link <- md_text(
  perf_dccs_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  "create_blockquote('Which of the <a href=\"#PDCCS1R\" class=\"modal-link\">following icons</a> refer to the function for cutting or removing parts of a picture (\\\"cropping\\\")?', preset = 'question')",
  "```"
) 

perf_dccs_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_dccs_questions,
  perf_dccs_vars,
  perf_correct_labs,
  perf_dccs_tex_wo_link,
  tbgrp        = "perf_dccs",
  graph_title  = perf_dccs_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)  %>%
  # Modal 2: With image
  add_modal(
    modal_id = "PDCCS1R",
    title = "Digital Content Creation: Performance Questions", 
    image = "https://placehold.co/600x400/EEE/31343C",
    modal_content = "Information literacy scores were highest at 85%.
                     Participants excelled at search strategies and
                     source evaluation."
  )


## 5.5 Performance: Safety & Control of Devices (perf_safety_viz) ----
perf_safety_questions <- c(
  "Keep passwords in a password safe",
  "Save passwords on paper (rev)",
  "Use passwords with ≥14 chars",
  "Different passwords per account",
  "Use passkey (finger/face)",
  "Two-step verification",
  "Install software updates",
  "Use adblocker",
  "Make backups",
  "None of the above"
)

# TODO: *Privacy, Safety & Control:* PSCS1R (dichotomous correct/incorrect)
# PSCS3R (dichotomous doing behavior yes/no) (BEHAVIORAL item) PSCS3C
# (dichotomous incorrect answer yes/no)
# digicom_data %>% count(PSCS3_10)
perf_safety_vars <- c(
  "PSCS3_1","PSCS3_2","PSCS3_3","PSCS3_4","PSCS3_5",
  "PSCS3_6","PSCS3_7","PSCS3_8","PSCS3_9", "PSCS3_10"
)

perf_safety_info_text <- "**Safety & Control of Information and Devices** encompasses protecting devices and personal information: using security measures, managing privacy settings, identifying phishing, and controlling what information is shared online."

perf_safety_tex_link <- md_text(
  perf_safety_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Which of the following safety precautions do you sometimes take for your digital/online media use?", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Safety results](safety.html)"
)

perf_safety_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_safety_questions,
  perf_safety_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_safety",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected"),
  text_b_tabset = perf_safety_tex_link
)

perf_safety_tex_wo_link <- md_text(
  perf_safety_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Which of the following safety precautions do you sometimes take for your digital/online media use?", preset = "question")',
  "```"
)

perf_safety_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_safety_questions,
  perf_safety_vars,
  perf_selected_labs,
  perf_safety_tex_wo_link,
  tbgrp        = "perf_safety",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected")
)


## 5.6 Performance: Health & Wellbeing (perf_health_viz) ----
perf_health_questions <- c(
  "Create digital detox moments",
  "Have rules limiting digital media",
  "Use screen-time limiter",
  "Temporarily switch off Internet",
  "Delete apps/programs",
  "Turn off notifications",
  "Reduce time without special approach",
  "None of these actions"
)

perf_health_vars <- c(
  "PDHWS1_1","PDHWS1_2","PDHWS1_3","PDHWS1_4",
  "PDHWS1_5","PDHWS1_6","PDHWS1_7","PDHWS1_8"
)

perf_health_info_text <- "**Digital Health & Wellbeing** skills relate to managing healthy digital habits: controlling screen time, minimizing distractions, taking digital breaks, and understanding how technology affects sleep and wellbeing."

perf_health_tex_link <- md_text(
  perf_health_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Digital Health results](digital_health.html)"
)

perf_health_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_health_questions,
  perf_health_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_health",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected"),
  text_b_tabset = perf_health_tex_link
)

perf_health_tex_wo_link <- md_text(
  perf_health_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_health_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_health_questions,
  perf_health_vars,
  perf_selected_labs,
  perf_health_tex_wo_link,
  tbgrp        = "perf_health",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected")
)


## 5.7 Performance: Green Skills (perf_green_viz) ----
perf_green_questions <- c(
  "Clean mailbox",
  "Use sustainable search engines",
  "Avoid unnecessary Cloud storage",
  "Turn down screen brightness",
  "Use sleep mode",
  "Close unused phone apps",
  "Recycle devices",
  "Repair before replacing",
  "None of these actions"
)

perf_green_vars <- c(
  "PSGDS1_1","PSGDS1_2","PSGDS1_3","PSGDS1_4",
  "PSGDS1_5","PSGDS1_6","PSGDS1_7","PSGDS1_8","PSGDS1_9"
)

perf_green_info_text <- "**Sustainable/Green Digital Skills** focus on environmentally conscious technology use: reducing energy consumption, buying sustainable devices, recycling electronics, and understanding the environmental impact of digital activities."

perf_green_tex_link <- md_text(
  perf_green_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Green Digital results](green_digital.html)"
)

perf_green_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_green_questions,
  perf_green_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_green",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected"),
  text_b_tabset = perf_green_tex_link
)

perf_green_tex_wo_link <- md_text(
  perf_green_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_green_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_green_questions,
  perf_green_vars,
  perf_selected_labs,
  perf_green_tex_wo_link,
  tbgrp        = "perf_green",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected")
)


## 5.8 Performance: Problem Solving (perf_ps_viz) ----
perf_ps_questions <- c(
  "I don't need help",
  "I don't know anyone",
  "Family",
  "Friends",
  "Colleagues/classmates",
  "Neighbors/acquaintances",
  "Help desk",
  "Library",
  "Telecom/online helpdesk"
)

perf_ps_vars <- c(
  "SourceHelp_1","SourceHelp_2","SourceHelp_3","SourceHelp_4",
  "SourceHelp_5","SourceHelp_6","SourceHelp_7","SourceHelp_8","SourceHelp_9"
)

perf_ps_info_text <- "**Digital Problem Solving** measures the ability to find help and solutions for digital challenges: knowing where to get help to improve digital skills and who to turn to when facing technical difficulties."

perf_ps_tex_link <- md_text(
  perf_ps_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Digital Problem Solving results](digital_problem_solving.html)"
)

perf_ps_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_ps_questions,
  perf_ps_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_ps",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected"),
  text_b_tabset = perf_ps_tex_link
)

perf_ps_tex_wo_link <- md_text(
  perf_ps_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_ps_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_ps_questions,
  perf_ps_vars,
  perf_selected_labs,
  perf_ps_tex_wo_link,
  tbgrp        = "perf_ps",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected")
)


## 5.9 Performance: Transactional (perf_trans_viz) ----
perf_trans_questions <- c(
  "Identify trust/safety icon (webshop)"
)
# digicom_data %>% count(PTS1R)
perf_trans_vars <- c("PTS1R")

perf_trans_info_text <- "**Transactional Skills** cover the ability to complete official tasks online: handling tax matters, making digital payments, arranging healthcare, using digital identification (DigID), and uploading documents for online services."

perf_trans_tex_link <- md_text(
  perf_trans_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Transactional results](transactional.html)"
)

perf_trans_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_trans_questions,
  perf_trans_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_trans",
  graph_title  = perf_trans_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_trans_tex_link
)

perf_trans_tex_wo_link <- md_text(
  perf_trans_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_trans_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_trans_questions,
  perf_trans_vars,
  perf_correct_labs,
  perf_trans_tex_wo_link,
  tbgrp        = "perf_trans",
  graph_title  = perf_trans_questions,
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)


## 5.10 Performance: AI (perf_ai_viz) ----
perf_ai_questions <- c(
  "Google",
  "Netflix",
  "Whatsapp",
  "Facebook",
  "Bol.com",
  "DigID",
  "NOS News",
  "Albert Heijn",
  "TikTok"
)

perf_ai_vars <- c(
  "PAIS2_1","PAIS2_2","PAIS2_3","PAIS2_4","PAIS2_5",
  "PAIS2_6","PAIS2_7","PAIS2_8","PAIS2_9"
)

perf_ai_info_text <- "**AI Skills** assess understanding and recognition of artificial intelligence in everyday applications: recognizing when websites/apps use AI, identifying AI-recommended content, and understanding how AI personalizes digital experiences."

perf_ai_tex_link <- md_text(
  perf_ai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Look closely at the pictures below. Which picture is not made with artificial intelligence (AI)?", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all AI results](ai.html)"
)

perf_ai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_ai_questions,
  perf_ai_vars,
  perf_selected_labs,
  "",
  tbgrp        = "perf_ai",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected"),
  text_b_tabset = perf_ai_tex_link
)

perf_ai_tex_wo_link <- md_text(
  perf_ai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Look closely at the pictures below. Which picture is not made with artificial intelligence (AI)?", preset = "question")',
  "```"
)

perf_ai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_ai_questions,
  perf_ai_vars,
  perf_selected_labs,
  perf_ai_tex_wo_link,
  tbgrp        = "perf_ai",
  graph_title  = "",
  map_values   = list("1" = "Selected", "0" = "Not selected")
)


## 5.11 Performance: GenAI (perf_genai_viz) ----
perf_genai_questions <- c(
  "Spot non-AI image"
)

perf_genai_vars <- c("PAIS1R")

perf_genai_info_text <- "**Generative AI Skills** measure competencies with AI tools like ChatGPT: knowing how to verify AI-generated information, writing effective prompts, detecting AI-generated content, and understanding GenAI's capabilities and limitations."

perf_genai_tex_link <- md_text(
  perf_genai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```",
  "[{{< iconify ph cards >}} See all Gen AI results](gen_ai.html)"
)

perf_genai_viz <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_genai_questions,
  perf_genai_vars,
  perf_correct_labs,
  "",
  tbgrp        = "perf_genai",
  graph_title  = perf_genai_questions,
  # in original you reversed categories_dat; here we can still map 1=Correct
  map_values   = list("1" = "Correct", "0" = "Incorrect"),
  text_b_tabset = perf_genai_tex_link
)

perf_genai_tex_wo_link <- md_text(
  perf_genai_info_text,
  "",
  "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
  'create_blockquote("Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.", preset = "question")',
  "```"
)

perf_genai_viz_wo_link <- create_vizzes2(
  breaks       = knowledge_breaks,
  perf_genai_questions,
  perf_genai_vars,
  perf_correct_labs,
  perf_genai_tex_wo_link,
  tbgrp        = "perf_genai",
  graph_title  = perf_genai_questions,
  # in original you reversed categories_dat; here we can still map 1=Correct
  map_values   = list("1" = "Correct", "0" = "Incorrect")
)


# 6. VISUALIZATION COLLECTIONS =================================================

## 6.1 Performance Collection ----
performance_collection <- perf_sis_viz %>%
  combine_viz(perf_cis_viz) %>%
  combine_viz(perf_dccs_viz) %>%
  combine_viz(perf_netiquette_viz) %>%
  add_pagination() %>% 
  combine_viz(perf_safety_viz) %>%
  combine_viz(perf_health_viz) %>%
  combine_viz(perf_green_viz) %>%
  combine_viz(perf_ps_viz)  %>%
  add_pagination() %>%
  combine_viz(perf_trans_viz) %>%
  combine_viz(perf_ai_viz) %>%
  combine_viz(perf_genai_viz) %>%
  set_tabgroup_labels(
    perf_sis    = "{{< iconify ph magnifying-glass >}} Strategic Information",
    perf_cis    = "{{< iconify ph detective-fill >}} Critical Information",
    perf_netiquette = "{{< iconify ph chats-fill >}} Netiquette"  ,
    perf_dccs   = "{{< iconify ph palette-fill >}} Digital Content Creation",
    perf_safety = "{{< iconify ph shield-check-fill >}} Safety",
    perf_health = "{{< iconify ph heart-fill >}} Digital Health",
    perf_green  = "{{< iconify ph recycle-fill >}} Green Digital",
    perf_ps     = "{{< iconify ph lightbulb-fill >}} Digital Problem Solving",
    perf_trans  = "{{< iconify ph wallet-fill >}} Transactional",
    perf_ai     = "{{< iconify ph robot-fill >}} AI",
    perf_genai  = "{{< iconify ph magic-wand-fill >}} Gen AI",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1",
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age    = "{{< iconify mdi:human-male-male-child >}} Age",
    gender = "{{< iconify mdi gender-transgender >}} Gender",
    edu    = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime   = "{{< iconify ph chart-line-fill >}} Over Time",
    overall = "{{< iconify ph users-fill >}} Overall",
    item1  = "{{< iconify ph chat-circle-fill >}} Question 1",
    item2  = "{{< iconify ph chat-circle-fill >}} Question 2",
    item3  = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4  = "{{< iconify ph chat-circle-fill >}} Question 4",
    item5  = "{{< iconify ph chat-circle-fill >}} Question 5",
    item6  = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7  = "{{< iconify ph chat-circle-fill >}} Question 7",
    item8  = "{{< iconify ph chat-circle-fill >}} Question 8",
    item8  = "{{< iconify ph chat-circle-fill >}} Question 9",
    item8  = "{{< iconify ph chat-circle-fill >}} Question 10"
  )

# 7. DIMENSION-SPECIFIC COMBINED VISUALIZATIONS ================================

library(htmltools)

## 7.0 Setup: Icon System ----
# Create combined visualizations for dimension pages with proper labels
# Consistent icon system:
# 💪 Skills = ph:lightning-fill (abilities/capabilities)
# 📚 Knowledge = ph:book-open-fill (understanding/learning)
# 🏆 Performance = ph:trophy-fill (achievement/testing)


sis_viz_wo_link <- create_vizzes(sis_questions, 
                                 sis_vars, sis_labs, 
                                 sis_tex_question, breaks = c(0.5, 2.5, 3.5, 5.5), 
                                 tbgrp = "sis",
                                 graph_title = "Strategic Information Skills")

## 7.1 Strategic Information Dimension ----
strategic_visualizations <- (sis_viz_wo_link + kinfo_viz_wo_link + perf_sis_viz_wo_link)  %>%
  set_tabgroup_labels(
    sis = "{{< iconify ph lightning-fill >}} Skills",
    kinfo = "{{< iconify ph book-open-fill >}} Knowledge",
    perf_sis = "{{< iconify ph clipboard-text >}} Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age",
    gender = "{{< iconify mdi gender-transgender >}} Gender",
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time",
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3"
  )

## 7.2 Critical Information Dimension ----
critical_info_visualizations <- (cis_viz_wo_link + critinfo_viz_wo_link + perf_cis_viz_wo_link) %>%
  set_tabgroup_labels(
    cis = "{{< iconify ph lightning-fill >}} Critical Information Skills",
    critinfo = "{{< iconify ph book-open-fill >}} Critical Information Knowledge",
    perf_cis = "{{< iconify ph clipboard-text >}} Critical Information Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3"
  )

## 7.3 Netiquette Dimension ----
netiquette_visualizations <- (nskills_viz_wo_link + knet_viz_wo_link) %>%
  set_tabgroup_labels(
    nskills = "{{< iconify ph lightning-fill >}} Netiquette Skills",
    knet = "{{< iconify ph book-open-fill >}} Netiquette Knowledge",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3", 
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4"
  )

## 7.4 Digital Content Creation Dimension ----
content_creation_visualizations <- (dccs_viz_wo_link + kcrea_viz_wo_link + perf_dccs_viz_wo_link) %>%
  set_tabgroup_labels(
    dccs = "{{< iconify ph lightning-fill >}} Digital Content Creation Skills",
    kcrea = "{{< iconify ph book-open-fill >}} Creative Knowledge",
    perf_dccs = "{{< iconify ph clipboard-text >}} Content Creation Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3", 
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4"
  )

## 7.5 Safety & Control Dimension ----
safety_visualizations <- (safety_viz_wo_link + ksafety_viz_wo_link + perf_safety_viz_wo_link) %>%
  set_tabgroup_labels(
    safety = "{{< iconify ph lightning-fill >}} Safety Skills",
    ksafety = "{{< iconify ph book-open-fill >}} Safety Knowledge",
    perf_safety = "{{< iconify ph clipboard-text >}} Safety Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5", 
    item6 = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7 = "{{< iconify ph chat-circle-fill >}} Question 7", 
    item8 = "{{< iconify ph chat-circle-fill >}} Question 8", 
    item9 = "{{< iconify ph chat-circle-fill >}} Question 9"
  )

## 7.6 Digital Health & Wellbeing Dimension ----
health_visualizations <- (dhealth_viz_wo_link + khealth_viz_wo_link + perf_health_viz_wo_link) %>%
  set_tabgroup_labels(
    dhealth = "{{< iconify ph lightning-fill >}} Digital Health Skills",
    khealth = "{{< iconify ph book-open-fill >}} Health Knowledge",
    perf_health = "{{< iconify ph clipboard-text >}} Health Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5", 
    item6 = "{{< iconify ph chat-circle-fill >}} Question 6", 
    item7 = "{{< iconify ph chat-circle-fill >}} Question 7"
  )

## 7.7 Green / Sustainable Digital Dimension ----
green_visualizations <- (green_viz_wo_link + kgreen_viz_wo_link + perf_green_viz_wo_link) %>%
  set_tabgroup_labels(
    green = "{{< iconify ph lightning-fill >}} Green Digital Skills",
    kgreen = "{{< iconify ph book-open-fill >}} Green Knowledge",
    perf_green = "{{< iconify ph clipboard-text >}} Green Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5", 
    item6 = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7 = "{{< iconify ph chat-circle-fill >}} Question 7", 
    item8 = "{{< iconify ph chat-circle-fill >}} Question 8"
  )

## 7.8 Digital Problem Solving Dimension ----
problem_solving_visualizations <- (dprob_viz_wo_link + perf_ps_viz_wo_link) %>%
  set_tabgroup_labels(
    dprob = "{{< iconify ph lightning-fill >}} Problem Solving Skills",
    perf_ps = "{{< iconify ph clipboard-text >}} Problem Solving Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5", 
    item6 = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7 = "{{< iconify ph chat-circle-fill >}} Question 7", 
    item8 = "{{< iconify ph chat-circle-fill >}} Question 8", 
    item9 = "{{< iconify ph chat-circle-fill >}} Question 9"
  )

## 7.9 Transactional Dimension ----
transactional_visualizations <- (trans_viz_wo_link + ktrans_viz_wo_link + perf_trans_viz_wo_link) %>%
  set_tabgroup_labels(
    trans = "{{< iconify ph lightning-fill >}} Transactional Skills",
    ktrans = "{{< iconify ph book-open-fill >}} Transactional Knowledge",
    perf_trans = "{{< iconify ph clipboard-text >}} Transactional Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5"
  )

## 7.10 AI Dimension ----
ai_visualizations <- (ai_viz_wo_link + kai_viz_wo_link + perf_ai_viz_wo_link) %>%
  set_tabgroup_labels(
    ai = "{{< iconify ph lightning-fill >}} AI Skills",
    kai = "{{< iconify ph book-open-fill >}} AI Knowledge",
    perf_ai = "{{< iconify ph clipboard-text >}} AI Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5", 
    item6 = "{{< iconify ph chat-circle-fill >}} Question 6",
    item7 = "{{< iconify ph chat-circle-fill >}} Question 7", 
    item8 = "{{< iconify ph chat-circle-fill >}} Question 8", 
    item9 = "{{< iconify ph chat-circle-fill >}} Question 9"
  )

## 7.11 Generative AI Dimension ----
genai_combined_visualizations <- (genai_viz_wo_link + kgai_viz_wo_link + perf_genai_viz_wo_link) %>%
  set_tabgroup_labels(
    genai = "{{< iconify ph lightning-fill >}} GenAI Skills",
    kgai = "{{< iconify ph book-open-fill >}} GenAI Knowledge",
    perf_genai = "{{< iconify ph clipboard-text >}} GenAI Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1", 
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age = "{{< iconify mdi:human-male-male-child >}} Age", 
    gender = "{{< iconify mdi gender-transgender >}} Gender", 
    edu = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime = "{{< iconify ph chart-line-fill >}} Over Time", 
    overall = "{{< iconify ph users-fill >}} Overall",
    item1 = "{{< iconify ph chat-circle-fill >}} Question 1", 
    item2 = "{{< iconify ph chat-circle-fill >}} Question 2", 
    item3 = "{{< iconify ph chat-circle-fill >}} Question 3",
    item4 = "{{< iconify ph chat-circle-fill >}} Question 4", 
    item5 = "{{< iconify ph chat-circle-fill >}} Question 5"
  )

# 8. DASHBOARD CREATION ========================================================

## 8.1 Navigation Menus ----
dimensions_menu <- navbar_menu(
  text = "Dimensions",
  pages = c("Strategic Information", "Critical Information", 
            "Netiquette", "Digital Content Creation",
            "Safety", "Digital Health", "Green Digital",
            "Digital Problem Solving", "Transactional",
            "AI", "Gen AI"),
  icon = "ph:books-fill"
)

strategic_visualizations <- (sis_viz_wo_link + kinfo_viz_wo_link + perf_sis_viz_wo_link)  %>%
  set_tabgroup_labels(
    sis = "{{< iconify ph lightning-fill >}} Skills",
    kinfo = "{{< iconify ph book-open-fill >}} Knowledge",
    perf_sis = "{{< iconify ph clipboard-text >}} Performance",
    wave1 = "{{< iconify ph number-circle-one-fill >}} Wave 1",
    wave2 = "{{< iconify ph number-circle-two-fill >}} Wave 2",
    age    = "{{< iconify mdi:human-male-male-child >}} Age",
    gender = "{{< iconify mdi gender-transgender >}} Gender",
    edu    = "{{< iconify ph graduation-cap-fill >}} Education",
    overtime   = "{{< iconify ph chart-line-fill >}} Over Time",
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

## 8.2 Dashboard Pages & Configuration ----
# Create comprehensive dashboard with ALL features
dashboard <- create_dashboard(
  ## Descriptions
  title = "Digital Competence Insights", 
  output_dir = "qmds", 
  publish_dir = "../docs",
  author = "Digital Competence Insights Dashboard Team",
  description = "Digital Competence Insights Dashboard",
  page_footer = "© 2025 Digital Competence Insights Dashboard - All Rights Reserved",
  date = "2025-11-20",
  logo = "logo.png",
  ## Themes / Styles
  page_layout = "full",
  theme = "flatly",  # Options: cosmo, flatly, darkly, minty, pulse, etc.
  tabset_theme = "minimal",  # This is YOUR style! 
  math = "katex",
  mobile_toc = T,
  search = TRUE,
  code_overflow = "wrap",        # ← From your original
  html_math_method = "mathjax",  # ← From your original
  #### Navbar settings
  navbar_sections = list(dimensions_menu),  # Just pass the menus!
  navbar_style = "dark",
  navbar_brand = "Digital Competence Insights Dashboard",
  navbar_toggle = "collapse",
  navbar_bg_color = "#f0f0f0",
  navbar_text_color = "#3A1B00E6", 
  navbar_text_hover_color = "lightgrey",
  ## pagination settings
  pagination_position = "both",
  pagination_separator = "/", 
  github = "https://github.com/favstats/dashboardr",
  linkedin = "https://linkedin.com/in/username",
  email = "user@example.com",
  website = "https://www.dedigiq.nl/",
  breadcrumbs = FALSE,
  page_navigation = TRUE,
  back_to_top = TRUE,
  # repo_url = "https://github.com/username/dashboardr",
  self_contained = TRUE,        # ← From your original
  # viewport_width = 1200,
  # viewport_scale = 0.3,
  # toc = "floating",
  # toc_depth = 3,
  code_tools = FALSE,  # ← Add this to explicitly disable the Code button
  code_folding = NULL, # ← Make sure this is NULL or FALSE too
  plausible = "example.com",
  metrics_style = "bootstrap"
) %>%
  # Landing page with icon
  add_page(
    name = "Welkom bij de Digital Competence Insights Dashboard",
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "Je kunt algemene trends onderzoeken in de verschillende secties, met de mogelijkheid om te differentiëren naar leeftijd, geslacht, opleidingsniveau en politieke voorkeur.",
      "",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    ),
    icon = "ph:house-fill",
    is_landing_page = TRUE
  ) %>%
  # Analysis page with data and visualizations
  add_page(
    overlay = T,
    overlay_duration = 1,
    name = "Skills",
    data = digicom_data,
    visualizations = skills_viz,
    icon = "ph:lightning-fill",
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "The **Skills** section measures participants’ *self-assessed ability* to perform a wide range of digital tasks. These items capture how confident people feel doing things like searching for information, creating content, protecting their privacy, or recognizing when AI is being used. The questions cover different domains of digital competence, from information and communication skills to AI and generative AI skills, and together provide insight into participants’ everyday digital capabilities and confidence levels."
    )
  ) %>%
  add_page(
    overlay = T,
    overlay_duration = 1,
    name = "Performance",
    data = digicom_data,
    visualizations = performance_collection,
    icon = "ph:clipboard-text",
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "The **Performance** section measures participants' practical digital skills across a range of real-life tasks. Instead of self-reports, these items test what people *can actually do*: for example, searching for reliable information, recognizing AI-generated images, protecting their devices, or using AI tools effectively. The items cover ten areas of digital competence, from strategic and critical information skills to AI and generative AI skills, providing an overall picture of how well individuals can navigate today's digital environment."
    )
  ) %>%
  # Analysis page with data and visualizations
  add_page(
    overlay = T,
    overlay_duration = 1,
    name = "Knowledge",
    data = digicom_data,
    visualizations = knowledge_collection,
    icon = "ph:book-open-fill",
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "The **Knowledge** section measures what participants *know* about the digital world: how it works, what risks it involves, and how different technologies affect everyday life. These items test factual understanding across topics such as information reliability, communication and privacy, online safety, AI, and generative AI. Respondents indicate whether each statement is true or false (or if they don’t know), allowing us to assess their level of digital literacy and awareness beyond self-perceived skills."
    )
  ) %>%
  # Analysis page with data and visualizations
  add_page(
    name = "Highlights",
    data = digicom_data,
    icon = "ph:star-fill", 
    visualizations = genai_viz,
    text = md_text(
      "If you’ve spent time around anyone under 25 lately, you’ve probably heard phrases like “I’ll just ask Chat” or “ChatGPT can do that faster.” Generative AI tools have quickly become part of everyday life for young people in the Netherlands. Whether for homework, social media posts, or just curiosity, Gen Z and even Gen Alpha are driving the adoption of these technologies at an astonishing pace.",
      "",
      "The flood of AI-generated images, videos, and memes means it’s almost impossible to grow up today without encountering artificial intelligence. For many, AI isn’t a futuristic concept: it’s a daily companion. Young people now turn to tools like ChatGPT for information, writing help, and even casual conversation. This has been documented in the [Dutch AI Opinion Monitor](https://monitor.algosoc.nl/engagement.html), which shows that young people are the fastest adopters of this technology.
",
      "",
      "## The Confidence Boom",
      
      "Our latest survey reflects this cultural shift. When asked how confident they felt using prompts to get useful responses from ChatGPT, a striking **71.2% of 16–25-year-olds** said they were confident. Even among those aged **10–15**, more than **half (54.4%)** expressed confidence in their ability to prompt AI effectively.",
      "",
      "In other words, pre-teens today feel just as capable of “talking to AI” as many highly educated professionals in their thirties and forties. This growing sense of mastery highlights how intuitively young people adapt to new technologies. But confidence isn’t the same as competence."
    )
  )%>%
  # Analysis page with data and visualizations
  add_page(
    name = "Strategic Information",
    icon = "ph:magnifying-glass",
    data = digicom_data,
    visualizations = strategic_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      sis_info_text
    )
  ) %>% 
  
  add_page(
    name = "Critical Information",
    icon = "ph:detective-fill",
    data = digicom_data,
    visualizations = critical_info_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Critical Information Skills** measure the ability to evaluate online information: checking whether information is true, assessing website reliability, and understanding the purpose of online content (to inform, influence, entertain, or sell)."
    )
  ) %>% 
  
  add_page(
    name = "Netiquette",
    icon = "ph:chats-fill",
    data = digicom_data,
    visualizations = netiquette_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Netiquette** refers to proper online communication etiquette: knowing when to ask permission before sharing, choosing the right communication tool, understanding what not to share online, and using emoticons appropriately."
    )
  ) %>% 
  
  add_page(
    name = "Digital Content Creation",
    icon = "ph:palette-fill",
    data = digicom_data,
    visualizations = content_creation_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Digital Content Creation** skills cover the ability to create and modify digital content: making presentations, combining different media, editing images/music/video, and understanding copyright rules around digital content."
    )
  ) %>% 
  
  add_page(
    name = "Safety",
    icon = "ph:shield-check-fill",
    data = digicom_data,
    visualizations = safety_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Safety & Control of Information and Devices** encompasses protecting devices and personal information: using security measures, managing privacy settings, identifying phishing, and controlling what information is shared online."
    )
  ) %>% 
  
  add_page(
    name = "Digital Health",
    icon = "ph:heart-fill",
    data = digicom_data,
    visualizations = health_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Digital Health & Wellbeing** skills relate to managing healthy digital habits: controlling screen time, minimizing distractions, taking digital breaks, and understanding how technology affects sleep and wellbeing."
    )
  ) %>% 
  
  add_page(
    name = "Green Digital",
    icon = "ph:recycle-fill",
    data = digicom_data,
    visualizations = green_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Sustainable/Green Digital Skills** focus on environmentally conscious technology use: reducing energy consumption, buying sustainable devices, recycling electronics, and understanding the environmental impact of digital activities."
    )
  ) %>% 
  
  add_page(
    name = "Digital Problem Solving",
    icon = "ph:lightbulb-fill",
    data = digicom_data,
    visualizations = problem_solving_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Digital Problem Solving** measures the ability to find help and solutions for digital challenges: knowing where to get help to improve digital skills and who to turn to when facing technical difficulties."
    )
  ) %>% 
  
  add_page(
    name = "Transactional",
    icon = "ph:wallet-fill",
    data = digicom_data,
    visualizations = transactional_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Transactional Skills** cover the ability to complete official tasks online: handling tax matters, making digital payments, arranging healthcare, using digital identification (DigID), and uploading documents for online services."
    )
  ) %>% 
  
  add_page(
    name = "AI",
    icon = "ph:robot-fill",
    data = digicom_data,
    visualizations = ai_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**AI Skills** assess understanding and recognition of artificial intelligence in everyday applications: recognizing when websites/apps use AI, identifying AI-recommended content, and understanding how AI personalizes digital experiences."
    )
  ) %>% 
  
  add_page(
    name = "Gen AI",
    icon = "ph:magic-wand-fill",
    data = digicom_data,
    visualizations = genai_combined_visualizations,
    text = md_text(
      "**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**",
      "",
      "**Generative AI Skills** measure competencies with AI tools like ChatGPT: knowing how to verify AI-generated information, writing effective prompts, detecting AI-generated content, and understanding GenAI's capabilities and limitations."
    )
  ) %>% 
  # Text-only page with icon showcasing card function
  add_page(
    name = "About", 
    icon = "ph:info-fill",
    navbar_align = "right",
    text = md_text(
      "This dashboard aggregates and visualizes data",
      "",
      "## Dashboard Creators",
      "",
      "```{r, echo=FALSE, message=FALSE, warning=FALSE}",
      "library(htmltools)",
      "library(dashboardr)",
      "",
      "mario_card <- card(",
      "  content = \"Mario il Gatto is a data scientist who believes that every dataset has a soul and that R is the language of the gods. He spends his days making beautiful visualizations and his nights dreaming of perfectly normalized databases.\",",
      "  title = \"Mario il Gatto\",",
      "  image = \"https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=300&h=200&fit=crop\",",
      "  image_alt = \"Photo of a majestic orange cat\",",
      "  footer = \"Website: mario-il-gatto.data\",",
      "  class = \"mb-3\"",
      ")",
      "",
      "giuseppe_card <- card(",
      "  content = \"Giuseppe il Cane is a machine learning engineer who thinks that neural networks are just very complicated dogs. He's convinced that every algorithm needs a good walk and that overfitting is just a sign of too much enthusiasm.\",",
      "  title = \"Giuseppe il Cane\",",
      "  image = \"https://images.unsplash.com/photo-1552053831-71594a27632d?w=300&h=200&fit=crop\",",
      "  image_alt = \"Photo of a happy golden retriever\",",
      "  footer = \"Website: giuseppe-il-cane.ai\",",
      "  class = \"mb-3\"",
      ")",
      "",
      "# Display cards in a row using the card_row function",
      "card_row(mario_card, giuseppe_card)",
      "```",
      "## More about Dashboardr",
      "Dashboardr is an R package with a clear vision: to make it intuitive for everyone to create beautiful dashboards.",
      "The package is especially useful when time is limited. The iterative piping logic means that it is very quick to add new pages",
      "and plots, even when the user is inexperienced with programming.",
      "In a variety of contexts, this means that you can get quick, beautiful insights to present findings to wider audiences."
    )
  ) %>%
  add_powered_by_dashboardr(style = "badge", size = "large")

# Test the print methods
cat("=== Dashboard Project Summary ===\n")
print(dashboard)

cat("\n=== Visualization Collection Summary ===\n")
# print(skills_viz)

# cat("\n=== Summary Visualizations ===\n")
# print(summary_vizzes)


## 8.3 Generate Dashboard ----
# Generate the dashboard
cat("\n=== Generating Dashboard ===\n")
generate_dashboard(dashboard, render = T, open = "browser")



gert::git_add(".")
gert::git_commit("update")
gert::git_push()