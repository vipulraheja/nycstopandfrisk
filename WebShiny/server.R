######################################
### Frisk and Stop Data - server.R ###
######################################
library(shiny) # load shiny at beginning at both scripts
library(ggplot2) #load ggplot2

#Time analysis preprocessing
load(file="timeSeriesAnalysis.RData")
load(file="clustering.RData")
load(file="logitAnalysisSample.RData")
result$date <- as.character(paste(result$YEAR, result$MONTH, "1", sep = "-"))
result$date <- as.Date(result$date, "%Y-%m-%d")
result$severity <- as.factor(result$severity)
years <- 2006:2012

shinyServer(function(input, output) { 
  
  #Render Clusters
  output$cluster.k <- renderTable({
    theClusters <- switch(input$num.clusters, "df.cluster.2" = df.cluster.2, "df.cluster.3" = df.cluster.3,
                     "df.cluster.4" = df.cluster.4, "df.cluster.5" = df.cluster.5,
                     "df.cluster.6" = df.cluster.6, "df.cluster.7" = df.cluster.7)
  })
  
  #Time Series Graph
  output$time.series.graph <- renderPlot({
    
    precinct <- as.numeric(input$precinct)
    plot.data <- result[result$PCT==precinct,]
    
    #filter bad data
    plot.data <- plot.data[plot.data$YEAR %in% years,]
    
    theGraph <- ggplot(plot.data, aes(date, count, color=severity)) + geom_line() + 
      xlab("Year") + ylab("Count of Crime") + 
      ggtitle(paste0("Number of Stops Made in Precinct ", precinct)) +
      theme (panel.background = element_blank(),
             legend.background = element_blank(),
             plot.background = element_blank()) +
      labs(color="Crime Severity")
    
    try(
    if (input$finance) {
      theGraph <- theGraph + geom_vline(xintercept=as.numeric(as.Date("2008-09-01", "%Y-%m-%d")), 
                                        linetype="dotted", size=1.25)
    }, silent=TRUE)
    
    try(
    if (input$sandy) {
      theGraph <- theGraph + geom_vline(xintercept=as.numeric(as.Date("2012-10-01", "%Y-%m-%d")), 
                                        linetype="dotted", size=1.25)
    }, silent=TRUE)
    
    print(theGraph)
  }, bg="transparent")
  
  
  #Render regression model
  output$regressionDisplay1 <- renderText({ 
    
    newInput <- data.frame(RACE = input$race, SEX = as.character(input$gender), AGE = as.numeric(input$age.model), 
                           WEAPON = input$weapon, PCT = input$precinct.model,
                           HOUR = as.numeric(input$hour.model))
    
    newInput$FRISKED <- predict(FRlogit, newdata = newInput, type = "response")
    
    sprintf("Probability of getting frisked is %s", 
            format(round(newInput$FRISKED,3), nsmall=3))
  })
  
  output$regressionDisplay2 <- renderText({ 
    
    newInput <- data.frame(RACE = input$race, SEX = as.character(input$gender), AGE = as.numeric(input$age.model), 
                           WEAPON = input$weapon, PCT = input$precinct.model,
                           HOUR = as.numeric(input$hour.model))
    print(newInput)
    newInput$SEARCHED <- predict(SRlogit, newdata = newInput, type = "response")
    
    sprintf("Probability of getting searched is %s", 
            format(round(newInput$SEARCHED, 3), nsmall=3))
  })
  
})



