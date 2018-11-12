library('NLP')
library('tm')
library('SnowballC')
library('RColorBrewer')
library('jiebaRD')
library('jiebaR')
library('slam')
library('Matrix')
library('tidytext')
library('wordcloud2')
#library of text mining

content <- read.table("data/飛狐外傳ch1.txt")

cc <- worker()
token = function(d){
  unlist(segment(d[[1]], cc))
}
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
})
#the delimeter of chinese

docs <- Corpus(VectorSource(token(content)))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)

docs <- tm_map(docs, toSpace, '的')
docs <- tm_map(docs, toSpace, '了')
docs <- tm_map(docs, toSpace, '這')
docs <- tm_map(docs, toSpace, '是')
docs <- tm_map(docs, toSpace, '你')
docs <- tm_map(docs, toSpace, '我')
docs <- tm_map(docs, toSpace, '他')
docs <- tm_map(docs, toSpace, '這')
docs <- tm_map(docs, toSpace, '那')
docs <- tm_map(docs, toSpace, '在')

tdm <- TermDocumentMatrix(docs)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

wordcloud2(d)
