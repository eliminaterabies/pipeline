## Check wildlife animals

library(dplyr)
library(shellpipes)
rpcall("SD_dogs.wildlifeCheck.Rout R/wildlifeCheck.R SD_dogs.dat.rds")
sourceFiles()
animals <- rdsRead()

wildlifeCheck <- (animals
   %>% mutate(code="WL1", check="")
	 %>% filter(grepl("Wildlife",Species) | Species == "Other") # filter on wildlife or other spp
	 %>% dplyr::select(code, check, Owner, Owner.name, Animal.name.known, everything()) # select fields related to ownership
	 %>% filter(Owner != "Not applicable") # find all examples where owner is: not "Not applicable"
	 %>% filter(Owner.name != "") # find all examples where owner name is NOT blank
	 %>% filter(Animal.name.known != "false") # find all examples where animal name is KNOWN!
	 %>% dplyr::select(code, check, ID, District, Species, Owner, Animal.name.known, Date.bitten.known, Symptoms.started.accuracy, Vaccination, everything() # select fields to view
	 )
)

print(nrow(wildlifeCheck)) # Odd wildlife with owners or names!

#saveCSV(wildlifeCheck)

## Owner must be Unknown or Known
### If Owner is Known, then:
### Owner.name must not be blank
### Vaccination status must not be blank


nonwildlifeCheck <- (animals
   %>% mutate(code = "WL2", check="")
	 %>% filter(!grepl("Wildlife",Species) 
			& Species != "Other" 
			& Species!="Unknown"
		) # filter on NON wildlife or other spp or UNKNOWN!
   %>% dplyr::select(code, check, Owner, Owner.name, Animal.name.known, everything()) # select fields related to ownership
   %>% filter(Owner == "Not applicable") # find all examples where owner is: "Not applicable"
	 %>% dplyr::select(code, check, ID, District, Species, Owner, Animal.name.known, Date.bitten.known, Symptoms.started.accuracy, Vaccination, everything()) # select fields to view
)

print(nrow(nonwildlifeCheck))

## 3. If Owner is Unknown or Not Applicable, then:
### Animal.name.known must be FALSE
### Date.bitten.known must be FALSE & Symptoms.started.accuracy cannot be 0
### Vaccination must be Unknown


nonwildlifeCheck2 <- (animals
   %>% mutate(code = "WL3", check="")
	 %>% filter(!grepl("Wildlife",Species)
	 		& Species != "Other"
			& Species != "Unknown"
		)
	 %>% filter(Owner != "Known")
	 %>% filter((Animal.name.known == TRUE)
	 		| ((Date.bitten.known == TRUE)&(Symptoms.started.accuracy == 0))
			| (Vaccination == "Known")
			)
	 %>% dplyr::select(code, check, ID, District, Species, Owner, Animal.name.known, Date.bitten.known, Symptoms.started.accuracy, Vaccination, Notes, everything())
)

print(head(nonwildlifeCheck2))

wildlifeCheck <- (full_join(full_join(wildlifeCheck, nonwildlifeCheck), nonwildlifeCheck2))

dat <- wildlifeCheck %>% dplyr::select(Notes,everything(.)) 

csvSave(dat)
