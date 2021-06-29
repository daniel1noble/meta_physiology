
## Survey Analysis

# Load libs
	pacman::p_load(tidyverse, flextable, ggplot2, janitor)

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


 
