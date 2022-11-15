library(readr)
library(dplyr)
library(shellpipes)

animals <- (csvRead()
	%>% mutate(NULL
		, Date.bitten = as.Date(Date.bitten, "%d-%b-%Y")
  		, Symptoms.started = as.Date(Symptoms.started, "%d-%b-%Y")
		, Year.bitten = as.numeric(format(Date.bitten, "%Y"))
		, Year.symptoms = as.numeric(format(Symptoms.started, "%Y"))
	)
	%>% filter(ID>0
		& !is.na(Year.bitten)
		& !is.na(Year.symptoms)
	)
	%>% dplyr:::select(Year.bitten, Year.symptoms, everything(.))
)

print(names(animals))
print(dim(animals))

csvSave(animals)

rdsSave(animals)
