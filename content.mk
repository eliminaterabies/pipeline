
outputTargets += Serengeti_animal_dat Serengeti_dogs_dat Serengeti_animal_incubation Serengeti_dogs_incubation
outputProducts = $(outputTargets:%=output/%.csv)
output/Serengeti_animal_dat.Rout.csv: Makefile
$(outputProducts): output/%.csv: %.Rout
	ls -l Animal_CT.csv | sed -e "s/.*->/## /" > $@
	cat $*.Rout.csv >> $@

outputProducts: $(outputProducts)

## Serengeti_animal_IDCheck.Rout: R/IDCheck.R
%_IDCheck.Rout: R/IDCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_ageCheck.Rout: R/ageCheck.R
%_ageCheck.Rout: R/ageCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_suspectCheck.Rout: R/suspectCheck.R
%_suspectCheck.Rout: R/suspectCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_outcomeCheck.Rout: R/outcomeCheck.R
%_outcomeCheck.Rout: R/outcomeCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_incCheck.Rout: R/incCheck.R
%_incCheck.Rout:  R/incCheck.R %_dat.rds R/helpfuns.R R/convert.R
	$(rrule)

## Serengeti_animal_incubation.Rout: R/incubation.R
Ignore += *_incubation.check.csv
%_incubation.check.csv: %_incubation.Rout ;
%_incubation.Rout: R/incubation.R %_dat.rds R/helpfuns.R R/convert.R
	$(rrule)

## Serengeti_animal_wildlifeCheck.Rout: R/wildlifeCheck.R
%_wildlifeCheck.Rout: R/wildlifeCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_dateCheck.Rout: R/dateCheck.R
%_dateCheck.Rout: R/dateCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_symptomCheck.Rout: R/symptomCheck.R
%_symptomCheck.Rout: R/symptomCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Serengeti_animal_infCheck.Rout: R/infCheck.R
%_infCheck.Rout: R/infCheck.R %_dat.rds R/helpfuns.R
	$(rrule)

## Dog.allchecks: 
## Animal.allchecks: 
%.allchecks: Serengeti_%_dat.Rout Serengeti_%_IDCheck.Rout Serengeti_%_ageCheck.Rout Serengeti_%_suspectCheck.Rout Serengeti_%_outcomeCheck.Rout Serengeti_%_incCheck.Rout Serengeti_%_wildlifeCheck.Rout Serengeti_%_dateCheck.Rout Serengeti_%_symptomCheck.Rout Serengeti_%_infCheck.Rout Serengeti_%_incubation.Rout ;


############################################################
## Additional downstream project issues


## Not sure why this is here
# Serengeti_animal_unsuspect.Rout: R/unsuspect.R
%_unsuspect.Rout:	%_incubation.Rout R/unsuspect.R 
	$(run-R)

## R0 manuscript

## https://github.com/wzmli/rabies_db_pipeline/tree/master/git_push/R0mergeCheck.Rout.csv
# R0mergeCheck.Rout.csv: R0mergeCheck.Rout ;

## This rule doesn't chain to R0 and assumes it's been installed through
## the top directory
R0mergeCheck.Rout: output/Serengeti_animal_dat.csv ../R0/mergeCheck.Rout dogsChecks.Rout R0mergeCheck.R
	$(run-R)

Sources += *_check_csv/README
Ignore += $(wildcard *_check_csv/*.csv) $(wildcard *Check.csv)

Sources +=  $(wildcard *.run.r */*.run.r)  $(wildcard *.rmd) 

## Push to directory for now (for testing usability)
## Sources += report.html animal_report.html $(wildcard html/*.html)

Ignore += animal_report.html dogs_report.html

%_report.html: %Checks.Rout %_report.rmd
## animal_report.html:
## dogs_report.html:

######################################################################

clean: 
	rm *.wrapR.r *.Rout *.wrapR.rout *.Rout.pdf

cleandir:
	git clone https://github.com/wzmli/rabies_db_pipeline.git
