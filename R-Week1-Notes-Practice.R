#####R Practice######
# Free version of the R class:
# https://bookdown.org/rdpeng/rprogdatascience/using-textual-and-binary-formats-for-storing-data.html


#VECTORS
vec <- c(1, "a", TRUE) #turns them all into characters
vec
vec <- c(1, TRUE, FALSE) #Turns them all into numeric type
vec


# "as" functions (COERCION)
vec <- c(0, 1, 2, 3)
as.character(vec) #turns the numerics into charcter type
as.logical(vec) #turns the numerics into booleans

vec <- c(TRUE, FALSE, TRUE)
as.numeric(vec)

vec <- c("a", "b", "c")
as.numeric(vec) #cannot change character into numeric
as.logical(vec) #cannot change character into logical


#NAMEING elements in a vector
v <- c(1, 2, 3)
names(v) #no names yet
names(v) <- c("Jim", "Bob", "Jeff")
v #note the names
#OR
v <- c(jeff = 1, jim = 2, john = 3)
v
names(v)
#OR
l <- list(bob = 1, bill = 2, bork = 3)
l
names(l)

#MATRICIES
m <- matrix(nrow = 2, ncol = 4)
m
dim(m)

v <- 1:24
v
#make a matrix and name the rows and cols
m <- matrix(1:6, nrow = 2, ncol = 3)
dimnames(m) <- list(c("a", "b"), c("x", "y", "z"))
m


#assign the dim function a vector. Weird, how does that work?
dim(v) <- c(2, 12)
v
dim(v) <- c(3, 8)
v
dim(v) <- c(4, 6)
v


#cbinding (column binding) and rbinding (rowbinding)
v1 <- 1:3
v2 <- 10:12

cbind(v1, v2)
rbind(v1, v2)


#FACTORS
#using a number value to describe a category (1 = male, 2 = female)
#also used for categorical values that are ordered (e.g. positions in a company)
x <- factor(c("yes", "no", "yes", "yes", "no"))
x #output vector and "levels" (the different words in this case). In this case
#the first (baseline) "level" is "no" be cause it comes first alphabetically.
x <- factor(c("yes", "no", "yes", "yes", "no"), 
            levels = c("yes", "no")) #this will assign "yes" to be the baseline level
x


#Missing values
#NA and NaN (not a number)
a <- 1
is.na(a) #used to test to see if the value is NA. (NA can be integer, char class etc.)
is.nan(a) #used to test to see if the value is NaN

nums <- c(1, 2, NA, 4, 5)
is.na(nums)
is.nan(nums) #NaN is not NA
nums2 <- c(1, 2, NaN, 4, 5)
is.na(nums2)
is.nan(nums2) #But NA is NaN


#DATA FRAMES
d <- data.frame(col1 = 1:5, col2 = c(T, F, T, T, F), 
                col3 = c("one", "two", "three", "four", "five"))
d
nrow(d)
ncol(d)
class(d)

data.matrix(d) #careful of coersion


#READING DATA from RAW DATASET
#read.table  - look up info on different arguments (assumes a space as default between data elements )
# read.table help page: https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table
# THE HELP PAGE IS VERY USEFUL TO KNOW
# read.csv - same as read.table but assumes commas instead of spaces
# For LARGE data sets R reads data onto the ram of them comp. makes sure it's not too much
# For LARGE data sets, the colClasses argument is very important. You can use it to 
# tell R what class the data in the specific columns are so R doesn't take up tons of
# memory trying to figure it out.

#dput, dget, dump to write to Textural formats. Read this to make sense:
#https://bookdown.org/rdpeng/rprogdatascience/using-textual-and-binary-formats-for-storing-data.html

#Connecting to a file
str(file) #outputs file's arguments. "description" is the name of the file
#for open, use "r" for reading, "w" for writing (and initializing a new file), 
#and "a" for appending
# “rb”, “wb”, “ab” reading, writing, or appending in binary mode (Windows)

#Connections:
#open a file for reading using con is redundant but if you want to just read a few
#lines from a file (using readlines function) it is useful
#use con function for reading lines from a web page too
#https://bookdown.org/rdpeng/rprogdatascience/interfaces-to-the-outside-world.html#file-connections


#SUBSETTING VECOTRS
x <- c("a", "b", "c", "c", "d", "a")  
x[1]    ## Extract the first element
x[2]    ## Extract the second element
x[1:4]  ## Extract first four elements
x[c(1, 3, 4)] #Extract specific elements

u <- x > "a"
u 
x[u] #output where the element is greater than a

x[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)] #prints only where TRUE

#SUBSETTING LISTS
#using single bracket operator and double bracket operator
x <- list(foo = 1:4, bar = 0.6)
x[1] # gives the list that contains 1-4
x[[1]]
x$bar
x["bar"]
x[["bar"]]
#double braket can be used with variable
name <- "bar"
x$name #will lieterally look for "name"
x[[name]] # this works though

#accessing elements of a list within a list
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))

## Get the 3rd element of the 1st element
x[[c(1, 3)]]  

## Same as above
x[[1]][[3]]   


#Subsetting Maticies
x <- matrix(1:6, 2, 3)
x[1, 2] #prints row 1, col 2
x[2, 1]

x[1, ]  ## Extract the first row
x[, 2]  ## Extract the second column

#can make the output a matrix (1x1) rather than a vector of length 1  
x <- matrix(1:6, 2, 3)
x[1, 2]
x[1, 2, drop = FALSE]
#similar here
x <- matrix(1:6, 2, 3)
x[1, ]
x[1, , drop = FALSE]
#[,1] [,2] [,3]
#[1,]    1    3    5

#Partial matching
x <- list(aardvark = 1:5)
x$a #finds the closest name to a
#[1] 1 2 3 4 5
x[["a"]]
#NULL
x[["a", exact = FALSE]]
#[1] 1 2 3 4 5

#Removing NA values
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
print(bad)
#[1] FALSE FALSE  TRUE FALSE  TRUE FALSE
x[!bad]
#[1] 1 2 4 5

#Removing from parallel vectors. Removes from both vectors when at least one vector is bad
#actually I'm confused. why is this different than previous?
x <- c(1, 2, NA, 4, NA, 5)
y <- c(NA, "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good

x[good]
y[good]

#Example with a dataframe
head(airquality)
#Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6
good <- complete.cases(airquality)
head(airquality[good, ])
#Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#7    23     299  8.6   65     5   7
#8    19      99 13.8   59     5   8
good #so good is just a list of booleans


#Vectorized Operations
x <- 1:4
y <- 6:9 
z <- x + y #also works with - , *, and /
z

x
x > 2 #outputs list of booleans

#adding different sized vectors
x <- 1:4
y <- 2:3
x + y

#Multiplying matricies
x <- matrix(1:4, 2, 2)
y <- matrix(rep(10, 4), 2, 2)

## element-wise multiplication
x * y       

## element-wise division
x / y       

## true matrix multiplication (like from linear algebra)
x %*% y     



x <- c(17, 14, 4, 5, 13, 12, 10)
x[x > 10] <- 4
x

#extract first 2 rows of data set and print them
?read.csv
data <- read.csv("~/Desktop/Coursera/hw1_data.csv")
data
head(data)

data[1:2, ]
dim(data)
data[152:153, ]
data[47, "Ozone"]

data[ , "Ozone"]
sum(is.na(data[ , "Ozone"] == TRUE))

bad <- is.na(data[ , "Ozone"])
data[ , "Ozone"][!bad]
mean(data[ , "Ozone"][!bad])


good <- data[ , "Ozone"] > 31 
good
good2 <- data[ , "Temp"] > 90

bad <- is.na(data[ , "Solar.R"])
bad
good <- good*good2*(!bad)
good
good <- as.logical(good)
good
data2 <- data[good, ]
data2
bad <- is.na(data2[ , "Solar.R"])

mean(data2[ , "Solar.R"][!bad])


test <- c(TRUE, NA, TRUE, FALSE)
test2 <- c(TRUE, TRUE, FALSE, FALSE)
final <- test*test2
as.logical(final)

data

good <- data[ , "Month"] == 5
bad <- is.na(data[ "Ozone"])
good <- good*(!bad)
good <- as.logical(good)
max(data[ , "Ozone"][good])
data
