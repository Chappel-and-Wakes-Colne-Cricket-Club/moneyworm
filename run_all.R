source ("get_token.R")
source ("fetch_purchases.R")
source ("fetch_products.R")
source ("plot.R")

token_json <- get_token()
products <- get_products(token_json)
totals <- get_purchases(token_json)
update_plots()
