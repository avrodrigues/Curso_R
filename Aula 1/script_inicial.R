a <- 1:10
x <- c("a","b")
z <- rep(x, 5)
z <- as.factor(z)
numeros <- rnorm(10, 5, 20)
b <- numeros == a
dados <- cbind(a, b, numeros)
dados1 <- as.data.frame(cbind(a, b, z))
