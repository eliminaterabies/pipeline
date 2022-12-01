Drop ?= ~/Dropbox
Dropdir ?= Rabies_TZ

Ignore += datadir
datadir: dir=$(Drop)/$(Dropdir)
datadir:
	- $(linkdirname)

Ignore += outdir
outdir: dir=$(Drop)/$(Dropdir)/output
outdir:
	- $(linkdirname)

%.config: %.local
	$(LNF) $< local.mk
