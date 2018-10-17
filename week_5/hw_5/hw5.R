library('xml2')
library('rvest')
#library of web crawling
library('stringr')
#library of string process

numextract <- function(string){
  str_extract(string, "\\-*\\d+\\.*\\d*")
}
#the function used in greb number from string

URL.origin <- "https://forum.gamer.com.tw/"
URL.part1 <- "https://forum.gamer.com.tw/B.php?page="
URL.part2 <- "&bsn=44095"
#the target forum

title <- c()
link <- c()
page <- 1
check <- character(0)
while(TRUE) {
  URL <- paste(URL.part1, toString(page), URL.part2, sep = "")
  #we can get a iterable webpage URL

  title.temp <- read_html(URL) %>% html_nodes(".b-list__main__title") %>% html_text()
  link.temp <- read_html(URL) %>% html_nodes(".b-list__main__title") %>% xml_attr("href")
  #get the title of the each small part for our next step

  if (identical(title.temp, check) || identical(title.temp, check)) {
    break
  }

  title <- c(title, title.temp)
  link <- c(link, link.temp)

  page <- page + 1
}

check <- integer(0)
index <- c()
for (i in c(1: length(title))) {
  index.temp <- grep("集中討論串", title[i])
  #to check if the link we wants to check
  if (identical(index.temp, check)) {
    #don't do anything
  } else {
    index <- c(index, i)
    #to save the link we wants to go in
  }
}

lost.part <- "?page="
check <- character(0)
#data <- list()
data <- c()
for (i in c(1: length(index))) {
  cat("Start process page number ", i, "\n")
  content <- c()
  page <- 1
  link.temp <- link[index[i]]
  filename <- numextract(title[index[i]])
  filename <- paste("episode", filename, ".txt", sep = "")
  #to extract the sublink we need to use
  link.temp <- unlist(strsplit(link.temp, split = "?", fixed = TRUE))
  while(TRUE) {
    URL <- paste(URL.origin, link.temp[1], lost.part, toString(page), toString("&"), link.temp[2], sep = "")
    content.temp <- read_html(URL) %>% html_nodes(".c-article__content") %>% html_text()
    if (identical(content.temp, check)) {
      break
    }

    content <- c(content, content.temp)
    #to concatenate the content in all the page

    check <- content.temp
    #to let the check become the same as last page
    content <- str_replace_all(content, " ", "")
    content <- str_replace_all(content, "  ", "")
    content <- str_replace_all(content, "\n", "")
    content <- str_replace_all(content, "　", "")

    page <- page + 1
  }
  #the loop will end in the grab all page
  write.table(content, filename, sep = "")
  cat("Output file: ", filename, " success\n")
  content.temp <- content[1]
  for (x in c(2: length(content))) {
    content.temp <- paste(content.temp, content[x], sep = "")
  }
  data <- c(data, content.temp)
}

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

cc <- worker()
jieba_tokenizer=function(d){
  unlist(segment(d[[1]], cc))
}
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
})
#the delimeter of chinese
docs <- Corpus(VectorSource(data))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)

seq = c()
for (i in c(1: length(index))) {
  seq = c(seq, jieba_tokenizer(data[i]))
}
freqFrame = as.data.frame(table(unlist(seg)))
d.corpus <- Corpus(VectorSource(seg))

dtm <- TermDocumentMatrix(d.corpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing = TRUE)
d <- data.frame(word = names(v),freq = v)
DF <- tidy(m)

N = dtm$ncol
tf <- apply(dtm, 2, sum)
idfCal <- function(word_doc)
{ 
  log2( N / nnzero(word_doc) ) 
}
idf <- apply(dtm, 1, idfCal)

doc.tfidf <- as.matrix(dtm)
for(x in 1:nrow(dtm)) {
  for(y in 1:ncol(dtm)) {
    doc.tfidf[x,y] <- (doc.tfidf[x,y] / tf[y]) * idf[x]
  }
}

findZeroId = as.matrix(apply(doc.tfidf, 1, sum))
tfidfnn = doc.tfidf[-which(findZeroId == 0),]

write.csv(tfidfnn, "show.csv")
