# 猜數字遊戲
# 基本功能
# 1. 請寫一個由"電腦隨機產生"不同數字的四位數(1A2B遊戲)
# 2. 玩家可"重覆"猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

# 額外功能：每次玩家輸入完四個數字後，檢查玩家的輸入是否正確(錯誤檢查)

answer <- sample(x = c(1000: 9999), size = 1)
answer.digit <- c(0, 0, 0, 0)

for (x in c(1: 4)) {
  answer.digit[x] <- (answer %% (10 ^ x) - answer %% (10 ^ (x - 1))) / (10 ^ (x - 1))
}
#1 ~ 4 分別是個、十、百、千

count <- 0
while (TRUE) {
  input <- readline(prompt = "請輸入猜測的數字：")
  input <- as.numeric(input)
  
  if (input < 1000 || input > 9999) {
    cat("請輸入正確可判讀的四位數字")
    next
  }

  input.digit <- c(0, 0, 0, 0)

  for (x in c(1: 4)) {
    input.digit[x] <- (input %% (10 ^ x) - input %% (10 ^ (x - 1))) / (10 ^ (x - 1))
  }

  if (input == answer) {
    count <- count + 1
    break
  }

  meet.A <- c(0, 0, 0, 0)
  meet.B <- c(0, 0, 0, 0)
  for (x in c(1: 4)) {
    if (input.digit[x] == answer.digit[x]) {
      meet.A[x] <- meet.A[x] + 1
    }
  }

  for (x in c(1 : 4)) {
    for (y in c(1 : 4)) {
      if (input.digit[x] == answer.digit[y] && meet.A[y] == 0) {
        meet.B[x] <- meet.B[x] + 1
      }
    }
    if (meet.B[x] >= 1 && meet.A[x] == 0) {
      meet.B[x] <- 1
    }
    else if (meet.B[x] >= 1 && meet.A[x] != 0) {
      meet.B[x] <- 0
    }
  }
  cat("這次結果是 ", sum(meet.A), "A", sum(meet.B), "B\n")
  count <- count + 1
}

cat("恭喜成功猜對數字，總共花了 ", count, " 次\n")
