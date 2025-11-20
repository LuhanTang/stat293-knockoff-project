#############################################
# 12_Knockoff_aux.R
# Lasso-based importance statistic for Knockoff+
#############################################

lasso_stat_generic <- function(X, Xk, y, family = c("gaussian","binomial")){
  family <- match.arg(family)
  
  Xaug <- cbind(X, Xk)
  fit  <- glmnet(Xaug, y, family = family)
  
  yhat <- predict(fit, Xaug, type = "response")
  rss  <- colSums((y - yhat)^2)
  idx_min <- which.min(rss)
  
  coefs <- as.numeric(fit$beta[, idx_min])
  
  p <- ncol(X)
  Z  <- abs(coefs[1:p])
  Zk <- abs(coefs[(p+1):(2*p)])
  
  W <- pmax(Z, Zk) * sign(Z - Zk)
  W
}