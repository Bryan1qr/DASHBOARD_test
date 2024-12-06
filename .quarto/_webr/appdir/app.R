library(shiny)
library(leaflet)
library(bslib)

# Definir los puntos de monitoreo
puntos <- data.frame(
  id = paste0("EMCA-", sprintf("%02d", 1:6)),
  lat = c(-18.004275, -17.993250, -17.980364, -18.00676, -18.03961, -18.02685),
  lon = c(-70.257304, -70.243305, -70.239032, -70.23816, -70.25581, -70.2507),  # Longitudes de ejemplo (ajústalas)
  descripcion = c("Hipólito Unanue", 
                  "Instituto Vigil", 
                  "I.E. Manuel Odría",
                  "E.P. UNJBG", "Jorge Chávez", "UNJBG"))

# Interfaz de usuario
ui <- fluidPage(
  
  titlePanel("Mapa de Puntos de Monitoreo"),
  
  # Menú desplegable para seleccionar el punto
  selectInput("punto", "Selecciona un Punto de Monitoreo:",
              choices = puntos$id),
  
  # Mapa interactivo
  leafletOutput("mapa", height = 500)
)

# Servidor
server <- function(input, output, session) {
  
  # Generar el mapa
  output$mapa <- renderLeaflet({
    
    # Filtrar el punto seleccionado
    punto_seleccionado <- puntos[puntos$id == input$punto, ]
    
    # Crear el mapa con el punto seleccionado
    leaflet(data = punto_seleccionado) %>%
      addTiles() %>%
      addMarkers(lng = punto_seleccionado$lon, lat = punto_seleccionado$lat,
                 popup = punto_seleccionado$descripcion)
  })
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)
