library(xaringan)
library(here)
library(rmarkdown)
library(pagedown)
library(tidyverse)

# Render presentation -----------------------------------------------------

# render(input = here("slides", "slides.Rmd"), 
#        output_dir = here("slides"),
#        output_file = "slides.html",
#        clean = T)

# Convert to PDF ----------------------------------------------------------

chrome_print(here("slides", "slides.html"), 
        here("slides", "slides.pdf"))
