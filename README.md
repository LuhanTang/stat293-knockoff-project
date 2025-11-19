# STAT 293 Final Project: Model-X Knockoffs vs BH Procedure

This repository contains the code and results for the STAT 293 final project, 
focusing on high-dimensional variable selection using the **Model-X Knockoff+** 
procedure and comparing it against the classical **Benjamini–Hochberg (BH)** method 
for FDR control. The project evaluates the empirical performance of both methods 
across three different data-generating models.

---

## 📌 Project Overview

The goal of this project is to:
- Construct knockoff variables under Gaussian or empirical designs  
- Compute feature importance statistics using Lasso-based methods  
- Apply the Knockoff+ thresholding rule to control the false discovery rate (FDR)  
- Compare Knockoff+ with the BH procedure under multiple high-dimensional settings  

The evaluation is based on:
- **False Discovery Rate (FDR)**
- **True Positive Rate (TPR / Power)**
- **Number of selected variables**

---

## 📊 Models Considered

We study three settings:

### 1. **Gaussian Linear Model**
- \( y = X\beta + \varepsilon \)
- \(X\) has AR(1) correlation
- Signal strength moderate (s ≈ 40)

### 2. **Logistic Regression with AR(1)**
- \( Y_i \sim \text{Bernoulli}(\text{logit}^{-1}(X_i^\top \beta)) \)
- Strong feature correlation makes this more challenging

### 3. **Independent Logistic Regression (Large p)**
- Features i.i.d. Gaussian
- Weak signals (s = 60) → extremely low SNR

Knockoff+ is expected to outperform BH especially in the Gaussian setting.

---

✨ Authors
	•	Luhan Tang & Shengming Chen
