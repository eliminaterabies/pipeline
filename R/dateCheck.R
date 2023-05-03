## Check Dates
library(dplyr)
library(shellpipes)
rpcall("SD_dogs.dateCheck.Rout R/dateCheck.R SD_dogs.dat.rds")
sourceFiles()
animals <- rdsRead()


datefalseCheck <- (animals # animals where neither the date bitten or the date of symptoms was known
	%>% mutate(code = "DB1")	
	%>% filter(Date.bitten.known == FALSE)
	%>% filter(Symptoms.started.known == FALSE)
	%>% dplyr::select(Notes, code, ID, District, Date.bitten.known, Symptoms.started.known, Date.bitten, Date.bitten.uncertainty,everything()
	)
)

print(nrow(datefalseCheck))
print(datefalseCheck)

print(dim(datefalseCheck))
datetrueCheck <- (animals # animals where the date bitten is known but not recorded (uncertainty also)
	%>% mutate(code = "DB2")
	%>% filter(Date.bitten.known == TRUE)
	%>% filter(is.na(Date.bitten) | is.na(Date.bitten.uncertainty))
	%>% dplyr::select(Notes, code, ID, District, Date.bitten.known, Date.bitten, Date.bitten.uncertainty,everything()
	)
)

print(nrow(datetrueCheck))

print(datetrueCheck)

dateCheck <- (full_join(datefalseCheck, datetrueCheck))

csvSave(dateCheck)

