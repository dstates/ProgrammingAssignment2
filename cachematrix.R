## makeCacheMatrix(x) - create an object to store a matrix
#                       and it's cached invese
## cacheSolve(x, ...) - compute or retrive the inverse of the matrix stored
#                       in x, an object returned by the makeCacheMatrix function

##  makeCacheMatrix(x)
#       Stores a matrix and it's inverse to prevent needing 
#       to solve the matrix repeatedly
#
#       arguments:
#           x - (optional) matrix() class object to store
#
#       return value:
#           list containing the functions:
#               get()       - returns the stored matrix object
#               set(m)      - replaces the stored matrix with new matrix `x`, 
#                               clearing the cached inverse matrix
#               getSolved() - returns the cached inverse matrix object
#               setSolved(s)- replaces the cached solved matrix object

makeCacheMatrix <- function(x = matrix()) {
    # initialize the `solved` matrix object to NULL
    solved <- NULL
    # Store a new matrix in `x`
    set <- function(m) {
        # Store new matrix `m` in the lexical context of 
        # makeCacheMatrix's environment
        x <<- m
        # Clear `solved` since we are storing a new matrix
        solved <<- NULL
    }
    
    # return the stored matrix `x`
    get <- function() x
    
    # return the inverted matrix `solved`
    getSolved <- function()
        solved
    
    # store the inverted matrix `s` in `solved` in the lexical 
    # context of makeCacheMatrix's environment
    setSolved <- function(s)
        solved <<- s
    
    # return a list() containing references to 
    # get/set functions for `m` and `solved`
    list(set = set, get = get,
         setSolved = setSolved,
         getSolved = getSolved)
}

##  cacheSolve(x, ...)
#       Solves or returns the cached solved matrix stored in x, an object 
#       generated by the makeCacheMatrix() function
#
#       arguments:
#           x   - object returned by the makeCacheMatrix() function containing 
#                   a matrix and possibly it's cached inverse
#
#           additional arguments are passed through to solve()
#
#       return value:
#           the inverse of the matrix stored in x, whether cached or solved
#           on the fly

cacheSolve <- function(x, ...) {
    # retrive the cached inverse, if it exists
    solved <- x$getSolved()
    # check to see if the inverse was cached, and return it's value
    if (!is.null(solved)) {
        message("Using cached value...")
        return(solved)
    }
    # inverse was not cached, compute and cache, then return it's value
    solved <- solve(x$get(), ...)
    x$setSolved(solved)
    solved
}
