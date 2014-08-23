library(shiny)
library(plotrix)
library(sfsmisc)

shinyServer(function(input, output) {

        output$plot1 <- renderPlot({
 
                #Run Inputs
                x <- sort(rnorm(input$n, mean = input$meanInp, sd = input$sdInp))
                hd <- hist(x + rexp(x, 1 / input$tau), freq = FALSE, breaks = input$breaks) #, prob = TRUE  , freq = FALSE
                nd <- curve(dnorm(x, mean = input$meanInp, sd = input$sdInp), col = "black", lwd = 2, add = TRUE)
                kd <- density(x + rexp(x, 1 / input$tau), bw = input$bwInp, adjust = input$adjInp)
                
                #Print Results
                hdD <- integrate.xy(hd$breaks[-length(hd$breaks)], hd$density[-length(hd$density)-1])   #integrate.xy(hd$breaks[-length(hd$breaks)], hd$density)
                ndD <- max(pnorm(sort(x), mean = input$meanInp, sd = input$sdInp))
                kdD <- integrate.xy(kd$x,kd$y)                
                hdP <- integrate.xy(hd$breaks[(hd$breaks >= input$area[1]) & (hd$breaks <= input$area[2])], hd$density[(hd$breaks >= input$area[1]) & (hd$breaks <= input$area[2])])
                ndP <- integrate.xy(nd$x[(nd$x >= input$area[1]) & (nd$x <= input$area[2])], nd$y[(nd$x >= input$area[1]) & (nd$x <= input$area[2])] )
                kdP <- integrate.xy(kd$x[(kd$x >= input$area[1]) & (kd$x <= input$area[2])],kd$y[(kd$x >= input$area[1]) & (kd$x <= input$area[2])])
        
                expr <- vector('expression', 6)        
                expr[1] = substitute(expression(italic(K.Hist) == VAL1), list(VAL1 = format(hdD, dig = 3)))[2]
                expr[2] = substitute(expression(italic(N.Dens) == VAL2), list(VAL2 = format(ndD, digits = 3)))[2]
                expr[3] = substitute(expression(italic(Kernel) == VAL3), list(VAL3 = format(kdD, digits = 3)))[2]                
                expr[4] = substitute(expression(italic(P(K.Hist)) == VAL1), list(VAL1 = format(hdP, dig = 3)))[2]
                expr[5] = substitute(expression(italic(P(N.Dens)) == VAL2), list(VAL2 = format(ndP, digits = 3)))[2]
                expr[6] = substitute(expression(italic(P(Kernel)) == VAL3), list(VAL3 = format(kdP, digits = 3)))[2]
                

                #Plot distributions
                #expr use inspired by: http://lukemiller.org
                #Tau integration inspired by: http://pcl.missouri.edu/jeff/node/313
                par(bg = "gray97")
                hist(x + rexp(x, 1/input$tau), freq = FALSE , breaks = input$breaks, main = "", 
                             xlab = "Standardized Inputs", col = "green") #  HIST        
                curve(dnorm(x, mean = input$meanInp, sd = input$sdInp), col = "orange", lwd = 3, add = TRUE) #NORM
                lines(kd, lwd = 3, lty = 2, col= "blue") #KERNEL
                legend('topright', legend = expr, bty = 'n') 
                rug(x + rexp(x, 1 / input$tau), col='black') # add a rugplot of y3
                abline(v = input$area[1], col = "black")
                abline(v = input$area[2], col = "black")
                rect(input$area[1], 0, input$area[2], 20, border = "black", col="#0000ff22")
                #Phantom() use inspired by: http://blog.revolutionanalytics.com/2009/01/multicolor-text-in-r.html
                title(expression("Kernel Histogram" * phantom("~ Normal Density ~ Kernel Density")), col.main = "green3", cex.main = 1.5)
                title(expression(phantom("Kernel Histogram ~ ") * "Normal Density" * phantom(" ~ Kernel Density")), col.main = "orange", cex.main = 1.5)
                title(expression(phantom("Kernel Histogram ~ Normal Density ~ ") * "Kernel Density"), col.main = "blue", cex.main = 1.5)
                title(expression(phantom("Kernel Histogram") *" ~ " * phantom("Normal Density") * " ~ " * phantom("Kernel Density")), col.main = "black", cex.main = 1.5)
                                        
        })
         
        output$summary <- renderPrint({ 
                textPrint <- c("Developing Data Products Project: Dynamic Probabilities ", "Johns Hopkins / Coursera Data Science Certificate Track", "Presented by Zecca Lehn (August 14, 2014)", "Documentation/Repo/Code >> https://github.com/ZeccaLehn/DataProducts_Project/blob/master/README.md ")
                textPrint
                })

}) 
        
       