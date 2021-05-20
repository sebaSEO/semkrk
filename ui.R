

ui <- fluidPage(
    
textInput("txt_Input_fraza", "Dane dla frazy", "Wprowadz fraze"),   
actionButton("ab", "Nacinij")    
,textOutput("t_Inp_Fraza")  
,verbatimTextOutput("urlALL")

,verbatimTextOutput("daneMJ")
,plotOutput("gtr")
)
