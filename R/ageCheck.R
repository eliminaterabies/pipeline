## Check animal ages to make sure data completed

library(dplyr)
library(tidyverse)
library(shellpipes)
rpcall("SD_dogs.ageCheck.Rout R/ageCheck.R SD_dogs.dat.rds")

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

