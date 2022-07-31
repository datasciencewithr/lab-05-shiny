library(shiny)
library(tidyverse)

# Define UI
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Inputs: Select variables to plot
    sidebarPanel(
      # Select variable for y-axis
      # Add your selectInput statements here.
    ),
    # Output: Show scatterplot
    mainPanel(
      # add your plot here
      )
  )
)

# Define server function
server <- function(input, output) {
  # read in your data and wrangle your dataframe
  
  # Create the scatterplot object the plotOutput function is expecting
  output$theplot <- renderPlot({
  # add your plot here.  Make sure to reference your input variables
  })
}

shinyApp(ui = ui, server = server)