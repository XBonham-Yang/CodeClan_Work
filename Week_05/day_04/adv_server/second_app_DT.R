library(shiny)
library(tidyverse)

students_big <- CodeClanData::students_big
handed_choices <- students %>% 
  distinct(handed) %>% 
  pull()

region_choices <- students %>% 
  distinct(region) %>% 
  pull()

gender_choices <- students %>% 
  distinct(gender) %>% 
  pull()
# ui ----------------------------------------------------------------------
ui <- fluidPage(
  
  fluidRow(
    
    column(4,
           radioButtons(inputId = "handed_input",
                        label = "Handedness",
                        choices = handed_choices,
                        inline = TRUE)),
    
    column(4,
           selectInput(inputId = "region_input",
                       label = "Region",
                       choices = region_choices)),
    
    column(4, 
           selectInput(inputId = "gender_input",
                       label = "Gender",
                       choices = gender_choices))
  ),
    
  fluidRow(
    column(6,
           plotOutput("travel_barplot")),
    
    column(6,
           plotOutput("spoken_barplot"))
  ),
  
    DT::dataTableOutput("table_output")
    

)

# server ------------------------------------------------------------------



server <- function(input, output) {
  
  output$table_output <- DT::renderDataTable({
    students_big %>%
      filter(handed == input$handed_input) %>% 
      filter(gender == input$gender_input) %>% 
      filter(region == input$region_input)
      
  })
  output$travel_barplot <- renderPlot({
    students_big %>% 
      filter( filter(handed == input$handed_input) %>% 
                filter(gender == input$gender_input) %>% 
                filter(region == input$region_input)) %>% 
      ggplot(aes(x = travel_to_school))+
      geom_bar(fill = "steel blue")
             
  })
  
  output$spoken_barplot <- renderPlot({
    students_big %>% 
      filter( filter(handed == input$handed_input) %>% 
                filter(gender == input$gender_input) %>% 
                filter(region == input$region_input)) %>% 
      ggplot(aes(x = languages_spoken))+
             geom_bar(fill = "steel blue")
  })
  
}

shinyApp(ui = ui, server = server)

