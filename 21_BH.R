# ===========================
# 21_BH.R
# ===========================

run_BH <- function(X, y, q = 0.1, model = "gaussian") {
  
  p <- ncol(X)
  pvals <- numeric(p)
  
  for (j in 1:p) {
    if (model == "gaussian") {
      fit <- summary(lm(y ~ X[, j]))
      pvals[j] <- fit$coefficients[2, 4]
    } else {
      fit <- summary(glm(y ~ X[, j], family = "binomial"))
      pvals[j] <- fit$coefficients[2, 4]
    }
  }
  
  selected <- which(p.adjust(pvals, method = "BH") <= q)
  
  list(selected = selected, pvals = pvals)
}