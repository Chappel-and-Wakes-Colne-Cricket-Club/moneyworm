library(httr2)
source("cat_purchases.R")
#source("get_token.R")

get_purchases <- function(token_json){
  savepath <- Sys.getenv("SAVE_PATH")
  savefile <- paste(savepath, "weeklytotals.csv", sep="")
  totals <- read.csv(savefile, colClasses=c("character", "character" , "character", "double"))
  totals$WeekStart <- as.Date(totals$WeekStart)
  totals$WeekEnd <- as.Date(totals$WeekEnd)

  authstring <- sprintf("Bearer %s", token_json$access_token)
#start_date <- as.Date("2025-03-25")
  start_date <- max(as.Date(totals$WeekEnd))
  end_date <- as.Date(start_date + 7)
  if ( end_date < Sys.Date()){
    purchase_req <- request(
      url_modify("https://purchase.izettle.com/", path = "/purchases/v2", 
                 query = list(startDate = start_date, endDate = end_date)))
    purchase_req <- purchase_req |> req_headers("Authorization" = authstring)

    purch_resp <- req_perform(purchase_req)
    purch_j <- resp_body_json(purch_resp)
    new_totals <- category_totals(purch_j, start_date, end_date)
    new_totals$Amount <- new_totals$Amount / 100
    totals <- rbind(totals, new_totals[,])
  }

  start_date <- start_date + 7 
  end_date <- end_date + 7

  while (end_date < Sys.Date())
  #while (end_date < as.Date("2025-04-17"))
  {
    purchase_req <- request(
      url_modify("https://purchase.izettle.com/", path = "/purchases/v2", 
                 query = list(startDate = start_date, endDate = end_date)))

    purchase_req <- purchase_req |> req_headers("Authorization" = authstring)
    purch_resp <- req_perform(purchase_req)
    purch_j <- resp_body_json(purch_resp)
    new_totals <- category_totals(purch_j, start_date, end_date)
    new_totals$Amount <- new_totals$Amount / 100
    totals <- rbind(totals, new_totals[,])
    start_date <- start_date + 7 
    end_date <- end_date + 7
  }


  write.csv(totals, savefile, row.names = FALSE)
  return(totals)
}
