rankhospital <- function(state, outcome, level){
  setwd("C:/RPrograms/RprogramWeek4")
  
  # read data from outcome
  # define outcome as either heart attack, heart failure or pneumonia
  thedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  #make data frame to hold only data necessary for analysis
  validState <- unique(c(thedata[, 7]))
  validState <- sort(validState)
  #validate state
  if(!is.element(tolower(state), tolower(validState))){
    stop("not valid state")
    geterrmessage()
  }
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
  if(identical(outcome,validOutcome[[2]]))
  {
    colNumber <- 17
  }
  if(identical(outcome,validOutcome[[3]]))
  {
    colNumber <- 23
  }
  #filter data set to only include needed columns
  querydata <- subset(thedata[c(2,7,colNumber)])
  colnames(querydata) <- c("Hospital", "State", "DeathData")
  
  #filter as per requirements by state
  querydata <- subset(querydata, tolower(querydata$State) == tolower(state))
  
  querydata <- querydata[querydata$DeathData != 'Not Available',]
  
  #create a rank column and make value NA
  querydata$hospitalrank <- NA
  querydata$hospitalrank[order(as.numeric(as.character(querydata$DeathData)),querydata$Hospital)] <- 1:nrow(querydata)
  
  finaldata <- querydata[order(querydata$hospitalrank), ]
  
  #finaldata <- finaldata[ ,2:5]
  head(finaldata , level)
}