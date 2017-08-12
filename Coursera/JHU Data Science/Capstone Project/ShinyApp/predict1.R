
library(dplyr)
library(stringr)
library(data.table)


# Function to clean up a string
clean.string <- function(str1) {
  str1 <- tolower(str1)  
  str1 <- gsub("[0-9]", "", str1)  # Remove numbers
  str1 <- gsub("\\s+", " ", str1)  # Replace multiple spaces with single space
  str1 <- gsub("^\\s+|\\s+$", "", str1)  # remove leading and trailing space
  str1
}

# Function to get top N from dataframe
get.top.n <- function(df, num = 1) {
  if(dim(df)[1] >= num){
    return(df[1:num, ])
  } else {
    return(df[1:dim(df)[1],])
  }
}

###################

get.4gram <- function(search.token) {  
  found.df <- fourgram.df %>% filter(grepl(search.token, terms ))
  if(dim(found.df)[1] != 0){
    return(found.df) 
  }
  df <- data.frame()
  return(df)  # empty dataframe
}

get.trigram <- function(search.token) {
  # cat("Checking for trigram\n")
  found.df <- trigram.df %>% filter(grepl(search.token, terms ))
  if(dim(found.df)[1] != 0){
    return(found.df) 
  }
  df <- data.frame()
  return(df)  # empty datafram
}


get.bigram <- function(search.token) {
  # cat("Checking for bigram\n")
  found.df <- bigram.df %>% filter(grepl(search.token, terms ))
  if(dim(found.df)[1] != 0){
    return(found.df) 
  }
  df <- data.frame()
  return(df)  # empty datafram
}

get.unigram <- function(top.n = 1) {
  # cat("Checking for unigram\n")
  found.df <- get.top.n(unigram.df, top.n)
  if(dim(found.df)[1] != 0){
    return(found.df) 
  }
  df <- data.frame()
  return(df)  # empty datafram 
}

format.output <- function(words) {
  num.words<-length(strsplit(words, " "))  # How many words?
  pred.words <- words[1]
  if(num.words >= 2){
    pred.word2 <- words[2]
    pred.words <- paste(pred.words, pred.word2, sep = " | ")
  }
  if(num.words >= 3){
    pred.word3 <- words[3]
    pred.words <- paste(pred.words, pred.word3, sep = " | ")
  }
  return(pred.words)
}

####

predict.words <- function(phrase, top.n = 1) {
  num.words<-length(strsplit(phrase, " ")[[1]])  # How many words?
  if(num.words < 3) {
    return("Please enter at least three words...")
  }
  
  token <- word(phrase, -3, -1)  # get last three words
  search.term <-paste("^\\b",token,"\\b",sep="")  # create grep string
  found <- get.4gram(search.term) # Look for fourgram
  
  if(dim(found)[1] > 0){ 
    return(get.top.n(found, top.n))  # Found fourgram
  }

  # Check for trigram
  token <- word(phrase, -2, -1)  # get last two words
  search.term <-paste("^\\b",token,"\\b",sep="")  # create grep string
  found <- get.trigram(search.term) # Look for trigram
  if(dim(found)[1] > 0){ 
    return(get.top.n(found, top.n)) # Found trigram
  }
  

  # Check for bigram
  token <- word(phrase, -1, -1)  # get last  word
  search.term <-paste("^\\b",token,"\\b",sep="")  # create grep string
  found <- get.bigram(search.term) # Look for bigram
  if(dim(found)[1] > 0){ 
    return(get.top.n(found, top.n)) # Found bigram
  }
  
  # get most likely unigram 
  found <- get.unigram() # Look for trigram
  if(dim(found)[1] > 0){ 
    return(found) # Found unigram
  }
  return("not found")
  
}
  
  
pred <- function(phrase, top.n = 1) {
  phrase <- clean.string(phrase)
  results <- predict.words(phrase, top.n)
  pred.words <- word(results$terms, -1, -1)
  return(format.output(pred.words))
}


#######################

# load files
unigram.df <- fread("Data-Files/dataframes/unigram.df-sgt.csv", stringsAsFactors = FALSE)
bigram.df <- fread("Data-Files/dataframes/bigram.df-sgt.csv", stringsAsFactors = FALSE)
trigram.df <- fread("Data-Files/dataframes/trigram.df-sgt.csv", stringsAsFactors = FALSE)
fourgram.df <- fread("Data-Files/dataframes/fourgram.df-sgt.csv", stringsAsFactors = FALSE)





