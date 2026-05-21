sprintf ("There are %s purchases", length(prod_j))

products <- data.frame(
  Name = character(),
  Category = character()
)
products <- rbind(products, c("Name", "Category"))
i <- 1

for ( product in prod_j ) {
  #print("hello")
    name <-  product$name
    category <- product$category$name
    if ( is.null(category) )
    {
      category <- "none"
    }
    products <- rbind(products, c(name, category))
    #sprintf ("%s %s", name, category)
    i <- i+1
    #print(i)
    #print(name)
    #print(category)
  }
  
