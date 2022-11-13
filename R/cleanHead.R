
library(shellpipes)
rpcall("cleanHead_Animal.Rout R/cleanHead.R Animal_CT.csv")

f <- csvRead(readFun=readLines)

f[[1]] <- paste(collapse=",", make.names(names(read.csv(text=f[[1]]))))

## This fixes names/text to be R friendly and write it into a csv
writeLines(f, con=targetname(ext=".Rout.csv"))

