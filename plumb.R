ibrary(plumber)
options(warn=-1)


r <- plumber::plumb("model_api.R")
r$run(port=80, host="0.0.0.0",swagger=TRUE)


# To run in your browser
#http://127.0.0.1/__docs__/
