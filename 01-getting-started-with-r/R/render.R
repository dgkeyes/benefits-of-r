library(xaringan)
library(here)
library(rmarkdown)
library(pagedown)
library(tidyverse)

# Render presentation -----------------------------------------------------

# render(input = here("01-getting-started-with-r/slides", "slides.Rmd"), 
#        output_dir = here("01-getting-started-with-r/slides"),
#        output_file = "slides.html",
#        clean = T)

# Convert to PDF ----------------------------------------------------------

chrome_print(here("01-getting-started-with-r/slides", "slides.html"), 
        here("01-getting-started-with-r/slides", "slides.pdf"))
