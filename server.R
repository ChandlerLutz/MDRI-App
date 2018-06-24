## c:/Dropbox/PublicShinyApps/MDRI-App/server.R

##    Chandler Lutz
##    Questions/comments: cl.eco@cbs.dk
##    $Revisions:      1.0.0     $Date:  2016-11-10

library(shiny); library(ggts); library(xts); require(dplyr); require(tidyr);
library(cowplot)

source("helpers.R")



## -- Create the datasets -- ##
##Cities and states. Use only NSA data
trends.states <- readRDS("MDRI_States_shiny.rds")
trends.states.regions <- unique(trends.states$region)
trends.cities <- readRDS("MDRI_Cities_shiny.rds")
trends.cities.regions <- unique(trends.cities$region)
##Also load trends city growth rank table
trends.city.rank <- readRDS("MDRI_cities_rank_shiny.rds")

##Bear Dates
data(bear_dates)



##Regions
regions <- c("City", "State")

shinyServer(function(input, output) {

    ##Drop-down selection of geographic region
    output$choose_geography <- renderUI({
        selectInput("geography", "Geographic Unit:", as.list(regions))

    })

    ##Check boxes
    output$choose_regions <- renderUI({

        ##If missing input, return to avoid error later in
        ##function
        if (is.null(input$geography))
            return()

        ##Choose the dataset
        if (input$geography == "State") {
            trends <- trends.states
            regions <- trends.states.regions
            choose.region <- "Choose States:"
            selected.region <- c("United States", "Arizona")
        } else if (input$geography == "City") {
            trends <- trends.cities
            regions <- trends.cities.regions
            choose.region <- "Choose Cities: "
            selected.region <- c("United States", "Miami")
        }

        ##Create the checkboxes and select only the
        checkboxGroupInput("region", choose.region,
                           choices = regions,
                           selected = selected.region)
    })


    ##Output the plot
    output$plot_trends <- renderPlot({

        ##If missing input, return to avoid an error later in function
        if (is.null(input$geography)) {
            return()
        }

        ##Get the data set
        ##Choose the dataset
        if (input$geography == "State") {
            trends <- trends.states
        } else if (input$geography == "City") {
            trends <- trends.cities
        }

        ##Make sure regions are correct for data set (when data set changeds,
        ##the columns will initially be for the previous dataset)
        if (is.null(input$region) || !all(input$region %in% trends$region)) {
            return()
        }

        ##Keep selected columns
        trends <- filter(trends, region %in% input$region)

        ##Plot
        plot_trends(trends)

    })

    ##The table of case-shiller cities ranked by MDRI
    output$trends_city_table <- renderTable({
        trends.city.rank
    })

})
