# Q: "Is there a way to change the name(s) being illustrated, 
#      either in the code or through a more interactive plot?"
# A: Yes!
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(fivethirtyeight)

ncaa_w_bball_tourney

#colleges_of_interest <- ncaa_w_bball_tourney %>%
   #filter(year == "2000") %>%
   #select(school)

#colleges_of_interest

#my_data <- reactive({
#data <- ncaa_w_bball_tourney %>%
#group_by(reg_w) %>%
#data

#})

ui <- fluidPage(
   titlePanel("NCAA WBB REGULAR SEASON SUCCESS"),
   sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "sch", 
                    label = "school",
                    choices = ncaa_w_bball_tourney$school 
                   ),
        radioButtons(inputId = "class", 
                    label = "Metric",
                    choices = c("reg_w"), 
                    selected = "reg_w")
      ),
      
      mainPanel(
         plotOutput("histPlot"))
   )
)


server <- function(input, output) {

   
   output$histPlot <- renderPlot({
   print(input$sch)
   my_data <- ncaa_w_bball_tourney %>%
      filter(school == input$sch)
      
   ggplot(data = my_data, aes(x = reg_w)) +
    geom_histogram() +
      geom_histogram(color = "black", fill = "purple", binwidth = 1) +
      labs(x = "Number of Wins per Season", y = "Number of Seasons", title = paste("Women's Basketball at", input$sch))
     
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

