## Symptom Check

library(dplyr)
library(shellpipes)
rpcall("SD_dogs.symptomCheck.Rout R/symptomCheck.R SD_dogs.dat.rds")
sourceFiles()
animals <- rdsRead()

symptomCheck <- (animals  # animals where the symptoms started date is known but not recorded (uncertainty also)
	%>% mutate(code = "Symptom")
	%>% filter(Symptoms.started.known == TRUE)
	%>% filter(is.na(Symptoms.started) | is.na(Symptoms.started.accuracy))
	%>% dplyr::select(Notes, code, ID, Symptoms.started.known, Symptoms.started, Symptoms.started.accuracy, Notes, everything())
)

csvSave(symptomCheck)
