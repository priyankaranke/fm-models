library("recommenderlab")
library(Matrix)

#Setting row names to be cities and deleting columns
df <- read.csv("Capital First - Capital first sheet.csv")
df$State <- NULL
df$Area <- NULL
row.names(df) <- df$City
df$City <- NULL

#transposing so that it'll recommend me cities and not franchises
df_t <- t(df)
transposeddf <- as.data.frame(df_t)

df1<-as.matrix(transposeddf) #It doesn't work without this step
df1<-sapply(data.frame(df1),as.numeric) # Convert to numeric (by arbitrarily mapping characters to numbers.)

recobuilder <- as(df1, "realRatingMatrix")
rec <- Recommender(recobuilder, method = "UBCF") #Building a recommender model with User-based CF

# ---Building top-N predictions using recommender model---
pre <- predict(rec, recobuilder[26, ], n = 10)  #predicts 10 cities for franchise number 26
as(pre, "list")

