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
#12 = specialisation: from mosaic to specialised cropland
#21 = diversification: from specialised cropland to mosaic

scenario <- "ESA"
urb_thold <- "_01_urb_"

LandCover <- c("forest", "urb", "crop")

for(e in 1:length(LandCover)){
  LC <- LandCover[e]

  if (scenario == "ESA") {
  inpath2000 <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/Reclassified_", LC, "/2000/")
  inpath2015 <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/Reclassified_", LC, "/2015/")
  rcl_type <- urb_thold
  outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/Change_", LC, "/")
  region_list <- c("brazil", "canada", "central_am", "china", "east_af", "eu_east", "eu_west", "india", "indonesia", "japan", "korea", "mexico", "mideast", "north_af", "oceania", "russia", "sea", "south_af", "south_am", "stan", "turkey", "ukraine", "usa", "west_af")
  } else {
  inpath2000 = paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/", scenario, "_", LC, "/Reclassified_", LC, "/2000/")
  inpath2015 = paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/", scenario, "_", LC, "/Reclassified_", LC, "/2015/")
  rcl_type <- "_rcl_"
  outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/", scenario, "_", LC, "/Change_", LC, "/")
  region_list <- c("EAF", "NAF", "SAF", "WAF", "China", "Japan", "Korea", "EUE", "EUW", "Turkey", "Ukraine", "India", "ME", "Canada", "Mexico", "USA", "Russia", "Stan", "Brazil", "CAM", "SAM", "Indonesia", "Oceania", "SEA")
  }

  for (f in 1: length(region_list)){
    region <- region_list[f]
    region2000 <- raster(paste0(inpath2000, region, "_", LC, rcl_type, "2000.tif"))
    region2015 <- raster(paste0(inpath2015, region, "_", LC, rcl_type, "2015.tif"))

    region_change <- (region2000 * 10) + region2015
    region_change <- writeRaster(region_change, filename = paste0(outpath, scenario, "_change_", LC, rcl_type, region, "_2015.tif"), format = "GTiff", overwrite = TRUE)

  }

}
