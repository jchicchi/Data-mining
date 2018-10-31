# In-Class Assignment 24, Apr 24, 2017



# Topic:
# Understanding classifier performance


######################################################################
# Exercise 2: 
# Bias Variance tradeoff

# For an rpart tree, compute the bias^2 and variance for increasing complexity. 
# Control complexity with the cp parameter. Assume that noise=0. 

# For each value of cp use 10 bootstrap samples. 
# Use these values for cp=seq(0.001,0.5,by=0.001)

# Plot the values you computed. 

# Compute the correlation between bias^2 and complexity and between 
# variance and complexity.

# Use Basetable.Rdata available at: https://www.dropbox.com/s/on5hleqwe8tgv8w/Basetable.Rdata?dl=0
# The dependent variable is called Retention.
# Answer:


load("Basetable.Rdata")


trainind <- sample(1:nrow(Basetable),round(0.5*nrow(Basetable)))
BasetableTRAIN <- Basetable[trainind,]
BasetableTEST <- Basetable[-trainind,]
str(BasetableTEST)
BasetableTRAIN$CustomerID <- NULL
BasetableTEST$CustomerID <- NULL


library(rpart)
#####rpart

ii <- 0
bias <- numeric()
variance <-  numeric()
cps <- c(seq(0.001,0.5,by=0.001))
for (cp in cps) {
  	ii <- ii + 1

	  
    #precallocate matrix
		pred <- data.frame(matrix(0,nrow=nrow(BasetableTEST),ncol=10))
    #build 10 trees on 10 boostrap samples
		for (i in 1:10) {
			#create boostrap sample
      trainind <- sample(1:nrow(BasetableTRAIN),replace=TRUE)
			BasetableTRAINboot <- BasetableTRAIN[trainind,]
				
			#create tree
			tree <- rpart(Retention ~ ., BasetableTRAINboot,control=rpart.control(cp = cp))
			#predicton test set
			pred[,i] <- predict(tree,BasetableTEST)[,2]
					
		}	

  #store bias^2 and variance
	df <- data.frame(bias=(as.integer(as.character(BasetableTEST$Retention))-rowMeans(pred))^2,
                   variance=as.numeric(apply(pred,1,var)))
	sums <- colSums(df)
	bias[ii] <- sums[1]
	variance[ii] <- sums[2]
	cat(ii/length(cps), "\n")
}


plot(-cps,bias,type="l",ylim=c(0,55),ylab="bias and variance",xlab="complexity")
points(-cps,variance,ylim=c(0,0.55),type="l")

cor(-cps,bias) #-0.935: if bias is high, complexity is low
cor(-cps,variance) #0.7772: if variance is high, complexity is high