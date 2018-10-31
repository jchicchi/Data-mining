# In-Class Assignment 17, Mar 27, 2017
# (deadline: Mar 27, 2017, 1:55pm)

######################################################################

# Topic:
# Bagged trees

library(AUC)
library(rpart)

######################################################################
# Exercise 2: 
# Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
trainind <- sample(1:nrow(BasetableTRAIN),10000,TRUE)
train <- BasetableTRAIN[trainind,]
ytrain <- yTRAIN[trainind]
valind <- sample(1:nrow(BasetableVAL),10000,TRUE)
val <-   BasetableVAL[valind ,]
yval <- yVAL[valind]
testind <-  sample(1:nrow(BasetableTEST),10000,TRUE)
test <- BasetableTEST[testind,]
ytest <- yTEST[testind]
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()
# Tune both the number of trees in a bagged tree (10, 50, 100, 200, 500, 750, 1000), and 
# cp (0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1). Create a plot
# with seven lines (one for size=10 (green), size=50 (red), size=100 (blue), ...).
# The y-axis represents the AUC, and the x-axis represents the cp.
# Answer:



samples <- c(10, 50, 100, 200, 500, 750, 1000)
candidates <- c(0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1)

pb <- txtProgressBar(min=0, max=length(samples) # create pogress bar
                     *length(candidates), style=3)

aucstore <- data.frame(matrix(0
                              , nrow=length(samples)
                              , ncol=3
                              , dimnames=list(as.character(samples)
                                              , c("cp","samples","auc"))))

ensembleoftrees <- list()
j <- 0

#An alternative to the solution below would be to build 1000 trees for a given cp
#and then subset those trees.
for (m in samples){
        for (i in candidates) {
                j <- j + 1
                
                for (ii in 1:m) {
                        # generating bootstrap sample
                        bootstrapsampleindicators <- sample.int(n=nrow(train)
                                                , size=nrow(train)
                                                , replace=TRUE)
                        # compute ensemble
                        ensembleoftrees[[ii]] <- rpart(ytrain[bootstrapsampleindicators] ~ .
                                       , train[bootstrapsampleindicators,]
                                       , control=rpart.control(cp = i))
                }
                
                baggedpredictions <- data.frame(matrix(NA,ncol=m # predict using val
                                                       , nrow=nrow(val)))
                for (ii in 1:m){
                        baggedpredictions[,ii] <- as.numeric(predict(
                                ensembleoftrees[[ii]], val)[,2])
                        }
                
                finalprediction <- rowMeans(baggedpredictions[,,drop=FALSE])
                
                aucstore[j,] <- c(i,m,AUC::auc(roc(finalprediction,yval)))
      
                # update progress bar
                setTxtProgressBar(pb, j)
    }
  
}
close(pb) # close progress bar

aucstore <- aucstore[order(aucstore$cp,aucstore$samples),]

plot(aucstore[samples==10,"cp"]
     , aucstore[samples==10,"auc"]
     , col="green"
     , type="l"
     , ylab="AUC"
     , xlab="cp")

legend("bottomright"
       , legend=c("size=10","size=50","size=100","size=200","size=500","size=750","size=1000")
       , col=c("green","red","blue","orange","gray","purple","pink")
       , lty=1)

lines(aucstore[samples==50,"cp"]
      , aucstore[samples==50,"auc"]
      , col="red")

lines(aucstore[samples==100,"cp"]
      , aucstore[samples==100,"auc"]
      , col="blue")

#add more lines similar to above
lines(aucstore[samples==200,"cp"]
      , aucstore[samples==200,"auc"]
      , col="orange")

lines(aucstore[samples==500,"cp"]
      , aucstore[samples==500,"auc"]
      , col="gray")

lines(aucstore[samples==750,"cp"]
      , aucstore[samples==750,"auc"]
      , col="purple")

lines(aucstore[samples==1000,"cp"]
      , aucstore[samples==1000,"auc"]
      , col="pink")


