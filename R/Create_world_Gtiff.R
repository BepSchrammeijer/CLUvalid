#'Mosaic CLUMondo scenario results to world ascii

#CLUMondo results are given in yearly cov_all.# files per the 24 regions, in separate region folders
#this script takes the cov_all file for a given year from each region folder and mosaics them into one single world ascii

###########################
#packages and definitions
###########################

## Load required packages
require (raster)
require (CLUvalid)

#define year and scenario
year <- 0
scenario <- "Scenario_SSP2"


#define in- and outpaths
inpath <- paste0("C:/Bep/Projects/CLUMondo/SSP implementation/", scenario)
outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/")

file <- paste0("cov_all.", year, ".asc")

CLU_files <- list_CLU_region_files(inpath = inpath, file = file)


list_regions <- lapply(1:length(CLU_files),
function(x) {
   raster(CLU_files[x])
})

list_regions$fun <- max

world <- do.call(mosaic, list_regions)

writeRaster(world, filename = paste0(outpath, "Global_", scenario, "_year_", year), format = "GTiff", overwrite = TRUE)


