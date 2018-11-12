library('xml2')
library('rvest')
#library of web crawling
library('stringr')
#library of string process

URL.top <- "http://www.millionbook.net/wx/j/jingyong/index.html"
URL.part1 <- "http://www.millionbook.net/wx/j/jingyong/"
folder.path <- "data/"

book.title <- read_html(URL.top) %>% html_nodes("a") %>% html_text()
book.link <- read_html(URL.top) %>% html_nodes("a") %>% xml_attr("href")

#to grab all novel of Louis Cha Jing-yong
content <- c()
for (i in c(5: 18)) {
  book.URL <- paste(URL.part1, book.link[i], sep = "")

  text <- ""
  if (i == 10 || i == 18) {
    text <- read_html(book.URL) %>% html_nodes(".tt2") %>% html_text()
  } else {
    chapter.title <- read_html(book.URL) %>% html_nodes("a") %>% html_text()
    chapter.link <- read_html(book.URL) %>% html_nodes("a") %>% xml_attr("href")
    link.first <- str_replace(book.URL, "index.html", "")
    for (j in c(4: 4)) {
      grab.link <- paste(link.first, chapter.link[j], sep = "")
      text.temp <- read_html(grab.link) %>% html_nodes(".tt2") %>% html_text()

      text <- paste(text, text.temp, sep = "")
      filename <- paste(book.title[i], "ch1.txt", sep = "")
      path <- paste(folder.path, filename, sep = "")
      #write.table(text, file = path, sep = "", col.names = F, row.names = F)
      content <- c(content, text)
      cat("Output file: ", filename, "success\n")
    }
  }
}
