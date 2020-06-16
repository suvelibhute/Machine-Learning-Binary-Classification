**An Analytic Model to Predict Loan Defaulter Activity**

**Objective:**
Predicted whether a customer will be defaulting the loan or not and
prevented the bank from losing the capital amount using machine learning algorithms. 

**Dataset:**
The dataset has total 601 observations and 11 predictors. We have one target variable (binary variable) which tells us if the customer has paid back loan or not. The dataset is obtained from Kaggle.com.

**Procedure:**
I have done the analysis using **tidymodels** library in R.
I have used upsampling in order to have a balanced dataset. I had very few missing values and hence I deleted it from my dataset.
I have normalized all the numeric variables.
I have used KNN and Decision tree algorithm using tidymodels in R. 

I have used cross validation in order to evaluate the performance of the models. 


**Conclusion:**
The ROC AUC is 0.50 for knn and 0.784 for decision tree.

The decision tree is performed better than knn model. 
