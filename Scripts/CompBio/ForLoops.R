###########################################################################################
# ForLoops
# 30 March 2017
# P. Alexander Burnham
###########################################################################################
# structure of for loops:

# for (var in seq) {

# body of loop (anything that we want)

# }

# var is a counter variable (i, j or k)
# seq_along(variable) instead of 1:length(variable)
###########################################################################################

myDat <- round(runif(10), digits=2)

for (i in seq_along(myDat)) {
  cat("loop number =", i, "vector element =", myDat[i], "\n")
}

###########################################################################################
# Making sure you for loops run quickly this example slows down by creaing the vector inside

myDat <- vector(mode="numeric", length = 10)

for (i in seq_along(myDat)) {
  
  myDat[i] <- round(runif(1), digits=2)
  cat("loop number =", i, "vector element =", myDat[i], "\n")
  
}

###########################################################################################
# dont change dimensions of an object inside a loop (cbind, c, list, rbind etc)

myDat <- runif(1)
for (i in 2:10) {
  temp <- round(runif(1), digits=2)
  myDat <- c(myDat, temp)
  cat("loop number =", i, "vector element =", myDat[i], "\n")
}

###########################################################################################
# not when you don't need to

myDat <- 1:10

for (i in seq_along(myDat)) {
  myDat[i] <- myDat[i] +myDat[i]^2
  cat("loop number =", i, "vector element =", myDat[i], "\n")
}

# we should just do this

z <- 1:10
z <- z + z^2

###########################################################################################
# be alert to the vector element and the counter variable i vs z[i]

z <- c(10,2,4)

for (i in seq_along(z)) {
  cat("i = ", i, "z[i] =", z[i], "\n")
}

###########################################################################################
# gaining control over the counter variable 
# next skips certain elements

z <- 1:20

# we can operate on the odd number elements

for (i in seq_along(z)) {
  if (i %% 2==0) next
  print(i)
}

###########################################################################################
# a faster better way to do this 
z <- 1:20
zsub <- z[z %% 2!=0]
z %% 2!=0

for (i in seq_along(zsub)) {
  cat("i = ", i, "zsub[i] =", zsub[i], "\n")
  
}

###########################################################################################
# break conditionaly gets you out of the loop

###########################################################################
# function name: RanWalk
# description: stochastic random walk
# parameters: 
#       n1 = initial population size
#       lambda = finite rate of increase (constnat multiplier)
#       times = number of time steps
#       noiseSD = sd of normal distribution with mean = 0
# output: vector n with popluation sizes > 0 until extinction NA
###########################################################################

library(tcltk)

RanWalk <- function(n1 = 50, 
                    times = 100, 
                    lambda = 1.001, 
                    noiseSD = 10){
 
  n <- rep(NA, times)
  n[1] <- n1
  noise <- rnorm(n=times, mean=0, sd=noiseSD)
  
  for (i in 1:(times-1)){
    n[i + 1] <- lambda*n[i] + noise[i]
    if(n[i+1] <= 0){
      n[i+1] <- NA
      #cat("Population extinction at time", i-1, "\n") 
      #tkbell()
      break}
  }
  
  return(n) 
}

plot(RanWalk(), type = "o")

###########################################################################
# END OF FUNCITON
###########################################################################





###########################################################################
# using double for loops

m <- matrix(round(runif(20), digits=3), nrow=5)

# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
print(m)

# loop over columns
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)


# double loop with rows and columns
m <- matrix(round(runif(20), digits=3), nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  }
}

print(m)

# write function to sweep pver model parameters
####################################################################
# FUNCTION: SpeciesAreaCurve
# power function for S and A
# input:  A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant
# output: smooth graph with parmeters shown
# ------------------------------------------------------------------

SpeciesAreaCurve <- function(A=1:5000, c=0.5, z=0.26) {
  S <- c*(A^z)
  
  return(S)
}

head(SpeciesAreaCurve())


# write function to sweep pver model parameters
####################################################################
# FUNCTION: SpeciesAreaPlot
# power function for S and A
# input:  A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant
# output: S a vector of predicted species richness
# ------------------------------------------------------------------

SpeciesAreaPlot <- function(A=1:5000, c=0.5, z=0.26) {

  plot(x=A,y=SpeciesAreaCurve(A=A,c=c,z=z),
       type="l",
       xlab = "Island Area",
       ylab = "S",
       ylim = c(0,1000)
       )
  
  mtext(paste("c = ", c, "z = ", z), cex=0.7)
  
  return(cat("made a plot"))
}

SpeciesAreaPlot()


####################################################################
# FUNCTION: myExpandGrid
# homegorwn expand grid function
# input: 2 vectors 
# output: data frame with parameters swept
# ------------------------------------------------------------------
myExpandGrid <- function(a=1:4, b=c(300,400,500)) {
  Factor1 <- rep(a,times=length(b))
  Factor2 <- rep(b, each=length(a))
  
  return(list(varA=Factor1, varB=Factor2))
}

myExpandGrid()


###################################################################################################
#MORE FOR LOOPS STUFF:














####################################################################
# FUNCTION: SA_Output
# grab results fomr species vector
# input: vctor of speices richness function 
# output: list of max-min, and coeficcients of variation
# ------------------------------------------------------------------
SA_Output <- function(S=1:10) {
  
  sumStats <- list(SDelta=max(S) -min(S),
                   SVC =sd(S)/mean(S))
  
  return(list(sumStats))
}

SA_Output()


#################################################################################################
# PROGRAM BODY

# model parameters
Area <- 1:5000
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.30)

# model frame
modelFrame <- expand.grid(c=cPars, z=zPars)
modelFrame$SDelta <- NA
modelFrame$SCV <- NA

# cycle through calculations:
for (i in 1:nrow(modelFrame)) {
  # generate S vector
  temp1 <- SpeciesAreaCurve(A=Area, c=modelFrame[i,1], z=modelFrame[i,2])
  
  # caclulate output stats
  temp2 <- SA_Output(temp1)
  
  # pass results back to the modelFrame
  modelFrame[i,c(3,4)] <- temp2
}

print(modelFrame)


################################################################################################
# SWEEPING PARAMETERS FOR A STOCHASTIC MODEL


RanWalk()


####################################################################
# FUNCTION: rWalkOutut
# summarizes unavariate metric to describe pop trajectory
# input: vctor of pop sizes
# output: length of positive elements in vector
# ------------------------------------------------------------------
rWalkOutput <- function(v=c(1:10, c(NA,NA))) {

  lenPop <- length(v[is.na(v)==FALSE])
  return(lenPop)
}

# global varables
SerLen <- 500
lambda <- c(0.95, 0.99, 1.00, 1.01, 1.05)
noiseSD <- c(0,5,10,20)
n1 <- 50 # initial pop size
reps <- 20 # number of replications for each parameter combo

ranOut <- expand.grid(n1=n1, reps=reps,
                      SerLen = SerLen,
                      lambda=lambda,
                      noiseSD=noiseSD)

# add summary respnose varaibles:
ranOut$meanLen <- NA
ranOut$sdLen <- NA

SurvTime <- rep(NA,reps)

# begin program body
for (i in 1:nrow(ranOut)) { # start of paremeter loop
  for (j in 1:reps){  # start of replicate loop
    
    temp <- RanWalk(times=ranOut$SerLen[i],
                    n1=ranOut$n1[i], 
                    lambda = ranOut$lambda[i],
                    noiseSD = ranOut$noiseSD[i])
    SurvTime[j] <- rWalkOutput(temp)
  } # end of replicate loop
  ranOut$meanLen[i] <- mean(SurvTime)
  ranOut$sdLen[i] <- sd(SurvTime)
} # end of parameter loop

ranOut




