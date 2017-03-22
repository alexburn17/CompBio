##################################################################################
# P. Alexander Burnham
# March 8, 2017
# Structured Programming
##################################################################################
###########################--Structured Programming--#############################
##################################################################################


# function template:
#################################################################################
# FUNCTION: FunctionName
# one line description
# input: x
# output: x
#################################################################################
# FunctionName <- function() {

#  return("testing......FunctionName")
# }
#################################################################################




#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#               Beginning Functions That make up program body                   #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





#################################################################################
# FUNCTION: GetData
# read our data in
# input: .csv file
# output: data frame
#################################################################################
GetData <- function(fileName=NULL) {
  
  if(is.null(fileName)){
    dataFrame <- data.frame(varA <- runif(10),
                            varB <- runif(10))
  } else {
  dataFrame <- read.table(file=fileName,
                          header=TRUE,
                          sep = ",",
                          stringsAsFactors = FALSE)
  }
  
  return(dataFrame)
}
#################################################################################



#################################################################################
# FUNCTION: FitRegressionModel
# fits an ordinary least squares regression
# input: x and y numeric vectors same length
# output: entire model summary from lm()
#################################################################################
FitRegressionModel <- function(xVar=runif(10), 
                               yVar=runif(10)) {
  dataFrame <- data.frame(xVar,yVar)
  lMod <- lm(yVar~xVar, data=dataFrame)
  summary(lMod)
  
  return(summary(lMod))
}
#################################################################################



#################################################################################
# FUNCTION: SummarizeOutput
# pull elements from model summary 
# input: list from model summary (call from lm())
# output: vector of regression residuals 
#################################################################################
SummarizeOutput <- function(z=NULL) {
  if(is.null(z)){
    z <- summary(lm(runif(10)~runif(10)))
  }
  
  return(z$residuals)
}
#################################################################################



#################################################################################
# FUNCTION: GraphOutput
# graph data and fitted OLS line
# input: x and y vectors (continuous and same length)
# output: scatter plot
#################################################################################
GraphOutput <- function(xVar=runif(10), yVar=runif(10)) {
  dataFrame <- data.frame(xVar, yVar)
  plot(x=dataFrame$xVar, 
       y=dataFrame$yVar,
       pch=21,
       bg="lightblue",
       cex=2)
  lMod <- lm(yVar~xVar, data=dataFrame)

    abline(lMod)
  
message("Message: Created a Graph")
}
#################################################################################








#################################################################################
############################### program body ####################################
#################################################################################

GetData()

FitRegressionModel()

SummarizeOutput()

GraphOutput()

