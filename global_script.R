#Install packages
install.packages("arules")
install.packages("arulesViz")
#Get libraries
library(arules)
library(arulesViz)
library(datasets)

product <- read.transactions("items_raw_noheader.csv",sep=',')

#Our matrix
product
summary(product)

#Inspect the first X elements
inspect(product[1:4])
#Support: percentage of transactions where the item appeared (here first 3)
itemFrequency(product[,1:3])
#Frequency
itemFrequencyPlot(product,topN=20,type = 'absolute')


#Rules
#Set minimum support to 0.001
#Set minumum condifence to 0.7 (likelihood that rhs will be bought if lhs is already bought)

#Here is the core of all that analysis - Apriori algorithm
rules <- apriori(product,parameter = list(support=0.001,confidence=0.05))
rules
summary(rules)

#Look at some first rules
inspect(rules[1:50])
#Sort by lift, i.e. support of a boundle divided by support of an individual support of each item
inspect(sort(rules, by="lift")[1:10])
#Sort by confidence, i.e. how likely is it that a customer buys rhs items if he/she already bought lhs items
sortedrules <- sort(rules,by="confidence",decreasing = TRUE)
inspect(sortedrules[1:25])

#Target some stuff
targetrules<-apriori(data=product, parameter=list(supp=0.001,conf = 0.05,minlen=2), 
               appearance = list(default="rhs",lhs="Shirt (on hanger)"),
               control = list(verbose=F))
targetrules<-sort(targetrules,decreasing=TRUE,by="confidence")
inspect(targetrules)








