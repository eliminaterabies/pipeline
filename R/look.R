library(dplyr)
library(shellpipes)

animals <- rdsRead()

summary(animals %>% mutate_if(is.character, as.factor))

## Are there replicate IDs?

print(animals
	|> select(District, ID)
	|> distinct()
	|> nrow()
)
