library(ggplot2)
library(reshape2)
library(plyr)
library(tidyverse)

#load ToothGrowth data to a df
tgrowth <- ToothGrowth

summary(tgrowth)

group_by(tgrowth, supp, dose) %>%
summarise(count = n(),
          mean = mean(len, na.rm = TRUE),
          sd = sd(len, na.rm = TRUE))

anovaResult <- aov(as.numeric(len)~as.factor(supp)*as.numeric(dose), data = tgrowth)
summary(anovaResult)

tukeyResult <- TukeyHSD(anovaResult)
summary(tukeyResult)


# g <- ggplot(aes(x=dose, y=len), data=tgrowth) +
#           geom_point(aes(color=supp))
# print(g)

gg <- ggplot(aes(x=dose, y=len), data=tgrowth) + 
  geom_boxplot(aes(color=supp))

print(gg)

summary_tgrowth <- aggregate(tgrowth$len, by=list(tgrowth$supp,tgrowth$dose), FUN=mean, na.rm=TRUE, na.action=NULL)

melted <- melt(tgrowth, id.vars=c("supp", "dose"))

means <- ddply(melted, c("supp", "dose", "variable"), summarise,
               mean=mean(value))
colnames(summary_tgrowth) <- c("Supp", "Dose", "Len")

means.barplot <- qplot(x=supp, y=mean, fill=len, data=means, geom="bar")
#
# #create a summary of toothgrowth data
# summary(tgrowth)

#means.barplot
