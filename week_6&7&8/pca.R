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

colnames(tfidf) <- c("飛狐外傳", "雪山飛狐", "連城訣", "天龍八部", "射鵰英雄傳", "鹿鼎記", "笑傲江湖", "書劍恩仇錄", "神雕俠侶", "俠客行", "倚天屠龍記", "碧血劍")

pca <- prcomp(t(tfidf), scale = T)

plot <- pca$x[, 1: 2]
plot <- as.data.frame(plot)

ggplot(plot, aes(x = PC1, y = PC2)) +
  geom_point() +
   geom_text(label = rownames(plot), family = "黑體-繁 中黑", size = 6)
