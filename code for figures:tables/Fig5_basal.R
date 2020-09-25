# basal area figure
# fig 
library(tidyverse)
library(cowplot)
library(here)
theme_set(theme_cowplot())
options(scipen = 9999)

ba <- read.csv(here("ba.csv"), stringsAsFactors = F)

ba$SITE[ba$SITE == "DALTON"] <- "Upland"
ba$SITE[ba$SITE == "STEESE"] <- "Lowland"

plot_ba <- ba %>%
  group_by(SITE, TREAT, PLOT, DIV) %>%
  summarise(BA_ha = mean(BA_ha))

plot_ba %>%
  filter(TREAT != 0) %>%
  ggplot(aes(x = as.factor(TREAT), y = BA_ha, fill = DIV)) + 
  geom_boxplot() + facet_wrap(~SITE)   + 
  labs(x = "Number of Fires", y = "Basal Area (m2/ha)", 
       title = "Av. Basal Area in Burned Plots") + 
  scale_fill_manual(values = c("#f0f0f0", "#bdbdbd"),
                     name = "Division",
                     labels = c("Conifer", "Deciduous"))
# export manually with 650 x 350, no aspect ratio
# name = ba_fig.png

