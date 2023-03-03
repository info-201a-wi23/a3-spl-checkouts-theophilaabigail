library(dplyr)
library(broom)
library(ggplot2)


# What is the most checked out material type?
most_checked_out_material_type <- data %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  pull(MaterialType[1])
cat("The most checked out material type is", most_checked_out_material_type[1], "\n")


# What is the most checked out book?
most_checked_out_book <- data %>% 
  group_by(Title) %>% 
  summarize(total_checkouts = sum(Checkouts)) %>% 
  arrange(desc(total_checkouts)) %>% 
  pull(Title)

cat("The most checked out book is", most_checked_out_book[1], "\n")


# What is the year in which the most checked out material type is books?
most_checked_out_year <- data %>%
  filter(MaterialType == "BOOK") %>%
  group_by(CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  pull(CheckoutYear)
cat("The year in which the most checked out material type is books is", most_checked_out_year[1], "\n")


# What is the year in which the most usage class checked out is digital?
year_most_usage_class <- data %>% 
  filter(UsageClass == "Digital") %>% 
  group_by(CheckoutYear) %>% 
  summarize(total_checkouts = sum(Checkouts)) %>% 
  arrange(desc(total_checkouts)) %>% 
  pull(CheckoutYear)
cat("The year in which the most usage class checked out is digital is", year_most_usage_class[1], "\n")


# What is the top 3 publishers based on the most number of check outs?
top_publishers <- data %>% 
  group_by(Publisher) %>% 
  summarize(total_checkouts = sum(Checkouts)) %>% 
  arrange(desc(total_checkouts))

top_1 <- top_publishers$Publisher[1]
top_2 <- top_publishers$Publisher[2]
top_3 <- top_publishers$Publisher[3]
cat("The top 3 publishers based on the most number of check outs are", top_1, "," , top_2, ", and" , top_3 )
