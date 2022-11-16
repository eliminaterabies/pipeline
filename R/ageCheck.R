## Check animal ages to make sure data completed

library(dplyr)
library(tidyverse)
library(shellpipes)
rpcall("Serengeti_animal_ageCheck.Rout R/ageCheck.R Serengeti_animal_dat.rds R/helpfuns.R")
rpcall("Serengeti_Animal_ageCheck.Rout R/ageCheck.R Serengeti_Animal_dat.rds R/helpfuns.R")
rpcall("Serengeti_Dog_ageCheck.Rout R/ageCheck.R Serengeti_Dog_dat.rds R/helpfuns.R")

sourceFiles()
animals <- rdsRead()

ageCheck <- (animals
	# filter all animals with apparently known ages
	%>% filter(Age.category == "Known")
	%>% filter(is.na(Age)) # now check they do have a specified age!
	%>% mutate(code = "Age")
	%>% dplyr::select(Notes, code, ID, everything())
)

print(nrow(ageCheck)) ## unknown age categories with non-NA Age

csvSave(ageCheck)

