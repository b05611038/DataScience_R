### [課程投影片](https://ppt.cc/fxQ79x)

## Data Details

 - 英文新聞資料：path/news.txt
 - 使用 NLTK 完成 NER 範例程式：NER.ipynb

## 本週任務
將沒有做過 NER 的資料，加入 NER，再銜接以前做過的方法，看看有甚麼不同。

## 本週完成
 - 試著跑課堂範例：class_example_NER.ipynb
 - [課堂範例網頁連結](https://b05611038.github.io/DataScience_R/week_12/class_example_NER.html)


## mac jupyter notebook prompt-toolkit version error 無法使用處理辦法
    這個問題其實是新版的jupyter-console version 6.0.0 無法支援prompt-toolkit的問題，那只要把這兩個版本更動一下就好，以下是指令，若是pip需要權限請加sudo，若是python2，請將pip3改成pip

```
pip3 uninstall prompt-toolkit
pip3 install prompt-toolkit==1.0.15
pip3 uninstall jupyter-console
pip3 install jupyter-console==5.2.0
```
