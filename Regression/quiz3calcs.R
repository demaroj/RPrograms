data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, mtcars)
summary(fit)$coeff

fit2 <- lm(mpg ~ factor(cyl) * wt, mtcars)
summary(fit2)$coeff

anova(fit,fit2)

lm(mpg ~ I(wt*0.5) + factor(cyl), data=mtcars)
