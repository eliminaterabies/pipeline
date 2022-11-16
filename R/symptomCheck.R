## Symptom Check

library(dplyr)
library(shellpipes)
rpcall("Serengeti_Animal_symptomCheck.Rout R/symptomCheck.R Serengeti_Animal_dat.rds R/helpfuns.R")
rpcall("Serengeti_Dog_symptomCheck.Rout R/symptomCheck.R Serengeti_Dog_dat.rds R/helpfuns.R")
sourceFiles()
animals <- rdsRead()

symptomCheck <- (animals  # animals where the symptoms started date is known but not recorded (uncertainty also)
	%>% mutate(code = "Symptom")
	%>% filter(Symptoms.started.known == TRUE)
	%>% filter(is.na(Symptoms.started) | is.na(Symptoms.started.accuracy))
	%>% dplyr::select(Notes, code, ID, Symptoms.started.known, Symptoms.started, Symptoms.started.accuracy, Notes, everything())
)

csvSave(symptomCheck)
