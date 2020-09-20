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

# data
install.packages('fivethirtyeightdata', repos
                 = 'https://fivethirtyeightdata.github.io/drat/', type = 'source')
ncaa_w_bball_tourney
babynames

#ncaa_w_bball_tourney_data <- ncaa_w_bball_tourney::ncaa_w_bball_tourney

# create choices vector for name choices
# too many names! app will be sloooooow
#name_choices <- babynames_dat %>% 
#  count(name) %>%
#  select(name)

name_choices <- str_to_title(c("Boston College", "Amherst", "Indiana", "Michigan", 
                               "USC", "Georgetown", "Columbia", "Harvard","UT Austin",
                               "Trinity", "Florida", "Notre Dame", "UPenn", "Yale", "Cornell",
                               "Duke", "Vanderbilt", "Northwestern", "UC Berkeley", "Wellesey",
                               "MIT", "Stanford", "UChicago", "NYU"))

name_choices

ui <- fluidPage(
   
   titlePanel("WALL STREET FEEDER SCHOOLS AND THEIR NCAA WBB SUCCESS"),

   sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "school", 
                    label = "School:",
                    choices = name_choices, 
                    selected = "Amherst"),
        radioButtons(inputId = "classify", 
                    label = "Metric",
                    choices = c("seed", "regular season wins"), 
                    selected = "seed")
      ),
      
      mainPanel(
         plotOutput("distPlot")),
      sidebarPanel(
         plotOutput("histPlot")),
      sidebarPanel(
         plotOutput("boxPlot"))
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     
     dat <- ncaa_w_bball_tourney %>%
       filter(School %in% input$school & Metric == input$classify) %>%
       group_by(seed, reg_w) %>%
       summarize(total = sum(n))
     
     ggplot(data = dat, aes(x = year, y = total)) +
       geom_line(color = "#0095b6") + 
       labs(x = "Year", y = "Total number of births with this name"
            , title = paste("Babies Named", paste(input$nm)))
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

