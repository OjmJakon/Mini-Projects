library(DT)
library(shiny)
function(input, output, session) {
  
  #Structure
  output$structure <- renderPrint(
    df %>% 
      structure()
  )
  
  #Summary
  output$summary <- renderPrint(
    df %>% 
      summary()
  )
  
  #DataTable
  output$dataTable <- renderDataTable(
    df
  )
  
  #Create Graphs for Selected Variable
  
  #Boxplot
  output$histplot <- renderPlotly({
    p1 <- df %>% 
      plot_ly() %>% 
      add_histogram(x=~get(input$var1)) %>% 
      layout(xaxis = list(title = paste(input$var1)))
    
    p2 <- df %>% 
      plot_ly() %>% 
      add_boxplot(x=~get(input$var1)) %>% 
      layout(yaxis = list(showticklabels = F))
    
    #Stack Plots
    subplot(p2, p1, nrows=2) %>% 
      layout(title = "Distribution chart - Histogram and Boxplot",
             yaxis = list(title="Frequency"))
  })
  
  #Correlation Matrix
  output$cor <- renderPlotly({
    df_corr <- df %>% 
      select(-"State", -"UrbanPop")
    
    # Calculate correlation matrix
    corr_matrix <- cor(df_corr, use = "pairwise.complete.obs")
    corr <- round(corr_matrix, 1)
    p.mat <- cor_pmat(df_corr)
    
    # Generate the correlation plot
    corr_plot <- ggcorrplot(
      corr,
      hc.order = TRUE,
      lab = TRUE,
      p.mat = p.mat
    )
    
    ggplotly(corr_plot) 
    
  })

  
  #Scatterplot
  output$scatterplot <- renderPlotly({
    p3 <- df %>% 
      ggplot(aes(x=get(input$var3), y=get(input$var4))) +
      geom_point() +
      geom_smooth(method="lm") +
      labs(title = paste("Relation between", input$var3, "and", input$var4),
           x= input$var3,
           y = input$var4)
    ggplotly(p3)
  })
    
  
    
}
