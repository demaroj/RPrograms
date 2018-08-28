rankall <- function(outcome, num){
  setwd("C:/RPrograms/RprogramWeek4")
  ##read outcome data
  # outcome <- "heart attack"
  # num <- 'worst'
  #pull in data set
  thedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  # #
  # validState <5- unique(c(thedata[, 7]))
  # validState <- sort(validState)
  #head(validState, 60)
  
  #validate outcome
  validOutcome <- list("heart attack", "heart failure", "pneumonia")
  if(!is.element(tolower(outcome),tolower(validOutcome))){
    stop("not valid condition")
    geterrmessage()
  }
  #use data to rank 
  if(identical(outcome,validOutcome[[1]]))
  {
    colNumber <- 11
  }
  if(identical(outcome,validOutcome[[2]]))
  {
    colNumber <- 17
  }
  if(identical(outcome,validOutcome[[3]]))
  {
    colNumber <- 23
  }
  
  finaldata <- data.frame()
  
  for(state in validState){
    
    querydata <- subset(thedata[c(2,7,colNumber)])
    colnames(querydata) <- c("Hospital", "State", "DeathData")
    
    querydata <- querydata[querydata$DeathData != 'Not Available',]
    
    querydata <- subset(querydata, querydata$State == state)
    qNum <- nrow(querydata)
    querydata$hospitalrank <- NA
    querydata$hospitalrank[order(querydata$DeathData, querydata$Hospital)] <- 1:nrow(querydata)
    
    if(is.numeric(num)) {
      num <- num
      rankdata <- subset(querydata, querydata$hospitalrank==num )
    } else if (tolower(num) == tolower("best")){
      #num <- 1
      rankdata <- subset(querydata, querydata$hospitalrank==1 )
    }else {
      num <- qNum
      rankdata <- tail(querydata, 1)
    }
    
    # rankdata <- subset(querydata, $hospitalrank==num )
    # rankdata <- tail(querydata, 1)
    finaldata <- rbind(finaldata, rankdata)
    querydata <- querydata[0,]
    #num <- 0
    
  }
  # head(nrow(validState))
  #head(querydata)
  head(finaldata, 55)
}
