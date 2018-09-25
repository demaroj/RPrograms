---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
editor_options: 
  chunk_output_type: console
---

## Loading and preprocessing the data


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.4.4
```

```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.4.4
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(knitr)
```

```
## Warning: package 'knitr' was built under R version 3.4.4
```

```r
library(mice)
```

```
## Warning: package 'mice' was built under R version 3.4.4
```

```
## Loading required package: lattice
```

```
## 
## Attaching package: 'mice'
```

```
## The following objects are masked from 'package:base':
## 
##     cbind, rbind
```

```r
#set working dir
setwd("c:\\rprograms\\reproducibleresearch\\reproducibleresearch")

#download and unzip raw data from website
zipfile <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
rawdata <- read.csv(file.path(tempdir(), "/myzip/activity.csv"))
activitydata <- rawdata

#process data froma 
activitydata$date <- as.Date(as.character(activitydata$date))
activitydata <- activitydata[complete.cases(activitydata),]
activitydata$steps <- as.numeric(activitydata$steps)
activitydata$interval <-as.numeric(as.character(activitydata$interval))
```

## What is mean total number of steps taken per day?

```r
totalSteps <- aggregate(activitydata$steps, by=list(activitydata$date), sum, na.rm=TRUE)
                        
#use ggplot to create histogram from totalSteps data frame
ggplot(totalSteps, aes(x=totalSteps$Group.1, weights=totalSteps$x)) + geom_bar() 
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
myFun <- function(x) {
     c( 
       mean = as.numeric(mean(x), na.rm=TRUE), median = as.numeric(median(sort(x), na.rm=TRUE)))
}
tapply(activitydata$steps, activitydata$date, myFun)
```

```
## $`2012-10-02`
##   mean median 
## 0.4375 0.0000 
## 
## $`2012-10-03`
##     mean   median 
## 39.41667  0.00000 
## 
## $`2012-10-04`
##     mean   median 
## 42.06944  0.00000 
## 
## $`2012-10-05`
##     mean   median 
## 46.15972  0.00000 
## 
## $`2012-10-06`
##     mean   median 
## 53.54167  0.00000 
## 
## $`2012-10-07`
##     mean   median 
## 38.24653  0.00000 
## 
## $`2012-10-09`
##     mean   median 
## 44.48264  0.00000 
## 
## $`2012-10-10`
##   mean median 
## 34.375  0.000 
## 
## $`2012-10-11`
##     mean   median 
## 35.77778  0.00000 
## 
## $`2012-10-12`
##     mean   median 
## 60.35417  0.00000 
## 
## $`2012-10-13`
##     mean   median 
## 43.14583  0.00000 
## 
## $`2012-10-14`
##     mean   median 
## 52.42361  0.00000 
## 
## $`2012-10-15`
##     mean   median 
## 35.20486  0.00000 
## 
## $`2012-10-16`
##   mean median 
## 52.375  0.000 
## 
## $`2012-10-17`
##     mean   median 
## 46.70833  0.00000 
## 
## $`2012-10-18`
##     mean   median 
## 34.91667  0.00000 
## 
## $`2012-10-19`
##     mean   median 
## 41.07292  0.00000 
## 
## $`2012-10-20`
##     mean   median 
## 36.09375  0.00000 
## 
## $`2012-10-21`
##     mean   median 
## 30.62847  0.00000 
## 
## $`2012-10-22`
##     mean   median 
## 46.73611  0.00000 
## 
## $`2012-10-23`
##     mean   median 
## 30.96528  0.00000 
## 
## $`2012-10-24`
##     mean   median 
## 29.01042  0.00000 
## 
## $`2012-10-25`
##     mean   median 
## 8.652778 0.000000 
## 
## $`2012-10-26`
##     mean   median 
## 23.53472  0.00000 
## 
## $`2012-10-27`
##     mean   median 
## 35.13542  0.00000 
## 
## $`2012-10-28`
##     mean   median 
## 39.78472  0.00000 
## 
## $`2012-10-29`
##     mean   median 
## 17.42361  0.00000 
## 
## $`2012-10-30`
##     mean   median 
## 34.09375  0.00000 
## 
## $`2012-10-31`
##     mean   median 
## 53.52083  0.00000 
## 
## $`2012-11-02`
##     mean   median 
## 36.80556  0.00000 
## 
## $`2012-11-03`
##     mean   median 
## 36.70486  0.00000 
## 
## $`2012-11-05`
##     mean   median 
## 36.24653  0.00000 
## 
## $`2012-11-06`
##    mean  median 
## 28.9375  0.0000 
## 
## $`2012-11-07`
##     mean   median 
## 44.73264  0.00000 
## 
## $`2012-11-08`
##     mean   median 
## 11.17708  0.00000 
## 
## $`2012-11-11`
##     mean   median 
## 43.77778  0.00000 
## 
## $`2012-11-12`
##     mean   median 
## 37.37847  0.00000 
## 
## $`2012-11-13`
##     mean   median 
## 25.47222  0.00000 
## 
## $`2012-11-15`
##      mean    median 
## 0.1423611 0.0000000 
## 
## $`2012-11-16`
##     mean   median 
## 18.89236  0.00000 
## 
## $`2012-11-17`
##     mean   median 
## 49.78819  0.00000 
## 
## $`2012-11-18`
##     mean   median 
## 52.46528  0.00000 
## 
## $`2012-11-19`
##     mean   median 
## 30.69792  0.00000 
## 
## $`2012-11-20`
##     mean   median 
## 15.52778  0.00000 
## 
## $`2012-11-21`
##     mean   median 
## 44.39931  0.00000 
## 
## $`2012-11-22`
##     mean   median 
## 70.92708  0.00000 
## 
## $`2012-11-23`
##     mean   median 
## 73.59028  0.00000 
## 
## $`2012-11-24`
##     mean   median 
## 50.27083  0.00000 
## 
## $`2012-11-25`
##     mean   median 
## 41.09028  0.00000 
## 
## $`2012-11-26`
##     mean   median 
## 38.75694  0.00000 
## 
## $`2012-11-27`
##     mean   median 
## 47.38194  0.00000 
## 
## $`2012-11-28`
##     mean   median 
## 35.35764  0.00000 
## 
## $`2012-11-29`
##     mean   median 
## 24.46875  0.00000
```

## What is the average daily activity pattern?

```r
intervalSteps <- aggregate(activitydata$steps, by=list(activitydata$interval), mean, na.action=na.omit)
names(intervalSteps) <- c("Interval", "AverageSteps")
#plot interval data
plot.ts(intervalSteps$Interval, intervalSteps$AverageSteps, type="l")
```

![](PA1_template_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
#find max
maxinterval <- intervalSteps[order(intervalSteps$AverageSteps),]


## Imputing missing values
pMiss <- function(x){sum(is.na(x))/length(x)*100}
apply(rawdata,2,pMiss)
```

```
##    steps     date interval 
## 13.11475  0.00000  0.00000
```

```r
md.pattern(rawdata)
```

![](PA1_template_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

```
##       date interval steps     
## 15264    1        1     1    0
## 2304     1        1     0    1
##          0        0  2304 2304
```

```r
impdata <- mice(rawdata,m=5,maxit=5,meth='mean')
```

```
## 
##  iter imp variable
##   1   1  steps
##   1   2  steps
##   1   3  steps
##   1   4  steps
##   1   5  steps
##   2   1  steps
##   2   2  steps
##   2   3  steps
##   2   4  steps
##   2   5  steps
##   3   1  steps
##   3   2  steps
##   3   3  steps
##   3   4  steps
##   3   5  steps
##   4   1  steps
##   4   2  steps
##   4   3  steps
##   4   4  steps
##   4   5  steps
##   5   1  steps
##   5   2  steps
##   5   3  steps
##   5   4  steps
##   5   5  steps
```

```
## Warning: Number of logged events: 25
```

```r
summary(impdata)
```

```
## Class: mids
## Number of multiple imputations:  5 
## Imputation methods:
##    steps     date interval 
##   "mean"       ""       "" 
## PredictorMatrix:
##          steps date interval
## steps        0    1        1
## date         1    0        1
## interval     1    1        0
## Number of logged events:  25 
##   it im   dep meth
## 1  1  1 steps mean
## 2  1  2 steps mean
## 3  1  3 steps mean
## 4  1  4 steps mean
## 5  1  5 steps mean
## 6  2  1 steps mean
##                                                                                                                              out
## 1 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
## 2 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
## 3 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
## 4 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
## 5 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
## 6 date2012-10-02, date2012-10-08, date2012-11-01, date2012-11-04, date2012-11-09, date2012-11-10, date2012-11-14, date2012-11-30
```

```r
completedata <- complete(impdata,1)
tapply(completedata$steps, completedata$date, myFun)
```

```
## $`2012-10-01`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-10-02`
##   mean median 
## 0.4375 0.0000 
## 
## $`2012-10-03`
##     mean   median 
## 39.41667  0.00000 
## 
## $`2012-10-04`
##     mean   median 
## 42.06944  0.00000 
## 
## $`2012-10-05`
##     mean   median 
## 46.15972  0.00000 
## 
## $`2012-10-06`
##     mean   median 
## 53.54167  0.00000 
## 
## $`2012-10-07`
##     mean   median 
## 38.24653  0.00000 
## 
## $`2012-10-08`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-10-09`
##     mean   median 
## 44.48264  0.00000 
## 
## $`2012-10-10`
##   mean median 
## 34.375  0.000 
## 
## $`2012-10-11`
##     mean   median 
## 35.77778  0.00000 
## 
## $`2012-10-12`
##     mean   median 
## 60.35417  0.00000 
## 
## $`2012-10-13`
##     mean   median 
## 43.14583  0.00000 
## 
## $`2012-10-14`
##     mean   median 
## 52.42361  0.00000 
## 
## $`2012-10-15`
##     mean   median 
## 35.20486  0.00000 
## 
## $`2012-10-16`
##   mean median 
## 52.375  0.000 
## 
## $`2012-10-17`
##     mean   median 
## 46.70833  0.00000 
## 
## $`2012-10-18`
##     mean   median 
## 34.91667  0.00000 
## 
## $`2012-10-19`
##     mean   median 
## 41.07292  0.00000 
## 
## $`2012-10-20`
##     mean   median 
## 36.09375  0.00000 
## 
## $`2012-10-21`
##     mean   median 
## 30.62847  0.00000 
## 
## $`2012-10-22`
##     mean   median 
## 46.73611  0.00000 
## 
## $`2012-10-23`
##     mean   median 
## 30.96528  0.00000 
## 
## $`2012-10-24`
##     mean   median 
## 29.01042  0.00000 
## 
## $`2012-10-25`
##     mean   median 
## 8.652778 0.000000 
## 
## $`2012-10-26`
##     mean   median 
## 23.53472  0.00000 
## 
## $`2012-10-27`
##     mean   median 
## 35.13542  0.00000 
## 
## $`2012-10-28`
##     mean   median 
## 39.78472  0.00000 
## 
## $`2012-10-29`
##     mean   median 
## 17.42361  0.00000 
## 
## $`2012-10-30`
##     mean   median 
## 34.09375  0.00000 
## 
## $`2012-10-31`
##     mean   median 
## 53.52083  0.00000 
## 
## $`2012-11-01`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-11-02`
##     mean   median 
## 36.80556  0.00000 
## 
## $`2012-11-03`
##     mean   median 
## 36.70486  0.00000 
## 
## $`2012-11-04`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-11-05`
##     mean   median 
## 36.24653  0.00000 
## 
## $`2012-11-06`
##    mean  median 
## 28.9375  0.0000 
## 
## $`2012-11-07`
##     mean   median 
## 44.73264  0.00000 
## 
## $`2012-11-08`
##     mean   median 
## 11.17708  0.00000 
## 
## $`2012-11-09`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-11-10`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-11-11`
##     mean   median 
## 43.77778  0.00000 
## 
## $`2012-11-12`
##     mean   median 
## 37.37847  0.00000 
## 
## $`2012-11-13`
##     mean   median 
## 25.47222  0.00000 
## 
## $`2012-11-14`
##    mean  median 
## 37.3826 37.3826 
## 
## $`2012-11-15`
##      mean    median 
## 0.1423611 0.0000000 
## 
## $`2012-11-16`
##     mean   median 
## 18.89236  0.00000 
## 
## $`2012-11-17`
##     mean   median 
## 49.78819  0.00000 
## 
## $`2012-11-18`
##     mean   median 
## 52.46528  0.00000 
## 
## $`2012-11-19`
##     mean   median 
## 30.69792  0.00000 
## 
## $`2012-11-20`
##     mean   median 
## 15.52778  0.00000 
## 
## $`2012-11-21`
##     mean   median 
## 44.39931  0.00000 
## 
## $`2012-11-22`
##     mean   median 
## 70.92708  0.00000 
## 
## $`2012-11-23`
##     mean   median 
## 73.59028  0.00000 
## 
## $`2012-11-24`
##     mean   median 
## 50.27083  0.00000 
## 
## $`2012-11-25`
##     mean   median 
## 41.09028  0.00000 
## 
## $`2012-11-26`
##     mean   median 
## 38.75694  0.00000 
## 
## $`2012-11-27`
##     mean   median 
## 47.38194  0.00000 
## 
## $`2012-11-28`
##     mean   median 
## 35.35764  0.00000 
## 
## $`2012-11-29`
##     mean   median 
## 24.46875  0.00000 
## 
## $`2012-11-30`
##    mean  median 
## 37.3826 37.3826
```

```r
ggplot(completedata, aes(x=completedata$date, weights=completedata$steps)) + geom_bar() 
```

![](PA1_template_files/figure-html/unnamed-chunk-3-3.png)<!-- -->


## Are there differences in activity patterns between weekdays and weekends?
#add column to completedata for weekend weekday indicator

```r
completedata$weekend <- grepl("S.+", weekdays(as.Date(completedata$date)))

#panel plot of weekend v weekday data
#plot graphs in 2x2 panel

par(mfrow = c(2,1), mar=c(0, 4, 1, 1) + 0.1)#it goes c(bottom, left, top, right) 


weekenddata <- subset(completedata, weekend == TRUE)
weekendintervalsteps <- aggregate(weekenddata$steps, by=list(weekenddata$interval)
                                  , mean, na.action=na.omit)
weekdaydata <- subset(completedata, weekend == FALSE)
weekdayintervalsteps <- aggregate(weekdaydata$steps, by=list(weekdaydata$interval)
                                  , mean, na.action=na.omit)

par(mar=c(3,4,4,1)+0.1)

#create plot a
plot.ts(weekendintervalsteps$Group.1, weekendintervalsteps$x, type="l",  main="Weekend", ylab="", xlab="", xaxt='n')

#create plot b
plot.ts(weekdayintervalsteps$Group.1, weekdayintervalsteps$x, type="l",  main="Weekday", ylab="", xlab="interval", xlim=c(0,3000))
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
