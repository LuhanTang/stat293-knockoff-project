# ===========================
# 99_RunSimulation.R
# ===========================

source("00_requirements.R")
source("01_DataSimulation.R")
source("11_Knockoff.R")
source("21_BH.R")

simulate_once <- function(model, q) {
  
  # Only Gaussian models are kept
  dat <- switch(
    model,
    "gaussian"        = gen_gaussian(),         # p > n
    "gaussian_lowdim" = gen_gaussian_lowdim(),  # n > p
    stop("Unknown model: ", model)
  )
  
  X    <- dat$X
  y    <- dat$y
  supp <- dat$supp
  
  # Always use Gaussian family now
  
method1 <- run_BH(X, y, q, model = "gaussian")
method2 <- run_knockoff_plus(X, y, q, model = "gaussian")
  
  eval <- function(sel) {
    TP <- sum(sel %in% supp)
    FP <- sum(!(sel %in% supp))
    FN <- sum(!(supp %in% sel))
    list(
      FDR = FP / max(length(sel), 1),
      TPR = TP / length(supp),
      Sel = length(sel)
    )
  }
  
  c(
    model = model,
    q     = q,
    BH    = unlist(eval(method1$selected)),
    KO    = unlist(eval(method2$selected))
  )
}
