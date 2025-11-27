# ===========================
# 99_RunSimulation.R
# ===========================

source("00_requirements.R")
source("01_DataSimulation.R")
source("11_Knockoff.R")
source("21_BH.R")

simulate_once <- function(model, q) {
  
  dat <- switch(model,
                "gaussian" = gen_gaussian(),
                "gaussian_lowdim" = gen_gaussian_lowdim(),
                "logistic_ar1" = gen_logistic_ar1(),
                "logistic_indep" = gen_logistic_indep()
  )
  
  X <- dat$X; y <- dat$y; supp <- dat$supp
  
  method1 <- run_BH(X, y, q, ifelse(grepl("logistic", model), "logistic", "gaussian"))
  method2 <- run_knockoff_plus(X, y, q, ifelse(grepl("logistic", model), "logistic", "gaussian"))
  
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
    q = q,
    BH = unlist(eval(method1$selected)),
    KO = unlist(eval(method2$selected))
  )
}