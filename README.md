# STAT 293 Final Project: Model-X Knockoffs vs. Benjamini–Hochberg

This repository contains the code and results for the STAT 293 Final Project, 
which evaluates the performance of **Model-X Knockoff+** for feature selection 
and compares it against the classical **Benjamini–Hochberg (BH)** procedure.

The project studies empirical FDR control and statistical power under three 
high-dimensional data-generating models.

---

## 📄 Reference Paper

This project is based on the Model-X Knockoffs methodology introduced in:

**Candès, Fan, Janson, and Jordan (2018)**  
*Panning for Gold: Model-X Knockoffs for High-Dimensional Controlled Variable Selection.*  
Annals of Statistics.

---

# 📊 Models Studied

## **1. Gaussian Linear Model**

- Response:  
  $$ y = X\beta + \varepsilon $$
- Covariates: AR(1) correlation  
  $$ \Sigma_{ij} = \rho^{|i-j|}, \; \rho = 0.3 $$
- Signal strength: moderate (s ≈ 40)

---

## **2. Logistic Regression with AR(1) Correlation**

- Model:  
  $$ Y_i \sim \text{Bernoulli}(\text{logit}^{-1}(X_i^\top \beta)) $$
- Covariates follow AR(1) Gaussian design  
- Strong feature correlations make this setting more challenging

---

## **3. Independent Logistic Regression (Large p)**

- Features i.i.d. Gaussian  
  $$ X_{ij} \sim N(0,1) $$
- Weak signals (s = 60) → extremely low SNR  
- Represents a difficult high-dimensional nonlinear regime

---

✨ Authors: Luhan Tang & Shengming Chen
