# Load necessary libraries
library(shiny)
library(dplyr)
library(tidyr)
library(highcharter)
library(forcats)
library(bslib)
library(stringr)
library(shinyWidgets)
library(bsicons)
library(tools)
# library(readr) # Not needed if simulating data

# --- 1. Full Data Simulation ---
set.seed(123)
N <- 5000 # Number of simulated observations

# Demographics & Base
data_sim <- tibble(
  ID = 1:N, # Add an ID for potential joins if needed later
  Age = sample(16:80, N, replace = TRUE),
  geslacht_raw = sample(c("Man", "Vrouw", "Anders"), N, replace = TRUE, prob = c(0.48, 0.48, 0.04)),
  Education_raw = sample(c("Primary", "Pre-Vocational", "Secondary", "Vocational", "Applied Sciences", "University"), N, replace = TRUE),
  weging_GAMO = abs(rnorm(N, 1, 0.1)),
  wave = sample(1:2, N, replace = TRUE) # Simulate two waves
)

# Derive age_groups and ensure factor levels
data_sim <- data_sim %>%
  mutate(
    age_groups = factor(case_when(
      Age %in% 16:17 ~ "16-17", Age %in% 18:24 ~ "18-24",
      Age %in% 25:34 ~ "25-34", Age %in% 35:44 ~ "35-44",
      Age %in% 45:54 ~ "45-54", Age %in% 55:64 ~ "55-64",
      Age %in% 65:150 ~ "65+", TRUE ~ NA_character_
    ), levels = c("16-17", "18-24", "25-34", "35-44", "45-54", "55-64", "65+")),
    geslacht = factor(geslacht_raw, levels = c("Man", "Vrouw", "Anders")),
    Education = factor(Education_raw, levels = c("Primary", "Pre-Vocational", "Secondary", "Vocational", "Applied Sciences", "University"))
  )

# List of all skill variables needed (extracted from your full skill_definitions)
all_skill_vars_names <- c(
  "SInfo1N", "SInfo3_V2N", "SInfo4N", "SInfo5N", "SInfo6N", "SInfo7N",
  "SCom1_V2N", "SCom2N", "SCom4_V2N", "SCom5N", "SCom3N",
  "SCrea2N", "SCrea3N", "SCrea4N", "SCrea5N",
  "SSafDev1N", "SSafDev2N", "SPriv1N", "SPriv2N", "SPriv3N", "SPriv4N",
  "SHealth1N", "SHealth2_V2N", "SHealth3_V2",
  "SEnv1N", "SEnv2N", "SEnv3N",
  "SProbl1N", "SProbl2N",
  "Strans1N", "Strans2N", "Strans3N", "Strans4N", "Strans5N",
  "SAI1N", "SAI2N",
  "SGAI1N", "SGAI2N", "SGAI3N"
)

# Simulate Likert scale (1-5) for all skill variables
for (var_name in all_skill_vars_names) {
  data_sim[[var_name]] <- sample(1:5, N, replace = TRUE, prob = c(0.05, 0.1, 0.25, 0.35, 0.25)) # Adjusted probabilities
}

# Simulate Knowledge Score (1-29)
data_sim$MeanKnowledge <- sample(1:29, N, replace = TRUE)

# Final simulated data
data <- data_sim

# --- 2. Skill Domain Definitions (Expanded - same as your previous good one) ---
skill_definitions <- list(
  "Dimensions" = list(
    vars = c("SInfo1N", "SInfo3_V2N", "SInfo4N"),
    short_labels = c("Skills", "Performance", "Knowledge"),
    full_labels = c("Skills Dimension", "Performance Dimension", "Knowledge Dimension")
  ),
  "Strategic Information Skills" = list(
    vars = c("SInfo1N", "SInfo3_V2N", "SInfo4N"),
    short_labels = c("Keywords", "Answers", "Search Funcs"),
    full_labels = c("I know how to choose good keywords for online searches (for example with Google).", 
                    "I know how I can find answers to my questions on the internet.", 
                    "I know how I can use search functions in search engines (for example with Google).")
  ),
  "Critical Information Skills" = list(
    vars = c("SInfo5N", "SInfo6N", "SInfo7N"),
    short_labels = c("Verify Info", "Reliability", "Assess Goal"),
    full_labels = c("I know how I can check if the information I find on the internet is true.", 
                    "I know how I can check if a website is reliable.", 
                    "I can assess what the goal of online information is (e.g., to inform, influence, entertain or sell).")
  ),
  "Netiquette Skills" = list(
    vars = c("SCom1_V2N", "SCom2N", "SCom4_V2N", "SCom5N"),
    short_labels = c("Share Permission", "Comm. Tool Choice", "Not Sharing", "Emoticon Use"),
    full_labels = c("I know when I should ask for permission to share something online.", 
                    "I know which communication tool best fits which situation (for example: call, send a WhatsApp-message, send an e-mail).", 
                    "I know which things I should not share online.", 
                    "I know when it is appropriate and when it is not appropriate to use emoticons (for example smileys ☺ or emoji's).")
  ),
  "Digital Content Creation Skills" = list(
    vars = c("SCrea2N", "SCrea3N", "SCrea4N", "SCrea5N"),
    short_labels = c("Presentations", "Combine Media", "Edit Media", "Enhance Media"),
    full_labels = c("I can make a presentation on the computer (for example in Powerpoint).", 
                    "I can make something that combines different digital media (for example a movie with music).", 
                    "I can change existing digital images, music, and video.", 
                    "I can make a photo or video more attractive (for example with a filter or Photoshop).")
  ),
  "Safety & Control Skills" = list(
    vars = c("SSafDev1N", "SSafDev2N" , "SPriv1N", "SPriv2N", "SPriv3N", "SPriv4N", "SCom3N"),
    short_labels = c("Device Access", "Virus Protect", "Privacy Set", "Location Set", "Suspicious Email", "Del History", "Block Msgs"),
    full_labels = c("I know how to protect a device against access (e.g. a PIN code or fingerprint).", 
                    "I know how to protect devices against viruses.", 
                    "I know how to adjust the privacy settings on a mobile phone or tablet.", 
                    "I know how to change the location settings on a mobile phone or tablet.", 
                    "I know how to identify suspicious e-mail messages that try to get my personal data.", 
                    "I know how to delete the history of websites that I have visited before.", 
                    "I know how to block messages from someone that I don’t want to hear from.")
  ),
  "Digital Health & Wellbeing Skills" = list(
    vars = c("SHealth1N", "SHealth2_V2N", "SHealth3_V2"),
    short_labels = c("Time Online", "Phone Distract", "Stop Devices"),
    full_labels = c("I know how to control how much time I spend on the internet.", 
                    "I know how to make sure my phone does not distract me.", 
                    "I know how I can stop using my phone and computer for a while, if I want to.")
  ),
  "Sustainable/Green Digital Skills" = list(
    vars = c("SEnv1N", "SEnv2N", "SEnv3N"),
    short_labels = c("Battery Use", "Buy Green", "Recycle Tech"),
    full_labels = c("I know how to reduce the battery use of a phone or computer.", 
                    "I know how I can buy a phone or computer in a “green” or sustainable way.", 
                    "I know how to have a phone or computer recycled.")
  ),
  "Digital Problem Solving Skills" = list(
    vars = c("SProbl1N", "SProbl2N"),
    short_labels = c("Help for Skills", "Help for Problems"),
    full_labels = c("I know where or from whom I can get help to improve my digital skills.", 
                    "I know where or from whom I can get help if I’m unable to do something on the internet.")
  ),
  "Transactional Skills" = list(
    vars = c("Strans1N", "Strans2N", "Strans3N", "Strans4N", "Strans5N"),
    short_labels = c("Tax Online", "Payments", "Healthcare Online", "DigID", "Upload Docs"),
    full_labels = c("I know how to handle things online for the tax authority (“belastingdienst”).", 
                    "I know how to do digital payments on the computer or smartphone.", 
                    "I know how to arrange my healthcare online.", 
                    "I know how to apply for a DigID and how to use it.", 
                    "I know how to upload documents and images when needed to arrange things online.")
  ),
  "AI Skills" = list(
    vars = c("SAI1N", "SAI2N"),
    short_labels = c("AI Adjust", "AI Recs"),
    full_labels = c("I recognize when a website or app uses AI to adjust the content to me.", 
                    "I recognize when specific content is recommended to me by AI.")
  ),
  "GenAI Skills" = list(
    vars = c("SGAI1N", "SGAI2N", "SGAI3N"),
    short_labels = c("GenAI Correct", "GenAI Prompts", "Check GenAI"),
    full_labels = c("I usually know when the content created for me by GenAI...contains correct information.", 
                    "I know which questions (or “prompts”) I should ask GenAI...to receive a useful result.", 
                    "I know how to check whether a text or picture is created by GenAI...instead of a person.")
  ),
  "Knowledge Score" = list(
    vars = c("MeanKnowledge"),
    short_labels = c("Knowledge Score"),
    full_labels = c("How good are people at knowledge questions? (Scale 1-29)")
  )
)


categories_dat_likert <- c("(Completely) True (4-5)", "Not true and not untrue (3)", "(Completely) Untrue (1-2)")
categories_dat_knowledge <- c("High (20-29)", "Middle (10-19)", "Low (1-9)")
colors_original <- c("#2ca02c", "#ff7f0e", "#1f77b4") # Green, Orange, Blue

# --- Highcharter Theme ---
hc_theme_custom <- hc_theme_flat(
  chart = list(backgroundColor = NULL, style = list(fontFamily = "Roboto")),
  title = list(style = list(color = "#333333", fontFamily = "Lato", fontWeight = "bold", fontSize = "1.2em")),
  legend = list(itemStyle = list(fontFamily = "Roboto", color = "black"), itemHoverStyle = list(color = "#007bff"), align = 'center', verticalAlign = 'bottom'),
  xAxis = list(labels = list(style = list(color = "#555")), title = list(style = list(color = "#333", fontWeight = 'bold'))),
  yAxis = list(labels = list(style = list(color = "#555")), title = list(style = list(color = "#333", fontWeight = 'bold')), gridLineColor = "#e6e6e6"),
  tooltip = list(backgroundColor = 'rgba(255, 255, 255, 0.95)', style = list(color = '#333'), borderWidth = 1, borderColor = '#ccc', shadow = TRUE)
)

# --- 3. Helper Function (Plotting - No Angle) ---
create_hc_plot <- function(data_in, var_label, group_vars = NULL, weight_var = "weging_GAMO", is_time_view = FALSE) {
  
  var <- names(var_label)
  var_label_text <- var_label[[1]]
  
  if (nrow(data_in) == 0 || !var %in% names(data_in)) {
    return(highchart() %>% hc_title(text = paste("Data or variable '", var, "' not available for current selection.")))
  }
  
  if (var == "MeanKnowledge") {
    range1 <- 1:9; range2 <- 10:19; range3 <- 20:29
    categories_dat <- categories_dat_knowledge; stacked_type <- "normal"
  } else {
    range1 <- 1:2; range2 <- 3; range3 <- 4:5
    categories_dat <- categories_dat_likert; stacked_type <- "percent"
  }
  
  positive_cat <- categories_dat[1]
  
  base_data <- data_in %>%
    mutate(value_cat = case_when(
      !!sym(var) %in% range1 ~ categories_dat[3],
      !!sym(var) %in% range2 ~ categories_dat[2],
      !!sym(var) %in% range3 ~ categories_dat[1]
    )) %>%
    filter(!is.na(value_cat)) %>%
    mutate(value_cat = fct_relevel(value_cat, categories_dat))
  
  if (!is.null(group_vars) && length(group_vars) > 0) {
    base_data <- base_data %>%
      unite("group_content", all_of(group_vars), sep = " - ", remove = FALSE, na.rm = TRUE) %>%
      mutate(group_content = as.factor(group_content))
  } else {
    base_data <- base_data %>% mutate(group_content = "Overall")
  }
  
  if (is_time_view) {
    chart_type <- "line"; x_axis_sym <- sym("wave"); x_axis_title <- "Wave"
    if (!is.null(group_vars) && length(group_vars) > 0) {
      plot_data <- base_data %>%
        count(wave, group_content, value_cat, wt = !!sym(weight_var)) %>%
        group_by(wave, group_content) %>% mutate(perc = n / sum(n) * 100) %>% ungroup() %>%
        filter(value_cat == positive_cat) %>%
        rename(x_var = wave, group_var_col = group_content) %>% mutate(x_var = as.character(x_var))
      y_axis_title <- paste0("% '", positive_cat, "'"); hc_colors_to_use <- NULL
    } else {
      plot_data <- base_data %>%
        count(wave, value_cat, wt = !!sym(weight_var)) %>%
        group_by(wave) %>% mutate(perc = n / sum(n) * 100) %>% ungroup() %>%
        rename(x_var = wave, group_var_col = value_cat) %>% mutate(x_var = as.character(x_var))
      y_axis_title <- "Percentage"; hc_colors_to_use <- colors_original
    }
  } else {
    chart_type <- "bar"; grouping_sym <- sym("value_cat"); x_axis_sym <- sym("group_content")
    x_axis_title <- if(all(base_data$group_content == "Overall")) "" else paste(toTitleCase(gsub("_", " ", group_vars)), collapse = " & ")
    hc_colors_to_use <- colors_original; y_axis_title <- "Percentage"
    plot_data <- base_data %>%
      count(!!x_axis_sym, !!grouping_sym, wt = !!sym(weight_var)) %>%
      group_by(!!x_axis_sym) %>% mutate(perc = n / sum(n) * 100) %>% ungroup() %>%
      rename(x_var = !!x_axis_sym, group_var_col = !!grouping_sym)
  }
  
  hc <- plot_data %>%
    hchart(chart_type, hcaes(x = x_var, y = perc, group = group_var_col)) %>%
    hc_title(text = NULL) %>%
    hc_xAxis(title = list(text = x_axis_title), type = "category", labels = list(rotation = 0)) %>%
    hc_yAxis(title = list(text = y_axis_title), max = if(stacked_type == "percent" && chart_type == "bar") 100 else NULL, labels = list(format = '{value}%')) %>%
    hc_tooltip(shared = TRUE, valueDecimals = 1, valueSuffix = "%", pointFormat = '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y:.1f}%</b><br/>') %>%
    hc_plotOptions(
      series = list(
        dataLabels = list(enabled = TRUE, format = '{y:.0f}%',
                          color = if(chart_type == "bar") 'white' else 'grey',
                          style = list(fontSize = '10px', fontWeight = '600', textOutline = "none"),
                          inside = TRUE, filter = list(property = 'y', operator = '>', value = 7)),
        borderWidth = 0),
      line = list(marker = list(enabled = TRUE))) %>%
    hc_add_theme(hc_theme_custom)
  
  if (!is.null(hc_colors_to_use)) { hc <- hc %>% hc_colors(hc_colors_to_use) }
  if (chart_type == "bar") { hc <- hc %>% hc_plotOptions(bar = list(stacking = stacked_type)) }
  
  return(hc)
}

# --- 4. UI ---
my_theme <- bs_theme(
  version = 5, bootswatch = "litera",
  base_font = font_google("Roboto", local = FALSE),
  heading_font = font_google("Lato", local = FALSE),
  primary = "#2780e3", # Cosmo primary
  secondary = "#777777"
)

ui <- navbarPage(
  title = "Digital Skills Dashboard",
  theme = my_theme,
  tabPanel("Explore Data", icon = bs_icon("bar-chart-line-fill"),
           tags$head(
             tags$style(HTML("
        body { background-color: #f4f6f9; font-size: 14px; }
        .navbar.navbar-expand-lg { 
            background-color: #ffffff !important; 
            border-bottom: 1px solid #e9ecef !important; 
            box-shadow: 0 1px 2px rgba(0,0,0,.03) !important; 
        }
        .navbar-brand { color: #212529 !important; font-weight: 600; }
        .navbar-nav .nav-link { color: #495057 !important; }
        .navbar-nav .nav-link.active { color: var(--bs-primary) !important; font-weight: 500; }
        .navbar-toggler-icon { 
            background-image: url(\"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(33, 37, 41, 0.75)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e\") !important;
        }

        .layout-sidebar { background-color: transparent; border: none; padding: 15px; gap: 20px; }
        .sidebar { background-color: #fff; border-radius: 6px; padding: 15px; box-shadow: 0 1px 4px rgba(0,0,0,.08); border: 0; }
        .main-panel { padding: 0 !important; background-color: #fff; border-radius: 6px; border: 1px solid #dee2e6; box-shadow: 0 1px 4px rgba(0,0,0,.08); }
        .main-panel h2 { padding: 15px 20px; margin: 0; font-size: 1.4em; color: #343a40; font-family: 'Lato', sans-serif; font-weight: 700; border-bottom: 1px solid #dee2e6; }
        
        .sidebar .accordion-item .accordion-button {
            font-size: 0.5em !important; 
            font-weight: 600 !important;
            padding: 10px 12px !important;
            line-height: 1.2 !important;  
        }
        .sidebar .accordion-item .accordion-button .bs-icon {
            font-size: 1em !important; 
            margin-right: 6px !important;
            vertical-align: text-bottom; /* Better icon alignment */
        }
        
        .accordion-button:not(.collapsed) { background-color: #f8f9fa !important; }
        .accordion-button:focus { box-shadow: none !important; }
        .accordion-body { padding: 10px 12px !important; }
        .form-group { margin-bottom: 10px !important; }
        .sidebar label { font-weight: 500 !important; margin-bottom: 3px !important; display: block; font-size: 0.8rem; }
        
        .highchart-container { padding: 20px; }
        
        .nav-tabs { border-bottom: 1px solid #dee2e6; background-color: #f8f9fa; padding: 0 10px; }
        .nav-tabs .nav-link {
            font-size: 0.85em; padding: 10px 15px; border: 0 !important;
            color: #495057; border-bottom: 3px solid transparent !important;
            margin-right: 2px; border-radius: 4px 4px 0 0 !important;
        }
        .nav-tabs .nav-link.active {
            color: var(--bs-primary) !important;
            font-weight: bold;
            border-bottom: 3px solid var(--bs-primary) !important;
            background-color: #fff !important;
        }
        .tab-content { background-color: #fff; padding: 0px; border: 0;}
        .tab-pane { padding: 0; }
        .tab-pane h4 { margin: 15px 20px 10px 20px; color: #343a40; font-weight: 600; font-size: 1.05em; border-bottom: 1px solid #f0f0f0; padding-bottom: 8px; }
        
        .shiny-output-error-validation { margin: 15px; }
        .bootstrap-select .btn { font-size: 0.85em; padding: 6px 10px; }
        .material-switch-div { padding-top: 8px; margin-bottom: 8px; display: flex; align-items: center; justify-content: space-between; }
        .material-switch-div label { margin-bottom: 0 !important; font-size: 0.9em; }
      "))
           ),
           layout_sidebar(
             sidebar = sidebar(
               width = 300,
               class = "sidebar",
               accordion(
                 id = "sidebar_accordion",
                 open = FALSE, # Start closed
                 accordion_panel(
                   title = tagList(bs_icon("sliders2"), " Main Controls"), value = "main",
                   selectInput("skill_domain", "Select Variable", choices = names(skill_definitions)),
                   pickerInput("group_by", "Group By (for Comparison)", choices = c("Age" = "age_groups", "Gender" = "geslacht", "Education"), multiple = TRUE, options = pickerOptions(noneSelectedText = "Overall (No Grouping)")),
                   tags$div(class = "material-switch-div", checkboxInput("time_view", label = "Show over time"))
                 ),
                 accordion_panel(
                   title = tagList(bs_icon("funnel-fill"), " Sub-Filters"), value = "sub",
                   pickerInput("filter_age", "Filter by Age", choices = levels(data$age_groups), selected = levels(data$age_groups), multiple = TRUE, options = pickerOptions(actionsBox = TRUE, liveSearch = TRUE, size = 8)),
                   pickerInput("filter_gender", "Filter by Gender", choices = levels(data$geslacht), selected = levels(data$geslacht), multiple = TRUE, options = pickerOptions(actionsBox = TRUE, size = 5)),
                   pickerInput("filter_education", "Filter by Education", choices = levels(data$Education), selected = levels(data$Education), multiple = TRUE, options = pickerOptions(actionsBox = TRUE, liveSearch = TRUE, size = 8)),
                   pickerInput("filter_wave", "Filter by Wave", choices = unique(data$wave), selected = unique(data$wave), multiple = TRUE, options = pickerOptions(actionsBox = TRUE, size = 5))
                 )
               )
             ),
             div(class = "main-panel", uiOutput("plots_ui"))
           )
  )
)

# --- 5. Server ---
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    d <- data # Use the globally simulated data
    
    validate(
      need(!is.null(input$filter_age) && length(input$filter_age) > 0, "Please select at least one Age group."),
      need(!is.null(input$filter_gender) && length(input$filter_gender) > 0, "Please select at least one Gender group."),
      need(!is.null(input$filter_education) && length(input$filter_education) > 0, "Please select at least one Education level."),
      need(!is.null(input$filter_wave) && length(input$filter_wave) > 0, "Please select at least one Wave.")
    )
    
    d %>%
      filter(age_groups %in% input$filter_age) %>%
      filter(geslacht %in% input$filter_gender) %>%
      filter(Education %in% input$filter_education) %>%
      filter(wave %in% input$filter_wave) -> d_filtered
    
    validate(need(nrow(d_filtered) > 0, "No data matches the selected filters. Please broaden your selections."))
    d_filtered
  })
  
  group_vars_reactive <- reactive({ input$group_by })
  
  output$plots_ui <- renderUI({
    skill_info <- skill_definitions[[input$skill_domain]]
    vars <- skill_info$vars; short_labels <- skill_info$short_labels; full_labels <- skill_info$full_labels
    group_vars <- group_vars_reactive(); data_to_plot <- filtered_data(); is_time <- input$time_view
    
    missing_vars <- vars[!vars %in% names(data_to_plot)]
    if (length(missing_vars) > 0) {
      return(div(class = "alert alert-danger", 
                 paste("The following required variable(s) for this skill domain are missing from the dataset:", 
                       paste(missing_vars, collapse = ", "))))
    }
    
    if(is_time && length(unique(data_to_plot$wave)) < 2 ) {
      return(div(class = "alert alert-warning", "Line chart needs multiple waves selected/available."))
    }
    
    tab_panels <- lapply(seq_along(vars), function(i) {
      var_name <- vars[i]; tab_label <- short_labels[i]; full_label <- full_labels[i]
      plot_id <- paste0("plot_", gsub("[^A-Za-z0-9]", "", var_name), "_", i)
      
      local({
        my_var_label <- setNames(list(full_label), var_name)
        my_groups <- group_vars; my_data <- data_to_plot; my_time_view <- is_time
        output[[plot_id]] <- renderHighchart({
          create_hc_plot(my_data, my_var_label, my_groups, is_time_view = my_time_view)
        })
      })
      tabPanel(title = tab_label, value = paste0("tab_", i),
               h4(full_label),
               div(class = "highchart-container", highchartOutput(plot_id, height = "480px")))
    })
    
    tagList(
      h2(input$skill_domain),
      do.call(tabsetPanel, c(tab_panels, list(id = "skill_tabs", type = "tabs")))
    )
  })
}

# --- 6. Run App ---
shinyApp(ui = ui, server = server)