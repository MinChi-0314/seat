library(tidyverse)
library(httr)
library(readxl)
#### Setting
## path to get tex (or ctx) file
class <- "SS102"
path <- "C:/Users/Username/Desktop/"
filename <- paste0("Seat(", class, ").ctx")

## deal with student list 
data <- read_xlsx("C:/Users/Username/Desktop/2020Fall_Statistics_成績登記_20201013.xlsx")[-c(144,145),c(1,4)]
colnames(data) <- c("department", "name")

#### Generate code
## import class size
classData <- GET("https://raw.githubusercontent.com/MinChi-0314/seat/master/NTU.csv") %>%
  content("text") %>% 
  str_split(pattern = "\r\n") %>% 
  unlist %>% .[-c(1,9)]

## seat code
seat <- function(list, class, method, drop, aisleSpace, seatSpace){
  # method of arrangement
  if(method==1){
    data <- sample(1:nrow(list), nrow(list)) %>% list[.,2] %>% unlist
  } else if(method==2){
    
  }
  
  # adjust for drop one
  if(drop){
    data0 <- data
    data <- c()
    for(i in 1:length(data0)){
      data[2*i-1] <- data0[i]
      data[2*i] <- "{\\color{white}王小明}"
    }
  }
  
  # Get the size of class
  tmp <- classData %>% grep(pattern = class,value=T) %>% 
    str_extract(regex("(?<=,).*"))
  
  # Control number of columns by seatSpace
  if(seatSpace){
    columns <- tmp %>% str_split("C") %>% unlist %>% .[1] %>% nchar +1
  } else {
    columns <- tmp %>% str_split("C") %>% unlist %>% .[1] %>% str_split("A") %>% unlist %>% length +1
  }
  arraySite <- str_c(rep("c", columns), collapse = "")
  
  # Start to write the array
  row <- 1
  
  if(seatSpace){
    code <- paste0("\\begin{array}{", arraySite, "}\n1")
    
    for(i in 1:nchar(tmp)){
      if(substring(tmp, 1, 1)=="S"){
        code <- paste0(code, " & \\fbox{", data[1], "}")
        data <- data[-1]
      } else if(substring(tmp, 1, 1)=="P"){
        code <- paste0(code," & \\fbox{{\\color{white}王}X{\\color{white}明}}")
        data <- data[-1]
      } else if(substring(tmp, 1, 1)=="A"){
        code <- paste0(code," & ", "\\hspace{", aisleSpace, "}")
      }else if(substring(tmp, 1, 1)=="C"){
        row <- row + 1
        code <- paste0(code," \\\\\n", row)
      }
      
      tmp <- substring(tmp, 2)
    }
  } else {
    code <- paste0("\\begin{array}{", arraySite, "}\n1&")
    
    for(i in 1:nchar(tmp)){
      if(substring(tmp, 1, 1)=="S"){
        code <- paste0(code, "\\fbox{", data[1], "}")
        data <- data[-1]
      } else if(substring(tmp, 1, 1)=="P"){
        code <- paste0(code,"\\fbox{{\\color{white}王}X{\\color{white}明}}")
        data <- data[-1]
      } else if(substring(tmp, 1, 1)=="A"){
        code <- paste0(code," & ", "\\hspace{", aisleSpace, "}")
      }else if(substring(tmp, 1, 1)=="C"){
        row <- row + 1
        code <- paste0(code," \\\\\n", row, "&")
      }
      
      tmp <- substring(tmp, 2)
    }
  }
  code <- code %>% gsub(pattern = "NA", replacement = "{\\\\color{white} 王小明}")
  return(code)
}

## total code
code <- function(list, class, method, drop = TRUE, date = NULL, aisleSpace = "1cm", seatSpace = FALSE){
  if(!is.null(date)) date <- paste0(" (", date, ")")
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
         "\\usepackage{MyriadPro}\n",
         "\\usepackage{color}\n",
         "\\fboxsep=5pt\n\n",
         "\\usepackage{pdflscape}\n",
         "\\thispagestyle{empty}\n\n",
         "\\begin{document}\n",
         "\\begin{landscape}\n",
         "\\begin{center}\n",
         "\\fbox{\\hspace{5cm}黑板\\hspace{5cm}}\\\\[-1cm]\n",
         "\\hfill Class: ", class, date, "\n",
         "\\end{center}\n",
         "\\begin{align*}\n",
         seat(list, class, method, drop, aisleSpace, seatSpace),"\n",
         "\\end{array}\n",
         "\\end{align*}\n\n",
         "\\end{landscape}\n",
         "\\end{document}") %>% return 
}

#### Result
## write .ctx (or .tex) file
code(data, class, method = 1) %>% write(file = paste0(path, filename))

## encoding (big5 to utf8)
setwd(path)
recode <- paste0("bg2uc ", filename)
shell(recode)

## delete -bg file
unlink(paste0(path, filename, "-bg"), recursive=TRUE)
