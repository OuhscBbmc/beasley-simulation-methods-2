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

oldPar <- par(mfrow=c(1,2), mar=c(1.45,2.1,1.5,0), mgp=c(1, 0, 0), tcl=0)
colorLocation <- "black"
colorTail <- gray(.4)
colorFill <- gray(.8)
colorBorder <- gray(.7)
colorCI <- gray(.5)
colorMain <- gray(.3)
fontMain <- 1


### Standard Error of the Median
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
     col.main = colorMain,
     font.main = fontMain,
     col.lab = colorMain,
     xaxt="n", yaxt="n",
     xlab="", main="Bootstrapped Medians") #Show bootstrap stats
axis(1, at=c(0, 40, 80), col=gray(.9), col.axis=gray(.5))
axis(2, at=c(0, 100, 200, 300), col=gray(.9), col.axis=gray(.5))
abline(v=rtMedian, col=colorLocation) #Show the location of the observed stat
mtext(expression(italic(MD)[obs]), side=1, at=rtMedian, col=colorLocation) #Label the line

#Stage 5: Calculate the standard error of the statistic (which is the standard deviation of the bootstrap distribution).
standardErrorOfMedian <- sd(bootstrapMedians)
print(standardErrorOfMedian)

### Standard Error of the Mean
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
     col.main = colorMain,
     font.main = fontMain,
     col.lab = colorMain,
     xaxt="n", yaxt="n",
     xlab="", ylab = "", main="Bootstrapped Means") #Show bootstrap stats
axis(1, at=c(0, 40, 80), col=gray(.9), col.axis=gray(.5))
axis(2, at=c(0, 100, 200, 300), col=gray(.9), col.axis=gray(.5))
abline(v=rtMean, col=colorLocation) #Show the location of the observed stat
mtext(expression(bar(italic(X))[Obs]), side=1, line=.3, at=rtMean, col=colorLocation) #Label the line
#mtext("obs", side=1, at=rtMean, col=colorLocation) #Label the line

#Stage 5: Calculate the standard error of the statistic (which is the standard deviation of the bootstrap distribution).
standardErrorOfMean <- sd(bootstrapMeans)
print(standardErrorOfMean)

### CI for the Mean
#Stages 1-4: Reuse the calculations in Stages 1-4 of Example 1b.

#Stage 5: Determine the CI.
alpha <- .05 #The proprtion of scores in both tails combined.
numberOfScoresInTails <- alpha/2 * (B+1) #Calculating the number of scores in each tail.
ciOfMeanBootstrap <- quantile(bootstrapMeans, probs=c(.025, .975), type=2)
#The line of code above does the following four (specify type=2):
#  bootstrapMeans <- sort(bootstrapMeans)
#  lowerBoundary <- bootstrapMeans[numberOfScoresInTails]
#  upperBoundary <- bootstrapMeans[B-numberOfScoresInTails+1]
#  ciOfMeanBootstrap <- c(lowerBoundary, upperBoundary)

#Modify an arrow to indicate the CI; draw it on top of the graph created in Example 1b.
heightOfBootstrapCI <- B*-.001 #This is the cosmetic height of the bar plotted below the distribution.
arrows(x0=ciOfMeanBootstrap[1],x1=ciOfMeanBootstrap[2], y=heightOfBootstrapCI, y1=heightOfBootstrapCI, col=colorCI, angle=90, code=3, lwd=3, xpd=NA, length=.1)

ciOfMeanParametric <- rtMean + c(-1, 1)*1.96*(sd(rtSample) / sqrt(N))

#Modify an arrow to indicate the parametric CI
#heightOfParametricCI <- B*-.003
#arrows(x0=ciOfMeanParametric[1],x1=ciOfMeanParametric[2], y=heightOfParametricCI, y1=heightOfParametricCI, col="orange", angle=90, code=3, lwd=3, xpd=NA, length=.1)

print(ciOfMeanBootstrap)

### p-value for the Mean
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
colorMain <- gray(.3)
fontMain <- 1

oldPar <- par(mfrow=c(1,2), mai=c(0.05,.05,.35,.05), omi=c(0,0,0,0))
plot(x, y, col="gray70", pch=16, xpd=NA,
     xaxt="n", yaxt="n", xlab="", ylab="", cex.main=1, fg="gray70",
     col.main = colorMain,
     font.main = fontMain,
     main="Observed Sample and\nBivariate Sampling Frame")
points(x, y)

plot(x, y, bg="gray70", pch=21, xpd=NA,
     xaxt="n", yaxt="n", xlab="", ylab="",  cex.main=1, fg="gray70",
     col.main = colorMain,
     font.main = fontMain,
     main="Univariate Sampling Frame")
points(xRect, yRect)
par(oldPar)


# ---- rejection-sampling ------------------------------------------------------
colorCandidateBounds <- gray(.6)
colorAccept <- gray(.6)
colorReject <- gray(.85)
colorCI <- gray(.5)
colorAxis <- NA #gray(.9)
colorLabel <- gray(.6)
markAccept <- 1 #Circle
markReject <- 4 #An 'x'
lineTypeCandidate <- "F4"
pointSize <- .9

### Bounded theta parameter
replicationCount <- 400L #Use many more points than 400.  This low number is just for graphing.

#Uncomment the next line to combine with the graph of Example 4b.
par( mfrow=c(1,2), mar=c(2, 1.7, 1.4, 1), mgp=c(.8,0,0), tcl=0)

#Stage 1: Specify the pdf of the posterior and draw it.
PosteriorPdf <- function( x ) {
  return( .3*dbeta( x=x+.5, shape1=9, shape2=3 ) +.7*dbeta( x=x+.5, shape1=2, shape2=5 ) )
}

#Stage 2a: Set the bounds of the candidate values.
xRange <- c(-.5, .5) #This range covers the allowable values of the target distribution.
#Drawing was listed as Stage 1, but we're delaying it to get the xRange precise
curve(PosteriorPdf(x), xlim=xRange, bty="n", xaxt="n", lwd=2, xaxt="n", yaxt="n", xaxs="i", yaxs="i",
  col.axis=colorAxis, col.lab=colorLabel,
  xlab=expression(theta), ylab="Density") #Draw the pdf on top of the empty plot.

axis(1, at=c(-.5, -.25, 0, .25, .5), labels=c("-.5", "-.25", "0", ".25", ".5"), col=colorAxis, col.axis=colorLabel)
axis(2, col=colorAxis, col.axis=colorLabel)
#Stage 2b: Determine the upper bound for the density (ie, how high the target distribution goes on the vertical axis).
yRange <- c(0, 1.75) #This range can be determined with trial-and-error.

rect(xleft=xRange[1], xright=xRange[2], ytop=yRange[2], ybottom=yRange[1], xpd=NA,
  lwd=2, lty=lineTypeCandidate, border=colorCandidateBounds)

posteriorPoints <- numeric(0)
for( replicationIndex in 1:replicationCount ) {
  #Step 3a: Generate the x value for a candidate.
  xValue <- runif(n=1, min=xRange[1], max=xRange[2])

  #Step 3b: Generate the height of the candidate
  yValue <- runif(n=1, min=yRange[1], max=yRange[2])

  #Step 4: Determine if the candidate is underneath the pdf's curve
  #  Add to the distribution if accepted
  accept <- (yValue < PosteriorPdf(xValue))
  if( accept ) {
    points(xValue, yValue, col=colorAccept, pch=markAccept, cex=pointSize)
    posteriorPoints <- c(posteriorPoints, xValue)
  }
  else {
    points(xValue, yValue, col=colorReject, pch=markReject, cex=pointSize)
  }
  rm(xValue, yValue, accept) #Remove the variables
}

acceptProportion <- length(posteriorPoints) / replicationCount
mtext(paste("Accepted Proportion:", acceptProportion), line=.4, col=colorLabel)

#Step 5: Calculate summary statistics
posteriorMean <- mean(posteriorPoints)
#posteriorMedian <- median(posteriorPoints)

ci95 <- quantile(posteriorPoints, probs=c(.025, .975))

#Plot the summary statistics
#abline(v=c(posteriorMean, posteriorMedian))
#mtext(side=1, at=c(posteriorMean, posteriorMedian), text=c(expression(bar(theta)), expression(theta["50%"])), line=c(.2, .2))
abline(v=posteriorMean, lty=2)
text(x=posteriorMean, y=1.5, expression(bar(theta)), xpd=TRUE, adj = 1.1)

#Modify an arrow to indicate the CI; draw it on top of the graph created in Example 1b.
arrows(x0=ci95[1], x1=ci95[2], y=0, y1=0, col=colorCI, angle=90, code=3, lwd=3, xpd=NA, length=.1)

text(expression(italic(f)(theta)), x=.35, y=PosteriorPdf(.35), pos=4)
text("0", x=xRange[2], y=yRange[1], xpd=NA, pos=4, col=colorCandidateBounds)
text(expression(italic(c)), x=xRange[2], y=yRange[2], xpd=NA, pos=4, col=colorCandidateBounds)

### Unbounded theta parameter
replicationCount <- 200L #Use many more points than 200.  This low number is just for graphing.

#Prepare a blank plot.  Determine the graphing limits by trial-and-error.
xRangeOfGraph <- c(-5, 5) #This range covers the majority of the t distribution.
yRangeOfGraph <- c(0, .75)
plot(NA, xlim=xRangeOfGraph, ylim=yRangeOfGraph, bty="n", xaxt="n", yaxt="n", xaxs="i",yaxs="i",
  col.axis=colorAxis, col.lab=colorLabel,
  xlab=expression(theta), ylab="")
axis(1, col=colorAxis, col.axis=colorLabel)
text(x=xRangeOfGraph[2], y=c(0, .3, .6), c("0", ".3", ".6"), srt=-90, col=colorLabel, xpd=NA)

#Stage 1: Specify and graph the pdf of the posterior (ie, the target distribution).
PosteriorPdf <- function( x ) {
  return( .55*dlogis(x, location=-.95, scale=.5) + .45*dnorm( x=x, mean=.7, sd=.45 )  )
}
curve(PosteriorPdf(x), add=TRUE, lwd=2) #Draw the target pdf on top of the empty plot.

#Stage 2a: Define the candidate distribution.
candidateDf <- 3
#Define the Candidate distribution.
CandidatePdf <- function( x ) {
  return( dt(x, df=candidateDf) )
}
#Define the Random Number Generator for the Candidate distribution.
CandidatePdfRng <- function( count ) {
  return( rt(n=count, df=candidateDf))
}

#Stage 2b: Define the scaling constant of the Candidate distribution
scalingConstant <- 2

#Stage 2c: Graph the candidate distribution
curve(scalingConstant * CandidatePdf(x), add=TRUE, col=colorCandidateBounds, lty=lineTypeCandidate, lwd=2)

posteriorPoints <- numeric(0) #Declare an empty vector (which will be appended to).
for( replicationIndex in seq_len(replicationCount) ) {
  #Step 3a: Generate a candidate.
  xValue <- CandidatePdfRng(count=1)

  #Step 3b: Generate the height of the candidate
  maxHeightOfCandidateDensity <- scalingConstant*CandidatePdf(xValue)
  yValue <- runif(n=1, min=0, max=maxHeightOfCandidateDensity)

  #Step 4: Determine if the candidate is underneath the pdf's curve
  #  Add to the distribution if accepted
  accept <- (yValue < PosteriorPdf(xValue))
  if( accept ) {
    points(xValue, yValue, col=colorAccept, pch=markAccept, xpd=NA, cex=pointSize)
    posteriorPoints <- c(posteriorPoints, xValue)
  } else {
    points(xValue, yValue, col=colorReject, pch=markReject, xpd=F, cex=pointSize)
  }
  rm(xValue, yValue, accept) #Remove the variables
}

acceptProportion <- length(posteriorPoints) / replicationCount
mtext(paste("Accepted Proportion:", acceptProportion), line=.4, col=colorLabel)

#Step 5: Calculate summary statistics
posteriorMean <- mean(posteriorPoints)
ci95 <- quantile(posteriorPoints, probs=c(.025, .975))

#Modify an arrow to indicate the CI; draw it on top of the graph created in Example 1b.
arrows(x0=ci95[1], x1=ci95[2], y=0, y1=0, col=colorCI, angle=90, code=3, lwd=3, xpd=NA, length=.1)

#Plot the summary statistics
abline(v=posteriorMean, lty=2)
text(x=posteriorMean, y=.5, expression(bar(theta)), xpd=NA, adj = c(1.1))

text(expression(italic(f)(theta)), x=0, y=PosteriorPdf(0), pos=4)
text(expression(italic(c)%*%italic(g)(theta)), x=.5, y=scalingConstant*CandidatePdf(.5), pos=4, col=colorCandidateBounds)
par(oldPar)

# ---- independent-metropolis-hastings -----------------------------------------
replicationCount <- 5000L
plotGrayscale <- TRUE
if( plotGrayscale ) { #For Figure 4.
  colorTargetBounds <- gray(0)
  colorCandidateBounds <- gray(.6)
  colorAccept <- gray(.7)
  colorReject <- gray(.4)
  colorAcceptFill <- gray(.9)#hsv(h=.416,s=.2,v=.95, gamma=1)
  colorAxis <- NA #gray(.9)
  colorAxisChain <- gray(.9)
  colorLabel <- gray(.6)
} else {
  colorTargetBounds <- "black"
  colorCandidateBounds <- "blue"
  colorAccept <- "springgreen3"
  colorReject <- "orange"
  colorAcceptFill <- hsv(h=.416,s=.2,v=.95)
  colorAxis <- gray(.9)
  colorAxisChain <- gray(.9)
  colorLabel <- gray(.6)
}
lineWeightDistribution <- 1

markAccept <- 1 #'1' corresponds to a circle for the graph
markReject <- 4 #'4' corresponds to an 'x'
lineTypeCandidate <- "F4"
set.seed(4) #Figure 4 was created using this seed.

oldPar <-
  par(
    mar       = c(2.6, 3.1, 0.4, 0),
    mgp       = c(1.4, .2, 0),
    tcl       = 0,
    cex.axis  = 1.6,
    cex.lab   = 1.6
  )
layout(rbind(c(1,2, 4), c(3, 3, 4)), widths=c(1, 1, .05))

#Prepare a blank plot (in the top left panel).  Determine the graphing limits by trial-and-error.
xRangeOfGraph <- c(-5, 5) #This range covers the majority of the t distribution.
yRangeOfGraph <- c(0, .36)
plot(NA, xlim=xRangeOfGraph, ylim=yRangeOfGraph, bty="n", xaxs="i",yaxs="i", xaxt="n", yaxt="n",
  col.axis=colorAxis, col.lab=colorLabel, cex = 10,
  xlab=expression(theta), ylab="Density")
axis(1, col=colorAxis, col.axis=colorLabel)
axis(2, at=c(0, .15, .3), labels=c("0", ".15", ".3"), col=colorAxis, col.axis=colorLabel)

#Stage 1: Define the target distribution and draw it.
TargetPdf <- function( x ) {
  return( .4*dnorm(x=x, mean=-1, sd=.5) + .6*dlogis(x, location=1, scale=.6) )
}

#Stage 2: Declare the candidate distribution's parameter.
candidateDf <- 3
#Define a function for the Candidate distribution.
CandidatePdf <- function( x ) {
  center <- 0 #This value will be set in Example 5b; it's the primary difference between the IMH and MH.
  return( dt(x - center, df=candidateDf) )
}
#Define the Random Number Generator for the Candidate distribution.
CandidatePdfRng <- function( count ) {
  center <- 0 #This value will be set in Example 5b
  return( rt(n=count, df=candidateDf) - center )
}

#Draw the candidate.
curve(CandidatePdf(x), add=TRUE, col=colorCandidateBounds, lty=lineTypeCandidate, xpd=TRUE, lwd=lineWeightDistribution)

targetPoints <- rep(NA, length=replicationCount) #A vector filled with B missing values.
targetPoints[1] <- CandidatePdfRng(count=1) #Initialize the first incumbent
loosingNewCandidatePoints <- rep(NA, length=replicationCount) #A vector filled with B missing values.
loosingNewCandidatePoints[1] <- targetPoints[1]  #Initialize the first incumbent
for( replicationIndex in 2:replicationCount ) {
  #Step 3a: Generate a candidate of beta
  x <- CandidatePdfRng(count=1)

  #Step 3b: Calculate the product of ratios
  fx <- TargetPdf(x)
  gx <- CandidatePdf(x)
  z <- targetPoints[replicationIndex - 1] #Remember the candidate who won the last step.
  fz <- TargetPdf(z)
  gz <- CandidatePdf(z)
  r <- (gz * fx ) / (fz * gx)

  #Step 4: Determine if the candidate is underneath the pdf's curve; Add to the distribution if accepted
  if( r > 1 ) {
    targetPoints[replicationIndex] <- x
  }
  else {
    y <- runif(n=1, min=0, max=1)
    if( r > y ) {
      targetPoints[replicationIndex] <- x
    }
    else {
      targetPoints[replicationIndex] <- z
      loosingNewCandidatePoints[replicationIndex] <- x
    }
  }
}
#Step 5: Calculate summary statistics
targetMean <- mean(targetPoints)
ci95 <- quantile(targetPoints, probs=c(.025, .975))
hist(targetPoints, xlim=xRangeOfGraph, ylim=yRangeOfGraph, add=TRUE, col=colorAcceptFill, border="white",
   breaks=60, freq=FALSE, main="", xlab=expression(theta))
curve(CandidatePdf(x), add=TRUE, col=colorCandidateBounds, lty=lineTypeCandidate, lwd=lineWeightDistribution) #Draw a second time
curve(TargetPdf(x), add=TRUE, col=colorTargetBounds, lwd=lineWeightDistribution) #Draw the pdf on top of the empty plot.


### Plot that illustrates jumping (top right panel).
plot(NA, xlim=xRangeOfGraph, ylim=yRangeOfGraph, ann=FALSE, bty="n", xaxt="n", yaxt="n", xaxs="i",yaxs="i")
curve(CandidatePdf(x), add=T, col=colorCandidateBounds, lty=lineTypeCandidate, xpd=TRUE, lwd=lineWeightDistribution)
curve(TargetPdf(x), col=colorTargetBounds, add=TRUE, lwd=lineWeightDistribution) #Draw the pdf on top of the empty plot.

tickLocations <-c(-1.9, 0, 2)
arrows(x0=tickLocations[2], x1=tickLocations[2], y0=0, y1=CandidatePdf(tickLocations[2]), col=colorReject, angle=90, code=3, xpd=NA, length=0, lty="16")
arrows(x0=tickLocations[2], x1=tickLocations[2], y0=TargetPdf(tickLocations[2]), y1=CandidatePdf(tickLocations[2]), col=colorReject, angle=90, code=3, xpd=NA, length=.05, lty=lineTypeCandidate)
arrows(x0=tickLocations[3], x1=tickLocations[3], y0=0, y1=CandidatePdf(tickLocations[3]), col=colorAccept, angle=90, code=3, xpd=NA, length=0, lty="16")
arrows(x0=tickLocations[3], x1=tickLocations[3], y0=TargetPdf(tickLocations[3]), y1=CandidatePdf(tickLocations[3]), col=colorAccept, angle=90, code=3, xpd=NA, length=.05)

rug(tickLocations, side=1, col=colorLabel)
mtext(side=1, at=tickLocations, line=.1, c(expression(italic(D)),expression(italic(E)),expression(italic(F))), col=colorLabel)

### Plot chain (bottom panel).
plot(targetPoints[1:100], type="l", bty="n", xaxt="n", yaxt="n", ylim=c(-4,4), xpd=NA, yaxs="i",
  col="gray50", col.lab=colorLabel,
  xlab="Step Number", ylab=expression(theta[italic(b)]))
points(targetPoints[1:100], col=colorAccept, xpd=NA)
points(loosingNewCandidatePoints[1:100], col=colorReject, pch=4, xpd=NA)
axis(side=1, at=seq(from=0, to=100, by=10), col=colorAxisChain, col.axis=colorLabel)
axis(side=2, at=c(-4, -2, 0, 2, 4),  col=colorAxis, col.axis=colorLabel)
rug(tickLocations, side=4, col=colorLabel)
mtext(side=4, at=tickLocations, las=1, c(expression(italic(D)),expression(italic(E)),expression(italic(F))), col=colorLabel)

par(oldPar)

