# Comp Bio - Lecture Sript
# Basic R stuff:
# 14, February 2017
# P. Alexander Burnham


##################################################################################
# Preliminaries:
# Clear memory of characters:
ls()
rm(list=ls())
##################################################################################

# Data structues and types:

x <- 5
print(5)

# varaible names:

z <- 3 # use lowercase for variable names at start
plant_height <- 3.3 # looks gangly
plant.height <- 4 # sometimes used in functions (confusing)
plantHeight <- 3 # camelCaseFormatting

# functions:
z <- c(3.2, 5, 5, 6) #combine
typeof(z) # gives type
is.numeric(z) #is statement



for (i in 1:1000){
z <- mean(rnorm(1000) > 2)
cat(z)
}



# How to write functions:

# For loops:

# Ifelse statement:
