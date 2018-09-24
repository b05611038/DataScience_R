print_status <- function(status) {
  #the print function of the game
  for (x in 1: 3) {
    for (y in 1 : 3) {
      if (status[x, y] == -1) {
        cat("X")
      } else if (status[x, y] == 1) {
        cat("O")
      } else {
        cat(" ")
      }

      if (y == 3) {
        cat("\n")
      } else {
        cat("|")
      }
    }
    if (x == 3) {
      cat("**************\n")
    } else {
      cat("_____\n")
    }
  }
}


status <- matrix(rep(0, len = 9), nrow = 3)
#to initialize the game status

round <- 0
#to initialize player A's and B's round

key <- "exit"
FLAG <- FALSE
#the exit key

while (round < 9 && FLAG == FALSE) {
  cat("Round ", round, "\n")
  if (round %% 2 == 0) {
    #player A's round
    cat("Now is player A's term!\n")
    input <- readline(prompt = "Player A input(1~9) : ")
  } else {
    #player B's round
    cat("Now is player B's term!\n")
    input <- readline(prompt = "Player B input(1~9) : ")
  }

  if (input >= 1 && input <= 9 && as.integer(input) == as.numeric(input)) {
    #main code
    input <- as.integer(input)
    input <- input - 1
    if (status[(as.integer(input / 3) + 1), ((input + 3) %% 3 + 1)] == 0) {
      if (round %% 2 == 0) {
        #fill in the status matrix(O)
        status[(as.integer(input / 3) + 1), ((input + 3) %% 3 + 1)] <- 1
      } else {
        #fill in the status matrix(X)
        status[(as.integer(input / 3) + 1), ((input + 3) %% 3 + 1)] <- -1
      }
      round <- round + 1
      #all input is valid, round++
      print_status(status)
      #print the matrix status

      for (x in c(1: 3)) {
        if (status[x, 1] == status[x, 2] && status[x, 1] == status[x, 3] && status[x, 1] == 1) {
          cat("Player A wins!!!\n")
          round <- 10
          break
        } else if (status[x, 1] == status[x, 2] && status[x, 1] == status[x, 3] && status[x, 1] == -1) {
          cat("Player B wins!!!\n")
          round <- 10
          break
        }
      }
      for (x in c(1: 3)) {
        if (status[1, x] == status[2, x] && status[1, x] == status[3, x] && status[1, x] == 1) {
          cat("Player A wins!!!\n")
          round <- 10
          break
        } else if (status[1, x] == status[2, x] && status[1, x] == status[3, x] && status[1, x] == -1) {
          cat("Player B wins!!!\n")
          round <- 10
          break
        }
      }
      if (status[1, 1] == status[2, 2] && status[1, 1] == status[3, 3] && status[1, 1] == 1) {
        cat("Player A wins!!!\n")
        round <- 10
        break
      } else if (status[1, 1] == status[2, 2] && status[1, 1] == status[3, 3] && status[1, 1] == -1) {
        cat("Player B wins!!!\n")
        round <- 10
        break
      }
      if (status[1, 3] == status[2, 2] && status[1, 3] == status[3, 1] && status[1, 3] == 1) {
        cat("Player A wins!!!\n")
        round <- 10
        break
      } else if (status[1, 3] == status[2, 2] && status[1, 3] == status[3, 1] && status[1, 3] == -1) {
        cat("Player B wins!!!\n")
        round <- 10
        break
      }
      #eight if else statement to check the winner or loser
      if (round == 9) {
        cat("End in a draw!!!\n")
      }
    } else {
      cat("This position is already occupied!\n")
      break
    }
  } else if (input == key && FLAG == FALSE) {
    cat("Bye-Bye!!\n")
    FLAG <- TRUE
    break
  } else {
    cat("Invalid input! Please re-enter!\n")
    next
  }
}

while(TRUE) {
  if (FLAG == FALSE) {
    input <- readline(prompt = "Please input exit to end the game : ")
    if (input == key && FLAG == FALSE) {
      cat("Bye-Bye!!\n")
      q(save = "no")
    }
  } else if (FLAG == TRUE) {
    q(save = "no")
  }
}
