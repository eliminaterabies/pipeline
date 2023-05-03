## Check Suspect animals

library(dplyr)
library(shellpipes)
rpcall("SD_dogs.suspectCheck.Rout R/suspectCheck.R SD_dogs.dat.rds")

animals <- rdsRead()

suspectOnly <- (animals
	 %>% dplyr::select(dplyr::contains("Suspect"),-Suspect)
	 %>% transmute(numSuspCrit = rowSums(.=="TRUE")) ## This is not good
)

dat <- (bind_cols(animals, suspectOnly)
	%>% filter(Suspect %in% c("Yes", "To Do"))
)

suspectCheck1 <- (dat
	%>% filter((Outcome == "Alive")) ## We don't have any Suspects that are alive.
	%>% mutate(code = "Suspect1")
	%>% dplyr:::select(Notes,code,ID,Suspect,Outcome,everything(.))
)

suspectCheck2 <- (dat
	%>% filter(Suspect %in% c("To Do"))
	%>% mutate(code = "Suspect2")
	%>% dplyr:::select(Notes, code,ID, Suspect, Outcome, everything(.))
)

## These are the entries that failed the "suspect" test
suspectCheck3 <- (dat
	%>% filter(Symptoms.started.known == TRUE)
	%>% filter((is.na(Symptoms.started))
		| (Symptoms.started.accuracy == "")
		)
	%>% mutate(code = "Suspect3")
	%>% dplyr:::select(Notes, code,ID,Suspect, Symptoms.started.known, Symptoms.started, Symptoms.started.accuracy,everything(.)
	)
)

suspectCheck4 <- (dat
	%>% filter(is.na(Symptoms.started))
	%>% mutate(code = "Suspect4")
	%>% dplyr::select(Notes, code, ID, everything(.))
)

suspectCheck5 <- (dat
	%>% filter((Symptoms.started >= as.Date("2010-01-01")) | 
		(Date.bitten >= as.Date("2010-01-01"))
		)
	%>% filter(numSuspCrit == 0)
	%>% mutate(code = "Suspect5")
	%>% dplyr:::select(Notes, code, ID, Suspect, Outcome, Symptoms.started.known, numSuspCrit, Date.bitten, contains("Suspect"), everything()
	)
)

print(dim(suspectCheck5))

print(dat %>% select(ID, Symptoms.started, numSuspCrit) %>% arrange(Symptoms.started) %>% filter(numSuspCrit > 0), n=100)

SuspCheck <- rbind(suspectCheck1
	, suspectCheck2
	, suspectCheck3
	, suspectCheck4
	, suspectCheck5
)

csvSave(SuspCheck)

