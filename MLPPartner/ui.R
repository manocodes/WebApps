library(shiny)

#shinyUI(fluidPage(
#        tabsetPanel(
navbarPage("MyLabsPlus",
                tabPanel( "Overview",(
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel( h3(".NExT courses"),
        sliderInput("slider1","Select the range you want to look at",
                    0, 100, value=c(25,50)),
        textInput("searchPartner", "Partner name contains"),
        numericInput("omit", "Drop Partnes with .NExT courses less than", 1, 1,
                     1000, step=1 ),
        dateRangeInput("dateRange", "Select Course Start Date Range from", 
                       start = '2016-01-01', end = '2016-12-31',
                       min = '2016-01-01', max = '2017-12-31',
                       separator = "To"),
        submitButton("Submit"),
        tags$br(),
        tags$a(href="mailto:mano.yakandawala@pearson.com?Subject=Feedback%20From%20MLP%20Stakeholders..",
               "Email Mano with your feedback..")
    ),
    mainPanel( h2(textOutput("text1")),
               h3(textOutput("text2")),
               tableOutput("data")
               
    )
  )
 )),
  tabPanel( "Partner Summary", "test"),
  tabPanel( "Misc", "test")
  )
#))
