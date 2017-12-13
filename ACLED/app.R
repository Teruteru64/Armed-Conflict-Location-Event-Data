
ui <- fluidPage(
  titlePanel("Armed Conflict Location Event"), # App title
  
  sidebarLayout(
    sidebarPanel( # Sidebar panel for inputs
      selectInput(inputId = "EVENT_TYPE", 
                  label = "Event type",
                  choices = unique(DATA$EVENT_TYPE),multiple=TRUE
      )),
    sidebarPanel( # Sidebar panel for inputs
      selectInput(inputId = "country", 
                  label = "Country",
                  choices = unique(DATA$country),multiple=TRUE
      )),
    mainPanel(
      tabsetPanel(
        tabPanel("Armed Conflict Location Event", plotOutput("lineChart"))
        # Output: Line Chart
      )
    )
  ))


server <- function(input, output) {
  
  # make line charts of events
  output$lineChart <- renderPlot({
    g<-ggplot(data=event(),aes(x=year, y=count))
    g<-g+geom_line() + 
      geom_point() +
      scale_x_discrete(limits = year) + 
      scale_y_continuous(labels=percent) +
      ggtitle( paste("Armed Conflicts")) +
      xlab("Year") + ylab("The number of reported cases")
    g
    
  })
  
}

shinyApp(ui = ui, server = server)
