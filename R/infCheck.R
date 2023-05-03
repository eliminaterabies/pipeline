##infectious periods

library(dplyr)
library(shellpipes)
rpcall("SD_dogs.infCheck.Rout R/infCheck.R SD_dogs.dat.rds")
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
