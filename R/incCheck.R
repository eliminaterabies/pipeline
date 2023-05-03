## check incubation period intervals
## Need to document this in the google doc

library(tidyverse)
library(shellpipes)

sourceFiles()
animals <- rdsRead()

# calculate incubation period from dates
dateInc <- (animals
	 %>% mutate(dateInc = as.numeric(
			Symptoms.started - Date.bitten
			)
		)
)

print(summary(dateInc
	%>% filter(Incubation.period.units == "Day")
	%>% select(Incubation.period)
	)
)

print(dateInc
	%>% filter(Species == "Domestic dog")
	%>% filter(dateInc <1)
	%>% select(ID,dateInc)
	%>% arrange(dateInc)
)

print(dateInc 
	%>% filter(Species == "Domestic dog")
	%>% select(ID, Incubation.period, Incubation.period.units, dateInc)
	%>% filter(!is.na(Incubation.period) | !is.na(dateInc))
	%>% filter(Incubation.period.units == "Day")
	%>% arrange(Incubation.period, dateInc)
	%>% filter(Incubation.period <4)
	, n=100
)

dateIncCheck <- (dateInc
	%>% mutate(inc_period = Incubation.period * as.numeric(convertDay(Incubation.period.units))
	, incdiff = dateInc-inc_period
	)
	%>% dplyr::filter(!is.na(incdiff) & (abs(dateInc-inc_period)>15))
	%>% dplyr::select(Notes, ID, District, inc_period, dateInc, Date.bitten, Symptoms.started, Incubation.period, Incubation.period.units, everything()
	)
)

csvSave(dateIncCheck)
