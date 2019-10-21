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