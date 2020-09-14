library(tidyverse)
library(httr)
library(readxl)

## import class size
class <- GET("https://raw.githubusercontent.com/MinChi-0314/seat/master/NTU.csv") %>%
  content("text") %>% 
  str_split(pattern = "\r\n") %>% 
  unlist %>% .[-c(1,9)]

## deal with student list 
data <- read_xlsx("C:/Users/Username/Desktop/1091_統計學暨實習_修課學生名單_選課結果202009082144.xlsx")[-c(1:3),c(3,6)]
colnames(data) <- c("department", "name")




