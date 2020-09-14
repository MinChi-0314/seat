library(dplyr)
library(stringi)

########## Parameters ##########
### Size of class
class101 <- c(5,9,5,17)
class403 <- c(2,6,2,14)
class502 <- c(2,6,2,14)

getwd() %>% 
  sub("Documents",replacement = "Google ¶³ºÝµwºÐ/NTU/Campus",.) %>%
  paste0(.,"/classSize.Rdata") %>%
  save(class101, class403, class502, file= .)