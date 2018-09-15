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

  input.digit <- c(0, 0, 0, 0)

  for (x in c(1: 4)) {
    input.digit[x] <- (input %% (10 ^ x) - input %% (10 ^ (x - 1))) / (10 ^ (x - 1))
  }

  if (input == answer) {
    count <- count + 1
    break
  }

  meet.A <- 0
  meet.B <- 0
  meet.check <- 0
  for (x in c(1 : 4)) {
    for (y in c(1 : 4)) {
      if (x == y && input.digit[x] == answer.digit[y]) {
        if (meet.check != 0) {
          meet.B <- meet.B - meet.check
          meet.check <- 0
        }

        meet.A <- meet.A + 1
        break

      } else if (x != y && input.digit[x] == answer.digit[y]) {
        meet.B <- meet.B + 1
        meet.check <- meet.check + 1
      }
    } 

    if (meet.check >= 2) {
      meet.B <- meet.B - (meet.check - 1)
    }
    meet.check <- 0
  }
  cat("這次結果是 ", meet.A, "A", meet.B, "B\n")
  count <- count + 1
}

cat("恭喜成功猜對數字，總共花了 ", count, " 次\n")
