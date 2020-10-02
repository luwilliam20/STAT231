library(rvest)
library(methods)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/List_of_justices_of_the_Supreme_Court_of_the_United_States"
tables <- url %>%
  read_html() %>%
  html_nodes("table")

length(tables)

justices <- read_html(url) %>%
  html_table(header = TRUE, fill = TRUE) %>% 
  .[[2]] 

justices <- as.data.frame(justices)

justices1 <- justices %>%
  select(3:ncol(justices))

justices1

write_csv(justices1, "/Users/luwil/OneDrive/Desktop/Assignments, Essays, and Other work-related Documents/Year 3 Semester 1 COVID Edition/Data Science/STAT231/justices.csv")