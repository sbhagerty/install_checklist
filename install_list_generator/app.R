#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gt)
library(tidyverse)
library(pins)
source("global.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Posit Environment Install Plan"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
      
          
          h4("Number of Servers per Cluster"),
          numericInput("wb_servers", label = "Workbench Servers", value = 1),
          numericInput("connect_servers", label = "Connect Servers", value = 1),
          numericInput("pm_servers", label = "Package Manager Servers", value = 1),
          
          h4("Environment"),
          
          selectInput("os", label = "Linux Distribution", 
                      choices = list("RHEL 7" = "rhel7", "RHEL 8" = "rhel8", "RHEL 9" = "rhel9", "CentOS 7" = "centos7", "Ubuntu 20" = "ubuntu20",
                                     "Ubuntu 22" = "ubuntu22", "openSUSE 15.4"="opensuse"),
                      
                      selected = "ubuntu22"),
          
          selectInput("auth", label = "Authentication", 
                      choices = list("SAML"="saml", "Local"="local", "OIDC/OAuth 2.0" = "oidc"),
                      selected = "saml")
          
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
         gt_output(outputId = "table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$table <- render_gt(expr=format_table(input$wb_servers, input$connect_servers, input$pm_servers, input$os, input$auth))
  

}

# Run the application 
shinyApp(ui = ui, server = server)
