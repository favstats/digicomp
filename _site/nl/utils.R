thecolors <<- c(
  "#F7A35C",    # Light orange
  "#ADD8E6",    # Light blue
  "#E9BB97",    # Soft amber
  "#E4D354",    # Light mustard
  "#90EE90",    # Light green
  "#1F78B4",    # Bluish
  "#F4A8A8",    # Pale red
  "#C29EC4",    # Pastel purple
  "#FFD966",    # Light gold
  "#B2DFEE",    # Light sky blue
  "#FFB6C2",    # Light pink
  "#B0E0C6"     # Powder blue
)

require(dplyr)
require(forcats)   # for recode_factor
# thecolors

recode_survey <- function(df) {
  
  # -----------------------------
  # 1) SKILL ITEMS: coerce to numeric IN PLACE and set 66/99 -> NA
  # -----------------------------
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
  
  # -----------------------------
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
  # -----------------------------
  # 3) SUBSCALES (using IN-PLACE skill vars; no ...N names)
  # -----------------------------
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

  
  # -----------------------------
  # 4) TOTAL KNOWLEDGE SCORE (sum of *RC columns you listed)
  # -----------------------------
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

## TODO: Knowledge question seem perhaps incorrect and are missing sometimes across waves

data_w1 <- read_csv2("../../data/DigCom24CompleteWithWeights.csv") %>% #table()
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
    geslacht == 1 ~"1",
    geslacht == 2 ~"2",
    T ~ NA_character_
  )) %>% 
  mutate(Education = EducationR) %>% 
  mutate(Education = fct_relevel(Education, c("Low", "Middle", "High"))) %>% 
  recode_survey()

data <- read_csv2("../../data/DigCom25CompleteWithWeights.csv") %>% #table()
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
    Gender == 1 ~"1",
    Gender == 2 ~"2",
    T ~ NA_character_
  )) %>% 
  mutate(Education = EducationR) %>% 
  mutate(Education = fct_relevel(Education, c("Low", "Middle", "High"))) %>% 
  recode_survey()



std.error <- function(x) sd(x, na.rm =T)/sqrt(length(x))


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




plot_to_html <- function(plot) {
  if (is.null(plot)) {
    cat("NULL plot detected!\n")
    return("NULL plot")
  }
  as.character(tags$div(
    class = "flex-item2",
    htmltools::tagList(plot)
  ))
}


generate_quarto_elements <- function(list_of_plots, plots_per_page = 2) {
  
  
  num_plots <<- length(list_of_plots)
  num_pages <<- ceiling(num_plots / plots_per_page)
  
  # for (page in 1:num_pages) {
  #   start_index <- (page - 1) * plots_per_page + 1
  #   end_index <- min(page * plots_per_page, num_plots)
  #   
  #   plots_for_page <- list_of_plots[start_index:end_index]
  #   
  #   html_content <<- paste(
  #     '<table style="width:100%; border-spacing: 1px;">',
  #     '<tr>',
  #     paste(
  #       lapply(plots_for_page, function(plot) {
  #         plot_html <- plot_to_html(plot)
  #         if (str_detect(plot_html, "NULL")) {
  #           cat("NULL detected in plot HTML!\n")
  #         }
  #         paste0('<td style="width:50%; vertical-align: top;">', plot_html, '</td>')
  #       }),
  #       collapse = "\n"
  #     ),
  #     '</tr>',
  #     '</table>'
  #   ) 
  #   
  #   istherenull2 <<- str_detect(html_content, "NULL")
  #   
  #   if(!is.null(html_content)){
  #     cat(paste0("### ", page, "\n"))
  #     cat(html_content)
  #   }
  # }
  page <- 0
  list_of_plots %>% 
    walk(~{
      page <<- page + 1
      # if(!is.null(html_content)){
      cat(paste0("### ", page, "\n"))
      cat(plot_to_html(.x))
      # }
    })
  
}

viz_general <- function(vars, var_labels, categories_dat, grpvar = NULL, groups = F, range1=1:2, range2=3, range3=4:5, weight_var = NULL, stacked = T) {
  
  
  if(groups){
    # varlabdat <- data %>%
    #   select(vars) %>%
    #   names() %>%
    #   tibble(key = ., varlabs = var_labels)
    
    fin <- data %>%
      select(vars, thevar = grpvar, weight_var) %>%
      drop_na() %>% 
      set_names(c(var_labels, "thevar", "weight_var"))
    
    media_rec_ages <- fin %>%
      gather(key, value,-thevar, -weight_var) %>%
      mutate(value = as.numeric(value)) %>% 
      mutate(
        value = case_when(
          value %in% range1 ~ categories_dat[3],
          value %in% range2 ~ categories_dat[2],
          value %in% range3 ~ categories_dat[1]
        )
      ) %>%
      count(key, thevar, value, wt = weight_var) %>%
      group_by(key, thevar) %>%
      mutate(perc = n / sum(n) * 100, total = sum(n)) %>%
      ungroup() %>% 
      drop_na()
  } else {
    fin <<- data %>% 
      select(vars, weight_var) %>% 
      
      drop_na() %>% 
      set_names(var_labels, "weight_var")
    
    media_rec <<- fin %>% 
      gather(key, value, -weight_var) %>% 
      mutate(value = as.numeric(value)) %>% 
      mutate(value = case_when(
        value %in% range1 ~ categories_dat[3],
        value %in% range2 ~ categories_dat[2],
        value %in% range3 ~ categories_dat[1]
      )) %>% 
      group_by(key) %>% 
      count(value, wt = weight_var) %>% 
      ungroup()  %>%
      mutate(value = fct_relevel(value, categories_dat)) %>%
      group_by(key) %>%
      mutate(perc = n/sum(n)*100, total = sum(n)) %>%
      ungroup() %>% 
      drop_na()
    
    theorder <<- media_rec %>% 
      filter(value == categories_dat[3]) %>% 
      distinct(key, .keep_all = T) %>% 
      arrange(desc(perc)) %>% 
      pull(key) 
  }
  
  if(groups){
    hc <<- media_rec_ages %>% 
      mutate(key = fct_relevel(key, theorder)) %>%
      arrange(key) %>%
      pull(key) %>% 
      levels() %>% 
      map(~{
        hc <- media_rec_ages %>%
          filter(key == .x) %>%
          mutate(value = fct_relevel(value, categories_dat)) %>%
          hchart("bar", hcaes(x = thevar, y = perc, group = value, custom = n, totalCount = total)) %>%
          hc_title(text = .x) %>%
          hc_chart(style = list(width = "100%", height = "100%"))  %>% 
          hc_plotOptions(bar = list(stacking = "percent")) %>%
          hc_yAxis(title = list(text = ""), max = 100) %>%
          hc_colors(colors) %>%
          hc_xAxis(title = list(text = "")) %>%
          hc_legend(enabled = TRUE) %>%
          hc_plotOptions(
            column = list(
              colorByPoint = TRUE
            ),
            series = list(
              tooltip = list(
                useHTML = TRUE,
                pointFormat = '<div style="min-width:220px"><div style="font-weight:600;margin-bottom:4px">{point.category}</div><div>{series.name}: <b>{point.y:.1f}%</b><br/><small>({point.custom:.0f} of {point.totalCount:.0f} respondents)</small></div></div>'
              ),
              dataLabels = list(
                enabled = TRUE,
                format = '{y:.0f}%',
                color = 'white',
                style = list(
                  fontSize = '10px',
                  fontWeight = 'bold'
                ),
                inside = TRUE,
                verticalAlign = 'middle',
                align = 'center',
                filter = list(
                  property = 'y',
                  operator = '>',
                  value = 5
                )
              )
            )
          ) %>%
          hc_caption(
            text = paste0("<em>N = ", nrow(fin), ".</em>"),
            align = "right",
            style = list(fontSize = '10px', color = 'lightgrey')
          ) %>%
          hc_exporting(
            enabled = TRUE,
            buttons = list(contextButton = list(menuItems = myMenuItems))
          )
        
        hc$x$hc_opts$series <- lapply(hc$x$hc_opts$series, function(series) {
          if (series$name == categories_dat[3]) {
            series$legendIndex <- 0
          } else if (series$name == categories_dat[2]) {
            series$legendIndex <- 1
          } else if (series$name == categories_dat[1]) {
            series$legendIndex <- 2
          }
          return(series)
        })
        
        return(hc)
      })
    
  } else {
    hc <- media_rec %>%
      mutate(key = fct_relevel(key, theorder)) %>%
      arrange(key) %>%
      hchart("bar", hcaes(x = key, y = perc, group = value, custom = n, totalCount = total))  %>%
      hc_colors(colors) %>%
      hc_xAxis(title = list(text = "")) %>%
      hc_legend(enabled = TRUE) %>%
      hc_plotOptions(
        column = list(
          colorByPoint = TRUE
        ),
        series = list(
          tooltip = list(
            useHTML = TRUE,
            pointFormat = '<div style="min-width:220px"><div style="font-weight:600;margin-bottom:4px">{point.category}</div><div>{series.name}: <b>{point.y:.1f}%</b><br/><small>({point.custom:.0f} of {point.totalCount:.0f} respondents)</small></div></div>'
          ),
          dataLabels = list(
            enabled = TRUE,
            format = '{y:.0f}%',
            color = 'white',
            style = list(
              fontSize = '12px',
              fontWeight = 'bold'
            ),
            inside = TRUE,
            verticalAlign = 'middle',
            align = 'center',
            filter = list(
              property = 'y',
              operator = '>',
              value = 5
            )
          )
        )
      ) %>%
      hc_caption(
        text = paste0("<em>N = ", nrow(fin), ".</em>"),
        align = "right",
        style = list(fontSize = '10px', color = 'lightgrey')
      ) %>%
      hc_exporting(
        enabled = TRUE,
        buttons = list(contextButton = list(menuItems = myMenuItems))
      )
    
    if(stacked){
      hc <- hc %>% 
        hc_plotOptions(bar = list(stacking = "percent")) %>%
        hc_yAxis(title = list(text = ""), max = 100)
    } else {
      hc <- hc %>%
        hc_yAxis(title = list(text = ""), max = max(media_rec$perc)+5)
    }
    
    hc$x$hc_opts$series <- lapply(hc$x$hc_opts$series, function(series) {
      if (series$name == categories_dat[3]) {
        series$legendIndex <- 0
      } else if (series$name == categories_dat[2]) {
        series$legendIndex <- 1
      } else if (series$name == categories_dat[1]) {
        series$legendIndex <- 2
      }
      return(series)
    })
  }
  
  if(groups){
    generate_quarto_elements(hc, plots_per_page = 2)
  } else {
    return(hc)
  }
  
  
}

vecc <- function(name, num) {
  paste0(name, num)
}


# polvals <- read_sav("../../cv23o_EN_1.0p.sav") %>% 
#   mutate(left_right = cv23o101) #%>% 
# # mutate(left_right = ifelse(is.na(left_right), "99", left_right))
# 
# data <- read_sav("../../L_AlgoSoc_wave1_1.0p.sav") %>% #table()
#   mutate(age_groups = case_when(
#     leeftijd %in% 16:17 ~ "16-17",
#     leeftijd %in% 18:24 ~ "18-24",
#     leeftijd %in% 25:34 ~ "25-34",
#     leeftijd %in% 35:44 ~ "35-44",
#     leeftijd %in% 45:54 ~ "45-54",
#     leeftijd %in% 55:64 ~ "55-64",
#     leeftijd %in% 65:150 ~ "65+",
#   )) %>% 
#   left_join(polvals %>% select(nomem_encr, left_right)) %>% 
#   mutate(pol_cat = case_when(
#     left_right %in% 0:3 ~ "Links",
#     left_right %in% 4:6 ~ "Centrum",
#     left_right %in% 7:10 ~ "Rechts"
#   )) %>% 
#   mutate(geslacht = sjmisc::to_label(geslacht)) %>% 
#   # mutate(geslacht = case_when(
#   #   geslacht == "Vrouw" ~ "Woman",
#   #   geslacht == "Anders" ~ "Other",
#   #   T ~ geslacht
#   # )) %>% 
#   mutate(geslacht = fct_relevel(geslacht, c("Man", "Vrouw", "Anders"))) %>% 
#   arrange(geslacht)  %>% 
#   mutate(oplcat = sjmisc::to_label(oplcat)) %>% 
#   # left_join(education_levels) %>%
#   # mutate(oplcat = eng) %>%
#   # mutate(oplcat = fct_relevel(oplcat, c("Primary (basisonderwijs)",
#   #                                       "Pre-Vocational (vmbo)",
#   #                                       "Secondary (havo/vwo)",
#   #                                       "Vocational (mbo)",
#   #                                       "Applied Sciences (hbo)",
#   #                                       "University (wo)"))) %>% 
#   mutate(pol_cat = fct_relevel(pol_cat, c("Links", "Centrum", "Rechts")))  %>% 
#   mutate(important1 = sjmisc::to_label(ADSVR_1))



colors <- c("#2ca02c", "#1f77b4", "#ff7f0e") # Add more colors if needed

# Create a stacked bar chart with highcharter
myMenuItems <- c("downloadPNG", "downloadJPEG", "downloadSVG", "downloadPDF")


