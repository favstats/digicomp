library(dashboardr)

# Minimal example: paginated page with modals
data <- data.frame(
  group = c("A", "A", "B", "B", "C", "C"),
  cat = c("X", "Y", "X", "Y", "X", "Y"),
  val = c(10, 20, 30, 15, 25, 35)
)

viz1 <- create_viz(data) %>%
  add_viz(type = "stackedbar", x_var = "group", stack_var = "cat",
          title = "[Page 1 chart](#modal1){.modal-link}") %>%
  add_modal(modal_id = "modal1", title = "Modal on Page 1",
            modal_content = "This modal should appear on **paginated page 1**.") %>%
  add_pagination()

viz2 <- create_viz(data) %>%
  add_viz(type = "stackedbar", x_var = "group", stack_var = "cat",
          title = "[Page 2 chart](#modal2){.modal-link}") %>%
  add_modal(modal_id = "modal2", title = "Modal on Page 2",
            modal_content = "This modal should appear on **paginated page 2**.")

combined <- combine_viz(viz1, viz2)

db <- create_dashboard(
  title = "Modal Pagination Test",
  output_dir = "minex_output"
) %>%
  add_page("Test", visualizations = combined)

generate_dashboard(db, render = TRUE, open = TRUE)
