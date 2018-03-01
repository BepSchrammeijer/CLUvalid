#To make a table showing numeric comparison different test results

#for reclassified maps
#start with comparing urban

library(dplyr)

#load maps
region <- "India"
ESAregion <- "india"
Tests <- c("C", "CL", "CL1", "CL1n", "CL1w", "CL1wn", "CL1wn2", "CL1w2n2", "L", "L1", "L1w", "L1wn", "L1wn2", "L1w2n2", "n", "n2", "w", "wn", "wn2", "L3", "L3w", "L3wn", "L3wn2", "L3w2n2", "CL3wn")

inpath <- "C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/"


LandCover <- c("forest", "urb", "crop")
#LandCover <- "urb"


for(e in 1:length(LandCover)){
  LC <- LandCover[e]

  comparison_table <- NULL

  ESApath <- paste0(inpath, "ESA/ESA_", LC, "/Reclassified_", LC, "/")

  urb_tholds <- c("01_urb", "02_urb", "05_urb")

  for(t in 1:length(urb_tholds)){
    urb_thold <- urb_tholds[t]

    ESA_map2015 <- raster(paste0(ESApath, "2015/", ESAregion, "_", LC, "_", urb_thold, "_2015.tif"))
    table_ESA2015 <- freq(ESA_map2015, digits = 2, merge = TRUE)
    colnames(table_ESA2015)[2] <- paste0("ESA_", urb_thold)
    comparison_table <- cbind(comparison_table, table_ESA2015, deparse.level = 2)
  }

    for(s in 1: length(Tests)){
      test <- Tests[s]

      SSPpath <- paste0(inpath, "Tests/Tests_", LC, "/Reclassified_", LC, "/")
      SSP_map2015 <- raster(paste0(SSPpath, "2015/", region, "_", test, "_", LC, "_rcl_2015.tif"))

      table_SSP2015 <- freq(SSP_map2015, digits = 2, merge = TRUE)
      colnames(table_SSP2015)[2] <- paste0("SSP2_", test)

      comparison_table <- cbind(comparison_table, table_SSP2015, deparse.level = 2)
      colnames(comparison_table)[1] <- "Value"
      r <- seq(2, 56, 2)
      comparison_table <- select(comparison_table, 1, r)

      #comparison_table <- write.table(comparison_table, file = paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Figs/Comparison_SSP_ESA/Comparison_2015_", LC, ".csv"), row.names = FALSE)
    }
}


