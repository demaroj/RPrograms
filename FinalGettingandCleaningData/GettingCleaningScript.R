#install.packages("plyr")
library(plyr)
#install.packages("dplyr")
library(dplyr)

zipfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

## create df with column labels from features.txt file.
colLabels <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/features.txt"), header= FALSE)

#make dframes out of necessary txt files 
x_testdata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/test/X_test.txt"))
x_traindata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/train/X_train.txt"))
y_testdata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/test/y_test.txt"),  col.names=c("activity"))
y_traindata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/train/y_train.txt"),  col.names=c("activity"))
subject_testdata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/test/subject_test.txt"), col.names=c("Subject"))
subject_traindata <- read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/train/subject_train.txt"), col.names=c("Subject"))

#use colLabels df to label columns in x test data before binding columns
names = ((colLabels[,2]))
colnames(x_testdata) = names
colnames(x_traindata) = names

testdata <- cbind(subject_testdata, y_testdata, x_testdata) #subject_testdata,
traindata <-cbind(subject_traindata, y_traindata, x_traindata)
dataset <- rbind(testdata, traindata)

testtrainingset <- dataset[, grep("Subject|activity|Mean|std", names(dataset), ignore.case=TRUE)]

activitylabels <-read.table(file.path(tempdir(), "/myzip/UCI HAR Dataset/activity_labels.txt"))

#head(activitylabels)

testtrainingset$activityname.str <- activitylabels$V2[match(testtrainingset$activity, activitylabels$V1)]

colClean <- function(x){ 
  colnames(x) <- gsub("[()]", "", colnames(x))
  
  colnames(x) <- gsub("mean", "mean.", colnames(x))
  colnames(x) <- gsub("std", "std.", colnames(x))
  colnames(x) <- gsub("fBody", "freq.Body.", colnames(x)) 
  colnames(x) <- gsub("tBody", "time.Body.", colnames(x))
  #colnames(x) <- gsub("fGravity", "freq.Gravity", colnames(x)) 
  colnames(x) <- gsub("tGravity", "time.Gravity.", colnames(x))
  colnames(x) <- gsub("-X", "X", colnames(x)) 
  colnames(x) <- gsub("-Y", "Y", colnames(x))
  colnames(x) <- gsub("-Z", "Z", colnames(x))
  #colnames(x) <- gsub("-", ".", colnames(x))
  colnames(x) <- gsub("[-]", ".", colnames(x))
  x } 

testtrainingset <- colClean(testtrainingset)
testtrainingset <- testtrainingset[, !(colnames(testtrainingset) %in% c("activity"))]

tidydataset <- testtrainingset %>%
  group_by(Subject, activityname.str) %>%
  summarise_all(mean)


