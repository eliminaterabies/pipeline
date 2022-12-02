Drop ?= ~/Dropbox
Dropdir ?= Rabies_TZ

Ignore += datadir
datadir: dir=$(Drop)/$(Dropdir)
datadir:
	- $(linkdirname)

Ignore += outdir
outdir=$(Drop)/$(Dropdir)/output
outdir: dir=$(outdir)
outdir: | $(outdir)
	- $(linkdirname)

$(outdir):
	$(mkdir)

%.config: %.local
	$(LNF) $< local.mk
