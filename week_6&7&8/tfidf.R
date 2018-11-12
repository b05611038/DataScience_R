library('NLP')
library('tm')
library('SnowballC')
library('RColorBrewer')
library('jiebaRD')
library('jiebaR')
library('slam')
library('Matrix')
library('tidytext')
#library of text mining

content <- read.table("data/*ch1.txt")

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

seg = lapply(docs, token)

d.corpus <- Corpus(VectorSource(seg))

d.corpus <- tm_map(d.corpus, toSpace, '的')
d.corpus <- tm_map(d.corpus, toSpace, '了')
d.corpus <- tm_map(d.corpus, toSpace, '這')
d.corpus <- tm_map(d.corpus, toSpace, '是')
d.corpus <- tm_map(d.corpus, toSpace, '你')
d.corpus <- tm_map(d.corpus, toSpace, '我')
d.corpus <- tm_map(d.corpus, toSpace, '他')
d.corpus <- tm_map(d.corpus, toSpace, '這')
d.corpus <- tm_map(d.corpus, toSpace, '那')
d.corpus <- tm_map(d.corpus, toSpace, '在')

tdm <- TermDocumentMatrix(d.corpus)
print( tf <- as.matrix(tdm) )
DF <- tidy(tf)

# tf-idf computation
N = tdm$ncol
tf <- apply(tdm, 2, sum)
idfCal <- function(word_doc)
{ 
  log2( N / nnzero(word_doc) ) 
}
idf <- apply(tdm, 1, idfCal)

doc.tfidf <- as.matrix(tdm)
for(x in 1:nrow(tdm))
{
  for(y in 1:ncol(tdm))
  {
    doc.tfidf[x,y] <- (doc.tfidf[x,y] / tf[y]) * idf[x]
  }
}

findZeroId = as.matrix(apply(doc.tfidf, 1, sum))
tfidfnn = doc.tfidf[-which(findZeroId == 0),]

write.csv(tfidfnn, "tfidf.csv")
