# Preprocess, save, model and visualize data on frequency of YouTube use and age

# Load dataset
dat = read.csv("/Users/maxwellandrew/Dropbox/Arc/Data/Sets/md_vote.csv", header = TRUE)

# View factor levels (of "ytfreq"), or how often respondents watch YouTube
print(levels(dat$ytfreq))

# (Prints)
# [1] ""                         "A few times a week"
# [3] "Between 1-5 times a day"  "Between 6-15 times a day"
# [5] "More than 15 times a day" "Never"
# [7] "Once a month or less"     "Once a week"

# Redefine levels from alphabetical to ascending order
dat$ytfreq = factor(dat$ytfreq,levels(dat$ytfreq)[c(6,7,8,2,3,4,5,1)])

# View updated factor levels
print(levels(dat$ytfreq))

# (Prints)
# [1] "Never"                    "Once a month or less"    
# [3] "Once a week"              "A few times a week"      
# [5] "Between 1-5 times a day"  "Between 6-15 times a day"
# [7] "More than 15 times a day" "" 

# Save level strings as integers
dat$ytfreqInt <- as.numeric(dat$ytfreq)

# Convert 8 to NA (because level 8 represented no value)
dat$ytfreqInt[dat$ytfreqInt == 8] <- NA

# Save dataset with the new "ytfreqInt" column
write.csv(dat, "/Users/maxwellandrew/Dropbox/Arc/Data/Sets/md_vote.csv")

# Run a regression on YouTube viewing frequency
# Use dummy variables of age groups 18-25, 26-34, and 45-64 as regressors, or independent variables
# Take the resulting coefficients to determine the relative frequency at which each group uses YouTube on average
lm(formula = ytfreqInt ~ age1825 + age2634 + age4564, data = dat)

# (Prints)
# (Intercept)      age1825      age2634      age4564
#     3.400        1.314        1.267       -0.400

# Create a table
tbl <- matrix(c(1.314, 1.267, -0.400), ncol=3, byrow=TRUE)
colnames(tbl) <- c("18-25", "26-34", "45-64")
tbl <- as.table(tbl)

# Visualize model as bar plot
barplot(tbl, main="Average frequency of YouTube use by age", xlab="Age range")

# The data indicates that 18- to 25-year-olds use YouTube most frequently, followed closely by 26- to 35-year-olds 
# with both groups watching on average between a few times a week and 1-5 times a day.
# 45- to 64-year-olds are unsurprisingly the least frequent viewers of YouTube, watching it only once a week on average.