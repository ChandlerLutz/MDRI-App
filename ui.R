## c:/Dropbox/PublicShinyApps/MDRI-App/ui.R

##    Chandler Lutz
##    Questions/comments: cl.eco@cbs.dk
##    $Revisions:      1.0.0     $Date:  2016-11-10

mdri.announcement <- readRDS("MDRI_announcement.rds")

shinyUI(fluidPage(
    titlePanel("The Mortgage Default Risk Index (MDRI)"),

    sidebarLayout(
        sidebarPanel(
            h3("Plot Settings"),

            uiOutput("choose_geography"),

            uiOutput("choose_regions"),

            width = 3
        ),

        mainPanel(
            plotOutput("plot_trends"),
            p('The plot shows the percentage increase in the seasonally adjusted MDRI since 2004. The blue bar is a bear market in the S&P500.', a(href = 'https://github.com/ChandlerLutz/MDRI_Data', 'Click here to download data and for more information.'),
              style = 'font-size: 1.15em;'),
            h3("Data Description"),
            p('The Mortgage Default Risk Index (MDRI) captures real-time household mortgage default risk by aggregating internet search queries such as "foreclosure help" and "mortgage help". Chauvet, Gabriel, and Lutz (2016) find that the MDRI is a leading indicator of traditional measures of mortgage default risk. ', style = 'font-size: 1.15em;'),

            p('Chauvet, Marcelle, Stuart Gabriel, and Chandler Lutz. "Mortgage default risk: New evidence from internet search queries.', em('Journal of Urban Economics'), '96 (2016): 91-111.',
              a(href = "http://dx.doi.org/10.1016/j.jue.2016.08.004", "DOI Link."),
              style = 'font-size: 1.15em;'),
            h3("Recent Trends"),
            p(mdri.announcement, style = 'font-size: 1.15em;'),
            h3("MDRI Performance During the Great Recession"),
            p("At the peak of the business cycle in December 2007, the MDRI identified San Diego, Las Vegas, Los Angeles, and Phoenix as the cities most at-risk of experiencing widespread mortgage defaults. Below is a table that ranks the 20 Case-Shiller by growth in their Mortgage Default Risk Index (MDRI) from January 2006 to December 2007:",
              style = 'font-size: 1.15em;'),
            tableOutput("trends_city_table"),
            br(),
            a(href = "https://gist.github.com/4211337", "Source code and data for this app"),
            width = 9
        )
    )

))







