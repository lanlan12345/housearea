# ui.r
horizontalSplitLayout <- function(left, right, lwidth='370px') {
        bootstrapPage(
                tags$head(tags$style(type="text/css", "html, body {width: 100%; height: 100%; overflow: hidden}")),
                tags$div(style="position: absolute; top: 0; left: 0; right: 0; bottom: 0",
                         tags$div(style=paste("position: absolute; top: 0; left: 0; width:", lwidth, "; bottom: 0; overflow: auto"), left),
                         tags$div(style=paste("position: absolute; top: 0; left:", lwidth, "; right: 0; bottom: 0; overflow: auto"), right)
                )
        )
}

sidebarSplitLayout <- function(controls, main) {
        horizontalSplitLayout(
                left = tags$div(class="well", style="margin: 30px",
                                controls
                ),
                right = main,
                lwidth = '370px'
        )
}

shinyUI(
        ui = fluidPage(titlePanel("How to get the maximum area for a shape of house with constant perimeter?"),
                       tags$style(type="text/css",
                                  ".shiny-output-error { visibility: hidden; }",
                                  ".shiny-output-error:before { visibility: hidden; }"
                       ),
                sidebarLayout(
                        sidebarPanel(
                                fluidRow(
                                        column(4,
                                               h3("Conditions"),
                                               p("P=2p=200"), 
                                               p("x+y+z=p"),
                                               p("0<x<p/2"),
                                               p("x<z<p-x")),
                                        column(8,
                                               br(),
                                               br(),
                                               br(),
                                               img(src="house.png", height = 120,inline=T))
                                ),
                                hr(),
                                sliderInput("x", h4("x:"), min=0, max=P/2, value=27,
                                            step=1),
                                sliderInput("z", h4("z:"), min=1, max=P, value=51,
                                            step=1),
                                h4(textOutput("val.y")),
                                br(),
                                #br(),
                                h4(textOutput("val.alpha"))
                        ),
                        mainPanel(
                                tabsetPanel( id="tabs",
                                        tabPanel("Manipulation",value = "A",
                                                h3(textOutput("caption")),
                                                br(),
                                                plotOutput(outputId = "plot")
#                                                 fluidRow(
#                                                         column(8,
#                                                                plotOutput(outputId = "plot")),# height = "400px"
#                                                         
#                                                         column(4,plotOutput(outputId = "subplot"))#, height = "400px"
#                                                         
#                                                 )
                                               ),
#                                         tabPanel("Area vs. z", value="B",
#                                                  h3(textOutput("caption2")),
#                                                 plotOutput(outputId = "plotlines", height = "500px")
#                                                 ),    
                                        tabPanel("Area vs. alpha",value = "C",
                                                 h3(textOutput("caption3")),
                                                 plotOutput(outputId = "plotlines2", height = "500px")
                                        ), 
                                        tabPanel("Analytic solution", value="D",
                                                 headerPanel(h3("Lagrange multiplier")),
                                                
                                                 mainPanel( hr(),
                                                            
                                                         includeHTML("./www/include2.html"))                                                
                                        )
                                )
                                


                        )
                        )
                
                )
        )
