ui <- fluidPage(
  leafletOutput("mymap", height = 850, width = 1550),
  absolutePanel(top = 80, left = 40, draggable = TRUE,
                selectInput("ageRange", label = p("Age range"),
                            choices = c(c("All"), sort(unique(accidentsTibble$age)))),
                sliderInput("date", label = p("Date"),
                            min = as.Date(min(accidentsTibble$date),"%d/%m/%Y"), 
                            max = as.Date(max(accidentsTibble$date),"%d/%m/%Y"), 
                            value = c(as.Date(min(accidentsTibble$date),"%d/%m/%Y"),
                                      as.Date(max(accidentsTibble$date),"%d/%m/%Y")), step = 1),
                selectInput("gender", label = p("Gender"),
                            choices = c(c("All"), "MUJER", "HOMBRE")))
)