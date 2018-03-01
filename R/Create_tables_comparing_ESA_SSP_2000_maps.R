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

  comparison_table2000 <- NULL

  ESApath <- paste0(inpath, "ESA/ESA_", LC, "/Reclassified_", LC, "/")

  urb_tholds <- c("01_urb", "02_urb", "05_urb", "01_2_urb", "01_15_urb", "008_1_urb")

  for(t in 1:length(urb_tholds)){
    urb_thold <- urb_tholds[t]

    ESA_map2000 <- raster(paste0(ESApath, "2000/", ESAregion, "_", LC, "_", urb_thold, "_2000.tif"))
    table_ESA2000 <- freq(ESA_map2000, digits = 2, merge = TRUE)
    colnames(table_ESA2000)[2] <- paste0("ESA_", urb_thold)
    comparison_table2000 <- cbind(comparison_table2000, table_ESA2000, deparse.level = 2)
  }

  SSPpath <- paste0(inpath, "Scenario_SSP2/Scenario_SSP2_", LC, "/Reclassified_", LC, "/")
  SSP_map2000 <- raster(paste0(SSPpath, "2000/", region, "_", LC, "_rcl_2000.tif"))

  table_SSP2000 <- freq(SSP_map2000, digits = 2, merge = TRUE)
  colnames(table_SSP2000)[2] <- "SSP"

  comparison_table2000 <- cbind(comparison_table2000, table_SSP2000, deparse.level = 2)
  comparison_table2000 <- comparison_table2000[, !duplicated(colnames(comparison_table2000))]

  write.csv(comparison_table2000, file = paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Figs/Comparison_SSP_ESA/Comparison_2000_", LC, ".csv"), row.names = FALSE)

}


