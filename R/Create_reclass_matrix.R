#'Create reclass matrices
#'
#'@param t1 first threshold
#'@param t2 second threshold
#'@return a matrix with three columns to be used as a reclass table

create_rcl_LC <- function(t1, t2){
  m <- c(0, t1, 0, t1, t2, 1, t2, 1.5, 2)
  rcl_LC <- matrix(m, ncol = 3, byrow = TRUE)
}

