rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-sources ------------------------------------------------------------
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("SomethingSomething.R")

# ---- load-packages -----------------------------------------------------------
import::from("magrittr", "%>%")
requireNamespace("dplyr")

# ---- declare-globals ---------------------------------------------------------
options(show.signif.stars=F) #Turn off the annotations on p-values
# config                      <- config::get()
# path_input                  <- config$path_car_derived
# Uncomment the lines above and delete the one below if value is stored in 'config.yml'.

# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------
