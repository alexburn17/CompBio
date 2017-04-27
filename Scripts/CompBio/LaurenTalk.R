###########################################################################################
# Spacial Anlaysis
# 12, April 2017
# P. Alexander Burnham
###########################################################################################

# loading necessary libraries:
library("ggmap")
library("maps")
library("raster")
library("maptools")
library("plyr")
library("rworldmap")
library("sp")
library("reshape2")
library("rJava")
library("dismo")

# Setting Working Directory:
setwd("~/ComputationalBiology/CompBio/Scripts/CompBio")

# Read in Data:
sites <- read.table("SamplingSites.csv", header=TRUE, sep = ",", stringsAsFactors = FALSE) 

# assign points to be plotted
points<-sites[,4:5] 

# creating the map:
map<-qmap(location=c(lon = -72.897343, lat = 44.351406),zoom=9, maptype="toner-lite",source="stamen")

map + geom_point(data = points, aes(x = Longitude, y = Latitude), color="red", size=3, alpha=0.5)

# map with vermont
library(maps)
map(database="state", region='vermont', interior=T, fill=T, col="lightgreen")
library(sp)
coordinates(points)<- ~ Longitude + Latitude
points(x=points, pch=17, col="red")


### The following line usually works, maybe something is wrong with the website?
# bioclim <- getData('worldclim', var='bio', res=10)

### Reading in climate and landcover data from tif file
library(raster)
library(rgdal)

bioclimLC<-stack("bioclim-landuse1.tif") # we need to 'stack' the layers on top of each other so that it is one file
names(bioclimLC)<-c("landcover","bio1","bio2","bio3","bio4","bio5","bio6","bio7","bio8","bio9","bio10","bio11","bio12","bio13","bio14","bio15","bio16","bio17","bio18","bio19") #renaming
bioclimLC1<-crop(x=bioclimLC, extent(-74,-71, 42.5, 45.5)) # cropping it to Vermont's extent
plot(bioclimLC1)

# running tests:
set.seed(44) 
points<-sites[,4:5] # subset only the latitudes and longitudes
fakePres<-sample(c(rep("Y", 9),rep("N",9))) ## creating fake presence data to compare sites
points<-cbind(points, fakePres)
climData <- extract(x=bioclimLC1, y=points[, c("Longitude", "Latitude")]) # extracting values of each layer (19 bioclim, 1 landcover) at each of the sites
dbio1 <- cbind(points, climData) 

summary(aov(formula=bio1~fakePres, data=dbio1)) # comparing the annual mean temperature (bio1) of the sites 'with disease' and without

boxplot(bio1~fakePres, data=dbio1, col=c("blue","red"))

mean(subset(dbio1, fakePres=="Y")$bio1) # checking means


mean(subset(dbio1, fakePres=="N")$bio1)

fakeP <- ifelse(dbio1$fakePres=="Y", 1, 0) # assigning presence as '1' and absence as '0' for the model

dbio1$fakeP<-fakeP # adding our new column of 0's and 1's to the original climate dataset
MyModel <- glm(fakeP~bio1, family=binomial("logit"),data=dbio1)
summary(MyModel)

plot(x=dbio1$bio1,y=fakeP,xlab="Annual Mean Temperature (C)",ylab="P(Extant)", type='n', ylim=c(0,1))
curve(predict(MyModel,data.frame(bio1=x),type="resp"),add=T)
points(x=dbio1$bio1,y=fakeP,cex=2,pch=21,bg="lightblue")
