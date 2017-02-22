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


vComposti <- rep(NA, 10)
for(j in 1:10){
  vComposti[j] <- c(listDFs[[j]]$Name)
}


z <- rep(NA, 100)
for (i in 1:100){
z[i] <- mean(runif(36))
hist(z)
}


a <- 1:12

m <- matrix(a, 4,3, byrow = TRUE)
rownames(m) <- LETTERS[1:4]
rownames(m) <- paste("site",1:nrow(m), sep="")
m

# how to subset:
z <- c( 3.1, 9.2, 1.3, 0.4, 7.5)

z[z<3]

tester <- z<3

# which()
which(z<3)
z[which(z<3)]

# everything but the last three numbers in the data set:
z[-(length(z):(length(z)-2))]

# vector elements can have names
names(z) <- letters[1:5]

z[c("a", "b")]

# subsetting a matrix or

m <- matrix(1:12, nrow=3)
dimnames(m) <- list(paste("Species", LETTERS[1:nrow(m)],sep=""), paste("site", 1:ncol(m), sep=""))
m

# subset this matrix:
m[1:2,3:4]

# subset on character strings:

m[c("SpeciesA","SpeciesB") , c("site3","site4")]

# blanks:
m[1:2,]
m[,3:4]

# give me columns for which the totals are greater than 15:

colSums(m) > 15

m[,colSums(m) > 15]

# select all rows for which the row total is equal to 22

m[rowSums(m)==22, ]

# select all rows for which the row total is NOT equal to 22

m[rowSums(m)!=22, ]

# choose all rows for which the numbers for site1 are less than 3 and all the columns for which the numbers for species A are less than 5

m[m[,"site1"] < 3, m["SpeciesA",] < 5]

# caution dropping down to one row or column, become vector not a matrix:

z <- m[1,]
print(z)
str(z)

z <- m[1, , drop=FALSE]

setwd("~/ComputationalBiology/CompBio/Scripts/CompBio")

data <- read.csv(file="antcountydata.csv", header = TRUE, sep=",", stringsAsFactors = FALSE)

head(data)

# take out one value in data frame
data[3,2]

# specify just column names, ehich are list elements:

dataNames <- data[ ,c("state", "county")]

# OR....

dataNames <- data[c("state", "county")]

# be careful to include both dimensions in the data matrix

m[2, ]
m[ ,2]

# thinks about everything as a vector

m[2]




