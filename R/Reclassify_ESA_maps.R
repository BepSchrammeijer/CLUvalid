


require(raster)
require(rgdal)
require(CLUvalid)

#setwd("/home/bep/Surfdrive/Data prep/")
setwd("C:/Bep/Projects/CLUMondo/SSP Validation/")

inpath <- "Data prep/Output/Maps/LC_ESA/remap/"

#Regions <- c("brazil", "canada", "central_am", "china", "east_af", "eu_east", "eu_west", "india", "indonesia", "japan", "korea", "mexico", "mideast", "north_af", "oceania", "russia", "sea", "south_af", "south_am", "stan", "turkey", "ukraine", "usa", "west_af")
Regions <- c("india", "china", "west_af", "canada", "usa")

#State which Land cover
LandCover <- c("forest", "urb", "crop")

#thresholds classification
urb_thold <- "008_1_urb"
urb_t1 <- 0.008
urb_t2 <- 0.1

crop_t1 <- 0.2
crop_t2 <- 0.5

forest_t1 <- 0.4
forest_t2 <- 0.7

for (c in 1:length(Regions)){
  region <- Regions[c]

  for(e in 1:length(LandCover)){
    LC <- LandCover[e]
    #Point to folders
    inpath2000 <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/", 2000, "/")
    inpath2015 <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/", 2015, "/")
    outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/ESA/ESA_", LC, "/")

    t1 <- get(paste0(LC, "_t1"))
    t2 <- get(paste0(LC, "_t2"))

    m <- c(0, t1, 0, t1, t2, 1, t2, 1.5, 2)
    rcl_LC <- matrix(m, ncol = 3, byrow = TRUE)

    #load rasters for region for year 2000 and 2015
    region2000 <- raster(paste0(inpath2000, region, "_", LC, "_85k_2000.tif"))
    region2015 <- raster(paste0(inpath2015, region, "_", LC, "_85k_2015.tif"))

    #reclass to create a simpler map using the reclass matrix
    region2000_reclass <- reclassify(region2000, rcl_LC, filename = paste0(outpath, "Reclassified_", LC, "/2000/", region, "_", LC, "_", urb_thold, "_2000.asc"), right = FALSE, overwrite = TRUE)
    region2015_reclass <- reclassify(region2015, rcl_LC, filename = paste0(outpath, "Reclassified_", LC, "/2015/", region, "_", LC, "_", urb_thold, "_2015.asc"), right = FALSE, overwrite = TRUE)

  }
## change to cropland or forest is not direct comparable to SSP results as
#in ESA data a change to cropland in one cell could also be a change to urban. In CUMondo it is one or the other
#Therefore to correct for urban area in checking cropland change
#reclass all areas in the crop and forest maps that are also urban in the urban map to 0

urb_map2000 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_urb/Reclassified_urb/2000/", region, "_urb_", urb_thold, "_2000.asc"))
crop_map2000 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/2000/", region, "_crop_", urb_thold, "_2000.asc"))
forest_map2000 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/2000/", region, "_forest_", urb_thold, "_2000.asc"))

crop_map2000[urb_map2000 == 1| urb_map2000 == 2] <- 0
forest_map2000[urb_map2000 == 1| urb_map2000 == 2] <- 0

writeRaster(crop_map2000, filename = paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/2000/", region, "_crop_", urb_thold, "_2000.asc"), overwrite = TRUE)
writeRaster(forest_map2000, filename = paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/2000/", region, "_forest_", urb_thold, "_2000.asc"), overwrite = TRUE)

urb_map2015 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_urb/Reclassified_urb/2015/", region, "_urb_", urb_thold, "_2015.asc"))
crop_map2015 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/2015/", region, "_crop_", urb_thold, "_2015.asc"))
forest_map2015 <- raster(paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/2015/", region, "_forest_", urb_thold, "_2015.asc"))

crop_map2015[urb_map2015 == 1| urb_map2015 == 2] <- 0
forest_map2015[urb_map2015 == 1| urb_map2015 == 2] <- 0

writeRaster(crop_map2015, filename = paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/2015/", region, "_crop_", urb_thold, "_2015.asc"), overwrite = TRUE)
writeRaster(forest_map2015, filename = paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/2015/", region, "_forest_", urb_thold, "_2015.asc"), overwrite = TRUE)

urb_map2000[urb_map2000 == 1| urb_map2000 == 2] <- 1
forest_map2000[forest_map2000 == 1| forest_map2000 == 2] <- 1
crop_map2000[crop_map2000 == 1| crop_map2000 == 2] <- 1

writeRaster(urb_map2000, filename = paste0("Data prep/Output/Maps/ESA/ESA_urb/Reclassified_urb/bool/", region, "_urb_", urb_thold, "bool_2000.asc"), overwrite = TRUE)
writeRaster(crop_map2000, filename = paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/bool/", region, "_crop_", urb_thold, "bool_2000.asc"), overwrite = TRUE)
writeRaster(forest_map2000, filename = paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/bool/", region, "_forest_", urb_thold, "bool_2000.asc"), overwrite = TRUE)

urb_map2000[urb_map2015 == 1| urb_map2015 == 2] <- 1
forest_map2015[forest_map2015 == 1| forest_map2015 == 2] <- 1
crop_map2015[crop_map2015 == 1| crop_map2015 == 2] <- 1

writeRaster(urb_map2015, filename = paste0("Data prep/Output/Maps/ESA/ESA_urb/Reclassified_urb/bool/", region, "_urb_", urb_thold, "bool_2015.asc"), overwrite = TRUE)
writeRaster(crop_map2015, filename = paste0("Data prep/Output/Maps/ESA/ESA_crop/Reclassified_crop/bool/", region, "_crop_", urb_thold, "bool_2015.asc"), overwrite = TRUE)
writeRaster(forest_map2015, filename = paste0("Data prep/Output/Maps/ESA/ESA_forest/Reclassified_forest/bool/", region, "_forest_", urb_thold, "bool_2015.asc"), overwrite = TRUE)

}



