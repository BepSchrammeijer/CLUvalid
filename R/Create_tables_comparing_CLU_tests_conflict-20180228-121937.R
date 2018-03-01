#To make a table showing numeric comparison different test results

#for reclassified maps
#start with comparing urban

#load maps
region <- "India"
ESAregion <- "india"
Tests <- c("C")

inpath <- "C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/"


LandCover <- c("forest", "urb", "crop")
#LandCover <- "urb"


for(e in 1:length(LandCover)){
  LC <- LandCover[e]

  d <- c(0, 1, 2, 3)
  comparison_table <- matrix(d, nrow = 4, ncol = 1, byrow = TRUE)

  ESApath <- paste0(inpath, "ESA/ESA_", LC, "/Reclassified_", LC, "/")

  urb_tholds <- c("_01_urb", "_02_urb", "_05_urb")

  for(t in 1:length(urb_tholds)){
    urb_thold <- urb_tholds[t]

    ESA_map2000 <- raster(paste0(ESApath, "2000/", ESAregion, "_", LC, urb_thold, "_2000.tif"))
    table_ESA2000 <- freq(ESA_map2000, digits = 2, merge = TRUE)
    colnames(table_ESA2000) <- urb_thold
    comparison_table <- cbind(comparison_table, table_ESA2000[ ,2], deparse.level = 1)
  }

  SSPpath <- paste0(inpath, "Scenario_SSP2/Scenario_SSP2_", LC, "/Reclassified_", LC, "/")
  SSP_map2000 <- raster(paste0(SSPpath, "2000/", region, "_", LC, "_rcl_2000.tif"))

  table_SSP2000 <- freq(SSP_map2000, digits = 2, merge = TRUE)

  comparison_table <- cbind(comparison_table, table_SSP2000[ ,2])

  #comparison_table <- write.csv(comparison_table, file = paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Figs/Comparison_SSP_ESA/Comparison_", LC, ".csv"))

}


