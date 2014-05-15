### Introduction

This second programming assignment will require you to write an R
function that is able to cache potentially time-consuming computations.
For example, taking the mean of a numeric vector is typically a fast
operation. However, for a very long vector, it may take too long to
compute the mean, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a vector are not changing, it may make
sense to cache the value of the mean so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at
    [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
    to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can
    edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your
    solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your
    git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains
    the completed R code for the assignment.

### Proof of Functionality

Create two square matrices

    > m2 <- matrix(rnorm(25), 5,5)
    > m1 <- matrix(rnorm(16), 4,4)
    > m1
                [,1]       [,2]       [,3]         [,4]
    [1,]  0.35296429  0.4951894  1.6478337  0.470410432
    [2,]  1.65624383 -1.4734089 -1.3614005  1.806187078
    [3,]  0.49288832 -0.5888183 -0.9051822  0.006974947
    [4,] -0.07693787 -0.7104939  1.2078814 -0.288907773
    > m2
              [,1]       [,2]       [,3]       [,4]       [,5]
    [1,] -2.106430  1.3032257  2.3170130 -1.0310386 -0.5791869
    [2,] -1.624708  0.3678403 -0.8085702 -0.6831729  0.6829674
    [3,] -1.790866  0.9449002 -1.0061056 -0.9136711 -1.4457784
    [4,]  1.326839  0.9978362 -1.1024430  1.1553087 -0.1592660
    [5,]  1.178373 -0.2982530 -1.2433936  0.1127043  0.4820656

Store `m1` in a chache object `c` and confirm is has our matrix in it, confirm that there is **no** cached inverted matrix

    > c <- makeCacheMatrix(m1)
    > c$get()
                [,1]       [,2]       [,3]         [,4]
    [1,]  0.35296429  0.4951894  1.6478337  0.470410432
    [2,]  1.65624383 -1.4734089 -1.3614005  1.806187078
    [3,]  0.49288832 -0.5888183 -0.9051822  0.006974947
    [4,] -0.07693787 -0.7104939  1.2078814 -0.288907773
    > c$getSolved()
    NULL

solve the matrix with cacheSolve(), and check it a second time to make sure it was cached

    > cacheSolve(c)
               [,1]        [,2]        [,3]        [,4]
    [1,]  1.2293736 -0.38121042  2.37886941 -0.32409888
    [2,]  0.5599944 -0.27171320  0.39065551 -0.77745525
    [3,]  0.3017277 -0.02572502 -0.07834034  0.32856587
    [4,] -0.4430712  0.66217432 -1.92175279 -0.08936669
    > cacheSolve(c)
    Using cached value...
               [,1]        [,2]        [,3]        [,4]
    [1,]  1.2293736 -0.38121042  2.37886941 -0.32409888
    [2,]  0.5599944 -0.27171320  0.39065551 -0.77745525
    [3,]  0.3017277 -0.02572502 -0.07834034  0.32856587
    [4,] -0.4430712  0.66217432 -1.92175279 -0.08936669

change the matrix stored in `c` to `m2`, confirm the matrix is stored, confirm the cached inverted matrix was **cleared**

    > c$set(m2)
    > c$get()
              [,1]       [,2]       [,3]       [,4]       [,5]
    [1,] -2.106430  1.3032257  2.3170130 -1.0310386 -0.5791869
    [2,] -1.624708  0.3678403 -0.8085702 -0.6831729  0.6829674
    [3,] -1.790866  0.9449002 -1.0061056 -0.9136711 -1.4457784
    [4,]  1.326839  0.9978362 -1.1024430  1.1553087 -0.1592660
    [5,]  1.178373 -0.2982530 -1.2433936  0.1127043  0.4820656
    > c$getSolved()
    NULL

solve the matrix with cacheSolve(), and check it a second time to make sure it was cached

    > cacheSolve(c)
               [,1]       [,2]        [,3]        [,4]       [,5]
    [1,]  0.3504246 -0.3941997 -0.01168911 -0.02107161  0.9374886
    [2,]  0.5287512  0.1115834 -0.03269304  0.46018601  0.5311788
    [3,]  0.2117485 -0.1755827 -0.19135820 -0.05743851 -0.0897188
    [4,] -0.6343257  0.2603355 -0.20134221  0.44895551 -1.5864783
    [5,]  0.1650166  0.5188814 -0.43815216  0.08310941  0.2509242
    > cacheSolve(c)
    Using cached value...
               [,1]       [,2]        [,3]        [,4]       [,5]
    [1,]  0.3504246 -0.3941997 -0.01168911 -0.02107161  0.9374886
    [2,]  0.5287512  0.1115834 -0.03269304  0.46018601  0.5311788
    [3,]  0.2117485 -0.1755827 -0.19135820 -0.05743851 -0.0897188
    [4,] -0.6343257  0.2603355 -0.20134221  0.44895551 -1.5864783
    [5,]  0.1650166  0.5188814 -0.43815216  0.08310941  0.2509242

Looks perfect to me ;)
