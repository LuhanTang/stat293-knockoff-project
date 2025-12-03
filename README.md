# STAT 293 Final Project: Model-X Knockoffs vs. Benjamini–Hochberg

This repository contains the code and results for the STAT 293 Final Project,  
which evaluates the performance of **Model-X Knockoff+** for feature selection  
and compares it against the classical **Benjamini–Hochberg (BH)** procedure.

The project studies empirical FDR control and statistical power under a  
**Gaussian linear data-generating model** in high dimensions.
---

## 📄 Reference Paper

This project is based on the Model-X Knockoffs methodology introduced in:

**Candès, Fan, Janson, and Jordan (2018).  
“Panning for Gold: Model-X Knockoffs for High-Dimensional Controlled Variable Selection.”  
*Journal of the Royal Statistical Society: Series B*.**

---
## 📁 Repository Structure
```
├── plots/ # Auto-generated simulation figures (FDR, TPR, boxplots, etc.)
│
├── 00_requirements.R # Install/load required packages
├── 01_DataSimulation.R # Gaussian linear model simulation (X, y, covariance structure, SNR)
├── 11_Knockoff.R # Knockoff+ construction + W-statistic computation
├── 21_BH.R # Benjamini–Hochberg baseline implementation
├── 99_RunSimulation.R # Main driver script that runs all simulations end-to-end
│
├── 30_MainAnalysis.Rmd # RMarkdown file that generates plots/tables for the final report
│
├── FinalReport.pdf # Final written report summarizing design, results, and conclusions
├── FinalReport.tex # LaTeX source for the final report
│
├── STAT293 Final Project.Rmd # Combined notebook used during development (optional)
│
└── README.md # Project documentation (this file)
```



---

## 🧪 Model Studied

We evaluate Knockoff+ and BH under a **single data-generating model**:

### **1. Gaussian Linear Model**

- Covariates $( X_i \sim N(0, \Sigma) )$ with Toeplitz structure \( \Sigma_{jk} = \rho^{|j-k|} \)
- Response model \( Y = X\beta + \varepsilon \)
- Sparsity level \( s = 40 \)
- Signal strength set so that SNR ≈ 8
- Dimensions tested: **p = 250** and **p = 400**

This model serves as a clean, well-controlled environment where theoretical guarantees of Knockoff+ hold exactly.

---

# 🔁 How to Reproduce All Results

Follow the steps below to fully reproduce our simulation study.

---

## **1️⃣ Install required R packages**

```r

source("00_requirements.R")

```

## **2️⃣ Generate Gaussian data**
This script generates the design matrices, coefficients, and noise according to the model

```r

source("01_DataSimulation.R")

```

## **3️⃣ Run Knockoff+ procedure**

Construct Gaussian knockoffs using shrinkage, compute W-statistics, and apply the Knockoff+ threshold:

```r

source("11_Knockoff.R")

```

## **4️⃣ Run BH baseline**

Compute marginal p-values and apply BH at multiple q-levels:

```r

source("21_BH.R")

```

## **5️⃣ Run the full simulation pipeline**

This script executes everything end-to-end and saves results into the plots/ folder:

```r

source("99_RunSimulation.R")

```


## **6️⃣ Reproduce tables & figures used in the final report**

Render the analysis RMarkdown file:

```r

rmarkdown::render("30_MainAnalysis.Rmd")

```

## 📊 Summary of Key Findings

- Knockoff+ consistently controls FDR near the nominal level.

- BH inflates FDR under correlated designs and in higher dimensions.

- Knockoff+ achieves much higher TPR due to accurate competition between variables and their knockoffs.

- Shrinkage-based covariance estimation ensures numerical stability for Gaussian knockoffs.

---
## ✏️ Authors
- **Luhan Tang**
- **Shengming Cheng**

