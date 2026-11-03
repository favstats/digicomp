# TEST SCRIPT - Just the Green Digital page
# Run this to quickly test the green_digital page generation

library(tidyverse)
library(dashboardr)

# Load translations
translation <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRHn6F7oL_0WCNdlwvV5WvT8JtT-XRKO2YQ8zX1zJbbPkznXGEVbXC80F4fC0NUjWK87kdirUXn6eLh/pub?gid=1284654467&single=true&output=csv")

transl <- function(x, lang) {
  translation %>% filter(variable == x) %>% pull(lang)
}

lang <- "en"

# Colors
the_colors <- c("#3D7271", "#E28D50", "#F5D76E", "#C7E6D5", "#0F6B5A", "#BABACD")

# Skill labels
sis_labs <- c(
  transl("label_cant_do_at_all", lang),
  transl("label_not_so_well", lang),
  transl("label_fairly_well", lang),
  transl("label_very_well", lang),
  transl("label_dont_understand", lang)
)

# Breaks for skills
sis_breaks <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5)

# Helper function
get_y_label_percentage <- function(lang) {
  transl("label_percentage_respondents", lang)
}

# Data recoding function (simplified for this test)
recode_survey <- function(df) {
  skill_vars <- c("SEnv1", "SEnv2", "SEnv3")
  skill_present <- intersect(names(df), skill_vars)
  df <- df |> mutate(across(all_of(skill_present), ~ suppressWarnings(as.numeric(.x))))
  df <- df |> mutate(across(all_of(skill_present), ~ replace(.x, .x %in% c(66, 99), NA_real_)))
  df
}

# Helper functions for creating visualizations
add_all_viz_timeline <- function(viz, vars, grp_var, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  for (i in seq_along(vars)) {
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        y_var = identity(vars[[i]]),
        group_var = identity(grp_var),
        tabgroup = tabgroup_path
      )
  }
  viz
}

add_all_viz_timeline_single <- function(viz, vars, tbgrp, demographic, wave_label, questions) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  for (i in seq_along(vars)) {
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        y_var = identity(vars[[i]]),
        tabgroup = tabgroup_path
      )
  }
  viz
}

add_all_viz_stackedbar <- function(viz, vars, questions, grp_var, tbgrp, demographic, wave_label) {
  wave_path <- tolower(gsub(" ", "", wave_label))
  label_keys <- c(age = "tab_age", gender = "tab_gender", edu = "tab_education", mig = "tab_migration")
  label_key <- label_keys[[demographic]]
  for (i in seq_along(vars)) {
    tabgroup_path <- if (length(vars) == 1) {
      glue::glue("{tbgrp}/{wave_path}/{demographic}")
    } else {
      glue::glue("{tbgrp}/{wave_path}/{demographic}/item{i}")
    }
    viz <- viz |>
      add_viz(
        title = questions[[i]],
        x_var = identity(grp_var),
        x_label = transl(label_key, lang),
        stack_var = identity(vars[[i]]),
        tabgroup = tabgroup_path
      )
  }
  viz
}

# create_vizzes function for skills
create_vizzes <- function(qs, vs, lbs, tex, breaks = c(0.5, 2.5, 3.5, 5.5), 
                          colors = the_colors, 
                          tbgrp, graph_title, high_values = 4:5, 
                          text_b_tabset = "ADD TEXT BEFORE TABSET", 
                          aggr_lab = get_y_label_percentage(lang),
                          lang = "en") {
  
  force(qs); force(vs); force(lbs); force(breaks); force(colors)
  force(tbgrp); force(graph_title); force(high_values)
  force(text_b_tabset); force(aggr_lab)
  
  # Wave 1 & 2 Overall (stackedbars)
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
    drop_na_vars = FALSE,
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
  
  # Over Time Overall
  sis_subvizzes_time <- create_viz(
    type = "timeline",
    time_var = "wave_time_label",
    chart_type = "line",
    text_before_tabset = text_b_tabset,
    y_filter = high_values, 
    y_filter_label = aggr_lab,
    y_filter_combine = TRUE,
    x_label = "", 
    y_label = aggr_lab,
    color_palette = the_colors,
    y_min = 0,
    y_max = 100,
    y_filter_label = NULL,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_timeline_single(vs, tbgrp, "overall", wave_label = "Over Time", questions = qs)
  
  # Wave 1 by demographics
  sis_subvizzes <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = TRUE,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    text_before_tabset = text_b_tabset,
    stack_order = rev(lbs),
    filter = ~ wave == 1,
    drop_na_vars = FALSE,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 1") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 1")
  
  # Wave 2 by demographics
  sis_subvizzes2 <- create_viz(
    type = "stackedbar",
    stacked_type = "percent",
    horizontal = TRUE,
    stack_breaks = breaks,
    stack_bin_labels = lbs,
    stack_order = rev(lbs),
    text_before_tabset = text_b_tabset,
    filter = ~ wave == 2,
    drop_na_vars = FALSE,
    color_palette = colors,
    weight_var = "weging_GAMO"
  ) |>
    add_all_viz_stackedbar(vs, qs, "AgeGroup", tbgrp, "age", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "geslacht", tbgrp, "gender", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "Education", tbgrp, "edu", wave_label = "Wave 2") |>
    add_all_viz_stackedbar(vs, qs, "MigrationBackground", tbgrp, "mig", wave_label = "Wave 2")
  
  # Over Time by demographics
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
  
  sis_viz %>% 
    combine_viz(sis_subvizzes_time) %>%
    combine_viz(sis_subvizzes) %>%
    combine_viz(sis_subvizzes2) %>%
    combine_viz(sis_subvizzes3)
}

# Load data
data <- readRDS("data/digicom_wave2.rds") %>% recode_survey()
data_w1 <- readRDS("data/digicom_wave1.rds") %>% 
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>% 
  recode_survey()

# Combine data
digicom_data <- data %>% 
  mutate(wave = 2) %>% 
  bind_rows(data_w1 %>% mutate(wave = 1)) %>% 
  mutate(wave_time_label = ifelse(wave == 1, paste0("Dec. 24 (", transl("tab_wave1", lang), ")"), paste0("Jun. 25 (", transl("tab_wave2", lang), ")"))) %>% 
  mutate(wave_time_label = factor(wave_time_label, levels = c(paste0("Dec. 24 (", transl("tab_wave1", lang), ")"), paste0("Jun. 25 (", transl("tab_wave2", lang), ")")))) %>% 
  mutate(Education = case_when(
    Education == "66" ~ NA_character_,
    Education == "99" ~ NA_character_,
    TRUE ~ as.character(Education)
  )) %>% 
  mutate(Education = fct_relevel(Education, c(transl("label_low_education", lang), transl("label_middle_education", lang), transl("label_high_education", lang)))) %>% 
  mutate(MigrationBackground = case_when(
    MigrationBackground == "yes" ~ transl("label_yes", lang),
    MigrationBackground == "no" ~ transl("label_no", lang),
    TRUE ~ MigrationBackground
  )) %>% 
  mutate(AgeGroup = case_when(
    Age %in% 10:15 ~ "10-15",
    Age %in% 15:30 ~ "16-30",
    Age %in% 31:64 ~ "31-64",
    Age %in% 65:150 ~ "65+",
  ))

# Green Digital Skills page content
green_questions <- c(
  transl("SEnv1", lang),
  transl("SEnv2", lang),
  transl("SEnv3", lang)
)
green_vars <- c("SEnv1", "SEnv2", "SEnv3")

green_info_text <- transl("green_description", lang)
green_tex_more_link <- paste0("[{{< iconify ph cards >}} ", transl("link_see_all_green", lang), "](green_digital.html)")

green_tex_complete <- paste0(
  green_info_text, "\n",
  green_tex_more_link
)

green_viz <- create_vizzes(
  green_questions, green_vars, sis_labs,
  green_tex_complete,
  sis_breaks,
  tbgrp = "green",
  text_b_tabset = green_tex_complete,
  graph_title = transl("title_sustainable_green_digital_skills", lang)
)

# Create the page
green_page <- create_page(
  name = "Green / Sustainable Digital",
  data = digicom_data,
  icon = "ph:leaf"
) %>% 
  add_content(green_viz)

# Create minimal dashboard with just this page
test_dashboard <- create_dashboard(
  title = "Test - Green Digital Page",
  output_dir = "test_output"
) %>% 
  add_pages(green_page)

# Generate and render
test_dashboard %>% 
  generate_dashboard(render = TRUE)

message("Done! Check the test_output folder.")
