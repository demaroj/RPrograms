setwd("c:\\rprograms\\statinference")

n<-1000
group <- 40

lambda <- 0.2

theoreticalmean <- 1 / lambda
theoreticalsd <- 1/lambda


data  <- rexp(n * group, lambda)
matrixdata <- matrix(data, nrow=1000, ncol=40)

mean.exp = apply(matrixdata, 1, mean)
simmean <- mean(mean.exp)
simsd <- sd(mean.exp)
simvar <- var(mean.exp)
hist(mean.exp)