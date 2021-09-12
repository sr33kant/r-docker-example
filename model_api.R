library(plumber)
library(caret)
library(jsonlite)
library(ipred)
library(e1071)
library(yaml)

model <- readr::read_rds("/Users/viper/tb_model.rds")
model$modelInfo

function(){
  list(status = "Connection to Stranded Patient API successful", 
       time = Sys.time(),
       username = Sys.getenv("USERNAME"))
}

#* Predict whether a patient is a stranded patient
#* @post /predict

function(req, res){
  data.frame(predict(model, newdata = as.data.frame(req$body), type="prob"))
}

#* @plumber
function(pr){
  pr %>% 
    pr_set_api_spec(yaml::read_yaml("openapi.yaml"))
}

