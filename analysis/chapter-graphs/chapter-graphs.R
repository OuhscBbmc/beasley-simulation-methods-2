rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("SomethingSomething.R")

# ---- load-packages -----------------------------------------------------------
import::from("magrittr", "%>%")
requireNamespace("dplyr")

# ---- declare-globals ---------------------------------------------------------
set.seed(9090)
# config                      <- config::get()

# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- waiting-times-basic -----------------------------------------------------
# library(bootstrap)
# library(boot)

rtSample <- c(1, 4, 10, 50, 80)

oldPar <- par(mfrow=c(1,2), mar=c(2.15,1.9,3,0), mgp=c(1, 0, 0), tcl=0)
colorLocation <- "black"
colorTail <- gray(.4)
colorFill <- gray(.8)
colorBorder <- gray(.7)
colorCI <- gray(.5)
###
### Example 1a: Standard Error of the Median
###
#Stage 1: Collect sample and calculate observed median
rtMedian <- median(rtSample)

#Stage 2: Prepare sampling frame (which is the observed sample in this case)
samplingFrame <- rtSample

#Stage 3: Create B bootstrap samples of size N.
B <- 999L
N <- length(rtSample)
bootstrapScores <- matrix(NA, nrow=B, ncol=N)
for( bootstrapIndex in seq_len(B) ) {
  bootstrapScores[bootstrapIndex, ] <- sample(x=samplingFrame, size=N, replace=TRUE)
}

#Stage 4:  Calculate the median of each bootstrap sample
bootstrapMedians <- rep(NA, length=B)
for( bootstrapIndex in seq_len(B) ) {
  star <- median( bootstrapScores[bootstrapIndex, ])
  #Add error checking to the star statistic (but this is not a problem for the median, but possibly oter stats you'd use).
  bootstrapMedians[bootstrapIndex] <- star
}
hist(bootstrapMedians, breaks=40, col=colorFill, border=colorBorder,
     xaxt="n", yaxt="n",
     xlab="", main="Bootstrapped Medians") #Show bootstrap stats
axis(1, at=c(0, 40, 80), col=gray(.9), col.axis=gray(.5))
axis(2, at=c(0, 100, 200, 300), col=gray(.9), col.axis=gray(.5))
abline(v=rtMedian, col=colorLocation) #Show the location of the observed stat
mtext(expression(italic(MD)[obs]), side=1, at=rtMedian, col=colorLocation) #Label the line

#Stage 5: Calculate the standard error of the statistic (which is the standard deviation of the bootstrap distribution).
standardErrorOfMedian <- sd(bootstrapMedians)
print(standardErrorOfMedian)

###
### Example 1b: Standard Error of the Mean
###
#Stage 1: Collect sample and calculate observed mean
rtMean <- mean(rtSample)

#Stages 2 & 3: Reuse the sampling frame and bootstrap distribution from Stages 2&3 in Example 1b.

#Stage 4: Calculate the the mean of each bootstrap sample
bootstrapMeans <- rep(NA, length=B)
for( bootstrapIndex in seq_len(B) ) {
  star <- mean( bootstrapScores[bootstrapIndex, ])
  #Add error checking to the star statistic (but this is not a problem for the mean, but possibly oter stats you'd use).
  bootstrapMeans[bootstrapIndex] <- star
}
breaks <- seq(from=min(rtSample), to=max(rtSample)+1, length=41)
hist(bootstrapMeans, breaks=breaks, col=colorFill, border=colorBorder,
     xaxt="n", yaxt="n",
     xlab="", main="Bootstrapped Means") #Show bootstrap stats
axis(1, at=c(0, 40, 80), col=gray(.9), col.axis=gray(.5))
axis(2, at=c(0, 100, 200, 300), col=gray(.9), col.axis=gray(.5))
abline(v=rtMean, col=colorLocation) #Show the location of the observed stat
mtext(expression(bar(italic(X))[Obs]), side=1, line=.3, at=rtMean, col=colorLocation) #Label the line
#mtext("obs", side=1, at=rtMean, col=colorLocation) #Label the line

#Stage 5: Calculate the standard error of the statistic (which is the standard deviation of the bootstrap distribution).
standardErrorOfMean <- sd(bootstrapMeans)
print(standardErrorOfMean)

###
### Example 1c: CI for the Mean
###
#Stages 1-4: Reuse the calculations in Stages 1-4 of Example 1b.

#Stage 5: Determine the CI.
alpha <- .05 #The proprtion of scores in both tails combined.
numberOfScoresInTails <- alpha/2 * (B+1) #Calculating the number of scores in each tail.
ciOfMeanBootstrap <- quantile(bootstrapMeans, probs=c(.025, .975), type=2)
#The line of code above does (specify type=2):
#  bootstrapMeans <- sort(bootstrapMeans)
#  lowerBoundary <- bootstrapMeans[numberOfScoresInTails]
#  upperBoundary <- bootstrapMeans[B-numberOfScoresInTails+1]
#  ciOfMeanBootstrap <- c(lowerBoundary, upperBoundary)


#Modify an arrow to indicate the CI; draw it on top of the graph created in Example 1b.
heightOfBootstrapCI <- B*-.001 #This is the cosmetic height of the bar plotted below the distribution.
arrows(x0=ciOfMeanBootstrap[1],x1=ciOfMeanBootstrap[2], y=heightOfBootstrapCI, y1=heightOfBootstrapCI, col=colorCI, angle=90, code=3, lwd=3, xpd=NA, length=.1)

ciOfMeanParametric <- rtMean + c(-1, 1)*1.96*(sd(rtSample) / sqrt(N))
##Modify an arrow to indicate the parametric CI
#heightOfParametricCI <- B*-.003
#arrows(x0=ciOfMeanParametric[1],x1=ciOfMeanParametric[2], y=heightOfParametricCI, y1=heightOfParametricCI, col="orange", angle=90, code=3, lwd=3, xpd=NA, length=.1)

print(ciOfMeanBootstrap)

###
### Example 1d: p-value for the Mean
###
#Stages 1-4: Reuse the calculations in Stages 1-4 of Example 1b.

#Stage 5: Declare a null hypothesis and calculate the p-value.
nullMean <- 5
countOfBootstrappedMeansEqualOrLessThanNull <- sum(bootstrapMeans <= nullMean)
pValueOneTail <- countOfBootstrappedMeansEqualOrLessThanNull / (B + 1L)

#Show bootstrap stats
hist(bootstrapMeans[bootstrapMeans <= nullMean], breaks=breaks, col=colorTail, add=T) #Write over
abline(v=nullMean, col=colorTail, lty=3)
mtext(expression(italic(H)[0]), side=1, line=.3, at=nullMean, col=colorTail)
par(oldPar)

print(pValueOneTail)


# ---- sampling-frame ----------------------------------------------------------
x <- c(1, 2, 3, 3.5, 5)
y <- c(10, 15, 35, 25, 40)
xRect <- rep(x, times=5)
yRect <- rep(y, each=5)

#oldPar <- par(mfrow=c(1,2), mar=c(3,3,3,3))#, fin=c(2,2))
#oldPar <- par(mfrow=c(1,2), mar=c(0.1,.1,1.7,.1), pin=c(2,1.1))
#oldPar <- par(mfrow=c(1,2), mar=c(0,.1,1.7,.1), pin=c(1.5,1), omi=c(0,0,0,0))
#oldPar <- par(mfrow=c(1,2), mar=c(0.1,.1,1.7,.1),  omi=c(0,0,0,0))
oldPar <- par(mfrow=c(1,2), mai=c(0.05,.05,.35,.05), omi=c(0,0,0,0))
plot(x, y, col="gray70", pch=16, xpd=NA,
     xaxt="n", yaxt="n", xlab="", ylab="", cex.main=1, fg="gray70",
     main="Observed Sample and\nBivariate Sampling Frame")
points(x, y)

plot(x, y, bg="gray70", pch=21, xpd=NA,
     xaxt="n", yaxt="n", xlab="", ylab="",  cex.main=1, fg="gray70",
     main="Univariate Sampling Frame")
points(xRect, yRect)
par(oldPar)

