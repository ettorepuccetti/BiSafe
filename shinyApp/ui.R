ui <- fluidPage(
  leafletOutput("mymap", height=800, width=1450),
  absolutePanel(top = 80, left = 40, draggable = TRUE,
                selectInput("ageRange", label = p("Age range"),
                            choices = c(c("All"), sort(unique(accidentsTibble$age)))),
                sliderInput("date", label = p("Date"),
                            min = min(as.Date(accidentsTibble$date,"%d/%m/%Y")), 
                            max = max(as.Date(accidentsTibble$date,"%d/%m/%Y")), 
                            value = c(min(as.Date(accidentsTibble$date,"%d/%m/%Y")),
                                      max(as.Date(accidentsTibble$date,"%d/%m/%Y"))), step = 1),
                selectInput("gender", label = p("Gender"),
                            choices = c(c("All"), "MUJER", "HOMBRE")),
                selectInput("district", label = p("District"),
                            choices = c(c("All"), unique(accidentsTibble$district))),
                plotOutput("histVictims", height=200)
                ),
  tags$div(id="cite",
           "Origen de los datos: Ayuntamiento de Madrid (o, en su caso, organo administrativo, organismo o entidad de que se trate)")
)