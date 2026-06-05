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
head(result_linear)
length(result_linear)

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

## ----custom-sitenames---------------------------------------------------------
# Create custom site names
custom_sitenames <- paste("Site", seq_len(nrow(varespec)))

# Plot with custom site names
p4 <- plotStability(results_multi, sitenames = custom_sitenames)
p4

## -----------------------------------------------------------------------------
print(sessionInfo())

