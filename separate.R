data <- read_xlsx("C:/Users/Username/Desktop/2020Fall_Statistics_成績登記_20201013.xlsx")[-c(144,145),c(1,4,5)]
colnames(data) <- c("department", "name", "class")

## Seperare by ClassA,B
classB <- data %>% filter(class=="B")
classA <- setdiff(data, classB)
