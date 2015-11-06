# library(shiny)
# library(BH)
# library(stringr)
# library(lattice)
# library(latticeExtra)
# library(psych) # enfernen?
library(markdown)
# library(foreign)
library(car)



  shinyUI(fluidPage(
    
  # Application title
  titlePanel("Transformations of variables/data"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      h5(textOutput("hits")),
      selectInput("transformation", label = "Transformation:",
                  choices = c("none", "center", "divided by 10", "mininum to 0", "reverse", "standardize"), selected = 1),
      selectInput("original.scale", label = "Keep original X-scale:",
                  choices = c("no", "yes (-50 to 170)"), selected = 1)   

  ),

 mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot")),
        tabPanel("Data", h4("Summary statistics of weight"), verbatimTextOutput("summary"), h4("Original data"), verbatimTextOutput("originaldata"), h4("Transformed data"), verbatimTextOutput("transformeddata")),
               tabPanel("Instructions", includeMarkdown("instruction.md")),
        tabPanel("About", includeMarkdown("about.md"))
      
      )
    )
  )
))


   










      



