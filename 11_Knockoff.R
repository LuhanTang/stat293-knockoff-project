# ===========================
# 11_Knockoff.R
# ===========================

run_knockoff_plus <- function(X, y, q = 0.1, model = "gaussian") {
  
  # Estimate covariance & mean for Model-X Gaussian knockoff
  mu_hat <- rep(0, ncol(X))
  Sigma_hat <- cov(X)
  
  # Create Model-X Gaussian knockoffs (works even when p > n)
  knock_X <- knockoff::create.gaussian(X, mu = mu_hat, Sigma = Sigma_hat)
  
  # Fit Lasso for importance stats
  fit <- glmnet::glmnet(cbind(X, knock_X), y, family = "gaussian")
  beta_hat <- coef(fit, s = fit$lambda.min)[-1]
  
  p <- ncol(X)
  Z  <- abs(beta_hat[1:p])
  Zk <- abs(beta_hat[(p+1):(2*p)])
  
  W <- pmax(Z, Zk) * sign(Z - Zk)
  
  T <- knockoff::knockoff.threshold(W, fdr = q, offset = 1)
  selected <- which(W >= T)
  
  list(selected = selected, W = W)
}
