setwd("c:\\rprograms\\statinference")
n <- 1000
group <- 40
lambda <- 0.2

theoreticalmean <- 1 / lambda
theoreticalsd <- 1 / lambda

# run the simulation
data  <- rexp(n * group, lambda)
matrixdata <- matrix(data, n, group)
matrixmean <- apply(matrixdata,1,mean)
simmean <- mean(matrixmean)
simsd <- sd(matrixmean)
simvar <- var(matrixmean)

#compare to CLT
simse = simsd / sqrt(group)

#calculate confidence
low <- simmean - 1.96 * simse
high <- simmean + 1.96 * simse
