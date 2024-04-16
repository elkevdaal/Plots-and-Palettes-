# Author: Elke van Daal
# Goal: create own color pallette for future use

# load packages
library(tidyverse)
library(ggthemes)
getwd()

# load data
wage <- ISLR::Wage

# create color pallette
my_pal <- c('#E63946', '#F1FAEE','#A8DADC', '#457B9D', '#1D3557')

# create basic plot
basic_plot <- ggplot(wage, aes(health_ins, fill = health_ins)) +
  geom_bar(color = 'black', linewidth = 0.7) +
  ggtitle('basic plot') +
  theme_classic()

basic_plot + scale_fill_manual(values = c('#E63946', '#457B9D')) +
  theme(plot.background = element_rect(color = 'white', fill = 'white'),
        strip.background = element_rect(color = 'white', fill = 'white'),
        panel.background = element_rect(color = 'black', fill = '#F1FAEE'))
?element_rect()
my_pal[1]

#####END#####
  