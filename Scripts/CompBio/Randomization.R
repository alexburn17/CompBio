###########################################################################################
# Randomization test
# 11, April 2017
# P. Alexander Burnham
###########################################################################################

# 1) define univariate metrix X
# 2) calculate X for observed data Xobs
# 3) randomize data subject to some constrains
# 4) calculate X for randomized data Xsim
# 5) repeat (4) many times (n=1000)
#     - generate a distribution of Xsim as a histogram
# 6) compare Xobs to Xsim
#     p(Xobs | H_0)
# 7) draw biological conclusion 

###########################################################################################
# compare ant species richness among different new england ecotypes 

# set working directory and load in data
setwd("~/ComputationalBiology/CompBio/Scripts/CompBio")

data <- read.table(file= "antcountydata.csv",
                   header = TRUE,
                   sep = ",",
                   stringsAsFactors = FALSE)

data$ecoregion <- as.factor(data$ecoregion)



# ANOVA to show the basic way to do this test
myModel <- aov(n.species~ecoregion, data=data)
summary(myModel)

# plot data
boxplot(data$n.species~data$ecoregion, col="indianred")

###########################################################################################
# use variance amoun treatment means

###################################################################
# FUNCTION: VarMeans
# calculates cariance amoung a group of treatment means
# input: vector of groups, vector of group means 
# output: amoung group variance of those means
# ------------------------------------------------------------------
VarMeans <- function(fac = NULL, res=runif(25)) {
  
  if (is.null(fac)){
    fac <- as.factor(rep(LETTERS[1:5],each=5))
  }
  
  temp <- aggregate(x=res, by=list(fac), FUN=mean)
  
  return(var(temp$x))
  
}

VarMeans()

###########################################################################################
# specify treatment randomization

###################################################################
# FUNCTION: TreatRan
# randomization treament (factor labels)
# input: vector of observed treatment labels
# output: vector of randomized treatment labels
# ------------------------------------------------------------------
TreatRan <- function(fac = NULL) {
 if (is.null(fac)){
   fac <- as.factor(rep(LETTERS[1:5],each=5))
 } 
 fac <- sample(fac,replace = FALSE)
 return(fac)
}

TreatRan()

###########################################################################################
#now write function for summary and plots

###################################################################
# FUNCTION: randomizeSummary
# give summary stats, boxplots, and histogram
# input: vector of simulated values, 1 value of observed value 
# output: list of null model stats, and graphs
# ------------------------------------------------------------------
randomizeSummary <- function(obsX = runif(1), 
                             simX = runif(1000),
                             fac = NULL,
                             res = runif(25)) {
  if (is.null(fac)){
    fac <- as.factor(rep(LETTERS[1:5],each=5))
  } 

  pLow <- mean(simX <= obsX)
  pHigh <- mean(simX >= obsX)
  meanSimX <- mean(simX)
  varSimX <- var(simX)
  SES <- (obsX - mean(simX))/sd(simX)
  
  outList <- list(stats=list(obsX=obsX,
                             meanSimX = meanSimX,
                             varSimX = varSimX,
                             pLow = pLow,
                             pHigh = pHigh,
                             SES = SES,
                             reps = length(simX)),
                    raw = simX
                  )
  
  par(mfrow=c(1,3))
  
  # show boxplot of real data
  boxplot(res~fac, col="indianred")
  mtext("Observed Data", side = 3, font = 2, cex=0.75)
  
  # show boxplot of simulated data
  boxplot(res~sample(fac), col="goldenrod")
  mtext("Simulated Data", side = 3, font = 2, cex=0.75)
  
  # show histogram of simulated and observed data
  hist(simX, breaks = 25, col="goldenrod", 
       main = "Null Distribution", 
       xlab = "Simulated Response",
       xlim = c(0, max(c(simX,obsX))))
  
  Interval95 <- quantile(x=simX, probs = c(0.05, 0.95))
  Interval975 <- quantile(x=simX, probs = c(0.025, 0.975))
  
  abline(v=obsX, col = "indianred", lwd = 2)
  abline(v=Interval95, col = "black", lwd = 2, lty = "dotted")
  abline(v=Interval975, col = "black", lwd = 2, lty = "dashed")
  
  par(mfrow = c(1,1))
  
  return(outList)
}

z <- randomizeSummary()
#----------------------------------------------------------------
# Global variables
filename <- "antcountydata.csv"
data <- read.table(file=filename,
                   header=TRUE,
                   sep = ",",
                   stringsAsFactors = FALSE)

data$ecoregion <- as.factor(data$ecoregion)
grps <- data$ecoregion
richness <- data$n.species
nreps <- 1000
outVec <- vector(mode="numeric", length = nreps)
obsX <- VarMeans(fac=grps, res=richness)