library(rvest)

title = read_html("http://sports.ltn.com.tw/baseball")

title = html_nodes(title,".list_title")

title = html_text(title)

title
