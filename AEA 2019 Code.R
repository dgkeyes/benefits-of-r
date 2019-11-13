#
# American Evaluation Association
# Annual Conference 2019
#                         
# Eric Einspruch
# ELE Consulting, LLC
#

#
# Load packages
#

library(tidyverse) # Group of Tidyverse packages
library(psych)     # General purpose toolbox
library(skimr)     # Summary statistics
library(gmodels)   # Various tools for model fitting

#
# Read data (hypothetical)
#   ID: Participant ID
#   Program: Prgram ID 
#   Outcome: Outcome Score
#   Satisfaction: Level of satisfaction with the program
#   Part_1 to Part_5: Five items measuring different aspects of program participation
#

AEA_2019 <- read.csv("AEA 2019 Example Data.csv", header = TRUE)

#
# Look at the data
#

# Type the name of the data frame
AEA_2019
 
# Use  head() function to see only some cases
head(AEA_2019, n = 5)

# Open a window to view the data fame (note  uppercase V)
# Alternatively, click on the file name in the environment panel
View(AEA_2019) 

#
# Look at a variable
#

# Base R approach (note use of " $ ")
AEA_2019$Part_4

# Tidyverse approach (note use of " %>% ")
AEA_2019 %>% 
  select(ID, Part_4) %>% 
  head(n = 10)

#
# Assign missing values
#

# Frequency distribution: Base R approach
transform(table(AEA_2019$Part_4))  

# Assign missing value
AEA_2019 <- AEA_2019 %>% 
     mutate(Part_4 = na_if(Part_4, 9))

# Frequency distribution: Tidyverse approach (check that missing value has been assigned)
AEA_2019 %>%
  group_by(Part_4) %>%
  summarize(Freq = n())

#
# Let R know if a variable is categorical (nominal): factor
#

# Display the structure of an object: str
#    For example "int" is an integer, "Factor" is a factor

str(AEA_2019$Program)
AEA_2019 <- AEA_2019 %>% 
     mutate(Program = factor(Program))
str(AEA_2019$Program)

#
# Create new variable
#

# Total participation score 
AEA_2019 <- AEA_2019 %>% 
     mutate(Participation = (AEA_2019$Part_1 + 
                             AEA_2019$Part_2 + 
                             AEA_2019$Part_3 + 
                             AEA_2019$Part_4 +
                             AEA_2019$Part_5))

# List cases to check computation

AEA_2019 %>% 
  select(ID, Part_1, Part_2, Part_3, Part_4, Part_5, Participation) %>% 
  head(n = 5)

#
# Analyze data
#

# Summary statistics

AEA_2019 %>% 
     describe()

AEA_2019 %>% 
     skim()

# Frequency distribution
AEA_2019 %>% 
     group_by(Satisfaction) %>% 
     summarize(n = n()) %>% 
     mutate(Percent = round(prop.table(n) * 100, 1)) 

# Note that result is an object that can subsequently be read and used (common in R)
Satisfaction_Dist <- AEA_2019 %>% 
  group_by(Satisfaction) %>% 
  summarize(n = n()) %>% 
  mutate(Percent = round(prop.table(n) * 100, 1)) 

Satisfaction_Dist
View(Satisfaction_Dist)

# Crosstab satisfaction by program

table(AEA_2019$Program, 
      AEA_2019$Satisfaction)

CrossTable(AEA_2019$Program, 
           AEA_2019$Satisfaction, 
           expected = FALSE, 
           prop.c = FALSE, 
           prop.t = FALSE, 
           prop.chisq = FALSE, 
           sresid = FALSE, 
           chisq = TRUE, 
           format = "SPSS")

#
# Data visualization
#
#    Layered grammar of graphics
#    You can uniquely describe any plot as a combination of:
#
#       data set: Data to display 
#       stat:     Transform data into info to display (e.g. percentage)
#       geom:     Geometric object to represent the transformed data; use aesthetic  (aes) 
#                    properties of geom to represent variables in the data
#       mapping:  Map the values of the variable(s) to the levels of the aesthetic
#       coord:    Place geoms onto a coordinate system
#       position: Adjust position of geoms within the coordinate system
#       facet:    Split the graph into subpolts


# Scatterplot
ggplot(data = AEA_2019, 
       mapping = aes(x = Outcome, 
                     y = Participation)) +
     geom_point()

# Bar chart (percentages)
ggplot(AEA_2019, aes(x = Satisfaction, y = ..prop.. * 100, group = 1)) + 
     geom_bar() +
     ylim(0, 100)

# Bar chart (facet by program)
ggplot(AEA_2019, aes(x = Satisfaction, y = ..prop.. * 100, group = 1)) +
     geom_bar() +
     facet_wrap(~Program)

# Save chart (default saves most recent chart)
ggsave("barchart.png")

