## Return a list of repeat IDs

library(dplyr)
library(tidyverse)
library(shellpipes)

sourceFiles()
animals <- rdsRead()

## Check ID and district makes unique _key_

repIDCheck <- (animals
	%>% filter((ID >= 1) &(!is.na(ID))) # Select Animal IDs >0 and exclude NAs
	%>% group_by(ID,District) # group by animal ID and district
	%>% summarize(count=n()) # and count number in each group
	%>% filter(count>1) # filter to just look at counts where non-unique IDs repeated in a district
	%>% arrange(desc(count)) # arrange this mistakes in descending order
)

print(repIDCheck)

print(sum(repIDCheck["count"]))

repIDdat <- (repIDCheck
	%>% dplyr:::select(ID, District)
	%>% distinct()
	%>% left_join(.,animals, by=c("ID","District"))
	%>% mutate(code = "RepID")
	%>% dplyr:::select(Notes,code, ID, District, Date.bitten, Symptoms.started, everything())
)

print(dim(repIDdat))

print(head(repIDdat))

csvSave(repIDdat)


