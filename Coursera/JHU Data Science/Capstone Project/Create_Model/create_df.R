# garbage collection
rm(list = ls())
gc()
#
# Load libraries
#
library(checkpoint)  # MRO Checkpoint
checkpoint("2016-03-01") # MRO Checkpoint
library(tm)
if(require("RevoUtilsMath")){
  setMKLthreads(4)
}

#Load data files
cat("Loading files...\n")
blogs <- readLines("Coursera-SwiftKey/final/en_US/en_US.blogs.txt")
news <- readLines("Coursera-SwiftKey/final/en_US/en_US.news.txt")
twitter <- readLines("Coursera-SwiftKey/final/en_US/en_US.twitter.txt")

# Sample to make data processing more manageable
set.seed(1234)  # To reproduce the sampling
sample.percent <- 0.1  # %
blogs.sample <- blogs[sample(1:length(blogs), length(blogs) * sample.percent )]
news.sample <- news[sample(1:length(news), length(news) * sample.percent )]
twitter.sample <- twitter[sample(1:length(twitter), length(twitter) * sample.percent )] 
rm(blogs, news, twitter)

write(blogs.sample, file = "Data-Files/sample/blogs.sample.txt")
write(news.sample, file = "Data-Files/sample/news.sample.txt")
write(twitter.sample, file = "Data-Files/sample/twitter.sample.txt")
rm(list = ls()) #clean environment

########################

library(tm)
library(filehash)
if(require("RevoUtilsMath")){
  setMKLthreads(4)
}

cat("Creating corpus and cleaning files...\n")

docs <- PCorpus(DirSource("Data-Files/sample/", encoding="UTF-8",mode="text"),
                      dbControl=list(dbName="sample.docs.db", dbType="DB1"))

# 
# Clean data
#
remove.URL <- content_transformer(function(x, pattern) {return (gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", x))})
docs <- tm_map(docs, remove.URL)

remove.punct <- content_transformer(function(x, pattern) {return (gsub("[^[:alnum:][:space:]'!?]", " ", x))})
docs <- tm_map(docs, remove.punct)

clean.Non.Ascii <- content_transformer(function(x) iconv(x, to="ASCII", sub=" "))
docs <- tm_map(docs,clean.Non.Ascii)
# docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs,content_transformer(tolower))
docs <- tm_map(docs, stripWhitespace)

# For Cleaning bad words
shutterstock.bad.words <- readLines("Coursera-SwiftKey/ShutterStock/bad.words.en.txt")
docs <- tm_map(docs, removeWords, shutterstock.bad.words)
rm(shutterstock.bad.words)


#
# Save corpus to disk as corpus and as text file
#
# save(docs, file = "Data-Files/corpus/docs.RData")
writeCorpus(docs, path = "Data-Files/clean-text/")
rm(list = ls()) #clean environment
gc()
####################

cat("Converting to DFM...\n")

library(quanteda)
library(tm)
library(stringr)
if(require("RevoUtilsMath")){
  setMKLthreads(4)
}

blogs <- textfile("Data-Files/clean-text/blogs.sample.txt.txt")
news <- textfile("Data-Files/clean-text/news.sample.txt.txt")
twitter <- textfile("Data-Files/clean-text/twitter.sample.txt.txt")

blog.corpus <- corpus(blogs)
news.corpus <- corpus(news)
twitter.corpus <- corpus(twitter)
rm(blogs, news, twitter)

full.corpus <- blog.corpus + news.corpus + twitter.corpus
rm(blog.corpus, news.corpus, twitter.corpus)
# save(full.corpus, file = "Data-Files/corpus/full.corpus.Rdata")

cat("Generating unigrams...\n")

uni.dfm <- dfm(full.corpus, 
                ngrams = 1,
                removeNumbers = TRUE,
                removeTwitter = TRUE,
                verbose = FALSE)

topf <- topfeatures(uni.dfm, n = nfeature(uni.dfm))
unigram.df <- data.frame(terms = names(topf), count = as.numeric(topf))
rm(uni.dfm, topf)
write.csv(unigram.df, "Data-Files/dataframes/unigram.df.csv", row.names = FALSE)
rm(unigram.df)

cat("Generating bigrams...\n")

bi.dfm <- dfm(full.corpus, 
               ngrams = 2,
               removeNumbers = TRUE,
               removeTwitter = TRUE,
               verbose = FALSE)

topf <- topfeatures(bi.dfm, n = nfeature(bi.dfm))
bigram.df <- data.frame(terms = names(topf), count = as.numeric(topf))
bigram.df$terms <- str_replace_all(bigram.df$terms, "_", " ")
rm(bi.dfm, topf)
write.csv(bigram.df, "Data-Files/dataframes/bigram.df.csv", row.names = FALSE)
rm(bigram.df)


cat("Generating trigrams...\n")


tri.dfm <- dfm(full.corpus, 
               ngrams = 3,
               removeNumbers = TRUE,
               removeTwitter = TRUE,
               verbose = FALSE) 

topf <- topfeatures(tri.dfm, n = nfeature(tri.dfm))
trigram.df <- data.frame(terms = names(topf), count = as.numeric(topf))
trigram.df$terms <- str_replace_all(trigram.df$terms, "_", " ")
rm(tri.dfm, topf)
write.csv(trigram.df, "Data-Files/dataframes/trigram.df.csv", row.names = FALSE)
rm(trigram.df)

cat("Generating fourgrams...\n")

four.dfm <- dfm(full.corpus, 
               ngrams = 4,
               removeNumbers = TRUE,
               removeTwitter = TRUE,
               verbose = FALSE)
topf <- topfeatures(four.dfm, n = nfeature(four.dfm))
fourgram.df <- data.frame(terms = names(topf), count = as.numeric(topf))
fourgram.df$terms <- str_replace_all(fourgram.df$terms, "_", " ")
rm(four.dfm, topf)
write.csv(fourgram.df, "Data-Files/dataframes/fourgram.df.csv", row.names = FALSE)
rm(fourgram.df)

rm(full.corpus)

cat("Finished!\n")

