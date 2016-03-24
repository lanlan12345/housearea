#global

library(shiny)
library(ggplot2)
library(reshape2)
load("data.RData")




#initial <- xypoints(27,31,100)
# P=100
# result<-NULL
# for(x in 1:49){
#         z <- seq(x,P-x)
#         y <- P-x-z
#         A <- round(2*x*y + (z^2-x^2)^0.5*x,2)
#         alpha <- round(acos(x/z)/pi*180,1)
#         xx <- rep(x,length(z))
#         df <- data.frame(x=xx,z=z,Area=A,alpha=alpha,y=y)
#         result <- rbind(result,df)
# }
# rm(z,y,A,alpha,xx,df)



# xypoints<-function(x, z, p){ 
#         if(x<=z){
#         y <- p-x-z
#         df <- data.frame("x"=c(0,0,x,2*x,2*x),
#                          "y"= c(0, p-x-z, p-x-z+(z^2-x^2)^0.5, p-x-z,0))
#         A <- 2*x*y + (z^2-x^2)^0.5*x
#         alpha <- acos(x/z)/pi*180
#         return(list(y=y,A=A,alpha=alpha,df=df))}
# } 