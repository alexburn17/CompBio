##################################################################################
# P. Alexander Burnham
# March 29, 2017
# Control Structures
##################################################################################
###########################--Structured Programming--#############################
##################################################################################





##################################################################################
# Logical Operators:

5 > 3
5 < 3
5 >= 3
5 <= 5
5 == 5
5 != 5

# compound sentences:
5 > 3 & 1 != 2

# use | for OR
1 == 2 | 1 != 2

# logicals with vectors
1:5 > 3

a <- 1:10
b <- 10:1

a > 4 & b > 4

# long form gives first value that can be evaluated as true or false

a > 4 && b > 4

a > 4 || b > 4

# isTRUE test whether any statements is a vector of length one that is TRUE

isTRUE()

# xor for exlusive or testing of vectors

a <- c(0,0,1)
b <- c(0,1,1)
a | b

xor(a,b)

# set operations:
# boolean algebra on sets of atomic vectors (logical, numeric and character strings)

a <- 1:7
b <- 5:10

# union for all elements: (all unique elements between a and b)
union(a,b)

# intersect (common elements)
intersect(a,b)

# setdiff to get distinct elements
setdiff(a,b)

# setequal to check for identical elemeents
setequal(a,b)

# compare two objects (matrices)
z <- matrix(1:12, nrow=4, byrow=TRUE)
z1 <- matrix(1:12, nrow=4, byrow=FALSE)

identical(z,z1)

# useful for if statements is %in% or is.element

d <- 12
d %in% union(a,b)

##################################################################################
# If Statement:

# if (condition) expression
# if (condition) expression1 else expression2

# if (condition) expression else
# if (condition) expression2 else
# expression3

z <- signif(runif(1), digits = 2)
z > 0.5

if(z > 0.5) cat(z, "is a bigger than average number", "\n")


if(z > 0.8) cat(z, "is a large number", "\n") else
  if(z < 0.2) cat(z, "is a small number", "\n") else
  {
    cat(z, "is an ordinary-sized number", "\n")
    cat("z^2 =", z^2, "\n")
  }

##################################################################################
# ifelse funciton

# ifelse(test, yes, no)
# test = object that can be coerced to yes or no
# yes = returns values for TRUE
# no = returns values for the FALSE elements

# insect in whcich each female lays, on average, 10.2 eggs (draw from a poisson)
# but 35% of females are parasitized and sterile 

tester <- runif(1000)
eggs <- ifelse(tester>0.35, 
               rpois(n=1000, lambda=10.2),
               0
               )
head(eggs)

hist(eggs)
