library('NLP')
library('tm')
library('SnowballC')
library('RColorBrewer')
library('jiebaRD')
library('jiebaR')
library('slam')
library('Matrix')
library('tidytext')
library('NLP')
library('ggplot2')
#library of text mining

tfidfnn <- read.csv("tfidf.csv")

tfidf <- as.matrix(tfidfnn[, 2: 13])
rownames(tfidf) <- tfidfnn[, 1]

v <- sort(rowSums(tfidf), decreasing = TRUE)
d <- data.frame(word = names(v),score = v)

plot <- d[1: 100, 1: 2]
plot$word <- factor(plot$word, levels = plot$word[order(- plot$score)])

ggplot(plot, aes(x = word, y = score)) +
  geom_bar(stat="identity", width=.5, fill="blue") +
  theme(text=element_text(family="黑體-繁 中黑", size = 4))
