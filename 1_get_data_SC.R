## bibliotecas
library(httr)
library(jsonlite)
library(dplyr)

## api para pegar os dados mais atualizados de Covid-19
read_CityDataCovid <- function() {
  # lê a URL da api   
  url <- "https://brasil.io/api/dataset/covid19/caso/data?format=json"
  tf <- GET(url)
  
  content <- content(tf, as = 'text')
  content_from_json <- fromJSON(content)
  out <- content_from_json$results
  # verifica se têm mais páginas de dados e pega todas.
  while(!is.null(content_from_json$`next`)){
    url <- content_from_json$`next`
    tf <- GET(url)
    content <- content(tf, as = 'text')
    content_from_json <- fromJSON(content)
    results_df_np <- content_from_json$results
    out <- bind_rows(out, results_df_np)
  }
  return(out)
}

data_covid19 <- read_CityDataCovid()

# Você pode especificar o estado ou a cidade que quer analisar. 
# Os dados estão disponíveis tanto a nível de cidade, quanto de estado, que pode ser definido no argumento place_type
# Na base existe o registro diário do número de casos. Caso queira apenas o mais recente basta filtrar a coluna is_last == TRUE
# Para o exemplo, usaremos os dados mais recentes a nível de cidades, do estado de Santa Catarina.
data_covid19 <- data_covid19 %>% filter(state == "SC", 
                                        place_type == "city", 
                                        !is.na(city_ibge_code), 
                                        confirmed > 0, 
