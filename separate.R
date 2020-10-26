data <- read_xlsx("C:/Users/Username/Desktop/2020Fall_Statistics_成績登記_20201013.xlsx")[-c(144,145),c(1,4,5)]
colnames(data) <- c("department", "name", "class")

## Seperare by ClassA,B
classB <- data %>% filter(class=="B")
classA <- setdiff(data, classB)

## Random
class <- sample(c(rep("SS302",24),rep("SS305",40),rep("SS306",40),rep("SS307",40)))
data <- cbind(data, class)
