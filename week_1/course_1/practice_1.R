### practice_1_question

# Craete variable called my.height.cm with your actual height in cm 
my.height.cm <- 171

# Craete variable called my.weight.kg with your actual weight in kg
my.weight.kg <- 76

# Create my.height.m transfered by my.height.cm  
my.height.m <- my.height.cm / 100

# Create my.bmi with BMI(Body Mass Index) formula
my.bmi <- my.weight.kg / (my.height.m ^ 2)

# Use if-else to print matched information
# Reference: http://www.tpech.gov.taipei/ct.asp?xItem=1794336&CtNode=30678&mp=109171
if (my.bmi >= 35) {
  print(paste("Your bmi: ", my.bmi))
  print("重度肥胖!")
} else if (my.bmi < 35) {
  print(paste("Your bmi: ", my.bmi))
  print("還算正常")
}
