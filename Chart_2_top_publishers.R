# Load library

library(ggplot2)
library(dplyr)

# Load the dataset 
df2 <- read.csv("/Users/theophilasetiawan/Downloads/2017-2023-10-Checkouts-SPL-Data.csv")

# Filter the data frame to include only book MaterialType
books <- filter(df2, MaterialType == "BOOK")

# Group the filtered data frame by Publisher, and sum the Checkouts for each publisher across all years
books_by_publisher <- books %>%
  group_by(Publisher) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  slice(1:10)

# Group the books data frame by CheckoutYear and Publisher, and sum the Checkouts for each publisher and year
books_by_publisher_year <- books %>%
  group_by(Publisher, CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  filter(Publisher %in% books_by_publisher$Publisher)

# Create a plot of total checkouts for each publisher by year
ggplot(books_by_publisher_year, aes(x = CheckoutYear, y = total_checkouts, fill = Publisher)) +
  geom_col(position = "dodge") +
  geom_line(position = "dodge") +
  scale_fill_manual(values = c("#2196F3", "#FFC107", "#4CAF50", "#9C27B0", "#FF5722", "#607D8B", "#8BC34A", "#E91E63", "#00BCD4", "#3F51B5")) +
  facet_wrap(~ Publisher, scales = "free_y") +
  ggtitle("Top 10 Publishers by Checkouts Throughout the Years") +
  xlab("Checkout Year") +
  ylab("Total Checkouts")
