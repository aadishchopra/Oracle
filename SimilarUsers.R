U.Data<-read.csv("http://files.grouplens.org/datasets/movielens/ml-100k/u.data",header = FALSE,sep = "\t",col.names = c("User_ID","Item_ID","Rating","TimeStamp"))

U.Item<-read.csv("http://files.grouplens.org/datasets/movielens/ml-100k/u.item",header=FALSE,sep="|",col.names = c("movie_id","movie_title","release_date","video_release_date","IMDb URL", "unknown","Action","Adventure","Animation","Children's","Comedy","Crime",    "Documentary","Drama","Fantasy","Film-Noir","Horror","Musical","Mystery","Romance"     ,"Sci-Fi","Thriller","War","Western"),as.is = TRUE)

U.User<-read.csv("http://files.grouplens.org/datasets/movielens/ml-100k/u.user",header=FALSE,sep="|",col.names = c("User_ID","age","gender","occupation","zip code"))


U.Genres<-read.csv("http://files.grouplens.org/datasets/movielens/ml-100k/u.genre",header=FALSE,sep="|",col.names = c("genre","Number"))






# Create rating matrix for users and movies where the rows correspond to the users and columns denote the movies
#and the cells denote the rating given by a user for a movie.



library(reshape2)
rating_matrix <- dcast(U.Data, User_ID~Item_ID, value.var = "Rating", na.rm=FALSE)
rating_matrix <- as.matrix(rating_matrix[,-1]) #remove User_ID

#To determine the similarity between the users, cosine similarity is used to generate similarity matrix
library(recommenderlab)

#Convert rating matrix into a recommenderlab sparse matrix
rating_matrix <- as(rating_matrix, "realRatingMatrix")

similarity_users <- similarity(rating_matrix,
                               method = "cosine",
                               which = "users")
similarity_matrix <- as.matrix(similarity_users)

#Based on the similarity matrix, the users having the least similarity value other than themselves are the
#most similar users with similar preferences in terms of similar movies and similar ratings.

most_similar_user<-as.data.frame(apply(similarity_matrix, 2,
                                       FUN = function(x) {which.min(x[(x > 0)])}))
colnames(most_similar_user)<-"similar_user"

#This gives the most similar user for each user