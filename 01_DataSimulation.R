#############################################
# 01_DataSimulation.R
# Data simulation functions
#############################################

# AR(1) covariance helper
ar1_cov <- function(p, rho){
  idx <- 1:p
  rho^abs(outer(idx, idx, "-"))
}

# 1) Gaussian linear model
gen_gaussian_linear <- function(n = 250, p = 400, s = 40,
                                snr = 8, rho = 0.3, seed = NULL){
  if(!is.null(seed)) set.seed(seed)
  
  Sigma <- ar1_cov(p, rho)
  X <- MASS::mvrnorm(n, mu = rep(0,p), Sigma = Sigma)
  
  beta <- rep(0, p)
  supp <- sample(1:p, s)
  beta[supp] <- 1.5
  
  signal <- as.vector(X %*% beta)
  sigma_eps <- sqrt(var(signal) / snr)
  y <- signal + rnorm(n, 0, sigma_eps)
  
  list(X = X, y = y, beta = beta, supp = supp)
}

# 2) Logistic regression with AR(1)
gen_logistic_ar1 <- function(n = 250, p = 400, s = 40,
                             rho = 0.3, beta_size = 1.5, seed = NULL){
  if(!is.null(seed)) set.seed(seed)
  
  Sigma <- ar1_cov(p, rho)
  X <- MASS::mvrnorm(n, mu = rep(0,p), Sigma = Sigma)
  
  beta <- rep(0,p)
  supp <- sample(1:p, s)
  beta[supp] <- beta_size
  
  eta <- as.vector(X %*% beta)
  prob <- 1/(1 + exp(-eta))
  y <- rbinom(n, 1, prob)
  
  list(X = X, y = y, beta = beta, supp = supp)
}

# 3) Independent logistic regression (large p)
gen_logistic_large <- function(n = 250, p = 400, s = 60,
                               beta_size = 1.5, seed = NULL){
  if(!is.null(seed)) set.seed(seed)
  
  X <- matrix(rnorm(n*p), n, p)
  
  beta <- rep(0,p)
  supp <- sample(1:p, s)
  beta[supp] <- beta_size
  
  eta <- as.vector(X %*% beta)
  prob <- 1/(1 + exp(-eta))
  y <- rbinom(n, 1, prob)
  
  list(X = X, y = y, beta = beta, supp = supp)
}