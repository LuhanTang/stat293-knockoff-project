#############################################
# 21_BH.R
# Benjamini–Hochberg baseline
#############################################

run_bh <- function(X, y, q=0.10, family=c("gaussian","binomial")){
  family <- match.arg(family)
  
  pvals <- apply(X, 2, function(x){
    if(family=="gaussian") {
      summary(lm(y ~ x))$coef[2,4]
    } else {
      summary(glm(y ~ x, family = binomial))$coef[2,4]
    }
  })
  
  which(p.adjust(pvals, method = "BH") <= q)
}