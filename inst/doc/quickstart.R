## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----installation, eval = FALSE-----------------------------------------------
# # Install from GitHub
# # install.packages("devtools")
# # devtools::install_github("gaoyu19920914/betaStability")
# 
# # OR install from BioConductor (in the future when it's available)
# # if (!requireNamespace("BiocManager", quietly = TRUE))
# #     install.packages("BiocManager")
# # BiocManager::install("betaStability")

## ----load-packages------------------------------------------------------------
library(betaStability)
library(vegan)
library(ggplot2)

## ----load-data----------------------------------------------------------------
data(varespec)
data(varechem)

# Inspect the data
head(varespec)
head(varechem)

# Dimensions of the datasets
cat("Dimensions of varespec:", dim(varespec), "\n")
cat("Dimensions of varechem:", dim(varechem), "\n")

## ----single-method------------------------------------------------------------
# Calculate stability with linearPred
result_linear <- betaStability(
    comtable = varespec,
    envmeta = varechem,
    method = "linearPred"
)

# Inspect the result
length(result_linear$stability_Linear)

# Calculate stability with linearPred with symmetric algorithm
result_linear_symmetric <- betaStability(
    comtable = varespec,
    envmeta = varechem,
    method = "linearPred",
    symmetric = TRUE
)

# Calculate the correlations between the results
corr_pearson <- cor.test(result_linear$stability_Linear, 
                         result_linear_symmetric$stability_Linear, 
                         method = c("pearson"))
corr_spearman <- cor.test(result_linear$stability_Linear, 
                          result_linear_symmetric$stability_Linear, 
                          method = c("spearman"))
corr_pearson
corr_spearman

## ----multiple-methods---------------------------------------------------------
# Calculate stability with multiple methods
results_multi <- betaStability(
    comtable = varespec,
    envmeta = varechem,
    method = c("linearPred", "mlPred", "glmPred")
)

# Inspect the result
head(results_multi)
dim(results_multi)

## ----all-methods--------------------------------------------------------------
# Calculate stability with all methods
results_all <- betaStability(
    comtable = varespec,
    envmeta = varechem,
    method = "all"
)

# Inspect the result
head(results_all)
dim(results_all)
colnames(results_all)

## ----plot-single--------------------------------------------------------------
# Plot stability results for single method
p1 <- plotStability(result_linear)
p1

## ----plot-multi---------------------------------------------------------------
# Plot stability results for multiple methods
p2 <- plotStability(results_multi)
p2

## ----plot-all-----------------------------------------------------------------
# Plot stability results for all methods
p3 <- plotStability(results_all)
p3

## ----plot-correlation---------------------------------------------------------
# Plot stability correlations between all pairs of methods
p4 <- plotCorrelation(results_all)
p4

## ----custom-sitenames---------------------------------------------------------
# Create custom site names
custom_sitenames <- paste("Site", seq_len(nrow(varespec)))

# Plot with custom site names
p5 <- plotStability(results_multi, sitenames = custom_sitenames)
p5

## -----------------------------------------------------------------------------
print(sessionInfo())

