library(tidyverse)
library(httr)
library(readxl)
#### Setting
## path to get tex (or ctx) file
path <- "D:/"
date <- ""
filname <- paste0(date, "座位表.ctx")

## deal with student list 
data <- read_xlsx("D:/1091_統計學暨實習_修課學生名單_選課結果202009082144.xlsx")[-c(1:3),c(3,6)]
colnames(data) <- c("department", "name")

#### Generate code
## import class size
classData <- GET("https://raw.githubusercontent.com/MinChi-0314/seat/master/NTU.csv") %>%
  content("text") %>% 
  str_split(pattern = "\r\n") %>% 
  unlist %>% .[-c(1,9)]

## seat code

## total code
code <- function(data, class, separate = TRUE, ailseSpace = "", seatSpace = TRUE, date = NULL){
  date <- ifelse(nchar(date)==0, date <- "{\\color{white}0}", date <- paste0("Date: ", date))
  paste0("\\documentclass[12pt]{article}\n",
         "\\renewcommand{\\baselinestretch}{2.25}\n",
         "\\topmargin=0pt\n",
         "\\headsep=0pt\n",
         "\\voffset=-1.5cm\n",
         "\\textheight=25cm\n",
         "\\textwidth=18cm\n",
         "\\oddsidemargin=0cm\n",
         "\\marginparwidth=0cm\n",
         "\\marginparsep=0cm\n\n",
         "\\usepackage[T1]{fontenc}\n",
         "\\usepackage[osf]{MinionPro}\n",
         "\\usepackage{MyriadPro}\n\n",
         "\\usepackage{color}\n",
         "\\fboxsep=5pt\n\n",
         "\\usepackage{pdflscape}\n",
         "\\thispagestyle{empty}\n\n",
         "\\begin{document}\n",
         "\\begin{landscape}\n",
         "\\begin{center}\n",
         "\\fbox{\\hspace{5cm}黑板\\hspace{5cm}}\\\\[-1cm]\n",
         "\\hfill ", date,"\\vspace{-1cm}\n",
         "\\end{center}\n",
         "\\begin{align*}\n",
         
         "\\end{align*}\n\n",
         "\\end{landscape}\n",
         "\\end{document}") %>% cat
}

#### Result
write(file = paste0(path,filename))

setwd(path)
recode <- paste0("bg2uc ",filename)
shell(recode)

unlink(paste0(path,filename,"-bg"),recursive=TRUE)




tmp <- classData %>% grep(pattern = "SS301",value=T) %>% str_extract(regex("(?<=,).*"))
tmp %>% str_split("C") %>% unlist
