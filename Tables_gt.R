# Author: Elke van Daal
# Goal: Make GT tables

#Load required packages
library(tidyverse)
library(gt)
library(sjPlot)
library(gapminder)
library(flextable)
library(webshot)

# check data
data(gapminder)
gapminder

# create constants 
n = 0
c_col = c("#1e3048", "#274060", "#2f5375", "#4073a0", "#5088b9")
c_col_light_blue = c("#edf2fb", "#e2eafc", "#d7e3fc", "#ccdbfd", "#c1d3fe")
c_container_width = px(800)
c_table_width = px(650)
c_rn = 30
c_save = TRUE
c_format = "html"

# show data header, sorted by year, adding grouping column
gt_tab <- gapminder %>% 
  arrange(-year) %>% 
  head(c_rn) %>% 
  filter(continent %in% c("Asia", "Europe", "Americas")) %>%
  gt(
    groupname_col = "continent",
    rowname_col = "Country"
  )

# adding summary rows
gt_tab <- gt_tab %>% 
  summary_rows(
    columns = c("lifeExp", "pop", "gdpPercap"), 
    fns = list(
      Sum = ~sum(.),
      Average = ~mean(.),
      "Standard Deviation" = ~sd(.)
    )
  )

# changing column labels 
gt_tab <- gt_tab %>% 
  cols_label(
    country = md("Country"),
    year = md("Year"),
    lifeExp = md("Life Expectancy"),
    pop = md("Population"),
    gdpPercap = md("GDP per Capita")
  )

# Formating columns
gt_tab <- gt_tab %>% 
  fmt_currency(
    columns = "gdpPercap",
    currency = "USD",
    decimals = 0
  ) %>% 
  fmt_number(
    columns = c("lifeExp", "pop"),
    suffixing = F,
    decimals = 0
  ) %>% 
  cols_align(
    align = "right",
    columns = "pop"
  ) %>% 
   cols_width(
    (country) ~ px(150),
    (year) ~ px(100),
    (lifeExp) ~ px(100),
    (pop) ~ px(150),
    (gdpPercap) ~ px(150),
  ) %>% 
  opt_row_striping()

# adding title and footnotes
gt_tab <- gt_tab %>% 
  tab_header(
    title = "DATA FROM GAPMINDER",
    subtitle = "Selected values for life expectancy, GDP per capita,
  and population, from the Gapminder data set."
  ) %>% 
  tab_footnote(
    footnote = "The lowest by population.",
    locations = cells_body(
      columns = "pop",
      rows = pop == min(pop)
    )
  ) %>% 
  tab_footnote(
    footnote = "In the full data set data for years 1952 to 2007 is available.",
    locations = cells_column_labels(columns = year)
  ) %>%
  tab_source_note(
    source_note = md("Source: Data from Gapminder, *Jennifer Bryan*, https://doi.org/10.5281/zenodo.594018")
  )

# table formatting
# text font, size, color and borders ----
gt_tab_fancy <- gt_tab %>%
  tab_options(
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
        size = px(38),
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
        size = px(18),
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
        size = px(18)
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
        font = "Bloomsbury"
      )
    ),
    locations = list(
      cells_column_labels(everything())
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
      cells_stubhead()   #what is this?
    )
  ) %>% 
  tab_style(
    style = list(
      cell_text(
        font = "Bloomsbury", size = px(16), 
        color = "#2f5375")
    ),
    location = list(
      cells_body(columns = country)
    )
  ) 

# Save gt table
gtsave(gt_tab_fancy, filename = 'gt_tab.html')
gtsave(gt_tab, filename = 'gt_tab.png')
gtsave(gt_tab_fancy, filename = 'gt_tab.rtf')
gtsave(gt_tab_fancy, filename = 'gt_tab.docx')

