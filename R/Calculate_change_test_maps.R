#Calculate change

#same as for ESA, but need to call regions differently

#year 2000 map is multiplied by 10 and added to 2015
#thus:
#0 = not specified land cover in year 2000 or 2015
#1 = expansion: changed to specified land system in year 2015 (mosaic, peri-urban, open forest)
#2 = expansion: change to specified land system in year 2015 (cropland, urban, dense forest)
#10 = contraction: change from specified land system in year 2015 (mosaic, peri-urban, open forest)
#20 = contraction: change from specified land system in year 2015 (cropland, urban, dense forest)
#11 = stable: stays the same land system (mosaic, peri-urban, open forest)
#22 = stable: stays the same land system (cropland, urban, dense forest)
#12 = specialisation: eg. from mosaic to specialised cropland
#21 = diversification: eg. from specialised cropland to mosaic

region <- "India"
#Tests <- c("C", "CL", "CL1", "CL1n", "CL1w", "CL1wn", "CL1wn2", "L", "L1", "L1w", "L1wn", "L1wn2", "n", "n2", "w", "wn", "wn2")
Tests <- c("C2L1n")

LandCover <- c("forest", "urb", "crop")

for(e in 1:length(LandCover)){
  LC <- LandCover[e]

  for(i in 1:length(Tests)){
    test <- Tests[i]
    inpath2000 <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/Scenario_SSP2/Scenario_SSP2_", LC, "/Reclassified_", LC, "/2000/")
    inpath2015 <- paste0("C:/Bep/Projects/CLUMondo/SSP Validation/Data prep/Output/Maps/Tests/Tests", "_", LC, "/Reclassified_", LC, "/2015/")
    outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP Validation/Data prep/Output/Maps/Tests/Tests", "_", LC, "/Change_", LC, "/")


    region2000 <- raster(paste0(inpath2000, region, "_", LC, "_rcl_2000.tif"))
    region2015 <- raster(paste0(inpath2015, region, "_", test, "_", LC, "_rcl_2015.tif"))

    region_change <- (region2000 * 10) + region2015
    region_change <- writeRaster(region_change, filename = paste0(outpath, "Scenario_SSP2_change_", LC, "_", region, "_", test, "_2015.tif"), format = "GTiff", overwrite = TRUE)
  }

}
