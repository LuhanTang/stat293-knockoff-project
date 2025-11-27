# ===========================
# 00_requirements.R
# ===========================
packages <- c(
  "MASS", "glmnet", "knockoff", "dplyr", "tibble",
  "purrr", "ggplot2", "stringr"
)

lapply(packages, library, character.only = TRUE)

# Global settings
set.seed(123)
options(stringsAsFactors = FALSE)