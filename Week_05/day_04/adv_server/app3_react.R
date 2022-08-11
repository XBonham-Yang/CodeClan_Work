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
  ),
  

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
  
  filtered_data <- reactive({
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
      geom_bar(aes(x = travel_to_school), fill = "steel blue")
  })
  
  output$spoken_barplot <- renderPlot({
    ggplot(filtered_data()) + 
      geom_bar(aes(x = languages_spoken), fill = "steel blue")
  })
  
}

# run app -----------------------------------------------------------------
shinyApp(ui = ui, server = server)