library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(VennDiagram)
library(data.table)

courses = read.csv("MLPCourseswithCourseTypeNew.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
        
minvalue = reactive({input$slider1[1]})
maxvalue = reactive({input$slider1[2]})

datefrom = reactive({
        validate(
                need(as.Date(input$dateRange[1]), "Enter a valid From Date")
        )
        input$dateRange[1]
        })

dateto = reactive({
        validate(
                need(as.Date(input$dateRange[2]), "Enter a valid To Date")
        )
        input$dateRange[2]
})

partner = reactive({input$searchPartner})

lessthan = reactive({
        validate(
                need(is.numeric(input$omit), "Enter min number of courses to drop the partners")
        )
        input$omit
        })

output$data = renderTable({
        tmpcourses = filter(courses, 
                            (StartDate >= datefrom() & 
                                     StartDate <= dateto()))
        
        if (trimws(input$searchPartner) != "") {
                tmpcourses = filter(tmpcourses, tolower(School) %like% tolower(partner()))
        }
        
        tmpcourses = select(tmpcourses, School, SemesterTitle, Type)
        tempData = data.frame(School = c("TEST","TEST"), SemesterTitle = c("TEST","TEST"), Type = c(".NExT","OV"))
        tmpcourses = rbind(tmpcourses,tempData)
        
        typesummary = as.data.frame(table(tmpcourses$School, tmpcourses$Type ))
        typesummary = spread(typesummary, Var2, Freq, fill = 0)
        typesummary = mutate(typesummary, 
                             .NExTPer = as.numeric(format((.NExT/(.NExT + OV) * 100), digits=0)))
        #typesummary = mutate(typesummary, .NExT = format(.NExT, digits=4))
        colnames(typesummary)[1] = "School"
        
        typesummary = filter(typesummary, School != "TEST")
        
        typesummary = filter(typesummary,
                             .NExTPer <= maxvalue() & .NExTPer >= minvalue())
        
        typesummary = filter(typesummary, .NExT >= lessthan())
        
        if (nrow(typesummary) > 0){
                typesummary = arrange(typesummary, desc(.NExTPer))
        } else {
                "No records for the given criteria."
        }
})

output$text1 = renderText({
        label = paste("List of Partners with ", 
                      minvalue(), "% to ", 
                      maxvalue(), "% courses in .NExT", sep="")
        })

output$text2 = renderText({
        paste("(Partners with less than ", lessthan(), " course(s) are
              droped from the list.)" )
        })

})
