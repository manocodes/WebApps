library(shiny)
library(ggplot2)

ui <- fluidPage(
        splitLayout(mainPanel(
                radioButtons("radio","select a single option", 
                             c("Option 1" = "opt1", 
                               "Option 2" = "opt2", 
                               "Option 3" = "opt3"),
                             selected = "opt3"),
                selectInput("select", "Select a School", 
                            c("Bakers college",
                              "Colorado community college",
                              "Monroe tech college"),
                            multiple=TRUE),
                selectInput("selectone", "Select a School", 
                            c("Bakers college",
                              "Colorado community college",
                              "Monroe tech college")),
                sliderInput("slider","Slider to select a number", 0, 100, 50, animate=TRUE),
                actionButton("button", "Button01", icon=icon("area-chart")),
                actionLink("link","this is a link", icon=icon("rocket")),
                checkboxGroupInput("checkgroup","select all that applies", 
                                   c("Option 1" = "opt1", 
                                     "Option 2" = "opt2", 
                                     "Option 3" = "opt3"),
                                   selected="opt2", inline = TRUE),
                checkboxInput("checksingle","This is a single checkbox", TRUE),
                dateInput("date","Select your birthday",value="2016-01-01",
                          min="2000-01-01", max="2030-01-01", width="100px"),
                dateRangeInput("daterange", "select a date Range",
                               start = "2000-01-01", end="2030-01-01",
                               min = "2000-01-01", max="2030-01-01", 
                               separator = "TO:"),
                fileInput("fileselect", "select a file to upload", multiple = TRUE),
                fileInput("filesingleselect", "select a file to upload", accept = TRUE),
                numericInput("number","Enter a number",100),
                passwordInput("password","Password","Mano"),
               # submitButton("Submit Changes"),
                textInput("text","Enter your name", "Mano")
        ),
        mainPanel(
                dataTableOutput("datatable"),
                imageOutput("image"),
                plotOutput("plot"),
                verbatimTextOutput("textout"),
                tableOutput("tableoutout"),
                textOutput("textlineout"),
                uiOutput("uioutout"),
                htmlOutput("htmloutput")
        ))
)

server <- function(input, output) {
        
        output$plot = renderPlot({
        
        binto = input$number
                        
        ggplot(,aes(x=rnorm(input$slider[1]))) + geom_histogram(bins = binto, fill="skyblue")
                
                })   
                
        output$tableoutout = renderText({"Mano Yakandawala"})
}

shinyApp(ui = ui, server = server)

