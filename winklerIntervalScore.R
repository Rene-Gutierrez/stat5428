winklerIntervalScore <- function(int, mea, a = 0.05){
  # Removes NA from files
  nInt   <- sum(!is.na(int[, 1]))
  int    <- int[1:nInt, ]
  n      <- length(mea)
  intLen <- int[, 2] - int[, 1]
  intPen <- rep(0, n)
  for(i in 1:n){
    if(int[i, 1] > mea[i]){
      intPen[i] <- (int[i, 1] - mea[i]) * 2 / a 
    } else if(int[i, 2] < mea[i]){
      intPen[i] <- (mea[i] - int[i, 2]) * 2 / a
    }
  }
  intSco <- intLen + intPen
}