# This file takes n-gram dataframes and merges them with Simple Good Turing (sgt) files to create dataframes of
# n-grams and smoothed probabilities.

rm(list = ls())
gc()
library(checkpoint)  # MRO Checkpoint
checkpoint("2016-03-01") # MRO Checkpoint
library(dplyr)
library(data.table)
if(require("RevoUtilsMath")){
  setMKLthreads(4)
}


# Read in the Simple Good Turing files
unigram.sgt <- fread("Data-Files/sgt/uni-sgtProbs.csv", stringsAsFactors = FALSE, header = FALSE)
bigram.sgt <- fread("Data-Files/sgt/bi-sgtProbs.csv", stringsAsFactors = FALSE, header = FALSE)
trigram.sgt <- fread("Data-Files/sgt/tri-sgtProbs.csv", stringsAsFactors = FALSE, header = FALSE)
fourgram.sgt <- fread("Data-Files/sgt/four-sgtProbs.csv", stringsAsFactors = FALSE, header = FALSE)

# rename the columsn of the SGT
colnames(unigram.sgt) <- c("terms", "prob")
colnames(bigram.sgt) <- c("terms", "prob")
colnames(trigram.sgt) <- c("terms", "prob")
colnames(fourgram.sgt) <- c("terms", "prob")

# sort by probability
unigram.sgt <- unigram.sgt %>% arrange(desc(prob))
bigram.sgt <- bigram.sgt %>% arrange(desc(prob))
trigram.sgt <- trigram.sgt%>% arrange(desc(prob))
fourgram.sgt <- fourgram.sgt %>% arrange(desc(prob))

# Remove items with lowest prob
low.prob <- tail(unigram.sgt$prob, 1)
unigram.sgt <- unigram.sgt %>% filter(prob > low.prob)
low.prob <- tail(bigram.sgt$prob, 1)
bigram.sgt <- bigram.sgt %>% filter(prob > low.prob)
low.prob <- tail(trigram.sgt$prob, 1)
trigram.sgt <- trigram.sgt %>% filter(prob > low.prob)
low.prob <- tail(fourgram.sgt$prob, 1)
fourgram.sgt <- fourgram.sgt %>% filter(prob > low.prob)



# Write the files out to disk
write.csv(unigram.sgt, "Data-Files/dataframes/unigram.df-sgt.csv", row.names = FALSE)
write.csv(bigram.sgt, "Data-Files/dataframes/bigram.df-sgt.csv", row.names = FALSE)
write.csv(trigram.sgt, "Data-Files/dataframes/trigram.df-sgt.csv", row.names = FALSE)
write.csv(fourgram.sgt, "Data-Files/dataframes/fourgram.df-sgt.csv", row.names = FALSE)
