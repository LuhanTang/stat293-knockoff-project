#############################################
# 00_requirements.R
# Load and install required packages
#############################################

packs <- c("MASS", "glmnet", "knockoff", "ggplot2", "dplyr", "corpcor")

new <- setdiff(packs, rownames(installed.packages()))
if(length(new)) install.packages(new)

invisible(lapply(packs, library, character.only = TRUE))

set.seed(100)