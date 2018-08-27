rankall <- function(outcome, num){
 # setwd("D:/DataClass/RClass2/ProgrammingAssignment3")
  ##read outcome data
  #outcome <- "heart attack"
  #num <- 12
  thedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  validState <- unique(c(thedata[, 7]))
  validState <- sort(validState)
  head(validState, 60)
  
  #validate data
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
  if(identical(outcome,"heart failure"))
  {
    colNumber <- 17
  }
  if(identical(outcome,"pneumonia"))
  {
    colNumber <- 23
  }
  ## determine position to find
  # if(is.numeric(num)) {
  #   num <- num
  # } else if (tolower(num) == tolower("best")){
  #   num <- 1
  # }else {
  #   num <- nrow(querydata)
  # }
  finaldata <- data.frame()
  
  for(a in validState){
    
    querydata <- subset(thedata[c(2,7,colNumber)])
    colnames(querydata) <- c("Hospital", "State", "DeathData")
    querydata <- subset(querydata, querydata$State == a)
    
    querydata$hospitalrank <- NA
    querydata$hospitalrank[order(querydata$DeathData)] <- 1:nrow(querydata)
    
    if(is.numeric(num)) {
      num <- num
    } else if (tolower(num) == tolower("best")){
      num <- 1
    }else {
      num <- nrow(querydata)
    }
    
    rankdata <- subset(querydata, querydata$hospitalrank == num)
    
    finaldata <- rbind(finaldata, rankdata)
    querydata <- querydata[0,]
    #num <- 0
    
  }
  # head(nrow(validState))
  head(querydata)
  head(finaldata, 55)
}
