library(shiny)
library(tidyverse)
library(bslib)
olym %>%
  mutate(medal = factor(medal, c("Gold", "Silver", "Bronze")))
all_teams <- unique(olym$team)
season <- unique(olym$season)

#user interface
ui <- fluidPage(
  
  titlePanel(tags$h1("Olympic Medals")),
  
  tabsetPanel(
    tabPanel('plot', plotOutput('medal_plot')),
    tabPanel("Season", radioButtons(inputId = 'season_input',
                                    label = tags$i('Summer or Winter Olympics?'),
                                    choices = season
    )),
    tabPanel("Which teams?", selectInput(inputId = 'team_input',
                                         label = 'Which team?',
                                         choices = all_teams
    ))
  ),
  
  
  tags$a('The Olympics website', href = 'https://www.Olympic.org')
  
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


shinyApp(ui = ui, server = server)



