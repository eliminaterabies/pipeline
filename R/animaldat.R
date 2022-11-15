library(dplyr)
library(tidyverse)
library(shellpipes)
rpcall("Serengeti_animal_dat.Rout R/animaldat.R readAnimal.rds")
rpcall("Serengeti_Animal_dat.Rout R/animaldat.R readAnimal.rds")
rpcall("Serengeti_Dog_dat.Rout R/animaldat.R readAnimal.rds")

animals <- rdsRead()

output_dir <- "output/"
if(grepl("Serengeti", targetname())){
	animals <- (animals
		%>% filter(ID>0)
		%>% filter(District == "Serengeti")
		%>% filter((!is.na(Year.bitten) & (Year.bitten > 2002))
			| ((!is.na(Year.Symptoms) & (Year.Symptoms > 2002)))
		)
		%>% dplyr:::select(Year.bitten, Year.Symptoms, everything(.))
		)
}

if(grepl("Serengeti_dogs", targetname())){
	animals <- (animals
		%>% filter(Species == "Domestic dog")
	)
}

print(dim(animals))

csvSave(animals)

rdsSave(animals)
