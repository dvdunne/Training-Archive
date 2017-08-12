# To generate count of count files for use in Simple Good Turing gernation (.py script).
rm(list = ls())
gc()
library(checkpoint)  # MRO Checkpoint
checkpoint("2016-03-01") # MRO Checkpoint
library(dplyr)

count.of.counts <- function(df){
  g <- group_by(df, count)
  g <- summarise(g, n = n())
  colnames(g) <- c("r", "n")
  g <- arrange(g, r)
}

filelist <- c("unigram.df.csv",
              "bigram.df.csv",
              "trigram.df.csv",
			        "fourgram.df.csv")

for(file in seq(filelist)) {
  cat("Processing ", filelist[file], "\n")
  path <- "./Data-Files/dataframes/"
  infile <- paste(path, filelist[file], sep="")
  df <- read.csv(infile)
  df2 <- count.of.counts(df)
  path <- "./Data-Files/sgt/countofcount-" 
  outfile <- paste(path, filelist[file], sep = "")
  write.csv(df2, outfile, row.names = FALSE)
}
