# Installing packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("janitor")
install.packages("tidyr")
install.packages("skimr")
install.packages("ggplot2")


# Loading packages
library(tidyverse)
library(dplyr)
library(janitor)
library(tidyr)
library(skimr)
library(ggplot2)


# Importing datasets
adidas <- read.csv("E:/Downloads/archive/adidas_usa.csv")


# Viewing adidas dataset
view(adidas)
str(adidas)
# Findings: 'data.frame':	845 obs. of  21 variables


# Checking column names
colnames(adidas)
#Findings: column names are consistent


# Checking for distinct SKUs in the dataset
n_distinct(adidas$sku)
# Findings: we have 845 distinct SKU numbers so there is no duplicated values in our table


# To ensure, we recheck for duplicated values
sum(duplicated(adidas))
# Findings: 0 duplicated value in our dataset


# Removing unnecessary columns: index, source, source_website, brand, images, language, crawled_at 
adidas_v1 = subset(adidas, select = -c(index, source, source_website, brand, images, language, crawled_at))
view(adidas_v1)
# Findings: 845 obs. of  14 variables


# Rearranging column position
adidas_v2 = adidas_v1[, c(3, 2, 4, 5, 6, 1, 7, 8, 9, 10, 11, 12, 13, 14)]
view(adidas_v2)


# Removing $ sign from the original price variable and convert it to integer
adidas_v2$original_price <- as.integer(gsub("\\$","", adidas_v2$original_price))
view(adidas_v2)
str(adidas_v2)
#Findings: original_price changes from chr to integer



#Removing missing values
adidas_v3 = drop_na(adidas_v2)
view(adidas_v3)
str(adidas_v3)
#Findings: after removing missing values we have 'data.frame': 829 obs. of  14 variables


# Adding new column discount = original_price - selling_price
adidas_v4 = adidas_v3 %>% mutate(discount = original_price - selling_price)


# Rearranging column position
adidas_v5 = adidas_v4[, c(1, 2, 3, 4, 15, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)]
view(adidas_v5)
str(adidas_v5)
#Findings: 'data.frame':	829 obs. of  15 variables:


# Removing unnecessary columns: url, description, currency, country 
adidas_v6 = subset(adidas_v5, select = -c(url, description, currency, country))
view(adidas_v6)
# Findings: 829 obs. of  11 variables

#Exporting adidas_v6 to csv file for data analyzing
write.csv(adidas_v6,"E:/Downloads/adidas_v6.csv", row.names = FALSE)



