## This is the TZ new_pipeline:
## https://github.com/eliminaterabies/rabiesTZ.git

Sources += Makefile README.md

######################################################################

## Vim hooks

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -cl "vmt content.mk"

######################################################################

## Dropbox for confidential inputs and outputs

## Store personal local.mk settings if needed in <yourname>.local
Sources += $(wildcard *.local)

Ignore += local.mk
-include local.mk
Drop ?= ~/Dropbox
Dropdir ?= Rabies_TZ

Ignore += datadir
datadir/%:
	$(MAKE) datadir
datadir: dir=$(Drop)/$(Dropdir)
datadir:
	- $(linkdirname)

Ignore += outdir
outdir/%:
	$(MAKE) outdir
outdir: dir=$(Drop)/$(Dropdir)/output
outdir:
	- $(linkdirname)

##################################################################

## Copies of main inputs (don't commit!)

Ignore += Animal_CT.csv Human_CT.csv

## del Animal_CT.csv ## to update for new data
Animal_CT.csv: datadir/*Animal*.csv
	$(LNF) `ls -t datadir/*Animal*.csv | head -1` $@

## del Human_CT.csv ## to update for new data
Human_CT.csv:
	$(LNF) datadir/*Human*.csv $@

##################################################################

## R set up

## Revisit; what R directories do we want?
Sources += $(wildcard R/*.R branch/*.R)

rrule = $(pipeRcall)
rrule = $(pipeR)

######################################################################

## R friendly csv
cleanHead_Animal.Rout: R/cleanHead.R Animal_CT.csv
	$(rrule)

## Some basic cleaning
animal.Rout: R/animal.R cleanHead_Animal.Rout.csv
	$(rrule)

######################################################################

## Examine: on hold 2022 Nov 15 (Tue)

animal.look.Rout: R/look.R animal.rds
	$(rrule)

######################################################################

## Branching: I'm very stuck here! 2022 Nov 15 (Tue)
## Try config files

branch/%.Rout: branch/%.R
	$(rrule)

## SD_dogs.dat.Rout: R/dat.R branch/SD_dogs.R
%.dat.Rout: R/dat.R animal.rds branch/%.rda
	$(rrule)

######################################################################

## Cribbing

## Transfer version of p1/Makefile
Sources += content.mk

Ignore += p1
p1:
	cp -r ../tz_pipeline $@ \
	|| git clone https://github.com/wzmli/rabies_db_pipeline $@

R/%.R: p1/R/%.R
	$(copy)

######################################################################

### Makestuff

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
