library(httr)
library(rvest)
library(stringr)
library(tidyverse)

GET("https://raw.githubusercontent.com/MinChi-0314/seat/master/%E6%95%99%E5%AE%A4%E8%A6%8F%E6%A0%BC.R") %>%
  content("text") %>% 
  gsub(pattern = "\r\n", replacement = "")