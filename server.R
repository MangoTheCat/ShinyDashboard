shinyServer(function(input, output, session) { 
  
  startTime <- as.numeric(Sys.time())
  
  weatherData <- reactive({
    
    invalidateLater(5000, session)
    
    N <- (as.numeric(Sys.time()) - startTime)/5 + 30
    
    N <- ifelse(N >= 1000, 1000, N)
    
    read.csv("Data/weatherdata.csv") %>%
      slice(1:N) %>%
      mutate(Dates = as.POSIXct(Dates)) %>%
      slice((n()-30):n())
    
    })
  
  
  output$temp <- renderPlot({

    weatherData<- weatherData()
    
    qplot(Dates, Temperature, data = weatherData, geom = "line") 
    
    })
  
  
  output$rain <- renderPlot({
    
    weatherData<- weatherData()
    
    ggplot(data = weatherData(), aes(Dates, Rainfall)) + 
      geom_bar(stat = "identity")
    
    })
  
  output$maxTemp <- renderValueBox({
    
    weatherData <- weatherData()
    
    maxTemp <- max(weatherData$Temperature, na.rm = TRUE)
    
    valueBox(maxTemp, subtitle = "Maximum Temperature (celsius)", icon = icon("arrow-up"),
             color = "light-blue")
    
    })
  
  output$minTemp <- renderValueBox({
    
    weatherData <- weatherData()
    
    minTemp <- min(weatherData$Temperature, na.rm = TRUE)
    
    valueBox(minTemp, subtitle = "Minimum Temperature (celsius)", icon = icon("arrow-down"),
             color = "light-blue")
    
  })

  output$averageRainfall <- renderValueBox({
    
    weatherData <- weatherData()
    
    meanRain <- round(mean(weatherData$Rainfall, na.rm = TRUE),1)
    
    valueBox(meanRain, subtitle = "Average Monthly rainfall (mm)", icon = icon("cloud"),
             color = "orange")
  })

  output$data <- renderPrint(weatherData())
  
}
)


