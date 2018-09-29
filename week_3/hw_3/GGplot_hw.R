library(ggplot2)

iris

ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_bar(fill = "lightblue", colour = "black")

ggplot(data = iris, aes(Sepal.Length, Sepal.Width)) +
  geom_jitter(width = .25, size = 2) +
  labs(subtitle="Iris: Sepal.Length vs Sepal.Width", y = "Sepal.Width", x = "Sepal.Length", title = "Iris")

select_species <- iris[iris$Species %in% c("setosa", "versicolor", "virginica"), ]

g <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  labs(subtitle="Iris: Sepal.Length vs Sepal.Width", title = "Iris")

g + geom_jitter(aes(col = Species))

g <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  labs(subtitle="Iris: Sepal.Length vs Sepal.Width", title = "Iris")

g + geom_jitter(aes(col = Species, size = Petal.Length))


