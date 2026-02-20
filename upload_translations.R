# Upload translations.csv to Google Sheets
# Run this script in RStudio (interactive session) - it will open a browser for auth.

library(googlesheets4)
library(readr)

# Authenticate (opens browser)
gs4_auth()

# Read the local translations file
translations <- read_csv("translations.csv", show_col_types = FALSE)

# Write to the Google Sheet
# The published CSV URL from dashboard.R points to this sheet.
# If this URL doesn't work for writing, replace with the edit URL from your browser, e.g.:
# sheet_url <- "https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID/edit"
sheet_url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRHn6F7oL_0WCNdlwvV5WvT8JtT-XRKO2YQ8zX1zJbbPkznXGEVbXC80F4fC0NUjWK87kdirUXn6eLh/pub?gid=1284654467&single=true&output=csv"

sheet_write(translations, ss = sheet_url, sheet = 1)

message("Done! translations.csv uploaded to Google Sheets.")
