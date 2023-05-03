
## Ground rules

This is a _public_ repo; make sure that linked data sources are secure and that outputs are properly ignored.

## Data linkage

You will need to have access to data files in a Dropbox. The default location of this Dropbox is ~/Dropbox/Rabies_TZ/. If your data is elsewhere (or if you're using a different Dropbox), you will need to either set up links, or make a local configuration file. If `ls ~/Dropbox/Rabies_TZ/Tanzania_Animal*.csv` shows you a bunch of WiseMonkey files, you're probably OK.

If not, but you already have a personal .local file, say `make <yourname>.config` after `make Makefile` (see below). NB: There is a file called `katie.local`

## Getting started

### File setup
1. Clone this repo
1. `make Makefile`
1. Sort out your Data linkage issues (see above)
1. `make dropsetup`
1. `ls -l *.csv`
	* This should show two data files in the main directory, and where they point to in the Dropbox

### R setup
You will need:

1. The program R
1. The tidyverse set of packages
	* `install.packages("tidyverse")
1. The [shellpipes package](https://dushoff.github.io/shellpipes/)

## Making a report

The current report structure is based on configuration scripts in a subdirectory called (branch)[branch/]; so far this only one: SD_dogs ([here](branch/SD_dogs.R) is the selection file).

`make SD_dogs.report.html` should just work to make the report, and related .csv files linked from the report.

`make SD_dogs.report.html.go` will often work to make the report _and_ automatically open it on your screen.

To add a new report to the pipeline, it should be sufficient to make (and commit) a new config file branch/<yourbranch>.R, and then follow steps above.

## Working on the pipeline

You can see the shape of the pipeline by examining the file `SD_dogs.allchecks.pipeR.script` and then opening that file. 

You should be able to edit any of the R scripts listed in the script file and then run any part of the R pipeline by using the script file, or by using make and the target name of your choice, e.g., `make SD_dogs.wildlifeCheck.Rout.csv`. 

You should also be able to run any R script directly from rstudio, modify it and run it again. The `rpcall` statement at the top tells it where to read and save things. To save changes, re-run the save-like commands at the bottom, and to incorporate upstream changes, re-run the load-like commands at the top (or just always run the script top-to-bottom).

`.csv` files are made first in the main directory. The report right now can only be made by `make`; this has a step to copy the .csv files to where the report wants them. `csv` files in the main directory can be deleted without harming the report, once it's made.

## Editing the report

You should be able to edit report.rmd in a straightforward manner in rstudio or any text editor. There are probably issues that will arise if and when we start working on other branches. If you have _only_ changed the report, you should be able to knit it in rstudio. If you have changed R files, you will need to use `make` once to get the .csv files all made and put in the right place.

## Updating WiseMonkey

To change the focal WiseMonkey file, you need to delete `Animal_CT.csv` in the main directory, and make sure that the file you want to use is the most recent file matching *Animal*.csv in the datadir (you can access via here or your Dropbox folder). If you download a new WiseMonkey file and delete Animal_CT.csv, it should just work. 

To focus another WiseMonkey file, you can update its modification time (use `touch` from the command line, or do something Mac-ish if you know how). This should rarely be necessary, and remember to touch the latest file when you're done whatever test you are doing.

