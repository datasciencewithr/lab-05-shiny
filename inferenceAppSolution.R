library(shiny)
library(tidyverse)

# Define UI
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Inputs: Select variables to plot
    sidebarPanel(
      # Select variable for y-axis
      selectInput(inputId = "GPU", label = "GPU selection",
                  choices = c("GPU","CPU"),
                  selected = "CPU"),
      # Select variable for x-axis
      selectInput(inputId = "network", label = "network type",
                  choices = c("none","wired","wireless"),
                  selected = "none", multiple = TRUE)
    ),
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "theplot")
    )
  )
)

# Define server function
server <- function(input, output) {
  inference <- read_csv(file = "data/neuralnetworkspeed.csv", skip_empty_rows = TRUE) %>%
    filter(!is.na(model)) %>%
    clean_names()
  
  # Create the scatterplot object the plotOutput function is expecting
  output$theplot <- renderPlot({
    inference %>%
      filter(gpu %in% input$GPU,
             network %in% input$network) %>%
      ggplot(aes(x = model, y = fps, fill = network)) +
      geom_col(position="dodge") +
      labs(title = input$GPU) +
      ylim(0,45)
  })
}

shinyApp(ui = ui, server = server)