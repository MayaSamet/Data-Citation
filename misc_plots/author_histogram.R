library(ggplot2)
library(readr)
library(tidyr)
library(Hmisc)
library(plyr)
library(RColorBrewer)
library(reshape2)




adc_author_ds_totals <- read_csv("adc_author_ds_totals.csv")

ggplot(adc_author_ds_totals,aes(x=number_of_datasets_authored)) + 
  stat_bin(binwidth=1) +
  stat_bin(binwidth=1, aes(label=..count..), vjust=-1.5)


ggplot(data = adc_author_ds_totals, aes(x="stub", y=number_of_datasets_authored)) +
  geom_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
  geom_point(aes(y=number_of_datasets_authored), position = position_jitter(width = .15), size = .5, alpha = 0.8) + 
  geom_boxplot(width = .1, alpha = 0.5, position = position_nudge(x = -.4, y = 0)) 
  #expand_limits(x = 5.25) 

