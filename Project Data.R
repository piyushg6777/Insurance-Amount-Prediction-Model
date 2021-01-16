## loading the dataset into insurance_data object

rm(list=ls())
dev.off()

setwd("C:\\Users\\abc\\Desktop\\Intermediate\\week 5\\project final")

insurance_data = read.csv("insurance.csv")
library(ggplot2)
library(MASS)

## plotting histogram for insurance cost / 'charges' variable
hist(insurance_data$charges, xlab="Insurance Charges" , main="Histogram representing insurance charges", col="cyan4")

## creating normalized plot using log transformation
insurance_data$n_charges = log(insurance_data$charges)


## plotting normalized histogram for insurance cost / 'charges' variable
hist(insurance_data$n_charges,xlab="Normalized Insurance Charges" , 
     main="Histogram representing normalized insurance charges", col="skyblue")

## Obtaining relationship between age and insurance cost / 'charges' variable
plot(insurance_data$age , insurance_data$charges, main="Linear relationship between 'age' and 'charges'", 
                            xlab="age of individual", ylab="insurance charges", col="blue") 

##Obtaining relationship between age and normalized insurance cost / 'charges' variable
plot(insurance_data$age , insurance_data$n_charges,main="Linear relationship between 'age' and normalized charges", 
                            xlab="age of individual", ylab="normalized insurance charges", col="red")

cor(insurance_data$age, insurance_data$bmi)


##Decision Tree
install.packages("partykit")
require(partykit)
modeldt<-ctree(n_charges~age+bmi+smoker, data=training_data,
               control = ctree_control(mincriterion=0.90, minsplit=300))
print(modeldt)
plot(modeldt, type="simple", main="Decision Tree for n_charges~age+bmi+smoker")



#plot(insurance_data$smoker , insurance_data$n_charges,main="Box Plot for 'smoker' and 'normalized charges'", 
#     xlab="Smoker", ylab="Normalized insurance charges", col="yellow")

boxplot<-ggplot(insurance_data, aes( smoker, n_charges, fill = smoker)) + geom_boxplot()
boxplot+labs(x="Smoker", y="Normalized insurance charges", title ="Box Plot for 'smoker' and 'normalized charges'")+ theme(
  plot.title = element_text(color="black", size=20, face="bold"),
  axis.title.x = element_text(color="#993333", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)

insurance_data$charges = NULL



# Lasso Regression
library(caret)
lasso <- train(n_charges~., data=insurance_data, method='glmnet', 
               tuneGrid = expand.grid(alpha=1, lambda= seq(0.0001, 1 ,length = 5)))

plot(lasso)

plot(lasso$finalModel, xvar = 'lambda', label=T)
plot(varImp(lasso, scale=F))

## defining training and test data
set.seed(675)
partition <- sample(2,nrow(insurance_data),replace=TRUE,prob=c(0.75,0.25))
training_data <- insurance_data[partition==1, ]
test_data <- insurance_data[partition==2, ]


linear_model <- lm(n_charges ~ ., data = training_data) #linear Model
summary(linear_model)

###  RMSE  ##
install.packages("Metrics")
predictions_test <- predict(linear_model, test_data)
predictions_training <- predict(linear_model, training_data)
RMSE(insurance_data$n_charges, predictions_test) 
RMSE(insurance_data$n_charges, predictions_training)

summary(test$n_charges)

coeff_var <- 1.27/9.137 #coefficient of variation (RMSE value/Mean value)
coeff_var

### selecting only training variable, not whole dataset
ModelFit = lm(n_charges~.,data=training_data)
summary(ModelFit)
names(ModelFit)

ModelFit$coefficients 

head(ModelFit$residuals) 

## Plotting residuals plot for checking normality (of errors)

hist(ModelFit$residuals, xlab="Residuals" , main="Plot to check for normality via residuals plot", col="green3")

### Tests for presence of heteroskedasticity and autocorrelation

## Standardizing the residuals 
residuals = stdres(ModelFit)

summary(ModelFit)

### Plot for predicted values and Normalized values 

plot(ModelFit$fitted.values, residuals, xlab="Fitted values)", ylab="Residuals", main = "Residuals vs. Fitted values", col= "blue")

### Test for getting specific no. and value of outliers
library(car)

outlierTest(ModelFit)

### Performing Durbin Watson test for autocorrelation
library(lmtest)

dwtest(ModelFit)


### Plot for searching outliers using cutoff value with the help of Breusch-Pagan / Cook - Weisberg test 

cook_dist = cooks.distance(ModelFit)

cutoff_value = 4/(nrow(training_data) - length(ModelFit$coefficients))

plot(ModelFit, which=4, cook.levels=cutoff_value, main="Breusch-Pagan / Cook - Weisberg test for testing heteroscedasticity ", col = "cyan3")

### Test for multicollinearity using Variable inflation factor

vif(ModelFit)

## removing outliers from out dataset 

training_data = training_data[ -c(517,220, 431, 1040, 103, 527, 1020), ]

ModelFit = lm(n_charges~.-bmi,data=training_data)
summary(ModelFit)


## checking for improvement in Heteroskedascity and Autocorrelation in our dataset after removing outliers
plot(ModelFit, which=3,col="darkblue", cex=1,lwd="2", main = "Plot for residuals vs. Normalized (Fitted) Values - Training Data")

## Plot for relationship between our target and input variables 

BMIvsCharges<- ggplot(training_data, aes(bmi,n_charges)) + geom_point(color="darkblue")
BMIvsCharges+labs(x="BMI", y="Normalized Insurance Charges", title ="Scatter Plot for 'BMI' and 'normalized charges'")


AGEvsCharges<-ggplot(training_data, aes( age, n_charges)) + geom_point(color="darkblue")
AGEvsCharges+labs(x="Age", y="Normalized Insurance Charges", title ="Scatter Plot for 'Age' and 'normalized charges'")


### merging bmi and age variables by dividing them and taking the square root into a completely new variable called 'age_bmi'

training_data$age_bmi = sqrt(training_data$bmi/training_data$age)

AGE_BMIvsCharges<- ggplot(training_data, aes( sqrt(age_bmi), n_charges)) + geom_point(color="darkblue")
AGE_BMIvsCharges+labs(x="sqrt(age_BMI)", y="Normalized Insurance Charges", title ="Scatter Plot for 'SQRT (Age_BMI)' and 'normalized charges'")


#### our final Model formed using ratio of age and bmi variables

ModelFit = lm( n_charges ~ . -bmi -age,  data=training_data)
summary(ModelFit) 

### merging age and bmi by multiplying them and taking them as a completely new variable called 'age.bmi'
training_data$bmi.age = log( training_data$bmi*training_data$age)

AGE.BMIvsCharges<-ggplot( training_data, aes( sqrt(bmi.age), n_charges)) + geom_point(color="darkblue")
AGE.BMIvsCharges+labs(x="sqrt(age.BMI)", y="Normalized Insurance Charges", title ="Scatter Plot for 'SQRT (Age.BMI)' and 'normalized charges'")


#adding new obtained variables to our model
ModelFit = lm( n_charges ~ . -bmi -age -age_bmi, data=training_data)

ModelFit_predict = lm( n_charges ~ . -bmi -age -age_bmi, data=training_data)

summary(ModelFit)

## plot for residuals vs. Normalized values
plot(ModelFit,which=1, col="darkblue", cex=1,lwd="2", main = "Plot for residuals vs. Normalized (ModelFitted) Values - Training Data")

## performing similar steps for test dataset 

ModelFit_testdata = lm(n_charges  ~  . -bmi , data=test_data)

plot(ModelFit_testdata, which=3, col="darkblue", cex=1,lwd="2", main = "Plot for residuals vs. Normalized (ModelFitted) Values - Test Data")


##plot for checking relationship between our target and predictor variables

BMIvsCharges_test<-ggplot(test_data, aes( bmi, n_charges)) + geom_point(color="darkgreen")
BMIvsCharges_test+labs(x="BMI", y="Normalized Insurance Charges", title ="Scatter Plot for 'BMI' and 'normalized charges' for TEST dataset")


AGEvsCharges_test<-ggplot(test_data, aes( age, n_charges)) + geom_point(color="darkgreen")
AGEvsCharges_test+labs(x="Age", y="Normalized Insurance Charges", title ="Scatter Plot for 'Age' and 'normalized charges'for TEST dataset")


### merging bmi and age into a new variable (similar to what we performed for training dataset)

test_data$age_bmi = sqrt(test_data$bmi/test_data$age)

AGE_BMIvsCharges_test<-ggplot( test_data, aes( sqrt(age_bmi), n_charges)) + geom_point(color="darkgreen")
AGE_BMIvsCharges_test+labs(x="sqrt(age_BMI)", y="Normalized Insurance Charges", title ="Scatter Plot for 'SQRT (Age_BMI)' and 'normalized charges' for TEST dataset")



#adding new obtained variables to our test dataset

ModelFit_testdata = lm( n_charges ~ . -bmi -age,  data= test_data)

summary(ModelFit_testdata) 

test_data$bmi.age = log( test_data$bmi*test_data$age)

AGE.BMIvsCharges_test<-ggplot( test_data, aes( sqrt(bmi.age), n_charges)) + geom_point(color="darkgreen")
AGE.BMIvsCharges_test+labs(x="sqrt(age.BMI)", y="Normalized Insurance Charges", title ="Scatter Plot for 'SQRT (Age.BMI)' and 'normalized charges' for TEST dataset")



# obtaining new test dataset by adding new variables
ModelFit_testdata = lm( n_charges ~ . -bmi -age -age_bmi, data=test_data)

summary(ModelFit_testdata)

plot(ModelFit_testdata,which=1,col="darkblue", cex=1,lwd="2", main = "Plot for residuals vs. Normalized (fitted) Values for Test dataset")

###Predictive Model

#test 1
Piyush <- data.frame(age = 25, sex = "male", bmi = 28.5, children = 1, smoker = "no", region = "northwest", age_bmi = 0.982, 
                  bmi.age = 7.40)
charges.Piyush = predict(ModelFit, Piyush)
charges.Piyush

#test 2
Anjali <- data.frame(age = 20, sex = "female", bmi = 27.9, children = 0, smoker = "yes", region = "northwest", age_bmi = 0.884, bmi.age = 5.32)
charges.Anjali = predict(ModelFit, Anjali)
charges.Anjali

#test 3
Ross <- data.frame(age = 26, sex = "male", bmi = 22, children = 2, smoker = "yes", region = "northwest", age_bmi = 0.729, bmi.age = 6.10)
charges.Ross = predict(ModelFit, Ross)
charges.Ross

#test 4
Monica <- data.frame(age = 30, sex = "female", bmi = 21, children = 0, smoker = "no", region = "northeast", age_bmi = 0.729, bmi.age = 6.10)
charges.Monica = predict(ModelFit, Monica)
charges.Monica
