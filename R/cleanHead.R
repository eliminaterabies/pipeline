## Make a more R-friendly csv using readLines and writeLines

library(shellpipes)
rpcall("cleanHead_Animal.Rout R/cleanHead.R Animal_CT.csv")

f <- csvRead(readFun=readLines)

f[[1]] <- paste(collapse=",", make.names(names(read.csv(text=f[[1]]))))

writeLines(f, con=targetname(ext=".Rout.csv"))

