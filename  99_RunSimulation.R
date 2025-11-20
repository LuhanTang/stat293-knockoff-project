#############################################
# 99_RunSimulation.R
#############################################

source("00_requirements.R")
source("01_DataSimulation.R")
source("11_Knockoff.R")
source("21_BH.R")

# one simulation
one_run_model <- function(model=c("gaussian","logistic_ar1","logistic_large"),
                          q=0.10, seed=1){
  model <- match.arg(model)
  
  if(model=="gaussian"){
    dat <- gen_gaussian_linear(seed=seed)
    family <- "gaussian"
  } else if(model=="logistic_ar1"){
    dat <- gen_logistic_ar1(seed=seed)
    family <- "binomial"
  } else {
    dat <- gen_logistic_large(seed=seed)
    family <- "binomial"
  }
  
  X <- scale(dat$X)
  y <- dat$y
  supp <- dat$supp
  
  sel_k <- run_knockoff(X,y,q,family)
  tp_k <- sum(sel_k %in% supp)
  fp_k <- length(sel_k) - tp_k
  fdr_k <- ifelse(length(sel_k)==0,0, fp_k/length(sel_k))
  tpr_k <- tp_k/length(supp)
  
  sel_bh <- run_bh(X,y,q,family)
  tp_bh <- sum(sel_bh %in% supp)
  fp_bh <- length(sel_bh) - tp_bh
  fdr_bh <- ifelse(length(sel_bh)==0,0, fp_bh/length(sel_bh))
  tpr_bh <- tp_bh/length(supp)
  
  data.frame(
    model=model,
    method=c("Knockoff+","BH"),
    q=q,
    FDR=c(fdr_k,fdr_bh),
    TPR=c(tpr_k,tpr_bh),
    selected=c(length(sel_k),length(sel_bh))
  )
}

# repeat for all models
run_reps_all <- function(R=10, qs=c(0.05,0.10,0.20)){
  models <- c("gaussian","logistic_ar1","logistic_large")
  
  all_res <- lapply(1:R, function(r){
    do.call(rbind, lapply(models, function(m){
      do.call(rbind, lapply(qs, function(q){
        one_run_model(model=m, q=q, seed=1000*r+100*q)
      }))
    }))
  })
  
  do.call(rbind, all_res)
}

# run experiment
res_all <- run_reps_all(R=10)

library(dplyr)

summ_all <- res_all %>%
  group_by(model, method, q) %>%
  summarise(
    mean_FDR = mean(FDR),
    mean_TPR = mean(TPR),
    mean_sel = mean(selected),
    .groups="drop"
  )

print(summ_all)

# plotting
library(ggplot2)

out_dir <- "plots"
if(!dir.exists(out_dir)) dir.create(out_dir)

models <- unique(summ_all$model)

for(m in models){
  df_m <- dplyr::filter(summ_all, model == m)
  
  p_fdr_m <- ggplot(df_m, aes(factor(q), mean_FDR, group=method, color=method)) +
    geom_line() + geom_point(size=2) +
    labs(title=paste0("FDR vs q (", m,")"),
         y="FDR", x="q") +
    theme_minimal()
  
  ggsave(file.path(out_dir, paste0(m,"_FDR.png")),
         p_fdr_m, width=6, height=4, dpi=300)
  
  p_tpr_m <- ggplot(df_m, aes(factor(q), mean_TPR, group=method, color=method)) +
    geom_line() + geom_point(size=2) +
    labs(title=paste0("Power vs q (", m,")"),
         y="TPR", x="q") +
    theme_minimal()
  
  ggsave(file.path(out_dir, paste0(m,"_power.png")),
         p_tpr_m, width=6, height=4, dpi=300)
}