require(foreign)
require(stringr)
require(plyr)
library(RCurl)
library(RJSONIO)
setwd("~/Google Drive/DataScience/rawData/")
rm(list=ls())

###########################################################
## Get Latitude and Longitute of the Data 
###########################################################

#Sets the url, for the API call to google maps
#https://developers.google.com/maps/documentation/geocoding/
#http://msdn.microsoft.com/en-us/library/ff701714.aspx
url <- function(address, return.call = "json", sensor = "false",
                service="bing", key=NULL, zip=FALSE)
{
  if (service == "bing"){
    root <- "http://dev.virtualearth.net/REST/v1/Locations/US/NY/NYC/"
    u <- paste(root, address, "?o=", return.call,
               "&key=", key, sep = "")
  } else if (service == "google") {
    root <- "http://maps.google.com/maps/api/geocode/"
    u <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  } 
  return(URLencode(u))
}

#Gets latitute and longitude from the data
geoCode <- function(address, service="bing", key=NULL) {

  #Build webpage query and get results from api
  u <- url(address, key=key, service=service)
  doc <- getURL(u)
  x <- fromJSON(doc,simplify = FALSE)
  
  #Extract useful information from the JSON results
  if (service == "google"){
    #Check status of API call
    if(x$status=="OK") {
      lat <- x$results[[1]]$geometry$location$lat
      lng <- x$results[[1]]$geometry$location$lng
      return(c(lat, lng))
    } else {
      stop("Address not found")
    }} 
  else if (service == "bing") {
    
    if(x$statusDescription=="OK") {
      lat <- x$resourceSets[[1]]$resources[[1]]$geocodePoints[[1]]$coordinates[[1]]
      lng <- x$resourceSets[[1]]$resources[[1]]$geocodePoints[[1]]$coordinates[[2]]
      return(c(lat, lng))
    } else {
      stop("Address not found")
    }
  }
}

#Try to get the latitude, longitude. Otherwise returns the address
robustGeoCode <- function(address, service="bing", key=NULL) {
  tryCatch(geoCode(address, service, key),
           error = function(e) {address})
}

bing.key <- "AiRB-UTb9-p8GoK_Cux50eijGmpmT-YeYNw-Kjlws_qKngRkgt_C8Fqrky60bEry"

#Load Data into Data Frames
years <- c("2003", "2005")
for (year in years){
  assign(paste("df", year, sep="."), read.spss(paste(year, ".por", sep=""), trim.factor.names=TRUE,
                                               to.data.frame = TRUE))
}

df.2004 <- read.csv(file="2004.csv", header=T, sep=",")

#Join data frames into one big data frame
names(df.2004) <- toupper((names(df.2004)))
attributes <- c("ADDRNUM", "STNAME", "STINTER", "CROSSST")

df.2003 <- df.2003[attributes]
df.2004 <- df.2004[attributes]
df.2005 <- df.2005[attributes]
data.df <- rbind(df.2003, df.2004, df.2005)

#Clean whitespaces
#From the start and from the end
FixAddress <- function(address.data) {
  
  #Trim whitespace from start and end of string.
  address.data <- colwise(str_trim)(address.data)
  
  #Remove excess of whitespace
  address.data <- colwise(gsub, pattern="\\s+", replacement=" ")(address.data)
  
  #Remove unwanted patterns
  remove.patterns <- c('N/A',  '\\b0\\b',  '0:00',  '+',  '[.]+',	'@',	
                       '/A',	'/CO',	'/D',	'/FO',	'/O',	'/F',	'`',	'1/F/O',	
                       '1/ P O',	'1/O',	'A/C',	'B/O',	'C//', 'C/', 'C./',
                       'C/[A-z]',	'F/[A-z]',	'CO',	'CP',	'Corner',
                       'F/LO',	'FLO',	'FLB',	'OPP',	'OPP.',	'OPPOSIT',	'R/O',	'REAR',
                       'REAR OF',	'N/E C/O',	'N/E/C',	'N/E/C/O',	'N/W',	'N/S',	'N/O',
                       'S/E C/O',	'S/W C/O', 'S/E/C/O', 'N/W/C/O', 'N/W C/O', 
                       'S/W/C/O', 'S/W C/O', '1/F/O', '1/ P O"', 'OPP\\.', 
                       'OPP\\.', 'BLANK', 'ACROSS', 'ALLEY', 'LOBBY',
                       'NA', 'NONE', '`', 'Corner', 'N/W/C', 'S/W/C', 'S/E/C', 'C/O',
                       'C/O', 'F/O', 'R/O', 'I/O') 
  
  for (pat in remove.patterns) {
    address.data <- colwise(gsub, pattern=pat, replacement="")(address.data)
  }
  
  return (address.data)
}

#Get XY Coordinates
addresses <- paste(address.data$ADDRNUM, address.data$STNAME, 
                   address.data$STINTER, address.data$CROSSST,
                   sep=" ")
addresses <- str_trim(addresses)

bad.entries <- list()
xy.coordinates <- list()
good <- 1
bad <- 1
index <- 15000
for (address in addresses[15000:50000]) {
  
  #Try to get the x, y coordinate
  result <- robustGeoCode(address, key=bing.key)
  
  #If there is a success, record
  if (class(result) == "numeric") {
    xy.coordinates[[good]] <- c(result, index)
    good <- good + 1
  } else { #otherwise, get the bad entry
    bad.entries[[bad]] <- c(result, index)
    bad <- bad + 1
  }
  
  index <- index + 1
}

coordinates <- do.call(rbind, xy.coordinates)



