shinyServer(
        function(input, output, session) {
        observe({
                val <- input$x
                # Control the value, min, max, and step.
                # Step size is 2 when input value is even; 1 when value is odd.
                updateSliderInput(session, "z",# value = val+4,
                                  min = floor(val), max = P-val)
        })
        
        datax1 <- eventReactive(input$z>input$x,{
                                   xypoints(x = input$x,z = input$z,p=P)})
        
        datax2 <- reactive({
                subset(result, x==input$x)
        })
        
        output$caption<-renderText({paste("Area = ", round(datax1()$A,3))
        })
        output$caption2<-renderText({paste("Area = ", round(datax1()$A,3))
        })
        output$caption3<-renderText({paste("Area = ", round(datax1()$A,3))
        })
        output$val.y<-renderText({paste("y:", datax1()$y)})
        output$val.alpha<-renderText({paste("alpha: ", round(datax1()$alpha,1),"°",sep = "")})
        
        
        output$plot <- renderPlot({
                if(input$tabs=="A"){
                p <- ggplot(data = datax1()$df,aes(x,y,label=paste("(",x,", ",round(y,1),")",sep = "")))+xlim(-5,100)+ylim(0,100)+
                       
                        geom_line(color="lightblue")+geom_area(fill="dodgerblue3",alpha=0.5)+theme_bw(base_size = 16)+
                        geom_point(shape=19,  color="lightslategrey", size=4)+
                        geom_point(shape=19,  color="white", size=2)+
                        
                        geom_vline(xintercept = input$x,  colour="steelblue", linetype = "longdash")+
                        geom_hline(yintercept = datax1()$y,  colour="steelblue", linetype = "longdash")+
                        geom_text(hjust=0.5,vjust=-1)+coord_fixed(ratio=1)
                print(p)}else{NULL}
                
        })
        
#         output$plotlines <- renderPlot({
#                 if(input$tabs=="B"){
#                 g<-ggplot(data=result, aes(x=z, y=Area,color=factor(x)))+
#                         geom_line()+theme_bw(base_size = 16)+
#                         geom_line(data=datax2(),size=2)+
#                         geom_vline(xintercept = input$z,  colour="steelblue", linetype = "longdash")
#                         print(g)}else{NULL}        
#         })
        
        output$plotlines2 <- renderPlot({if(input$tabs=="C"){
                g<-ggplot(data=result, aes(x=alpha, y=Area,color=factor(x)))+
                        geom_line()+theme_bw(base_size = 16)+
                        geom_line(data=datax2(),size=2)+
                        geom_vline(xintercept = datax1()$alpha,  colour="steelblue", linetype = "longdash")+
                        geom_vline(xintercept = 30,  colour="orange", linetype = "12345678")
                
                print(g)}else{NULL}        
        })
        
        output$subplot <- renderPlot({if(input$tabs=="A"){
                g<-ggplot(data=melt(datax2()[-1],id='z'),aes(z,value))+geom_line()+
                        facet_grid(variable~.,scales = "free")+theme_bw(base_size = 16)+
                        geom_vline(xintercept = input$z,  colour="steelblue", linetype = "longdash")
                
                print(g) }else{NULL}       
        })
})