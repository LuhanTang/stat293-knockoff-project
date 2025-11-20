#############################################
# 11_Knockoff.R
# Knockoff+ selection procedure
#############################################

run_knockoff <- function(X, y, q=0.10, family=c("gaussian","binomial")){
  family <- match.arg(family)
  
  # Shrinkage covariance ensures PD
  Sigma1 <- cov.shrink(X)
  Sigma  <- as.matrix(Sigma1)
  class(Sigma) <- NULL
  
  kobj <- knockoff::create.gaussian(X, mu = rep(0, ncol(X)), Sigma = Sigma)
  Xk <- if(is.list(kobj) && !is.null(kobj$Xk)) kobj$Xk else kobj
  
  W <- lasso_stat_generic(X, Xk, y, family = family)
  T <- knockoff.threshold(W, fdr = q, offset = 1)
  
  which(W >= T)
}