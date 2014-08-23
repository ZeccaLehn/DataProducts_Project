library(shiny)

shinyUI(fluidPage(
        
        #Title
        titlePanel("Dynamic Probabilities"),
        
        #Sidebar
        sidebarLayout(
                
                sidebarPanel(
                        
                        sliderInput(inputId = "meanInp", "Mean:", min = -1, max = 1, value = 0, step = .05),
                        
                        sliderInput(inputId = "sdInp", "SD:", min = 0.01, max = 1, value = 1, step = .05),
                        
                        sliderInput(inputId = "n", "N:", min = 10, max = 5000, value = 500, step = 10),

                        sliderInput(inputId = "bwInp", "Smoothing Bandwidth (BW):", min = .05, max = 3, value = .5, step = .05),
                        
                        sliderInput(inputId = "adjInp", "BW Adjust:", min = .05, max = 3, value = .5, step = .05),
                        
                        sliderInput(inputId = "tau", "Tau:", min = 0, max = 2, value = 0, step = .05),
                        
                        sliderInput(inputId = "breaks", "Breaks:", min = 2, max = 200, value = 15, step = 1),
                        
                        sliderInput(inputId = "area", "Probability:", min = -15, max = 15, value = c(-1,1), step = .05)
                        
                ),

                mainPanel(
                        plotOutput("plot1"), # verbatimTextOutput("summary")
                        verbatimTextOutput("summary")
                        
        )
                
)


               

))


