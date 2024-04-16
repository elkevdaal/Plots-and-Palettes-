# Author: Elke van Daal
# Goal: Create own Plot-theme

# load packages
library(tidyverse)
library(ggthemes)

# create fake dataset
score <- rnorm(100, 50, 10)
time <- rnorm(100, 10, 3)
name <- LETTERS[1:10]
cluster <- rep(name, 10)
df <- tibble(score, time, cluster)
df

# create basic plot
basic_plot <- ggplot(df, aes(time, score, color = cluster)) +
  geom_point() +
  ggtitle('basic plot') 

# add existing theme to basic plot
basic_plot + theme_stata()
basic_plot + theme_bw()
basic_plot + theme_gdocs()
basic_plot + theme_few()
basic_plot + theme_calc()

# add theme to basic plot
basic_plot + 
  #text themes
  theme(
  axis.title = element_text(
    size = 10 ,
    family = 'sans',
    color = 'deepskyblue3',
    face = 'plain'
    ),
  title = element_text(
    size = 14,
    family = 'sans' ,
    color = 'deepskyblue3',
    face = 'plain'),
  axis.text.x = element_text(
    color = 'black',
    size = 7,
    face = 'plain'
  ),
  axis.text.y = element_text(
    color = 'black',
    size = 7,
    face = 'plain'
  ),
  #line themes
  axis.ticks = element_blank(),
  panel.grid = element_blank(),
  #rect themes
  panel.background = element_rect(
    color = 'deepskyblue3', fill = 'azure'),
  strip.background = element_rect(
    color = ''),
  plot.background = element_rect(
    fill = 'white'),
  #legend 
  legend.position = 'right',
  legend.background = element_blank(),
  legend.key = element_blank(),
  legend.text = element_text(
    color = 'black',
    size = 7
  ),
  legend.title = element_text(
    size = 10
  )
)


