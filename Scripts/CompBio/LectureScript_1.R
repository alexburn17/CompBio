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

#################################################################################
# random samples and probabilty dist:
setwd("~/ComputationalBiology/CompBio/Scripts/CompBio")

data <- read.table(file="antcountydata.csv", header = TRUE, sep=",", stringsAsFactors = FALSE)

littleData <- data[1:8,3:6]

# randomized order of 1 through 10
sample(10)

# applied to a vector
print(littleData$n.species)

# randomized vector values
sample(littleData$n.species)

# randomized vector values (3 of them) without replacement:
sample(x=littleData$n.species, size = 3)

# randomized vector values (20 of them) with replacement (for bootstrapping):
sample(x=littleData$n.species, size = 20, replace = TRUE)


#----------------------------------------------------------------------------
# NULL communities: comparing community structure to what distribution would look like by chance:

# community not sampled equiprobably:
mainlandSpecies <- paste("Species",1:10, sep="")
popSizes <- c(1000,500,100,20,10,5,5,5,1,1)

# sample is equiprobable 
islandA <- sample(x=mainlandSpecies, size=5)
islandA

# assume colonization isnt equiprobable
islandB <- sample(x=mainlandSpecies, size=5, prob=popSizes)
islandB

# assume colonization isnt equiprobable and draw indivuals with replacement 
islandC <- sample(x=mainlandSpecies, size=100, prob=popSizes, replace=TRUE)
table(islandC)
unique(islandC)
length(unique(islandC))

# island D colonazation of equiprob indivuals
islandD <- sample(x=mainlandSpecies, size=100, prob=NULL, replace=TRUE)
table(islandD)
table(islandD)
unique(islandD)
length(unique(islandD))

length(table(islandD)[table(islandD)>9])

###############################################################################
# probabilty distrutions:

# continuous dist:

#normal norm()
#uniform unif()
#gamma gamma()
#beta (0 to 1) beta()

# discrete dist:

#binomial (coin flip) binom()
#poisson (chance through time) pois()
#neg binomial is waiting times or failure times

# syntax for dist functions:

# d - prefix is density (give me the height of the curve for value of x)
# p - smaller than d is p prefix or probability (lower tail)
# q - what value of x generates p (inverse of p)
# r - give us random draw from the distribution 

#---------------------------------------------------------------
# poisson (rate at whci event is occuring) (average of values = lambda rate or freq that this is occuring) and y axis shows percent event 0 or 1 ....10 occurs.

# lambda sampling once, good for rare events

MyVec <- dpois(x=seq(0:10), lambda = 1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# lambda = 2

MyVec <- dpois(x=seq(0:10), lambda = 2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# lambda high (lambda increases more normal looking)

MyVec <- dpois(x=seq(0:10), lambda = 5)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# lambda low really rare event (lambda decreases backs up against wall) (90% of the time we get a 0)

MyVec <- dpois(x=seq(0:10), lambda = 0.1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

#-------------------------------------------------
# prob of getting each number (lower tail)
MyVec <- ppois(q=seq(0:10), lambda = 2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)


#-------------------------------------------------
MyVec <- qpois(p=c(0.025, 0.975), lambda = 50)
# 90% of values dranw from dist with lambda of 50 will be between these values (37, 64)

#-------------------------------------------------
# random sample:
x <- rpois(n=1000, lambda = 1.1)
hist(x)

################################################
# binomial
# p = prob of dichotmous outcome (binary)
# size = number of trials
# x = possible outcomes
# x is number of sucesses

MyVec <- dbinom(x=seq(1,10), size = 10, p=0.5)
names(MyVec) <- seq(1,10)
barplot(height = MyVec)


# Biased

MyVec <- dbinom(x=seq(1,10), size = 10, p=0.75)
names(MyVec) <- seq(1,10)
barplot(height = MyVec)


# qbinom() function
MyVec <- qbinom(p=c(0.025, 0.975), size = 100, prob=0.75)
barplot(height = MyVec)
MyVec

