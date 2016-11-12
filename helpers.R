## c:/Dropbox/PublicShinyApps/MDRI-App/helpers.R

##    Chandler Lutz
##    Questions/comments: cl.eco@cbs.dk
##    $Revisions:      1.0.0     $Date:  2016-11-10

library(shiny)

##Color palette from R cookbook
cbPalette <- c("darkmagenta",  "darkblue", "darkgreen",  "darkgrey", "gold", "deeppink", "darkred")
##Add a bunch of other colors
cbPalette <- c(cbPalette, "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

##A function to make the plot
plot_trends <- function(trends.data) {

    ##Create a factor for the US if it's included in the dataset
    if ("United States" %in% trends.data$region) {
        ##order the US first
        trends.data$region  <- factor(trends.data$region,
                                        levels = unique(trends.data$region),
                                        ordered = TRUE)
    }

    ##The plot
    p <- ggplot(trends.data, aes_string(x = "time", y = "value", group = "region")) +
        geom_line(aes_string(color = "region")) +
        geom_cycle(dates = bear_dates, alpha = 0.1) +
        scale_colour_manual(values=cbPalette) +
        ylab("MDRI (% Increase from 2004)") +
        background_grid(major = "xy", minor = "none") +
        theme(legend.position = "bottom",
              axis.title.x = element_blank(),
              legend.title = element_blank(),
              legend.text = element_text(size = 16),
              axis.title.y = element_text(size = 16)) +
        ##Increase the size of the lines in the legend
        ##http://stackoverflow.com/a/20416049/1317443
        guides(color = guide_legend(override.aes = list(size=2)))


    ##return the plot
    return(p)

}
