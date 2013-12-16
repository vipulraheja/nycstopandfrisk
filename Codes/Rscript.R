setwd("Dropbox/2013-2/IntroDataScience/CourseProject/Data/")
load("~/Dropbox/2013-2/IntroDataScience/CourseProject/Data/AllLoadedData.RData")
require(foreign)
require(BurStMisc)
require(lubridate)
require(stringr)

rm(list=ls())
years <- c(2003:2012)
years <- c("2003", "2005", "2006", "2009", "2010", "2011", "2012")

for (year in years)
{
  assign(paste("df", year, sep="."), read.spss(paste(year, ".por", sep=""), to.data.frame = TRUE))
}

df.2004 <- read.csv(file="2004.csv", header=T, sep=",")
df.2007 <- read.csv(file="2007.csv", header=T, sep=",")
df.2008 <- read.csv(file="2008.csv", header=T, sep=",")

corner(df.2003)

names(df.2004) <- toupper((names(df.2004)))
names(df.2007) <- toupper((names(df.2007)))
names(df.2008) <- toupper((names(df.2008)))

SymmetricDifference <- function(A, B) {
  union(setdiff(A, B), setdiff(B, A))
}

attributes <- c("RESCODE ",	"PREMTYPE ",	"PREMNAME ",	"ADDRNUM ",	"STNAME ",	"STINTER ",	"CROSSST ",	"APTNUM ",	"CITY ",	"STATE ",	"ZIP ",	"ADDRPCT ",	"SECTOR ",	"BEAT ",	"POST ",	"XCOORD ",	"YCOORD ",	"HAIRCOLR ",	"EYECOLOR ",	"RF_KNOWL ",	"SEX ",	"RACE ",	"AGE ",	"HT_FEET ",	"WEIGHT ",	"PF_HANDS ",	"PF_WALL ",	"PF_GRND ",	"PF_DRWEP ",	"PF_PTWEP ",	"PF_BATON ",	"PF_HCUFF ",	"PF_PEPSP ",	"PF_OTHER ",	"RF_VCRIM ",	"RF_OTHSW ",	"AC_PROXM ",	"RF_ATTIR ",	"CS_OBJCS ",	"CS_DESCR ",	"CS_CASNG ",	"CS_LKOUT ",	"RF_VCACT ",	"CS_CLOTH ",	"CS_DRGTR ",	"CS_FURTV ",	"RF_VERBL ",	"CS_VCRIM ",	"CS_BULGE ",	"CS_OTHER ",	"RF_FURT ",	"RF_BULG ",	"RF_KNOWL ",	"YEAR ",	"PCT ",	"DATESTOP ",	"TIMESTOP ",	"CRIMSUSP ",	"EXPLNSTP ",	"OTHPERS ",	"ARSTMADE ",	"FRISKED ",	"SEARCHED ",	"PISTOL ",	"RIFLSHOT ",	"ASLTWEAP ",	"KNIFCUTI ",	"MACHGUN ",	"OTHRWEAP ")
attributes <- str_trim(attributes, side="both")

names(df.2006)[grep("RES", names(df.2006))] <- "RESCODE"
names(df.2006)[grep("PRENAM", names(df.2006))] <- "PREMNAME"
names(df.2006)[grep("PREMTYP", names(df.2006))] <- "PREMTYPE"
names(df.2006)[grep("ADRNUM", names(df.2006))] <- "ADDRNUM"
names(df.2006)[grep("STRNAME", names(df.2006))] <- "STNAME"
names(df.2006)[grep("STRINTR", names(df.2006))] <- "STINTER"
names(df.2006)[grep("ADRPCT", names(df.2006))] <- "ADDRPCT"

write.table(x=df.2003[attributes], file="2003data.csv", sep=",", row.names=FALSE)