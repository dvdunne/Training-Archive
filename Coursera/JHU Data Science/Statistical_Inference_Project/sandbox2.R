library(datasets)
data(ToothGrowth)
head(ToothGrowth)
str(ToothGrowth)
library(dplyr)
library(ggplot2)


ggplot(ToothGrowth, aes(x=interaction(supp, dose), y=len)) + geom_boxplot(aes(fill = supp))

library(dplyr)
oj.2mg <- filter(ToothGrowth, supp == "OJ", dose == 2)
vc.2mg <- filter(ToothGrowth, supp == "VC", dose == 2)

mean(vc.2mg$len)
mean(oj.2mg$len)



#study the relations between len and supp and dose
t.test(len ~ dose, data = ToothGrowth)

oj <- filter(ToothGrowth, supp == "OJ")
vc <- filter(ToothGrowth, supp == "VC")
t.test(oj$len, vc$len)

dose.0.5 = filter(ToothGrowth, dose == 0.5)
dose.1 = filter(ToothGrowth, dose == 1)
dose.2 = filter(ToothGrowth, dose == 2)

t.test(dose.0.5$len, dose.1$len)
t.test(dose.0.5$len, dose.2$len)
t.test(dose.1$len, dose.2$len)


test.supp <- t.test(len ~ supp, data = ToothGrowth)
test.supp
test


#Taking just the dose of 0.5mg, would yeild the following test.
ToothGrowth.0.5mg <- filter(ToothGrowth, dose == 0.5)
supp.test <- t.test(len ~ supp, data = ToothGrowth.0.5mg)  # Do T test.
supp.test

#Taking just the dose of 1mg, would yeild the following test.
ToothGrowth.1mg <- filter(ToothGrowth, dose == 1)
supp.test <- t.test(len ~ supp, data = ToothGrowth.1mg)  # Do T test.
supp.test

#Taking just the dose of 2mg, would yeild the following test.
ToothGrowth.2mg <- filter(ToothGrowth, dose == 2)
supp.test <- t.test(len ~ supp, data = ToothGrowth.2mg)  # Do T test.
supp.test

# Test dose of 0.5mg versus 1mg
doses <- filter(ToothGrowth, dose %in% c(0.5, 1.0))
dose.test <- t.test(len ~ dose, data = doses)
dose.test

# Test dose of 0.5mg versus 2mg
doses <- filter(ToothGrowth, dose %in% c(0.5, 2.0))
dose.test <- t.test(len ~ dose, data = doses)
dose.test

# Test dose of 1mg versus 2mg
doses <- filter(ToothGrowth, dose %in% c(1.0, 2.0))
dose.test <- t.test(len ~ dose, data = doses)
dose.test