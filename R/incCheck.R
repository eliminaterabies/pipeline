## check incubation period intervals
## Need to document this in the google doc

library(tidyverse)
library(shellpipes)
rpcall("Serengeti_Animal_incCheck.Rout R/incCheck.R Serengeti_Animal_dat.rds R/helpfuns.R R/convert.R")
rpcall("Serengeti_Dog_incCheck.Rout R/incCheck.R Serengeti_Dog_dat.rds R/helpfuns.R R/convert.R")

sourceFiles()
animals <- rdsRead()

convertDay <- Vectorize(function(x){
	if(is.na(x)|(x=="")){return(NA)}
	if(x=="Day"){return(1)}
	if(x=="Week"){return(7)}
	if(x=="Month"){return(365.25/12)}
	stop("Can't convert unit", x)
})


# calcuate incubation period from dates
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
	%>% dplyr::filter(!is.na(incdiff) && (abs(dateInc-inc_period)>15))
	%>% dplyr::select(Notes, ID, District, inc_period, dateInc, Date.bitten, Symptoms.started, Incubation.period, Incubation.period.units, everything()
	)
)

if(nrow(dateIncCheck) > 0){
	write.csv(dateIncCheck,file=paste0(check_dir,csvname))
}

