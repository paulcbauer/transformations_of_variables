

# Counter
# A server parameters
SP <- list()
# Record the number of poeple who have used the app
#    since initiation on the server
SP$npers <- 0

originaldata <- Davis$weight

shinyServer(  function(input, output){
  
  # Counter
  # shinyServer is Started up every time the domain is called.
  # Use <<- to assign to the global server environment.
  SP$npers <<- SP$npers + 1
  output$hits <- renderText({
    paste0("Pageviews: " , SP$npers)
  })
  

  type=T
  name <- "weight"
  Davis2 <- Davis
  
  
 
output$plot <- renderPlot({
  if(input$transformation=="center"){
    Davis$weight <- Davis$weight-mean(Davis$weight)
    name <- "weight - mean(weight)"
  }
  if(input$transformation=="divided by 10"){
    Davis$weight <- Davis$weight/10
    name <- "weight/10"
  }
  if(input$transformation=="mininum to 0"){
    Davis$weight <- Davis$weight-min(Davis$weight)
    name <- "weight - min(weight)"
  }
  if(input$transformation=="reverse"){
    Davis$weight <- abs(Davis$weight-max(Davis$weight))
    name <- "|weight - max(weight)|"
  }
  if(input$transformation=="standardize"){
    Davis$weight <- (Davis$weight-mean(Davis$weight))/sd(Davis$weight)
    name <- "[weight - mean(weight)]/sd(weight)"
  }     
  
  if(input$original.scale=="no"){
    par(mar=c(5,5,2,1))
    hist(Davis$weight, xaxt="n", breaks=14, cex.axis=2, cex.lab=2, cex.main=2, freq=type, xlab=name, main="Histogram (+ transformation)", col="#FF5C5C22", ylim = c(0,70))
    hist(originaldata, xaxt="n", breaks=14, cex.axis=2, cex.lab=2, cex.main=2, freq=type, xlab="", main="", col = "#003DF540", add=TRUE, ylim = c(0,70))
    if(input$transformation!="divided by 10"){axis(1, at=seq(-170, 170,10), labels=seq(-170, 170,10), cex.axis=2)}
    if(input$transformation=="divided by 10"){
      axis(1, at=seq(-17, 17,1), labels=seq(-17, 17,1), cex.axis=2)
    }    
  }
  
  if(input$original.scale=="yes (-50 to 170)"){
    par(mar=c(5,5,2,1))
    hist(Davis$weight, xaxt="n", breaks=14, cex.axis=2, cex.lab=2, cex.main=2, freq=type, xlab=name, main="Histogram (+ transformation)", xlim=c(-50, 170), col="#FF5C5C22", ylim = c(0,70))
    hist(originaldata, xaxt="n", breaks=14, cex.axis=2, cex.lab=2, cex.main=2, freq=type, xlab="", main="", col = "#003DF540", add=TRUE, ylim = c(0,70))
    axis(1, at=seq(-170, 170,10), labels=seq(-170, 170,10), cex.axis=2)
  }      
  
}, height=400)






output$transformeddata <- renderPrint({  


  
  if(input$transformation=="center"){
    Davis$weight <- Davis$weight-mean(Davis$weight)
    name <- "weight - mean(weight)"
  }
  if(input$transformation=="divided by 10"){
    Davis$weight <- Davis$weight/10
    name <- "weight/10"
  }
  if(input$transformation=="mininum to 0"){
    Davis$weight <- Davis$weight-min(Davis$weight)
    name <- "weight - min(weight)"
  }
  if(input$transformation=="reverse"){
    Davis$weight <- abs(Davis$weight-max(Davis$weight))
    name <- "|weight - max(weight)|"
  }
  if(input$transformation=="standardize"){
    Davis$weight <- (Davis$weight-mean(Davis$weight))/sd(Davis$weight)
    name <- "[weight - mean(weight)]/sd(weight)"
  }
  
  
  Davis[c(1:10),c(1,2)]
})


output$summary <- renderPrint({  
  
  
  # SUMMARY STATISTICS
  summary(Davis2[,2])
  
})


output$originaldata <- renderPrint({  
  
  
  # SUMMARY STATISTICS
  Davis2[c(1:10),c(1,2)]
})



})
