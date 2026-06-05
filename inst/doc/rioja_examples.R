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
# Check if rioja is available and install it to load dataset
if (!requireNamespace("rioja", quietly = TRUE)) install.packages("rioja")
data("Ponds", package = "rioja")


## ----data preparation---------------------------------------------------------
comtable <- Ponds$spec
envmeta <- Ponds$env[, 6:19]

# Calculate stability with linearPred
stability_rioja_linear <- betaStability(
    comtable = comtable,
    envmeta = envmeta,
    method = "linearPred"
)

# Inspect the result
head(stability_rioja_linear)
p_rioja <- plotStability(stability_rioja_linear, sitenames = Ponds$env$Name)
p_rioja

## -----------------------------------------------------------------------------
print(sessionInfo())

