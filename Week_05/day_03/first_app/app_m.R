library(shiny)
library(tidyverse)
library(bslib)
olym <- read_csv("data/olympics_overall_medals.csv")%>%
mutate(medal = factor(medal, c("Gold", "Silver", "Bronze")))
all_teams <- unique(olym$team)
season <- unique(olym$season)

#user interface
ui <- fluidPage(
  theme = bs_theme(bootswatch = 'darkly'),
  
  titlePanel(h1("Medals")),

  sidebarLayout(
    sidebarPanel = sidebarPanel(
      p("Sidebar"),
      p('Some other text in the side bar'),
      radioButtons(inputId = "season_input",
                   label = tags$em('Summer or winter?'),
                   choices = season),
      
      selectInput(inputId = "team_input",
                  label = "which team?",
                  choices = all_teams)
    ),
  
    mainPanel = mainPanel(
      "Main panel",
      br(),
      br(),
      'some other text in the main part',
      plotOutput('medal_plot'),
      
      #html, hypertext markup language 
      tags$a("The olympics website", href = "https://www.olympic.org")
    )
  )
)

server <- function(input, output) {
  output$medal_plot <- renderPlot({
    olym %>%
      filter(team == input$team_input,
             season == input$season_input) %>%
      ggplot(aes(x = medal, y = count, fill = medal)) +
      geom_col()
  })
  
}


#run the application key code 
shinyApp(ui = ui, server = server)














