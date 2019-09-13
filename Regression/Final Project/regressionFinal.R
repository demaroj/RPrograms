library(ggplot2)
library(GGally)
data("mtcars")

## Executive Summary
You work for Motor Trend, a magazine about the automobile industry. 
Looking at a data set of a collection of cars, 
they are interested in exploring the relationship between 
a set of variables and miles per gallon (MPG) (outcome). 
They are particularly interested in the following two questions:
     
     "Is an automatic or manual transmission better for MPG"
"Quantify the MPG difference between automatic and manual transmissions"

## Data Visualization
head(mtcars)
str(mtcars)

## Data Tidy
data.subset <- subset(mtcars, select=c(mpg,am))
mt.auto <- mtcars[(mtcars$am==0),]
mt.manual <- mtcars[(mtcars$am==1),]

#Need!!!
boxplot(mpg ~ am, data=mtcars, xlab="Transmission", ylab="MPG", main="MPG v Transmission Type")
summary(mtcars)

aggregate(data.subset[,1:2], list(data.subset$am), mean)
t.test(mt.auto$mpg, mt.manual$mpg)

mod0 <- lm(mpg ~ am, mtcars)
summary(mod0)

mod1 <- lm(mpg~cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb, mtcars)
summary(mod1)$coef
summary(aov(mod1))

mod2 <- lm(mpg ~ am + cyl + disp + wt, mtcars)

anova(mod0,mod2)
mtcars$predicted <- predict(mod0)
mtcars$residuals <- residuals(mod0)
ggplot(mtcars, aes(x=factor(am), y=mpg)) +
     geom_smooth(method="lm", se=FALSE, color="lightgrey") +
     geom_segment(aes(xend=am,yend=predicted), alpha=.2)+
     geom_point(aes(color=abs(residuals), size=abs(residuals))) +
     scale_color_continuous(low="green", high="red")+
     guides(color=FALSE, size=FALSE)+
     geom_point(aes(y=predicted), shape=1)+
     theme_bw()

# mod1 <- glm(mtcars$am ~ (mtcars$mpg), data=mtcars, family=binomial)
# 
# summary(mod1)$coef
# 
# mod2 <- glm(mtcars$am ~ (mtcars$mpg), data=mtcars, family=poisson)
# summary(mod2)$coef
# ggplot(mtcars, aes(x=am, y=mpg)) + 
#      geom_point()
# 
# cars.subset <- subset(mtcars, select=c(mpg,am,hp,wt))
# ggpairs(cars.subset)
# 
# ggplot(mtcars, aes(x=am, y=mpg)) + 
#      geom_boxplot()
# 
# ggplot(mtcars, aes(x=mpg))+
#      geom_histogram(color="black", fill="white")
