#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library('shiny')
library('rsconnect')
library('shinythemes')
library('stringr')
library('png')

novel.tag <- c("請選擇", "飛狐外傳ch1", "雪山飛狐ch1", "連城訣ch1", "天龍八部ch1", "射鵰英雄傳ch1",
"鹿鼎記ch1", "笑傲江湖ch1", "書劍恩仇錄ch1", "神鵰俠侶ch1", "俠客行ch1",
"倚天屠龍記ch1", "碧血劍ch1")

# Define UI for application that draws a histogram
ui <- navbarPage(
  theme = shinythemes::shinytheme("superhero"),
  #shinytheme
  "金庸長篇小說開頭分析",

  tabPanel(
    "簡介",

    tags$h2("簡介"),br(),
    tags$h3("作者：張育堂"),br(),br(),
    tags$h4("就在這篇小報告做出來不久前，華人界最享譽盛名的小說作者金庸，
            本名查良鏞於香港醫院病逝，這個消息實在頗令人感慨，想當初我國中、
            國小時也是看這他的武俠小說長大，雖然金庸早就不寫長篇小說了，
            但是之前的小說早已被翻拍成無數部的電影跟電視劇，
            雖然我在這個小報告裡面用到的分析方法其實是非常傳統的文字探勘，
            但是我也想看看當這些小說不是以我們熟悉的「文字」的形式出現在我們面前時，
            我們會不會對這些小說有不同的認識呢！"),br(),
    tags$h5("資料來源：龍騰世紀書庫, http://www.millionbook.net/wx/j/jingyong/index.html"),
    tags$h5("github:")
  ),

  tabPanel(
    "開頭(第一章)文字雲",
    tags$h4("因為原檔是小說，所以需要非常大的運算空間，
            所以在這裡我是將已經做好的文字雲在去掉比較常見的無意義的字，
            像是「你、我、他」之類的去除，並已經做成一個圖片，
            所以只能選擇文本而不能選擇數量"),br(),
    sidebarPanel(
      selectInput("wc", "小說名稱：",
                  choices = novel.tag),
      hr(),
      helpText("可以顯現出不同長篇小說第一章的文字雲")
    ),
    mainPanel(
      imageOutput("image1")
    )
  ),

  tabPanel(
    "開頭(第一章)字數長條圖",
    tags$h4("因為原檔是小說，需要非常大的運算空間，
            所以在這裡我是將文本篩選之後，像是「你、我、他」之類的去除，
            並已經做成一個長條圖，所以只能選擇文本而不能選擇數量"),br(),
    sidebarPanel(
      selectInput("wc2", "小說名稱：",
                  choices = novel.tag),
      hr(),
      helpText("顯示不同長篇小說第一章的字數長條圖")
    ),
    mainPanel(
      imageOutput("image2")
    )
  ),

  tabPanel(
    "tfidf分析",
    tags$h4("這裡也是先做好圖才丟上來的，雖然圖因為很難容納那麼多的資訊而有些不清楚，
            但仔細看也可以看出其實在開頭的部分，雖然人名在不同篇都不一樣，
            但是其實也會有很多姓氏重複所以造成分數很高的狀況，
            接下來分數高的大概都是一些暱稱，
            像是「小丐」等金庸較常用的用在不重要人物上的人物敘述，
            最後就是地名或者是生活物品之類的，
            由此可知金庸的其實長篇小說的開頭並沒有真的有特別用什麼特殊的字詞"),br(),
    mainPanel(
      imageOutput("image3")
    )
  ),

  tabPanel(
    "PCA文本分析",
    tags$h4("這裡也是先做好圖才丟上來的，是將tfidf的資料將成二維之後顯示在圖上，
            而這裡可以看出雖然大部分的小說開頭集中在同一個區域，但是像是
            鹿鼎記、倚天屠龍記，這兩個就是跟其他的開頭相差甚遠的，
            PCA的PC1和PC2可以代表說最能分開tfidf矩陣各個資料點的向量投影，
            我想這些離開較遠的點一定有它的意義存在，
            也許再詳細閱讀之後就能豁然開朗呢！"),br(),
    mainPanel(
      imageOutput("image4")
    )
  ),

  tabPanel(
    "小結",
    tags$h4("金庸爺爺享耆壽94歲，一生的成就其實真的不可限量，
            要透過這個簡單的文本分析要了解小說的本質其實真的過於簡單，
            以其他的面向來觀賞小說其實真的有趣，當結合數學的時候，
            文學不再那麼文學，當我們幫他們安上數字時，
            我想最能帶給我們的改變是能將它們都打上一個分數，
            這個分數高低不一定代表他的好壞，但卻是只屬於他們的獨特數字，
            希望以後能有機會可以用更強的工具達成更好的分析效果，
            不然這個報告實在是太對不起金庸這位讓我們可以有機會可以藉由小說
            馳騁於武俠世界的稀世文學巨匠呢"),br(),
    mainPanel(
      imageOutput("image5")
    ),
    tags$h5("圖片來源：香港經濟日報,
            https://topick.hket.com/article/1662016/香港首個「金庸館」%E3%80%803月沙田文化博物館亮相")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$image1 <- renderImage({
    if (is.null(input$wc))
      return(NULL)

    if (input$wc == novel.tag[2]) {
      return(list(
        src = paste("wordcloud/", novel.tag[2], ".png", sep = ""),
        contentType = "image/png",
        alt = novel.tag[2]
      ))} else if (input$wc == novel.tag[3]) {
        return(list(
          src = paste("wordcloud/", novel.tag[3], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[3]
      ))} else if (input$wc == novel.tag[4]) {
        return(list(
          src = paste("wordcloud/", novel.tag[4], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[4]
      ))} else if (input$wc == novel.tag[5]) {
        return(list(
          src = paste("wordcloud/", novel.tag[5], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[5]
      ))} else if (input$wc == novel.tag[6]) {
        return(list(
          src = paste("wordcloud/", novel.tag[6], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[6]
      ))} else if (input$wc == novel.tag[7]) {
        return(list(
          src = paste("wordcloud/", novel.tag[7], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[7]
      ))} else if (input$wc == novel.tag[8]) {
        return(list(
          src = paste("wordcloud/", novel.tag[8], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[8]
      ))} else if (input$wc == novel.tag[9]) {
        return(list(
          src = paste("wordcloud/", novel.tag[9], ".png", sep = ""),
          contentType = "image/png",
         alt = novel.tag[9]
      ))} else if (input$wc == novel.tag[10]) {
        return(list(
          src = paste("wordcloud/", novel.tag[10], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[10]
      ))} else if (input$wc == novel.tag[11]) {
        return(list(
          src = paste("wordcloud/", novel.tag[11], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[11]
      ))} else if (input$wc == novel.tag[12]) {
        return(list(
          src = paste("wordcloud/", novel.tag[12], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[12]
      ))} else if (input$wc == novel.tag[13]) {
        return(list(
          src = paste("wordcloud/", novel.tag[13], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[13]
      ))} else {
        return(list(
          src = "nothing.png",
          contentType = "image/png",
          alt = "nothing"
      ))}
  }, deleteFile = FALSE)

  output$image2 <- renderImage({
    if (is.null(input$wc2))
      return(NULL)

    if (input$wc2 == novel.tag[2]) {
      return(list(
        src = paste("plot_bar/", novel.tag[2], ".png", sep = ""),
        contentType = "image/png",
        alt = novel.tag[2]
      ))} else if (input$wc2 == novel.tag[3]) {
        return(list(
          src = paste("plot_bar/", novel.tag[3], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[3]
      ))} else if (input$wc2 == novel.tag[4]) {
        return(list(
          src = paste("plot_bar/", novel.tag[4], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[4]
      ))} else if (input$wc2 == novel.tag[5]) {
        return(list(
          src = paste("plot_bar/", novel.tag[5], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[5]
      ))} else if (input$wc2 == novel.tag[6]) {
        return(list(
          src = paste("plot_bar/", novel.tag[6], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[6]
      ))} else if (input$wc2 == novel.tag[7]) {
        return(list(
          src = paste("plot_bar/", novel.tag[7], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[7]
      ))} else if (input$wc2 == novel.tag[8]) {
        return(list(
          src = paste("plot_bar/", novel.tag[8], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[8]
      ))} else if (input$wc2 == novel.tag[9]) {
        return(list(
          src = paste("plot_bar/", novel.tag[9], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[9]
      ))} else if (input$wc2 == novel.tag[10]) {
        return(list(
          src = paste("plot_bar/", novel.tag[10], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[10]
      ))} else if (input$wc2 == novel.tag[11]) {
        return(list(
          src = paste("plot_bar/", novel.tag[11], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[11]
      ))} else if (input$wc2 == novel.tag[12]) {
        return(list(
          src = paste("plot_bar/", novel.tag[12], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[12]
      ))} else if (input$wc2 == novel.tag[13]) {
        return(list(
          src = paste("plot_bar/", novel.tag[13], ".png", sep = ""),
          contentType = "image/png",
          alt = novel.tag[13]
      ))} else {
        return(list(
          src = "nothing.png",
          contentType = "image/png",
          alt = "nothing"
      ))}
  }, deleteFile = FALSE)

  output$image3 <- renderImage({
    return(list(
      src = "image/word_weight.png",
      contentType = "image/png",
      alt = "word_weight"
    ))
  }, deleteFile = FALSE)

  output$image4 <- renderImage({
    return(list(
      src = "image/pca.png",
      contentType = "image/png",
      alt = "pca"
    ))
  }, deleteFile = FALSE)

  output$image5 <- renderImage({
    return(list(
      src = "image/icon.png",
      contentType = "image/png",
      alt = "icon"
    ))
  }, deleteFile = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)

