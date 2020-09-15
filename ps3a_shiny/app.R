library(shiny)

ui <- fluidPage(
  title = "Random generator",
  sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 25, min = 1, max = 100),
  actionButton(inputId = "go", 
               label = "Print Value"),
  textInput(inputId = "title", 
            label = "Type a Title",
            value = "Insert Your Title Here"),
  navlistPanel(              
    tabPanel(title = "Normal data",
             plotOutput("hist"),
             verbatimTextOutput("stats")
    ),
    tabPanel(title = "Uniform data",
            plotOutput("hist"),
            verbatimTextOutput("stats")
    ),
    tabPanel(title = "Chi Squared data",
            plotOutput("hist"),
            verbatimTextOutput("stats")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$go, {
    print(as.numeric(input$num))
  })
  output$hist <- renderPlot({
    hist(rnorm(input$num), main = input$title)
  })
  output$stats <- renderPrint({
    summary(rnorm(input$num))
  })
  
}


shinyApp(ui = ui, server = server)
