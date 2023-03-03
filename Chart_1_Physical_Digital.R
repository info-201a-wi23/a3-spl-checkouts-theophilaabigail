library(ggplot2)
library(dplyr)

df <- read.csv("/Users/theophilasetiawan/Downloads/2017-2023-10-Checkouts-SPL-Data.csv")

# filter the data frame to include only physical and digital UsageClass
physical_digital <- filter(df, UsageClass %in% c("Physical", "Digital"))

# group the filtered data frame by UsageClass and CheckoutYear, and sum the Checkouts for each class and year
usage_by_type_year <- physical_digital %>%
  group_by(UsageClass, CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts))

# create a line plot of the total checkouts by usage class and year
ggplot(usage_by_type_year, aes(x = CheckoutYear, y = total_checkouts, color = UsageClass)) +
  geom_line() +
  scale_color_manual(values = c("#FFC107", "#4CAF50")) +
  labs(title = "Difference in Number of Checkouts by Usage Class and Year",
       x = "Year",
       y = "Total Checkouts",
       color = "Usage Class")
