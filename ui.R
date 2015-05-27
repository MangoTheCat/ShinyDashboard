dashboardPage(
  
  # Dashboard header
  dashboardHeader(title = "Mango Solutions"),
  
  #Dashboard sidebar, currently disabbled
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualisation", tabName = "Visualisation", icon = icon("line-chart")),
      menuItem("Data", tabName = "Data", icon = icon("file"))
    )
    ),
  
  #Body
  dashboardBody(
    
    tabItems(
      tabItem("Visualisation", 
    # First Row
    fluidRow(
      
      box(title = "Temperature over the last month", plotOutput("temp", height = 300), 
          width = 6),
      
      box(title = "Daily rainfall over the last month", plotOutput("rain", height = 300), 
          width = 6)
      
    ),
    
    
    # Second Row
    fluidRow(
      
      valueBoxOutput("maxTemp"),
      
      valueBoxOutput("minTemp"), 
      
      valueBoxOutput("averageRainfall")
      
      )
    
      ), # end vis item
    
    # Second menu tab
    tabItem("Data", 
            verbatimTextOutput("data")
      )
  ) # end tab items
  ) # end dash body
)