#Mosaic the regions created in reclassification to world raster
##check year, inpath and filename writeRAster carefullyl!


###
#packages and definitions
###


type <- "Change_"
LandCover <- c("forest", "urb", "crop")
scenario <- "ESA"
year <- 2015
urb_thold <- "02_urb"


for(e in 1:length(LandCover)){
  LC <- LandCover[e]
  #define in- and outpaths
  inpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/", scenario, "_", LC, "/", type, LC, "/")

  outpath <- paste0("C:/Bep/Projects/CLUMondo/SSP validation/Data prep/Output/Maps/", scenario, "/Global_change/")



  all_regions <- list.files(inpath, pattern = urb_thold, full.names = TRUE)
  list_regions <- lapply(1:length(all_regions),
  function(x) {
    raster(all_regions[x])
  })

  list_regions$fun <- max

  world <- do.call(mosaic, list_regions)

  writeRaster(world, filename = paste0(outpath, "Global_", type, LC, "_", urb_thold, "_", scenario, "_", year, ".tif"), format = "GTiff", overwrite = TRUE)
}
