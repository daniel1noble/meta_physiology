
## Survey Analysis

# Load libs
	pacman::p_load(tidyverse, flextable, ggplot2)

# Load data
	data <- read.csv("./data/MA_CompPysio_Survey.csv")
# Have a look
	data %>% glimpse()