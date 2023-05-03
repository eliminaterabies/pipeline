Sources += dropbox.mk setup.mk

## Vim hooks

current: target
-include target.mk
Ignore += target.mk

vim_session:
	bash -cl "vmt README.md"

## R set up

## Revisit; what R directories do we want?
Sources += $(wildcard R/*.R branch/*.R *.rmd)

rrule = $(pipeRcall)
rrule = $(pipeR)
