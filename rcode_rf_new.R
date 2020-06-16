library(tidymodels)
library(parsnip)
library(skimr)
library(kknn)

datas <- read.csv('C:/Users/suvel/Desktop/rcode/loan-prediction.csv', header = T)
skim(datas)
datas$Loan_Status <- as.factor(datas$Loan_Status)
datas$Gender <- as.factor(datas$Gender)
datas$Married <- as.factor(datas$Married)
datas$Education <- as.factor(datas$Education)
datas$Self_Employed <- as.factor(datas$Self_Employed)
datas$Property_Area <- as.factor(datas$Property_Area)
datas$Loan_Status <- as.factor(datas$Loan_Status)
datas$Dependents <- as.factor(datas$Dependents)
skim(datas)


set.seed(1234)
data_split <- initial_split(datas)
data_train <- training(data_split)
data_test <- testing(data_split)

library(themis)
data_rec <- recipe(Loan_Status ~ ., data = data_train) %>%
            update_role(Loan_ID, new_role = "ID") %>%
            step_naomit(LoanAmount, Loan_Amount_Term, Credit_History)%>%
            step_upsample(Loan_Status) %>%
            step_normalize(all_numeric())
          


data_prep <- prep(data_rec)
juiced <- juice(data_prep)



test_proc <- bake(data_prep, new_data = data_test)

knn_spec <- nearest_neighbor() %>%
  set_engine("kknn") %>%
  set_mode("classification")


knn_fit <- knn_spec %>%
  fit(Loan_Status ~ ., data = juice(data_prep))

rf_fit


tree_spec <- decision_tree() %>%
  set_engine("rpart") %>%
  set_mode("classification")

tree_fit <- tree_spec %>%
  fit(Loan_Status ~ ., data = juice(data_prep))

tree_fit

set.seed(1234)
validation_splits <- mc_cv(juice(data_prep), prop = 0.9, strata = Loan_Status)
validation_splits

knn_res <- fit_resamples(
  knn_spec,
  Loan_Status ~ .,
  validation_splits,
  control = control_resamples(save_pred = TRUE)
)

knn_res %>%
  collect_metrics()



tree_res <- fit_resamples(
  tree_spec,
  Loan_Status ~ .,
  validation_splits,
  control = control_resamples(save_pred = TRUE)
)

tree_res %>%
  collect_metrics()



