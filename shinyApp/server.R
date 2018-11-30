map = leaflet(accidentsTibble) %>% addProviderTiles(providers$Stamen.TonerLite, 
                                     options = providerTileOptions(noWrap = TRUE, minZoom=3))
map = setView(map, -3.70256, 40.4165, zoom = 12)

shinyServer(function(input, output, session) {
  mapData = reactive({
    mapData = subset(accidentsTibble, as.Date(accidentsTibble$date,"%d/%m/%Y") >= input$date[1] & as.Date(accidentsTibble$date,"%d/%m/%Y") <= input$date[2])
    if (input$gender != "All"){
      mapData = subset(mapData, mapData$gender %in% input$gender)
    } 
    if (input$ageRange != "All"){
      mapData = subset(mapData, mapData$age %in% input$ageRange)
    }
    mapData
  })
  output$mymap <- renderLeaflet({
    mapData = mapData()
    content = paste(sep = "", mapData$date, "<br/>", "Age: ", mapData$age, "<br/>", "Gender: ", mapData$gender)
    map = map %>% addMarkers(~mapData$longitude, ~mapData$latitude, 
                             clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                             popup = ~content)
    })
  accidentsInBounds <- reactive({
    if (is.null(input$mymap_bounds))
        return(accidentsTibble[FALSE,])
    bounds <- input$mymap_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    accidentsInBounds = subset(accidentsTibble, 
           latitude >= latRng[1] & latitude <= latRng[2] &
             longitude >= lngRng[1] & longitude <= lngRng[2])
  })
  output$histVictims <- renderPlot({
    accidentsInBounds = accidentsInBounds()
    hist(as.matrix(accidentsInBounds$victims), main = "Accidents in current area",
                   xlab = "No. of victims involved")
  })
})