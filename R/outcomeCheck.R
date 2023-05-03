## Check Outcomes

library(dplyr)
library(tidyverse)
library(shellpipes)
rpcall("SD_dogs.outcomeCheck.Rout R/outcomeCheck.R SD_dogs.dat.rds")
sourceFiles()
animals <- rdsRead()

outcomeCheck <- (animals
	 %>% filter(Outcome %in% c("Alive","Disappeared")) # Look at animals that were alive or disappeared
	 %>% filter(Action != "Not applicable") # identify those where action NOT classified as not applicable
	 %>% mutate(code = "OC1")
	 %>% dplyr:::select(Notes, code, ID, District, Outcome, Action, everything())
)

print(nrow(outcomeCheck)) # 235 entries need examining
print(outcomeCheck)

actionCheck <- (animals
	 %>% filter(!(Outcome %in% c("Alive","Disappeared"))) # Look at animals that were NOT alive or did NOT disappear
	 %>% filter(Action == "Not applicable") # identify those where action classified as not applicable
	 %>% filter(!(grepl("kill",ignore.case=TRUE,Outcome)))
	 %>% filter(!(grepl("died",ignore.case=TRUE,Outcome)))
	 %>% mutate(code = "OC2", check="")
	 %>% dplyr:::select(Notes, code, ID, District, Outcome, Action, everything())
)

print(nrow(actionCheck)) # 1586 entries need examining
print(actionCheck)

outcomeCheck <- (full_join(outcomeCheck,actionCheck))

csvSave(outcomeCheck)
