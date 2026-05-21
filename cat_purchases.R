library(httr2)

#jbody <- resp_body_json(resp)

#thingy <- category_totals(jbody)

category_totals <- function(purchases_json, week_start, week_end){
  #week_start <- start_date
  #week_end <- end_date
  #purchases_json <- purch_j
  cat_totals <- data.frame(WeekStart=week_start, WeekEnd=week_end, 
                      Category = unique(products[,2])[2], Amount = 0)

  for(i in 3:length(unique(products[,2])))
  {
        cat_totals <- rbind(cat_totals, list(week_start, week_end, unique(products[,2])[i], 0))
  }
  
  #sprintf ("There are %s purchases", length(purchases_json$purchases))
  #print(length(purchases_json$purchases))
  i <- 1
  for ( purchase in purchases_json$purchases ) {
    prodlength <- length(purchase$products)
    for ( product in purchase$products ){ 
      name <-  product$name
      price <- product$grossValue
      discount <- 0
      if (length (purchase$discounts) > 0 ) {
        discount <- purchase$discounts[[1]]$percentage
      }
      category <- products[products$X.Name == name,]$X.Category.
      
      total <- cat_totals[cat_totals$Category == category,]$Amount
      
      cat_totals[cat_totals$Category == category,]$Amount <- total + (1 - discount/100) * price
    }
  i <- i+1
  }
 # totals ["Week Start", ] <- weekstart
#  totals ["Week End", ] <- weekend
  return(cat_totals)
}
