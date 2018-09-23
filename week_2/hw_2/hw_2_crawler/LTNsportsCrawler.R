library(rvest)
#import the R package

URL <- c("http://sports.ltn.com.tw/baseball",
         "http://sports.ltn.com.tw/basketball",
         "http://sports.ltn.com.tw/athletics",
         "http://sports.ltn.com.tw/tennis",
         "http://sports.ltn.com.tw/football",
         "http://sports.ltn.com.tw/leisure",
         "http://sports.ltn.com.tw/gaming",
         "http://sports.ltn.com.tw/interview")
         #set the url that we wants to greb

title <- c(1: 10)
#to title the news number

title.name <- c("numbers", "baseball", "basketball", "athletics", "tennis", "football", "leisure", "gaming", "interview")
#the name of subtitle

for (x in c(1: 8)) {
  title.temp <- read_html(URL[x])
  #using read_html() to get the information of the websites

  title.temp <- html_nodes(title.temp, ".list_title")
  #to greb the class that contain the data that we want

  title.temp <- html_text(title.temp)
  #to filter the not string data

  title.temp <- title.temp[c(1: 10)]
  #only catch the latest 10 news

  title <- rbind(title, title.temp)
  #to combine the data
}

title <- as.data.frame(title)
#conert the matrix data into dataframe

rownames(title) <- title.name
#rename the dataframe rows' name

save(title, file='Sport_news_title.RData')
#save the data in to a file
