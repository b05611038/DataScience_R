library(xml2)
library(rvest)
#import the library for web crawling

URL <- "https://discuss.pytorch.org"
#define the website URL

title <- read_html(URL) %>% html_nodes("a") %>% html_text()
#get the title of the discussion

library('stringr')
#import the libaray of string work

title <-str_replace(title, "\n        ", "")
title <-str_replace(title, "\n      ", "")
#clean the surplus space line breaking symbol

library("NLP")
library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")
#import the library of word mining and word cloud

docs <- Corpus(VectorSource(title))
#load data as corpus

inspect(docs)
#can check the corpus content

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing = TRUE)
d <- data.frame(word = names(v),freq = v)
#to check the word frequency in the docs
head(d, 10)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, removeNumbers)
#remove all numbers in the docs
docs <- tm_map(docs, removePunctuation)
#remove extra white space
docs <- tm_map(docs, toSpace, 'Uncategorized')
docs <- tm_map(docs, toSpace, 'uncategorized')
docs <- tm_map(docs, toSpace, 'the')
docs <- tm_map(docs, toSpace, 'With')
docs <- tm_map(docs, toSpace, 'with')
docs <- tm_map(docs, toSpace, 'How')
docs <- tm_map(docs, toSpace, 'how')
#delete the stop word

new.dtm <- TermDocumentMatrix(docs)
new.m <- as.matrix(new.dtm)
new.v <- sort(rowSums(new.m),decreasing = TRUE)
new.d <- data.frame(word = names(new.v),freq = new.v)
#to check the word frequency in the docs
head(new.d, 10)

set.seed(1111)
wordcloud(words = new.d$word, freq = new.d$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
#to display the wordcloud
