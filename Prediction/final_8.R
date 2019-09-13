##install.packages("corrplot")
library(readr)
library(AppliedPredictiveModeling)
library(caret)
library(gbm)
library(corrplot)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)

## load training data
training = read_csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"))
dim(training)

## load test data
testing <- read_csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"))
dim(testing)

## clean training data
indColToRemove <- which(colSums(is.na(training) | training=="")>0.9*dim(training)[1]) 
training_clean <- training[,-indColToRemove]
training_clean <- training_clean[,-c(1:7)]
dim(training_clean)

## Clean testing data
indColToRemove <- which(colSums(is.na(testing) | testing=="")>0.9*dim(testing)[1]) 
testing_clean <- testing[,-indColToRemove]
testing_clean <- testing_clean[,-c(1:7)]
dim(testing_clean)


####
set.seed(12345)
## Get training data
inTrain <- createDataPartition(training_clean$classe, p = 0.7, list = FALSE)
trainData <- training_clean[inTrain, ]
dim(trainData)
testData <- training_clean[-inTrain, ]
dim(testData)

## Corralation plot for training data

corr_data <- cor(trainData[, -53])
corrplot(corr_data, method="circle")

## find highly correlated columns
highCor <- findCorrelation(corr_data, cutoff = 0.80)
names(trainData)[highCor]

decisionTreeMod1 <- rpart(classe ~ ., data=trainData, method="class")
fancyRpartPlot(decisionTreeMod1)

predictTreeMod1 <- predict(decisionTreeMod1, testData, type = "class")
##str(predictTreeMod1)
##str(testData$classe)

ConMat <- confusionMatrix(factor(predictTreeMod1), factor(testData$classe))
ConMat

#plot accuracy data

plot(ConMat$table, col=ConMat$byClass, 
      main = paste("Decision Tree Accuracy = ", round(ConMat$overall['Accuracy'],4)))

## Random Forest Analysis
controlRF <- trainControl(method="cv",number=3, verboseIter = FALSE)
modRF1 <- train(classe ~ ., data=trainData, method="rf", trControl=controlRF)
modRF1$finalModel

## Validate RF model
predictRF1 <- predict(modRF1, newdata=testData)
ConRF <- confusionMatrix(factor(predictRF1), factor(testData$classe))
ConRF

plot(modRF1)
## Plot Accuracy of Random Forest Model
plot(ConRF$table, col=ConRF$byClass, main=paste("RF Confusion Matrix: Accuracy =", round(ConRF$overall['Accuracy'], 4)))

## to GBM
set.seed(12345)
cGBM <- trainControl(method="repeatedcv", number=5,repeats=1)
modGBM <- train(classe ~ ., data=trainData, method="gbm", trControl=cGBM, verbose=FALSE)
modGBM$finalModel

print(modGBM)

# validate gbm model

predictGBM <- predict(modGBM, newdata = testData)

CMgbm <- confusionMatrix(factor(predictGBM), factor(testData$classe))
CMgbm

Results <- predict(modRF1, newdata = testing_clean)
Results