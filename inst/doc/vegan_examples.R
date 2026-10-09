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
library(sf)
data("BCI", "BCI.env", "mite", "mite.env", "dune", "dune.env")

## ----dataframe_preparing function---------------------------------------------
df_prepare <- function(df) {
    # Remove columns where all elements are the same
    df <- df[, vapply(df, function(x) length(unique(x)) > 1, logical(1))]

    # Convert columns to integer if they contain different types of strings
    for (col in names(df)) {
        if (is.character(df[[col]]) && length(unique(df[[col]])) > 1) {
            df[[col]] <- as.integer(as.factor(df[[col]]))
        }
    }
    return(df)
}

## ----linear-bci---------------------------------------------------------------
# Calculate stability with linearPred
stability_BCI_linear <- betaStability(
    comtable = BCI,
    envmeta = BCI.env[, c("Precipitation", "Elevation", "EnvHet")],
    method = "linearPred"
)

# Inspect the result
head(stability_BCI_linear)
length(stability_BCI_linear)

BCI.coords <- st_as_sf(BCI.env, coords = c("UTM.EW", "UTM.NS"), crs = 32617)
BCI.coords <- st_transform(BCI.coords, 4326)
BCI.longlat <- st_coordinates(BCI.coords)
BCI.longlat <- as.data.frame(BCI.longlat)
rownames(BCI.longlat) <- seq_len(nrow(BCI.longlat))
BCI.longlat$site <- rownames(BCI.longlat)
plotStabilityMap(stability_BCI_linear, 
                 BCI.longlat, 
                 sitenames = paste("site", rownames(BCI.longlat)),
                 elev = FALSE
                 )

## ----linear-dune--------------------------------------------------------------
data(dune)
data(dune.env)

# Inspect the data
head(dune)
head(dune.env)

# Dimensions of the datasets
cat("Dimensions of dune:", dim(dune), "\n")
cat("Dimensions of dune.env:", dim(dune.env), "\n")

# Process environmental data using df_prepare
dune.env_processed <- df_prepare(dune.env)

# Calculate stability with linearPred
stability_dune_linear <- betaStability(
    comtable = dune,
    envmeta = dune.env_processed,
    method = "linearPred"
)

# Inspect the result
head(stability_dune_linear)
length(stability_dune_linear)

## ----linear-mite--------------------------------------------------------------
data(mite)
data(mite.env)

# Inspect the data
head(mite)
head(mite.env)

# Dimensions of the datasets
cat("Dimensions of mite:", dim(mite), "\n")
cat("Dimensions of mite.env:", dim(mite.env), "\n")

# Process environmental data using df_prepare
mite.env_processed <- df_prepare(mite.env)

# Calculate stability with linearPred
stability_mite_linear <- betaStability(
    comtable = mite,
    envmeta = mite.env_processed,
    method = "linearPred"
)

# Inspect the result
head(stability_mite_linear)
length(stability_mite_linear)

## ----plot-all-linear----------------------------------------------------------
p_mite <- plotStability(stability_mite_linear)
p_mite

p_dune <- plotStability(stability_dune_linear)
p_dune

p_BCI <- plotStability(stability_BCI_linear)
p_BCI

## -----------------------------------------------------------------------------
print(sessionInfo())

