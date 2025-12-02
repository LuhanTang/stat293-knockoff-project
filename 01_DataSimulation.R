# ===========================
# 01_DataSimulation.R
# ===========================

# Helper: AR(1) covariance
ar1_cov <- function(p, rho) {
  idx <- 1:p
  rho ^ abs(outer(idx, idx, "-"))
}

# 1. Gaussian linear (p=400)
gen_gaussian <- function(n = 250, p = 400, s = 40, beta_size = 1.5, rho = 0.3) {
  Sigma <- ar1_cov(p, rho)
  X <- MASS::mvrnorm(n, rep(0, p), Sigma)
  
  beta <- numeric(p)
  supp <- sample(1:p, s)
  beta[supp] <- beta_size
  
  y <- X %*% beta + rnorm(n)
  
  list(X = X, y = y, beta = beta, supp = supp)
}

# 2. Gaussian linear (low-dim p=1000)
gen_gaussian_lowdim <- function(n = 600, p = 1000, s = 60, beta_size = 1.5, rho = 0.3) {
  Sigma <- ar1_cov(p, rho)
  X <- MASS::mvrnorm(n, rep(0, p), Sigma)
  
  beta <- numeric(p)
  supp <- sample(1:p, s)
  beta[supp] <- beta_size
  
  y <- X %*% beta + rnorm(n)
  
  list(X = X, y = y, beta = beta, supp = supp)
}
