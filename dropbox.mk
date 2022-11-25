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

