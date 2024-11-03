library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title ="Exploring the 1973 US Arrests data with R & Shiny Dashboard",
                  titleWidth = 650,
                  tags$li(class="dropdown", tags$a(href="https://www.youtube.com/watch?v=tlOBVZx8Hy0", icon("youtube"), "Tutorial Link")),
                  tags$li(class="dropdown", tags$a(href="https://github.com/OjmJakon", icon("github"), "My GitHub"))
                  ),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      
      menuItem("Dataset", tabName = "dataset", icon = icon("database")),
      menuItem("Visualization", tabName = "visualization", icon = icon("chart-line")),
      menuItem("Map", tabName = "map", icon = icon("map"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dataset",
              
              tabBox(id="t1",
                     tabPanel("About", icon = icon("address-card"), fluidRow(
                       column(width=8, 
                              tags$img(src="crime.jpg", width=600, height=300),
                              tags$br(),
                              tags$a(href="https://www.google.com/search?sca_esv=0d6d888e3e845be0&sxsrf=ADLYWIKngqqkHccZtPM4qZR2T_9eXCvvIQ:1730555619253&q=crime&udm=2&fbs=AEQNm0BM2w4rP6CfEDnGufBTB9HK1sJ747o0YUiT1nOf-h7CijYJtIy-8cxD-k42kJEh_DbEJW48qFTvsfMJrV-_XVSApNt-MkL4V2liSfLUXB6Y1D_WbV9LfHWqW9jxMJNNCpQAu8rtH3zRZDm5i8lEASkWlakQptjJ5uafcUYHylwQthFJgMQ&sa=X&ved=2ahUKEwj_kMyH5r2JAxXV6gIHHQhdANMQtKgLegQIHBAB&biw=940&bih=976&dpr=1#vhid=bavw7Ma_UKYKXM&vssid=mosaic",
                                     "Photo is only a refrence", align="center")
                              ),
                       column(width=8, tags$br(),
                              tags$p("This dataset comes along with base R."))
                       )
                    ),
                     tabPanel("Data", icon = icon("address-card"), dataTableOutput("dataTable")),
                     tabPanel("Structure", icon = icon("address-card"), verbatimTextOutput("structure")),
                     tabPanel("Summary Stats", icon = icon("address-card"), verbatimTextOutput("summary"))
                     )
              ),
      
      tabItem(tabName = "visualization",
              
              tabBox(id="t2",
                     tabPanel(title="Crime trends By State", value="trends", h4("tabpanel 1 placeholder")),
                     tabPanel(title="Distribution", value="distro",
                              selectInput(inputId = "var1", label="Select Variable", choices= c1, selected="Rape"),
                              plotlyOutput("histplot")),
                     tabPanel(title="Correlation Matrix", value="correlations",
                              plotlyOutput("cor", width="600px", height="600px")),
                     tabPanel(title="Relationship Among Arest types And Urban Population",
                              selectInput(inputId = "var3", label="Choose X axis", choices = c1, selected = "UrbanPop"),
                              selectInput(inputId = "var4", label="Choose Y axis", choices = c1, selected = "Rape"),
                              plotlyOutput("scatterplot"))
              ),
      
      tabItem(tabName = "map"
              
      )
    )
  )
  
  )
  
)

