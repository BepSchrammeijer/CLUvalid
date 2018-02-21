#Reclassify ESA data to specified Land Cover class
#Requires alot of computing power. This was carried out on linux 64 bit computer
#Still required splitting into regions to allow processing


##
#packages and definitions
###

library(raster)
library(rgdal)

setwd("/home/bep/Surfdrive/SSP Validation/")

###
#Process:
###


#Point to folders where data is held

inpath <- "/home/bep/Surfdrive/SSP Implementation/Data prep/Input data/CLUMondo/CLUMondo model region masks/TIFS/"

#State which Land cover
LandCover <- c("crop", "forest", "urb")

#State which year
years <- c(2000, 2015)

#list CLUMondo region masks
regions <- list.files(inpath, pattern = ".tif$", full.names = TRUE)
#name with shorter names
region_name <- gsub(".*/", "", regions)

#loop through each region in list of CLUMondo region rasters
#crop ESA data to region, then reclassify and aggregate according
#keeping in mind Eckert IV is equal area projection and WGS 84 not
#therefore specific aggregation factors calculated in script
for (d in 1:length(years)){
year <- years[d]
LC_map_path <- paste0("Input/LC change/ESACCI-LC-L4-LCCS-Map-300m-P1Y-", year, "-v2.0.7.tif")

#load ESA data as raster
LC_map <- raster(LC_map_path)
#specify projection
proj4string(LC_map) <- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

  for(e in 1:length(LandCover)){
  LC <- LandCover[e]
  #Point to folder where data is to go
  outpath <- paste0("Output/Maps/LC_ESA/remap/ESA_", LC, "/", year, "/")

  #load reclass csv file
  rcl_LC <- read.csv(paste0("Input/LC change/ESA reclass_", LC, ".csv"), header = FALSE)

    for (f in 1:length(regions)){
      #load raster for region f
      region <- raster(regions[f])
      message(paste("processing", names(region), LC, year))
      #specify EckertIV projection
      proj4string(region) <- CRS("+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0")
      #project region to ESA projection, create extent object
      region_project <- projectRaster(region, crs="+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
      region_extent <- extent(region_project)

      #crop ESA map to CLUMondo region f
      region_cropped <- crop(LC_map, region_extent)
      #reclassify raster to binary (to do for each of crop, urban and forest land covers)
      region_reclass <- reclassify(region_cropped, rcl = rcl_LC)
      #reproject and write to file for reference
      region_reclass_clu_project <- projectRaster(region_reclass, region, method = "ngb", filename = paste0("Output/Maps/LC_ESA/remap/ESA_", LC, "/300m/", year, "/", names(region), "_", LC, "300m_", year, ".tif"), overwrite = TRUE)
      #calculate aggregation factors
      #by dividing number of columns ESA raster by number of columns CLUMondo raster = horizontal aggregation factor (h)
      #v = vertical
      h <- round((ncol(region_cropped)/ncol(region_project)))
      v <- round((nrow(region_cropped)/nrow(region_project)))
      #aggregate reclassified ESA region raster by calculated factors
      #using function sum to give the total original number of cells of certain landuse in each resultant cell
      region_85k <- aggregate(region_reclass, fact = c(h, v), fun = mean, expand = TRUE, na.rm = TRUE)
      message("aggregating")

      #project to CLUMondo projection, which also aligns resolution and extent
      region_clu_project <- projectRaster(region_85k, region, method = "ngb")
      #mask to CLUMondo region to ensure extent is exactly the same
      region_clu_project <- mask(region_clu_project, region, filename = (paste0(outpath, names(region), "_", LC, "_85k_", year, ".tif")), format = "GTiff", overwrite = TRUE)

      removeTmpFiles(h = 0)
      gc()
    }
  }
}
