# At-Home Exercises 23, Apr 19, 2017

# Topic:
# Performance measures for binary classification models

# Subsequent questions may depend on previous ones.

######################################################################
# Exercise 1: 
#Consider the following vector:
head(vec <- runif(10))
#Compute the following dispersion measures:
#range
#interquartile range
#standard deviation
#mean absolute deviation
#median absolute deviation
#Answer:

#range
diff(range(vec))
# or 
max(vec) - min(vec)

#interquartile range
IQR(vec)
as.numeric(quantile(vec,probs=0.75)-quantile(vec,probs=0.25))

#standard deviation
sd(vec)
#or
sqrt(mean((vec-mean(vec))^2)) #divide by n
sqrt(sum((vec-mean(vec))^2)/(length(vec)-1)) #divide by n-1 

#mean absolute deviation
mean(abs(vec-mean(vec)))

#median absolute deviation
median(abs(vec-median(vec)))
mad(vec, constant=1) #FYI (not important): we can change the constant to obtain consistency 
                     #with the standard deviation in case of a normal distribution, and large n


