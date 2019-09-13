set.seed(3433)
library(AppliedPredictiveModeling)
library(caret)
library(gbm)
data(AlzheimerDisease)
adData = data.frame(diagnosis, predictors)

inTrain = createDataPartition(adData$diagnosis, p=3/4)[[1]]

training = adData[ inTrain, ]
testing = adData[-inTrain, ]

set.seed(62433)
rfp1 <- train(diagnosis ~., data=training, method="rf")
bp1 <- train(diagnosis ~ ., data=training, method = "gbm")
ladP1 <- train(diagnosis ~., data=training, method="lda")

rfPred <- predict(rfp1, testing)
bpPred <- predict(bp1, testing)
ladPred <- predict(ladP1, testing)

predDF <- data.frame(rfPred, bpPred, ladPred, diagnosis = testing$diagnosis)
modFit <- train(diagnosis ~., method="rf", data=predDF)

modPred <- predict(modFit, predDF)

confusionMatrix(rfPred, testing$diagnosis)$overall[1]
confusionMatrix(bpPred, testing$diagnosis)$overall[1]
confusionMatrix(ladPred, testing$diagnosis)$overall[1]
confusionMatrix(modPred, testing$diagnosis)$overall[1]


