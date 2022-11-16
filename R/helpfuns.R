## Save csv function

saveCSV <- function(x){
  write.csv(x,file=paste("check_csv/",deparse(substitute(x)),".csv",sep=""))
}

changeLogical <- function(x){
  	ifelse(x=="false", FALSE,
		ifelse (x=="true", TRUE, NA)
	)
}
