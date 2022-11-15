library(dplyr)
library(shellpipes)

animals <- rdsRead()

summary(animals %>% mutate_if(is.character, as.factor))
