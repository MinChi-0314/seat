library(httr)
library(tidyverse)

class <- GET("https://raw.githubusercontent.com/MinChi-0314/seat/master/NTU.csv") %>%
  content("text") %>% 
  str_split(pattern = "\r\n") %>% 
  unlist %>% .[-c(1,9)]

#class %>% grep(pattern = "SS301",value=T) %>% str_extract(regex("(?<=,).*"))
