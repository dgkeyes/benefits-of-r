
# Install Packages --------------------------------------------------------

# Install the tidyverse and skimr packages using the install.packages function

install.packages("tidyverse")
install.packages("skimr")

# Load Packages -----------------------------------------------------------

# Load the tidyverse and skimr packages using the library function

library(tidyverse)
library(skimr)

# Import Data -------------------------------------------------------------

# Import the faketucky data into a data frame called faketucky.

faketucky <- read_csv("01-getting-started-with-r/data/faketucky.csv")


# Examine Data ------------------------------------------------------------

# Enter the name of your data frame (faketucky) and run it as code to see the output.

faketucky

# Open faketucky by clicking on it in the environment/history pane or by using the View() function.

View(faketucky)

# Use the skim() function to examine faketucky.

skim(faketucky)


