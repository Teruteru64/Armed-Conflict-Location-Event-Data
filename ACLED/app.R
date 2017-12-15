
ui <- fluidPage(
  titlePanel("Armed Conflict Location Event"), # App title
  sidebarLayout(
    sidebarPanel( # Sidebar panel for inputs
      selectInput(inputId = "EVENT_TYPE", 
                  label = "Event type",
                  choices = unique(ACLED$EVENT_TYPE)
      ),
      selectInput(inputId = "country", 
                  label = "Country",
                  choices = unique(ACLED$country)
      )),
    mainPanel(
      tabsetPanel(
        tabPanel("Armed Conflict Location Event", plotOutput("lineChart"))
        # Output: Line Chart
      )
    )
  ))


server <- function(input, output) {

  ACLED$count <- as.numeric(ACLED$count)
  
  ACLED.new <- reactive({
    filter(ACLED, EVENT_TYPE==input$EVENT_TYPE, country==input$country)
  })
  
  # make line charts of events
  output$lineChart <- renderPlot({
  g<-ggplot(data=ACLED.new(), aes(x=year, y=count, group=country))
  g<-g+geom_line(color="steelblue") + 
    geom_point() +
    xlab("Year") + ylab("The number of reported cases")
  g
  
})

}


shinyApp(ui = ui, server = server)
