library(shiny)
library(dplyr)
library(stringr)
library(data.table)
library(shinyjs)

# Initialize
source("predict1.R")

# Shiny Server
shinyServer(function(input, output, session) {

  # Replace input default text after all files are loaded.
  # They are loaded via the predict1.R source file.
  observe({
    updateTextInput(session, "text.input", value = "")  
  })
  
 
  
  
  
  # Predict the text
  output$predictionText <- renderText({
    pred.words <- ifelse(input$num.of.words == "One", 1, 3)
    num.words<-length(strsplit(input$text.input, " ")[[1]])
    if(num.words > 2){   
      removeClass("predictionText", "error")
      addClass("predictionText", "bold")
      predicted.word <- pred(input$text.input, pred.words)
    } else {
      removeClass("predictionText", "bold")
      addClass("predictionText", "error")
      "Please enter three or more words to start prediction..."
      }
  }) 
  

  
})