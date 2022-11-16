##infectious periods

library(dplyr)
library(shellpipes)
rpcall("Serengeti_Animal_infCheck.Rout R/infCheck.R Serengeti_Animal_dat.rds R/helpfuns.R")
rpcall("Serengeti_Dog_infCheck.Rout R/infCheck.R Serengeti_Dog_dat.rds R/helpfuns.R")
sourceFiles()
animals <- rdsRead()

infCheck <- (animals
  %>% mutate(code = "Inf")
	%>% filter(!is.na(Infectious.period)) # infectious period is specified
	%>% filter(Infectious.period>10) # and is longer than 9 days
	%>% filter(Infectious.period.units == "Day")
	%>% dplyr::select(Notes,code, ID, Infectious.period, everything())
)

print(nrow(infCheck))

csvSave(infCheck)
