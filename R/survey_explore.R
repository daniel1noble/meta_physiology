
## Survey Analysis

# Load libs
	pacman::p_load(tidyverse, flextable, ggplot2)

# Load data
	data <- read.csv("./data/MA_CompPysio_Survey.csv")
# Have a look
	data %>% glimpse()

# Lets just subset to the main questions for simplicity

	data2 <- data %>% select(!grep("Comment", colnames(data)))

# Just some simple plots. Ok, needs some cleaning looking at this. Studies often used multiple effects

	ggplot(data2, aes(x = Q2.1_EffectUsed)) + 
		geom_histogram(stat = "count") +
		theme(axis.text = element_text(size =6))


