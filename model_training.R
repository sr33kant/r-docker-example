library(NHSRdatasets)
library(dplyr)
library(tidyr)
library(varhandle)
library(magrittr)
library(rsample)
library(caret)
library(taskscheduleR)
library(data.table)

stranded <- NHSRdatasets::stranded_data %>% 
  setNames(c("stranded_class", "age", "care_home_ref_flag", "medically_safe_flag", 
             "hcop_flag", "needs_mental_health_support_flag", "previous_care_in_last_12_month", "admit_date", "frail_descrip")) %>% 
  mutate(stranded_class = factor(stranded_class)) %>% 
  drop_na()

# Create dummy encoding of frailty index
cats <- varhandle::to.dummy(stranded$frail_descrip, "frail") %>% 
  as.data.frame() %>% 
  dplyr::select(-c(frail.No_index_item)) #Get rid of reference column

stranded <- stranded %>%
  cbind(cats) %>% 
  dplyr::select(-c(admit_date, frail_descrip))

set.seed(123)
split <- rsample::initial_split(stranded, prop=3/4)
train_data <- rsample::training(split)
test_data <- rsample::testing(split)
class_bal_table <- table(stranded$stranded_class)
prop_tab <- prop.table(class_bal_table)
upsample_ratio <- class_bal_table[2] / sum(class_bal_table)
tb_model <- caret::train(stranded_class ~ .,
                         data = train_data,
                         method = 'treebag',
                         verbose = TRUE)
saveRDS(tb_model, file = "tb_model.rds")
