library(httr2)

get_token <- function(existing_token){
  if (!missing(existing_token) && (existing_token$expires_at > Sys.time()))
  {
    return(existing_token)
  }
  API_KEY=Sys.getenv("API_KEY")
  CLIENT_ID=Sys.getenv("CLIENT_ID")
  CLIENT_ID_PRODS=Sys.getenv("CLIENT_ID_PRODS")
  token_request <- request("https://oauth.zettle.com/token")
  token_request <- token_request |> req_body_form(grant_type="urn:ietf:params:oauth:grant-type:jwt-bearer")
  token_request <- token_request |> req_body_form(client_id=CLIENT_ID)
  token_request <- token_request |> req_body_form(assertion=API_KEY)
  token_body <- req_perform(token_request)
  token_json <- resp_body_json(token_body)
  token_json$expires_at <- token_json$expires_in + Sys.time()
  token_json$client_id <- CLIENT_ID
  token_json$client_id_prods <- CLIENT_ID_PRODS
  return (token_json)
}
#token <- token_json$access_token
