complete <- function(directory="C:\\specdata", id = 1:332) {
  
  m <- c()
  bad <- 0
  comp <- 0
  for (i in id){
    
    path <- file.path(directory, paste(sprintf("%003d", as.numeric(i)), ".csv", sep=""))
    data <- read.csv(path)
    
    for (j in nrow(data)){
      row <- data[j,]
      if (is.na(row[["sulfate"]]))  ## |is.na(data[["nitrate"]]))
      {
        bad <- bad + 1
        print(row)
      }
      else{
        comp <- comp + 1
      }
    }
    ## m <- c(m, data[[path]][!b])
  }
  print(bad)
}

# Assign1 -----------------------------------------------------------------



