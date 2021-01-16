# Insurance-Amount-Prediction-Model
This project was aimed to predict insurance cost for an individual given his demographics and other info
## Introduction:
The project report talks about how the insurance costs are affected by other factors such as, the age of an individual, how many children he/she have, gender, their BMI (Body Mass Index), smoking habits and region they belong to. All these factors are collected and stored within 6 predictor variables and the 7th response variable contains the individual insurance costs for all observations. 
## Data Dictionary:
1. Age:  This is a continuous variable representing the age of the individual.
2. Sex: This is a categorical variable with 2 factors, male or female.
3. BMI: A continuous variable consisting of Body mass index, providing an understanding of body, weights that are relatively high or low relative to height, objective index of body weight (kg / m ^ 2) using the ratio of height to weight, ideally 18.5 to 24.9 (Choi M., 2018).
4. Children: This is a continuous variable showing number of children one is having i.e. the number of dependents. 
5. Smoker: This is a factor/categorical variable which consists of Yes or No depending upon the individual’s smoking habits.
6. Region: This contains a categorical variable with 4 possible inputs as northeast, northwest, southwest, southeast.
7. Charges: Total Insurance premium one has to pay against insurance premium annually.

## Business questions to aim our reseasrch upon:
In this project, we will be addressing our research on the following questions:
1.	What variables contributes the most for the change in insurance cost for different individuals.
2.	What changes are procured by our model in its effectiveness if we partition it into training and testing models.
3.	How are insurance companies and consumers benefitted from the model?
4.	What will be the output if the input values are out of range in obtained predictive model.

## Methods involved in our project
We used several methods and techniques of descriptive statistics, Linear regression, LASSO regression, Decision tree etc. to answer the above questions. These methods will be useful to address the above mentioned questions because our dataset consists of dependent variable and we would like to research on various aspects of this which can be precisely achieved by our chosen methods. 
Decision tree and LASSO regression will help us in determining the most important variable on which our target variable gets affected. Linear model will help us in creating a predictive model by forecasting the future values based on the values already present in our dataset.
We are having 6 predictors here, so multiple regression techniques will be preferred. We will be testing autocollinearity, multicollinearity, Heteroscedescity etc. to validate effectiveness of our model. We have also implemented a predictive model which generates value of insurance costs when provided with the predictor values for dummy individuals. This model will help in checking the accuracy of the model by taking different sets of inputs.
The goal of this project is to address the above mentioned questions and finally create a model for insurance cost deciding factors, such that companies can provide cheaper and personalized package of insurance deals for individuals with less risk in terms of health, without procuring any loss.

## Conclusion:
- We saw that the variables such as ‘age’ and ‘children’ had a pretty significant impact on the value of ‘charges’. 

- Both predictors were directly proportional to our response variable and with increase in age or no. of children for an individual, his/her insurance costs also got increased. Furthermore, smoking habits also plays an important role for deciding insurance costs as we saw individual having smoking habits as ‘yes’ were paying more for their insurance as compared with their counterparts who do not smoke. Hence, living a healthy life and maintaining low BMI and avoiding smoking will lead to less insurance premiums for an individual.

- Moreover, our model will help the customers as they can see the factors affecting the cost they have to pay resulting in more clear picture and transparency. Whereas, insurance companies will also be benefitted as companies can provide cheaper and more personalized packages or insurance deals for individuals with less risk in terms of health, without procuring any loss. Hence, number of individuals signing up for insurance will also enhance coherently.
For our predictive model, we conclude that the predictions are quite accurate. But for the values which are not in the range (outliers), the accuracy in result outcome of predicted insurance cost may be affected which will be taken care of with the increasing entries in our datasets over time.

- Data partitioning of our parent dataset ‘insurance_data’ into training and test datasets came out quite successful as we tested that the variability and dispersion of data was quite similar in both of them. RMSE values also came out to be similar suggesting our model to be good. 
Hence, data partitioning helped us in validating the outcomes and all other factors of the data to achieve perfect and effective outcomes. In addition, our model will help both the customers and companies to save time in estimating the insurance premium for new individuals.

- Future scope of our model is pretty wide as the insurance industry in US is facing many frauds making around 10% of the total expenses in the industry which is estimated to be more than $40 billion per year (Insurance Fraud, 2010) and fraud detection can be achieved by predicting upcoming influx and risks involved by understanding the repercussions of previous years’ data. Also, it can be implemented in various sectors apart from insurance industry, like healthcare, education, manufacturing industries etc.

