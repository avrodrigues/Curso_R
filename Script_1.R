## Rode os códigos abaixo:

a <- 1:10
x <- c("a","b")
z <- rep(x, 5)
z <- as.factor(z)
numeros <- rnorm(10, 5, 20)
b <- numeros == a
dados <- matrix(data = c(a, numeros), 10, 2)
dados1 <- data.frame(a, b, z)

