# Imported libraries
library(tidyverse)

# Read CSV file
yearly <- read_csv("data/yearly_deaths_by_clinic.csv")

monthly <- read_csv("data/monthly_deaths.csv")

# Pre-view data
head(yearly)

head(monthly)

# Add proportion of deaths column
yearly <- yearly %>%
			mutate(proportion_deaths = deaths / births)
yearly
monthly <- monthly %>%
			mutate(proportion_deaths = deaths / births)
monthly

# create chart for yearly and monthly
ggplot(yearly, aes(x = year , y =proportion_deaths, color = clinic)) +
	geom_line() 
	
ggplot(monthly, aes(date, proportion_deaths)) +
	geom_line() +
	labs(x = "Year", y = "Proportion of deaths")

# Add handwashing started and create chart for watch trend of proportion death
handwashing_start = as.Date('1847-06-01')

monthly <- monthly %>%
	mutate(handwashing_started = date >= handwashing_start)
monthly 

ggplot(monthly, aes(x = date, 
					y = proportion_deaths, 
					color = handwashing_started)) +
	geom_line()

# Calcualte mean of proportion before and after handwashing
monthly_summary <- monthly %>% 
					group_by(handwashing_started) %>%
					summarize(mean(proportion_deaths))
monthly_summary
