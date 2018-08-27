
best <- function(state, outcome){
  outcome="heart failure"
  state="TX"
  # read data from outcome
  # define outcome as either heart attack, heart failure or pneumonia
  thedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  #make data frame to hold only data necessary for analysis
  theframe <- thedata[, c( 2, 7, 11,17,23)]
  #filter data with function variables
  if(outcome=="heart attack")
    {theindex<-3}
  if(outcome=="heart failure")
    {theindex<-4}
  if(outcome=="pneumonia")
    {theindex<-5}
  
  #display lowest value for state and outcome

}

