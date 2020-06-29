## bibliotecas
library(leaflet)

map_cities <- leaflet(data_covid19) %>% 
  addTiles() %>%
  addMarkers(popup = paste0("<b>Cidade: </b>", data_covid19$city,"<br>",
                   "<b>Casos Confirmados: </b>", data_covid19$confirmed),
             label = ~city
             group = "addMarkers") %>% 
  addCircleMarkers(popup = paste0("<b>Cidade: </b>", data_covid19$city,"<br>",
                   "<b>Casos Confirmados: </b>", data_covid19$confirmed),
             label = ~city
             group = "addCircleMarkers") %>%
  addLayersControl(baseGroups = c("addMarkers","addCircleMarkers"), 
                   options = layersControlOptions(collapsed = F))