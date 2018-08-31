
best <- function(state, outcome){
  setwd("C:/RPrograms/RprogramWeek4")
  #outcome="pneumonia"
  #state="NY"
  # read data from outcome
  # define outcome as either heart attack, heart failure or pneumonia
  thedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  #make data frame to hold only data necessary for analysis
 # theframe <- thedata[, c( 2, 7, 11,17,23)]
  validState <- unique(c(thedata[, 7]))
  validState <- sort(validState)
  head(validState, 60)
  
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
  if(identical(tolower(outcome),validOutcome[[1]]))
  {
    colNumber <- 11
  }
  if(identical(tolower(outcome),"heart failure"))
  {
    colNumber <- 17
  }
  if(identical(tolower(outcome),"pneumonia"))
  {
    colNumber <- 23
  }
  #display lowest value for state and outcome
  
  querydata <- subset(thedata[c(2,7,colNumber)])
  colnames(querydata) <- c("Hospital", "State", "DeathData")
  querydata <- subset(querydata, querydata$State == state)
  querydata <- querydata[querydata$DeathData != 'Not Available',]
  querydata$hospitalrank <- NA
  querydata$hospitalrank[order(as.numeric(as.character(querydata$DeathData)))] <- 1:nrow(querydata)
  
  finaldata <- querydata[order(querydata$hospitalrank), ]
  head(finaldata, 1)
    
    }

