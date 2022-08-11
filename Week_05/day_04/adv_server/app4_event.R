library(shiny)
library(tidyverse)

students_big <- CodeClanData::students_big

# ui ----------------------------------------------------------------------

ui <- fluidPage(
  
  fluidRow(
    
    column(3,
           radioButtons('handed_input',
                        'Handedness',
                        choices = unique(students_big$handed),
                        inline = TRUE)
    ), 
    
    column(3,
           selectInput("region_input", 
                       "Which Region?", 
                       choices = unique(students_big$region))
    ), 
    
    column(3,
           selectInput("gender_input", 
                       "Which Gender?",
                       choices = unique(students_big$gender))
    ),
    
    column(2,
           radioButtons('colour_input',
                        "Pick a colour",
                        choices = c('red', 'blue', 'orange')))
  ),
  
 #action button add in 
  actionButton("update", "Update dashboard"),
  
  fluidRow(
    column(6,
           plotOutput("travel_barplot")
    ),
    column(6,
           plotOutput("spoken_barplot")
    )
  ),
  DT::dataTableOutput("table_output")
)

# server ------------------------------------------------------------------

server <- function(input, output) {
  
  # CHANGE THIS TO EVENT REACTIVE
  filtered_data <- eventReactive(input$update, {
    students_big %>%
      filter(handed == input$handed_input) %>%
      filter(region == input$region_input) %>%
      filter(gender == input$gender_input)
  }) 
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  output$travel_barplot <- renderPlot({
    ggplot(filtered_data()) + 
      geom_bar(aes(x = travel_to_school), fill = input$colour_input)
  })
  
  output$spoken_barplot <- renderPlot({
    ggplot(filtered_data()) + 
      geom_bar(aes(x = languages_spoken), fill = input$colour_input)
  })
  
}

shinyApp(ui = ui, server = server)