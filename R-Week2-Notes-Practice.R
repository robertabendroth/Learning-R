###Coursera week 2###

#FOR LOOPS
x <- c("a", "b", "c", "d")

for(i in 1:4) {
    ## Print out each element of 'x'
    print(x[i])  
}

#OR

for(i in seq_along(x)) {   
    print(x[i])
}

#OR

for(letter in x) {
    print(letter)
}

#Printing a matrix
x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) { #seq_len() creates a vector from integer
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }   
}

##REPEAT LOOP (runs for ever - use break to stop)
x0 <- 1
tol <- 1e-8
#
repeat {
  x1 <- computeEstimate() #not a real function
  
  if(abs(x1 - x0) < tol) {  ## Close enough?
    break
  }else {
    x0 <- x1
  } 
}

##Using Next
for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next                 
  }
  ## Do something here
}

##FUNCTIONS
above <- function(x, n = 10){ #n = 10 makes n default to 10 but user can specify
    use <- x > n #creates boolean vector
    x[use]  #prints all the x's that align with TRUE (this is returned)
}

#This function prints the mean of each column in specified data frame
columnmean <- function(y, skipNA = TRUE){
    nc <- ncol(y) #put num cols in a variable
    means <- numeric(nc) #creates a numeric vector of length nc filled with 0s
    for(i in 1:nc){
        #creates a vector of the means
        means[i] <- mean(y[ , i], na.rm = skipNA) #na.rm removes NAs!
    }
    #returns our vector
    means
}

columnmean(airquality, FALSE)


#Arguments for functions (details)
f <- function(a, b) {
    print(a)
    print(b)
}
f(45)
#[1] 45
#Error in print(b): argument "b" is missing, with no default

#the "..." operator
#This function makes the default for the type argument "l". The ... absorbs all the
#rest of the args, keeping them the same
myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)         ## Pass '...' to 'plot' function
}

#other use of "..." operator
#the paste function is ... first because the amount of arguments are unknown (strings I think)
#args after ... must be writen explicitly. must say sep = ? for example
args(paste)
#function (..., sep = " ", collapse = NULL, recycle0 = FALSE) 
#  NULL
args(cat)
#function (..., file = "", sep = " ", fill = FALSE, labels = NULL, 
#          append = FALSE) 
#  NULL

##Scoping Rules - Symbol Binding
#https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html
#Streamline the making of similar functions
make.power <- function(n) {
  pow <- function(x) {
     x^n 
  }
  pow 
}

cube <- make.power(3)
square <- make.power(2)
cube(3)
#[1] 27
square(3)
#[1] 9

#notice that the environments create different environments (n is in both but has
#different values)
ls(environment(cube))
#[1] "n"   "pow"
get("n", environment(cube))
#[1] 3

ls(environment(square))
#[1] "n"   "pow"
get("n", environment(square))
#[1] 2


##OPTIMIZATION (USING SCOPING) CONFUSING
#https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html#application-optimization

#DATES AND TIMES
## Coerce a 'Date' object from character
x <- as.Date("1970-01-01")   
x
#[1] "1970-01-01"

#Working with times and dates as date objects, POSIXct/POSIXlt objects
#Times use the POSIXct and POSIXlt class, Dates use the date class
#POSIXct is the number of seconds since jan 1 1970
#POSIXlt is contains all the info for the specified second (what month it's in etc)
#Character strings can be coerced to Date/Time classes using the strptime function 
  #or the as.Date, as.POSIXlt, or as.POSIXct
#See Link below for more deatails about working with dates
#https://bookdown.org/rdpeng/rprogdatascience/dates-and-times.html


#Logic functions in R
isTRUE()
isFALSE()
xor(
# || checks or for first item in vector
# | checks or for all items in vector
# && checks and for first item in vector
# & checks and for all items in a vector
ints <- sample(10)
which(ints > 5) #outputs indices where the value in ints is greater than 5
any(ints == 10) #returns true if any num in ints is equal to 10
all(ints > 0) #returns true if all nums in ints is greater than 0


bd20 <- "September 24, 2020 0:0"
ny21 <- "January 1, 2021 0:0"
bd20 <- strptime(bd20, "%B %d, %Y %H:%M")
ny21 <- strptime(ny21, "%B %d, %Y %H:%M")
difftime(ny21, bd20, units = 'days')

bd <- "September 24, 1994, 4:36"
bd <- strptime(bd, "%B %d, %Y, %H:%M")
difftime(Sys.time(), bd, units = 'days')
class(bd)
unclass(bd)
bd <- as.POSIXct(bd)
unclass(bd)
bd + 10000*24*60*60

cube <- function(x, n) {
  x^3
}
cube(3)

x <- 1:10
if(x > 5) {
  x <- 0
}


f <- function(x) {
  g <- function(y) {
    y + z
  }
  z <- 4
  x + g(x)
}

z <- 10
f(3) #What is the out put here? see link below for more info
#https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html#application-optimization

x <- 5
y <- if(x < 3) {
  NA
} else {
  10
}
y

