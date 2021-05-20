
server <- function(input, output) {

#############
library(httr)
library(dplyr)
library(jsonlite)
library(shiny)
library(stringr)
library(gtrendsR)  

##############        
    output$t_Inp_Fraza <- renderText(input$txt_Input_fraza)
        #ObserveIvent odpytuje API dopiero po nacisnieciu guzika akcji
        observeEvent(input$ab, {  
 ####################  Budowanie URL do MJ         
url1 <- 'https://api.majestic.com/api/json?app_api_key=0CFE037B9D55DA22F67ED0944CDD3487&cmd=SearchByKeyword&query='
url2 <- str_replace(input$txt_Input_fraza, pattern = " ", replacement = "+")
    #Url2 <- str_replace(Url2,pattern = " ", replacement = "+")
url3 <- '&scope=2&GeoTarget=pl' 
output$urlALL <- reactive({paste(url1,url2,url3, sep = "")})    
urlAPI <- reactive({paste(url1,url2,url3, sep = "")})
        
zm <- reactive({input$txt_Input_fraza})
gtr <- gtrends(zm())
output$gtr <- renderPlot({plot(gtr)})
        
###############################           
        
SearcByKeyword <-    GET(urlAPI())
                         
SearcByKeyword_JSON <-SearcByKeyword %>% content("text") %>% fromJSON(flatten = F)
a <-SearcByKeyword_JSON$DataTables$Results$Data
MJ_JSON <- c()
MJ_JSON$URL <- a$Item
MJ_JSON$Score <- a$SearchScore
MJ_JSON$CF <- a$CitationFlow
MJ_JSON$TF <- a$TrustFlow
MJ_JSON <- as.data.frame(MJ_JSON)       
                             
output$daneMJ <- renderPrint({print(MJ_JSON)})        
        })
}
