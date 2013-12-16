# CLUSTERING
getwd()
setwd("C:/Users/Image 17/Documents/Fall 2013/3. Intro to Data Science/Project")
load("clusteringAnalysis.RData")
require(fpc)
require(mvtnorm)
require(useful)

# Now the clustering using fpc package
# names(data2008)
# sapply(data2008, class)
# Continuous variables in vector cont, discrete variables in vector disc
cont <- c(3,4,8)
disc <- c(1,2,5,6,7)
data.list.2006 <- discrete.recode(data2006, xvarsorted=FALSE, continuous=cont, discrete=disc)
data.list.2008 <- discrete.recode(data2008, xvarsorted=FALSE, continuous=cont, discrete=disc)
# Recoded Data (now a matrix, ready for flexmixedruns)
data.recoded.2006 <- data.list.2006$data
data.recoded.2008 <- data.list.2008$data

######### Explanation of clustering: continuous - Gaussian distribution, categorical - independent multinomial

#### Clustering for 3 continuous variables, and 5 categorical variables using flexmixedruns
#### flexmixedruns ﬁts a latent class mixture (clustering) model where some variables are continuous
#### and modelled within the mixture components by Gaussian distributions and some variables are
#### categorical and modelled within components by independent multinomial distributions. The ﬁt is
#### by maximum likelihood estimation computed with the EM-algorithm. The number of components
#### can be estimated by the BIC.

# cLUSTERING FOR 2006 using 3 simulation runs per k, k ranging from 2 to 7 (each takes over 2-3 hours)
cluster.2006 <- flexmixedruns(data.recoded.2006, continuous=3, discrete=5,
                              simruns=3,n.cluster=2:7,allout=TRUE)
#cluster.2008 <- flexmixedruns(data.recoded.2008, continuous=3, discrete=5,
simruns=3,n.cluster=2:7,allout=TRUE)

#####################################################################
############################## THIS IS WHERE YOU COME IN, ESTEBAN
# Printing results for 2006
# For the whole model
cluster.2006$optimalk # optimal number of k for the clustering model
class(cluster.2006$optsummary) # summary (class: flexmix)
cluster.2006$bicvals # vector of BIC for each k
cluster.2006$ppdim # vector of categorical variable-wise numbers of categories

# The model for particular k, ex) k = 7
cluster.2006$flexout[[7]]@k # number of clusters
cluster.2006$flexout[[7]]@size # number of observations in each cluster
cluster.2006$flexout[[7]]@logLik # Log-likelihood at EM convergence

# center: mean values of variables age, weight, and height(in inches)
# cov : covariance values of continuous variables listed above
# pp: categorical variables
# pp[[1]]: sex, pp[[2]]: race, pp[[3]]: hair color, pp[[4]]: eye color, pp[[5]]: build
# values of categorical variables
data.list.2006$discretelevels[[1]]
data.list.2006$discretelevels[[2]]
data.list.2006$discretelevels[[3]]
data.list.2006$discretelevels[[4]]
data.list.2006$discretelevels[[5]]

# Check that this is a list of information for the specific cluster
# We want the $center, $cov, $pp to be linked to appropriate levels

for (k in 2:7){
  
  attributes <- list()
  for (i in 1:k){
    
    attributes[[i]] <- as.character(round(cluster.2006$flexout[[k]]@components[[i]][[1]]@parameters$center, 3))
    for (j in 1:5) {
      temp <- cluster.2006$flexout[[k]]@components[[i]][[1]]@parameters$pp[[j]]
      levels <- data.list.2006$discretelevels[[j]]
      if (j == 1){
        attributes[[i]] <- c(attributes[[i]], round(temp[1:2],3))
      } else{
        attributes[[i]] <- c(attributes[[i]], levels[which(temp %in% sort(temp,decreasing=T)[1:3])])
      }
    }
  }
  
  #Build data frame
  temp <-as.data.frame(do.call(rbind, attributes), row.names=NULL)
  colnames(temp) <- c("Age", "Weigth", "Height", "Male", "Female",
                      "Race1", "Hair Color", "Eye Color",
                      "Build")
  row.names <- c("Cluster 1")
  for (l in 2:k){
    row.names <- c(row.names, paste0("Cluster ", l))
  }
  rownames(temp) <- row.names
  
  assign(paste0("df.cluster.", k), temp)
}


# Printing results for 2008
#print(cluster.2008$optimalk)
#print(cluster.2008$optsummary)
#print(cluster.2008$flexout@cluster)
#print(cluster.2008$flexout@components)

# Plotting
classifyCluster <- cluster.2006$flexout[[cluster.2006$optimalk]]@cluster
clusplot(x=data2006, cluster.2006$flexout[[cluster.2006$optimalk]]@cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

# Plotting to look at patterns of the clusters
library(cluster)
? clusplot
clusplot(x=data, dataK9$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)
# Using Principle 
plot(data[c("AGE", "WEIGHT")], col = dataK9$cluster)
points(dataK3$centers[,c("AGE", "WEIGHT")], col = 1:13, pch = 8, cex=2)

# SAVE
rm(data.recoded.2006, data.recoded.2008, data2006, data2008)
save.image(file="clusteringAnalysis_2006_2.RData")