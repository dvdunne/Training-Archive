library(shiny)
library(shinyjs)
require(markdown)

shinyUI(
  navbarPage(
    "Datascience Capstone",
    theme = "bootstrap3.min.1.css",
    tabPanel(p(icon("ellipsis-h")," Predict"),
             sidebarLayout(
               sidebarPanel(
                 h3("Predict a Word"),
                 tags$hr(),
                 textInput("text.input", "Enter at least 3 words", "Please wait data loading (~ 10 secs) ..."),
                 # actionButton("button", "Predict"),
                 radioButtons("num.of.words", "Number of predicted words", c("One", "Three"), selected = "One"),
                 tags$hr(),
                 p("See 'Help' for more information on using this App.")
                 
               ),
               mainPanel(
                 shinyjs::useShinyjs(),
                 # shinyjs::inlineCSS(list(.error = "color: DarkRed;font-style: italic;")),
                 # shinyjs::inlineCSS(list(.bold = "font-weight: bold")),
                 h3("Prediction", align = "left"),
                 tags$hr(),
                 div(id = "predictText",
                  textOutput("predictionText"))
                )
             )),
    
      tabPanel(p(icon("question-circle")," Help"),
               mainPanel(includeMarkdown("help.md")))
    )
)
