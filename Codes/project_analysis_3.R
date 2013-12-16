#### 3. Logistic Regression on P(Frisked / Searched | Stopped)
## Data: 2012 data
require(stringr)
require(cwhmisc)
require(lubridate)
require(glmnet)
require(useful)
require(devtools)
getwd()
setwd("C:/Users/Image 17/Documents/Fall 2013/3. Intro to Data Science/Project")
load("allLoadData.RData")
load("logitAnalysis.RData")

# Logistic Regression on P(frisked / searched | stopped)
# Frisked (1 if frisked, 0 o.w) ~ race + age + sex + firearm / weapon possession + location (dummy)

# INFO REGARDING STOP: YEAR, PCT, TIMESTOP, SEX, RACE, AGE, firearm/weapon possession (27:31) 
# output variable: FRISKED, SEARCHED
names(df.2012)
myvars <- c(1, 2, 5, 23:24, 27:31, 81:82, 84)
data <- df.2012[myvars]

# Split those that require manipulation and not's
levels(data$TIMESTOP)
data$TIMESTOP <- as.character(factor(as.integer(as.character(data$TIMESTOP))))
summary(data$TIMESTOP)
data$index <- str_detect(string=data$TIMESTOP, pattern="^\\d{4}$")
# table(data$index)
data.mani <- subset(x=data, subset=data$index==FALSE)
data.mani$TIMESTOP <- sapply(data.mani$TIMESTOP, padding, space = 4, with = "0", to = "right")
data.mani$HOUR <- hour(strptime(data.mani$TIME, format='%H%M'))
data.no.mani <- subset(x=data, subset=data$index==TRUE)
data.no.mani$HOUR <- hour(strptime(data.no.mani$TIME, format='%H%M'))
data <- rbind(data.mani, data.no.mani)

sapply(data, class)
data$POSSESSION <- NULL
data$PISTOL <- factor(as.numeric(data$PISTOL) - 1)
data$RIFLSHOT <- factor(as.numeric(data$RIFLSHOT) - 1)
data$ASLTWEAP <- factor(as.numeric(data$ASLTWEAP) - 1)
data$KNIFCUTI <- factor(as.numeric(data$KNIFCUTI) - 1)
data$MACHGUN <- factor(as.numeric(data$MACHGUN) - 1)

table(data$RACE)
levels(data$RACE) <- c("Asian", "Black", "Native American","Hispanic-black","Hispanic-white", "Unknown", "White","Other")
table(data$PCT)

############ DATA CLEANING DONE

## Logit regression for FRISKED
FRformula <- FRISKED ~ RACE + AGE + SEX + PISTOL + RIFLSHOT + ASLTWEAP + KNIFCUTI + MACHGUN + PCT + HOUR - 1
FR.X <- build.x(FRformula, data=data, contrasts=FALSE)
FR.Y <- build.y(FRformula, data=data)
FRfit <- cv.glmnet(x=FR.X, y=FR.Y, family="binomial", nfold=5)
FRfit$lambda.min
plot(FRfit) # proper value of lambda (first line on the left: min(cross-validation), 
# second line: within one stdev of the min value)

plot(FRfit$glmnet.fit)
coef(FRfit, s="lambda.min")
coef(FRfit, s="lambda.1se") # more parsimony, less variables
coefMatrix <- as.matrix(coef(FRfit$glmnet.fit))

## Logit regression for SEARCHED
SRformula <- SEARCHED ~ RACE + AGE + SEX + PISTOL + RIFLSHOT + ASLTWEAP + KNIFCUTI + MACHGUN + PCT + HOUR - 1
SR.X <- build.x(SRformula, data=data, contrasts=FALSE)
SR.Y <- build.y(SRformula, data=data)
SRfit <- cv.glmnet(x=SR.X, y=SR.Y, family="binomial", nfold=5)
SRfit$lambda.min
plot(SRfit) # proper value of lambda (first line on the left: min(cross-validation), 
# second line: within one stdev of the min value)

plot(SRfit$glmnet.fit)
coef(SRfit, s="lambda.min")
coef(SRfit, s="lambda.1se") # more parsimony, less variables
SRcoefMatrix <- as.matrix(coef(SRfit$glmnet.fit))

# Logit regression 2
FRlogit <- glm(FRISKED ~ RACE + AGE + SEX + PISTOL + RIFLSHOT + ASLTWEAP + KNIFCUTI + MACHGUN + PCT + HOUR - 1, data = data, family = "binomial")
summary(FRlogit)
SRlogit <- glm(SEARCHED ~ RACE + AGE + SEX + PISTOL + RIFLSHOT + ASLTWEAP + KNIFCUTI + MACHGUN + PCT + HOUR - 1, data = data, family = "binomial")
summary(FRlogit)
## odds ratios and 95% CI
# exp(cbind(OR = coef(FRlogit), confint(FRlogit)))


# Prediction
levels(data$RACE)
sort(unique(data$AGE))
levels(data$SEX)
levels(data$PCT)

for(lel in levels(data$PCT)){
  print(sprintf("<option value=%s>%d</option>",lel, as.numeric(lel)))
}


sort(unique(data$HOUR))
levels(data$PISTOL)
levels(data$RIFLSHOT)
levels(data$ASLTWEAP)
levels(data$KNIFCUTI)
levels(data$MACHGUN)
race <- c() # return dropdown menu value here (users choose some value)
newInput <- with(data, data.frame(RACE = RACE, SEX = SEX, AGE = AGE, PISTOL = PISTOL, RIFLSHOT = RIFLSHOT, ASLTWEAP = ASLTWEAP, KNIFCUTI = KNIFCUTI, MACHGUN = MACHGUN, PCT = PCT, HOUR = HOUR))
newInput$FRISKED <- predict(FRlogit, newdata = newInput, type = "response")
newInput$SEARCHED <- predict(SRlogit, newdata = newInput, type = "response")

save.image(file="logitAnalysis.RData")