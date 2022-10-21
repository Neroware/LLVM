### Include libraries
library(ggplot2)
library(data.table)
library(magrittr) # Needed for %>% operator
library(tidyr)
library(ggrepel)
library(stringr)
library(hash)
library(lubridate)


### Load benchmark data
prep_tables <- function(dt) {
    dt <- dt[, c("V1", "V2")]
    colnames(dt) <- c("query", "time_millis")
    dt[, query := as.numeric(sub("tpch", "", dt[, query]))]
    dt[, query := as.factor(query)]
    return(dt)
}

### Define Plot theme
plot_theme <- theme(
    plot.title = element_text(face = "bold", size = 20),
    panel.background = element_rect(color = "black", size = 2, fill = "white"),
    panel.grid.minor = element_line(size = 0.25, color = "#00000011"),
    panel.grid.major = element_line(size = 0.5, color = "#00000018"),
    axis.text = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 16, face = "bold"),
    legend.title = element_text(size = 16, face = "bold"),
    legend.text = element_text(size = 15, face = "bold"),
    legend.key.height = unit(1, "cm"),
    legend.key.width = unit(2, "cm"),
    legend.background = element_rect(color = "black", size = 1)
)
### TUM Colors
tum_colors <- c("#0076bb", "#2c2b2b", "white")
tum_colors_range <- c("#0e3750", "#005c96", "#0076b8", "#52a6d5", "#9dcdeb")
tum_colors_special <- c("#a1b019", "#ed752c", "#eae5d6")