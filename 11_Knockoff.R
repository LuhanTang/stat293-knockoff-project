# ===========================
# 11_Knockoff.R
# ===========================

run_knockoff_plus <- function(X, y, q = 0.1, model = "gaussian") {
  
  knock_X <- knockoff::create.gaussian(X, mu = rep(0, ncol(X)), Sigma = cov(X))
  
  if (model == "gaussian") {
    fit <- glmnet::glmnet(cbind(X, knock_X), y, family = "gaussian")
  } else {
    fit <- glmnet::glmnet(cbind(X, knock_X), y, family = "binomial")
  }
  
  beta_hat <- coef(fit, s = fit$lambda.min)[-1]
  
  p <- ncol(X)
  Z <- abs(beta_hat[1:p])
  Zk <- abs(beta_hat[(p+1):(2*p)])
  
  W <- pmax(Z, Zk) * sign(Z - Zk)
  
  T <- knockoff::knockoff.threshold(W, fdr = q, offset = 1)
  
  selected <- which(W >= T)
  
  list(selected = selected, W = W)
}
