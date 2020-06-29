
# Primeiro precisamos dos dados de latitude e longitude das cidades analisadas. 
urlfile <- "https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/master/csv/municipios.csv"
cities_lat_lng <- read.csv(urlfile,encoding = "UTF-8", col.names = c("COD_IBGE", "Cidade","lat","lng","Capital","Codigo_UF"))
# é necessário se certificar que o código de cada cidade estará em formato de texto, para o que a função left_join funcione. 
cities_lat_lng$COD_IBGE <- as.character(cities_lat_lng$COD_IBGE)
data_covid19 <- left_join(data_covid19, cities_lat_lng, by = c("city_ibge_code" = "COD_IBGE"))