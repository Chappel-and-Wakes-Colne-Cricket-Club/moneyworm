library(httr2)
source("get_token.R")

get_products <- function(token_json){
   
   address <- sprintf("https://products.izettle.com/organizations/%s/products/v2", token_json$client_id_prods)

   prod_req <- request(address)

   authstring <- sprintf("Bearer %s", token_json$access_token)
   prod_req <- prod_req |> req_headers("Authorization" = authstring)

   prod_resp <- req_perform(prod_req)
   prod_j <- resp_body_json(prod_resp)
   
   products <- data.frame(
     Name = character(),
     Category = character()
   )
   products <- rbind(products, c("Name", "Category"))
   i <- 1
   for ( product in prod_j ) {
     name <- product$name
     category <- product$category$name
     if ( is.null(category) )
     {
       category <- "none"
     }
     products <- rbind(products, c(name, category))
   }
   
   return(products)
}