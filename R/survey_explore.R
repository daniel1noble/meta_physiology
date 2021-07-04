## Survey Analysis

# Load libs
pacman::p_load(tidyverse, flextable, ggplot2, janitor, ggalluvial)

# Load data
data <- read.csv("./data/MA_CompPysio_Survey.csv")
# Have a look
data %>% glimpse()

# Lets just subset to the main questions for simplicity

data2 <- data %>% select(!grep("Comment", colnames(data)))

# Have a look at frequency and stuff
data2 %>% tabyl(Q2.2_ContVariable)

# Just some simple plots. Ok, needs some cleaning looking at this. Studies often used multiple effects

data2 %>% tabyl(Q2.1_EffectUsed) %>%
  summarise(SMD = if_else(grepl("SMD", Q2.1_EffectUsed), n, 0),
            lnRR = if_else(grepl("Response Ratio", Q2.1_EffectUsed), n, 0),
            r = if_else(grepl("correlation", Q2.1_EffectUsed), n, 0),
            other = if_else(grepl("unclear/other", Q2.1_EffectUsed), n, 0)) %>% colSums(.)


ggplot(data2, aes(x = Q2.1_EffectUsed)) + 
  geom_histogram(stat = "count") +
  theme(axis.text = element_text(size =6))


data2 %>% ggplot(aes(x = Q1.4, fill = Q2.4_WeightedModel)) +
  geom_bar() +
  labs(x = 'Year', fill = 'Model weighting') +
  scale_x_continuous(breaks = 2014:2020) +
  scale_fill_discrete(labels = c('unclear', 'unweighted', 'weighted')) +
  theme_bw()


data2 %>%
  mutate(Q2.4_short = factor(Q2.4_WeightedModel, labels = c('unclear/other', 'unweighted', 'weighted'))) %>%
  ggplot(aes(axis2 = Q2.2_ContVariable, axis1 = Q2.4_short)) +
  geom_alluvium(aes(fill = Q2.4_short), width = 1/4) +
  theme_minimal() +
  theme(legend.position = 'none', panel.grid = element_blank(), axis.text.y = element_blank()) +
  scale_fill_manual(values = c('red','orange','blue')) +
  geom_stratum(fill = 'black', colour = 'darkgrey', width = 1/5) +
  geom_text(stat = 'stratum',
            aes(label = after_stat(stratum)),
            # label = c('weighted', 'unweighted', 'unclear'),
            colour = 'darkgrey', angle = c(90,90,0,0,0,0)) +
  scale_x_discrete(limits = c('Model weigthing', 'Cont. var.'), expand = c(.05, .05))
