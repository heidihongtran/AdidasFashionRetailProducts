
# Installing packages
install.packages("dplyr")

# Loading packages
library(dplyr)


# Importing cleaned dataset
adidas <- read.csv("C:/Users/haleh/Downloads/BigData2/adidas_v6.csv")


## Q1 - Which products are receiving the highest rating - 5 out of 5?
q1_step1 <- select(adidas, name, category, average_rating, reviews_count)

q1_step2 <- q1_step1 %>% group_by(name, category, reviews_count)  %>%
  summarise(avrg_rating_ProductLine=mean(average_rating), #calculate average rating of each category
            .groups = 'drop') %>% 
  as.data.frame()

q1_step2 %>% arrange(desc(avrg_rating_ProductLine)) #sort in descending order

# We see that there are some products with high rating but low number of review counts.
# Filter dataset to choose observations with number of reviews more than 1000 
  #it means we only count on products with more than 1000 total review counts.
q1_step3  <- filter(q1_step2, reviews_count > 1000)

# Top 10 products with actual highest rating
HighestRating_Products<-head(q1_step3 %>% arrange(desc(avrg_rating_ProductLine)),10)  
HighestRating_Products


## Q2 - Top 5 products are receiving the lowest rating
head(lowest_rating <- q1_step2 %>% arrange(avrg_rating_ProductLine),5)
#arrange() function orders in ascending order by default
#display the first 5 rows



## Q3 - Top 10 products with the most reviews
q3_step1 <- select(adidas,name, category, reviews_count)

q3_step2 <- q3_step1 %>% group_by(name, category)  %>%
  summarise(Total_ReviewCounts = sum(reviews_count),
            .groups = 'drop') %>%
  as.data.frame()

Products_topReviewCounts<-head(q3_step2 %>% arrange(desc(Total_ReviewCounts)),10)  
Products_topReviewCounts



## Q4 - Calculate correlation

#Store data for all the numeric variables
numdata = adidas[sapply(adidas,is.numeric)]

#Add discountRate column in numdata 
numdata2 <- numdata %>% 
  mutate(discountRate = discount / selling_price) 

#Calculates summary statistics for all the columns in numdata2
summarise_all(numdata2, funs(n(), mean, median, min, max))

#Show the correlation between average_rating with other numeric variables:
cor(numdata$average_rating, numdata$selling_price, method="pearson")

cor(numdata$average_rating, numdata$original_price, method="pearson")

cor(numdata$average_rating, numdata$reviews_count, method="pearson")

cor(numdata$average_rating, numdata$discount, method="pearson")

cor(numdata2$average_rating, numdata2$discountRate, method="pearson")

#Show the correlation between reviews_count with other numeric variables:

cor(numdata$reviews_count, numdata$selling_price, method="pearson")

cor(numdata$reviews_count, numdata$original_price, method="pearson")

cor(numdata$reviews_count, numdata$discount, method="pearson")

cor(numdata2$reviews_count, numdata2$discountRate, method="pearson")
