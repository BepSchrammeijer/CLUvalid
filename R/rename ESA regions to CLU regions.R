

Regions <- c("brazil", "canada", "central_am", "china", "east_af", "eu_east", "eu_west", "india", "indonesia", "japan", "korea", "mexico", "mideast", "north_af", "oceania", "russia", "sea", "south_af", "south_am", "stan", "turkey", "ukraine", "usa", "west_af")

LandCover <- c("forest", "urb", "crop"

for(e in 1:length(LandCover)){
 LC <- LandCover[e]
 #Point to folders
 inpath2000 <- paste0("Data prep/Output/Maps/LC_ESA/ESA_", LC, "/", 2000, "/")
 inpath2015 <- paste0("Data prep/Output/Maps/LC_ESA/ESA_", LC, "/", 2015, "/")

 #load rasters for region for year 2000 and 2015
 region2000 <- raster(paste0(inpath2000, region, "_", LC, "_85k_2000.tif"))
 region2015 <- raster(paste0(inpath2015, region, "_", LC, "_85k_2015.tif"))
