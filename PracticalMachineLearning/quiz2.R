library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

hist(log(training$Superplasticizer+1))


library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
head(training[grepl("^IL_", names(training))])
names(training[grepl("^IL_", names(training))])


modelfit <- train(diagnosis ~ IL_11+IL_13+IL_16+IL_17E+IL_1alpha+IL_3+IL_4+IL_5+IL_6+IL_6_Receptor+IL_7+IL_8, 
                  data=training, preProcess=c("center", "scale"), 
                                            method="glm")
modelfit

which(colnames(training)=="diagnosis")

preProc <- preProcess(training[grepl("^IL_", names(training))],
                      method=c("center","scale","pca"), thres=0.9)
preProc


library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]





