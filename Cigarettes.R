
# Install  packages
install.packages("ggplot2")
install.packages("Ecdat")

# Load libraries package
library(ggplot2)
library(Ecdat)

# Load the Cigarette dataset
data(Cigarette)

head(Cigarette)





# Task 1: Boxplot of the highest and lowest:

ggplot(Cigarette, aes(x = state, y = packpc)) + geom_boxplot() +
  labs(title = "Highest and Lowest Packs per Capita by State",
       x = "State", y = "Packs per Capita")




## Calculate the median number of packs per capita by state
median_packs <- aggregate(packpc ~ state, data = Cigarette, FUN = median)

## Sort the data frame by median packs per capita
sorted_median_packs <- median_packs[order(median_packs$packpc), ]

## Select the top and bottom median values
top_median <- sorted_median_packs[length(sorted_median_packs$packpc), ]
lowest_median <- sorted_median_packs[1, ]


## Create a boxplot of the top median packs per capita
top_median_data <- subset(Cigarette, state == top_median$state)
boxplot(top_median_data$packpc, main = "Top Median Packs per Capita",
        ylab = "Packs per Capita")

## Create a boxplot of the lowest median packs per capita
lowest_median_data <- subset(Cigarette, state == lowest_median$state)
boxplot(lowest_median_data$packpc, main = "Lowest Median Packs per Capita",
        ylab = "Packs per Capita")




# Find states with the highest and lowest number of packs
state_avg_packs <- aggregate(packpc ~ state, Cigarette, mean)
highest_packs <- state_avg_packs[which.max(state_avg_packs$packpc), "state"]
lowest_packs <- state_avg_packs[which.min(state_avg_packs$packpc), "state"]


cat("States with the highest number of packs:", highest_packs, "\n")
cat("States with the lowest number of packs:", lowest_packs, "\n\n")


# Task 2: Median number of packs per capita for each year (1985-1995)
years <- 1985:1995
median_packs_per_year <- aggregate(packpc ~ year, Cigarette, median)

# Plotting the median values
plot(median_packs_per_year$year, median_packs_per_year$packpc, type = "l",
     xlab = "Year", ylab = "Median Packs per Capita",
     main = "Median Packs per Capita (1985-1995)")

# Task 3: Scatter plot of price per pack vs number of packs per capita
plot(Cigarette$ppack, Cigarette$packpc, xlab = "Price per Pack",
     ylab = "Packs per Capita", main = "Price per Pack vs Packs per Capita")

# Task 4: Correlation between price and per capita packs
correlation <- cor(Cigarette$ppack, Cigarette$packpc)
if (correlation > 0) {
  cat("The price and the per capita packs are positively correlated.\n")
} else if (correlation < 0) {
  cat("The price and the per capita packs are negatively correlated.\n")
} else {
  cat("The price and the per capita packs are uncorrelated.\n")
}
cat("Correlation coefficient:", correlation, "\n\n")

# Task 5: Scatter plot with points colored by year
plot(Cigarette$ppack, Cigarette$ppe, xlab = "Price per Pack",
     ylab = "Packs per Capita", main = "Price per Pack vs Packs per Capita",
     col = Cigarette$year)

# Task 6: Linear regression between price and per capita packs
lm_model <- lm(packpc ~ ppack, data = Cigarette)
summary(lm_model)$r.squared

# Task 7: Adjusted price, scatter plot, and linear regression
Cigarette$adjusted_price <- Cigarette$avgprs / Cigarette$cpi

plot(Cigarette$adjusted_price, Cigarette$ppe, xlab = "Adjusted Price per Pack",
     ylab = "Packs per Capita", main = "Adjusted Price vs Packs per Capita")

lm_model_adjusted <- lm(ppe ~ adjusted_price, data = Cigarette)
summary(lm_model_adjusted)$r.squared


# Task 8: Paired t-test for number of packs per capita in 1985 and 1995
Task 8: Paired t-test for number of packs per capita in 1985 and 1995

# Create a data frame with rows from 1985
data_1985 <- subset(Cigarette, year == 1985)

# Create a data frame with rows from 1995
data_1995 <- subset(Cigarette, year == 1995)

# Perform paired t-test
t_test_result <- t.test(data_1985$packpc, data_1995$packpc, paired = TRUE)

# Print the results
print(t_test_result)


#Explanation of the results#
##The number of packs per capita in 1985 and 1995.

- The test statistic (t-value) is 14.789, indicating a large difference between the means of the two samples.
- The degrees of freedom (df) are 47, which is the number of paired observations minus 1.
- The p-value is less than 2.2e-16, which is extremely small. This suggests strong evidence against the null hypothesis (that there is no difference in means) in favor of the alternative hypothesis.
- The alternative hypothesis is that the true difference in means is not equal to zero, indicating that there is a significant difference between the number of packs per capita in 1985 and 1995.
- The 95% confidence interval for the difference in means is calculated as (22.21151, 29.20576). This means that we can be 95% confident that the true difference in means falls within this interval.
- The sample estimate of the mean difference is 25.70863, indicating that, on average, there is an increase of approximately 25.71 packs per capita from 1985 to 1995.

Overall, the results suggest a significant increase in the number of packs per capita from 1985 to 1995, with a substantial difference between the means of the two years.





