## Ground rules

This is a _public_ repo; make sure that linked data sources are secure and that outputs are always to directories that are Ignore-d.

## Data linkage

You will need to have access to data files in a Dropbox. The default location of this Dropbox is ~/Dropbox/Rabies_TZ/. If your data is elsewhere (or if you're using a different Dropbox), you will need to either set up links, or make a local configuration file. If `ls ~/Dropbox/Rabies_TZ/Tanzania_Animal*.csv` shows you a bunch of WiseMonkey files, you're probably OK.

## Getting started

### File setup
1. Clone this repo
1. Sort out your Data linkage issues (see above)
1. `make dropsetup`
1. `ls -l *.csv`
	* This should show two data files in the main directory, and where they point to in the Dropbox

### R setup
You will need:

1. The program R
1. The tidyverse set of packages
	* `install.packages("tidyverse")
1. The [shellpipes package](https://dushoff.github.io/shellpipes/]

## Making a report

The current report structure is based on configuration scripts in a subdirectory called (branch)[branch/]; so far this only one: SD_dogs ([here](branch/SD_dogs.R) is the selection file).

`make SD_dogs.report.html` should just work to make the report, and related .csv files linked from the report.

`make SD_dogs.report.html.go` will often work to make the report _and_ automatically open it on your screen.

To add a new report to the pipeline, it should be sufficient to make (and commit) a new config file branch/<yourbranch>.R, and then follow steps above.
