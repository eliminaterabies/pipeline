library(shellpipes)
rpcall("SD_dogs.allchecks.Rout SD_dogs.dat.Rout SD_dogs.IDCheck.Rout SD_dogs.ageCheck.Rout SD_dogs.suspectCheck.Rout SD_dogs.outcomeCheck.Rout SD_dogs.incCheck.Rout SD_dogs.wildlifeCheck.Rout SD_dogs.dateCheck.Rout SD_dogs.symptomCheck.Rout SD_dogs.infCheck.Rout SD_dogs.incubation.Rout R/allchecks.R")
print(fileSelect(exts="Rout"))
