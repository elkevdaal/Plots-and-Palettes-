# Author: Elke van Daal
# Goal: Example of own gt theme to use for beautifying tables

# load packages
library(gt)
library(gapminder)
library(tidyverse)

# Create a gt Table from the S&P Data Set
data("sp500")
gt_500 <- sp500 %>% 
  head() %>% 
  gt() %>% 
  tab_header(
    title = "Daily S&P 500 Index data",
    subtitle = "This dataset provides daily price indicators for the S&P 500 index from the beginning of 1950 to the end of 2015. "
  ) 

# Define constants 
n = 0
c_col = c("#1e3048", "#274060", "#2f5375", "#4073a0", "#5088b9")
c_col_light_blue = c("#edf2fb", "#e2eafc", "#d7e3fc", "#ccdbfd", "#c1d3fe")
c_container_width = px(800)
c_table_width = px(650)
c_rn = 30
c_save = TRUE
c_format = "html"

# Create a theme
my_theme <- function(data) {
  c_col = c(c_col[1], "#274060", "#2f5375", "#4073a0", "#5088b9")
  tab_options(
    data = data,
    table.font.name = "Optima",
    table.font.color = c_col[1],
    table.border.top.style = "none",
    table.border.bottom.style = "solid",
    table.border.bottom.color = c_col[2],
    table.border.bottom.width = px(3),
    column_labels.border.top.color = "white",
    column_labels.border.top.width = px(3),
    column_labels.border.bottom.color = c_col[2],
    column_labels.border.bottom.width = px(3),
    data_row.padding = px(10)
  ) %>% 
    tab_style(
      style = list(
        cell_text(
          size = px(24),
          weight = "normal",
          align = "left",
          font = "Bloomsbury"
        )
      ),
      locations = list(
        cells_title(groups = "title")
      )
    ) %>% 
    tab_style(
      style = list(
        cell_text(
          size = px(16),
          align = "left"
        )
      ),
      locations = list(
        cells_title(groups = "subtitle")
      )
    ) %>% 
    tab_style(
      style = list(
        cell_text(
          size = px(13)
        ),
        cell_borders(
          sides = c("bottom", "top"),
          color = c_col[1],
          weight = px(1)
        )
      ),
      locations = list(
        cells_body(gt::everything())
      )
    ) %>% 
    tab_style(
      style = list( 
        cell_text(
          size = px(14),
          color = "#2f5375",
          font = "Bloomsbury",
          weight = 'bold'
        )
      ),
      locations = list(
        cells_column_labels(everything())
      )
    ) %>% 
    tab_style(
      style = list( 
        cell_text(
          size = px(14),
          color = "#2f5375",
          font = "Bloomsbury",
          weight = 'bold'
        ),
        cell_borders(
          sides = c("bottom"),
          style = "solid",
          color = c_col[1],
          weight = px(2)
        )
      ),
      locations = list(
        cells_row_groups(gt::everything())
      )
    ) %>% 
    tab_style(
      style = list( 
        cell_text(
          size = px(16),
          color = "#2f5375",
          font = "Bloomsbury"
        ),
        cell_borders(
          sides = c("bottom", "right"),
          style = "solid",
          color = "white",
          weight = px(1)
        )
      ),
      locations = list(
        cells_stub(gt::everything()),
        cells_stubhead()
      )
    ) %>% 
    tab_style(style = list( 
      cell_text(
        size = px(12),
        color = "#2f5375",
        font = "Bloomsbury"
      ),
      cell_borders(
        sides = c("bottom", "right"),
        style = "solid",
        color = "white",
        weight = px(1)
      )
    ),
    locations = cells_footnotes()
    ) %>%
    opt_row_striping() %>%
    opt_table_font(
      font = list(
        google_font(name = "Merriweather"),
        "Cochin", "serif"
      )
    ) %>%
    opt_all_caps(
      all_caps = TRUE,
      locations = c("column_labels", "row_group")
    )
}

# apply my_theme to gt table
gt_500 <- sp500 %>% 
  head() %>% 
  gt() %>% 
  tab_header(
    title = "Daily S&P 500 Index data",
    subtitle = "This dataset provides daily price indicators for the S&P 500 index from the beginning of 1950 to the end of 2015. "
  ) %>% 
  my_theme()


