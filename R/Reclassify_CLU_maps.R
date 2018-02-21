#Reclass SSP2 results for comparison with ESA

require(CLUvalid)

#define scenario
scenario <- "Scenario_SSP2"

outpath <- "Data prep/Output/Maps/Scenario_SSP2/"

LandCover <- c("forest", "urb", "crop")

#create the reclass matrices
u <- c(0, 21, 0, 21, 22, 1, 22, 24, 2)
urb_rcl <- matrix(u, ncol = 3, byrow = TRUE)

c <- c(0, 5, 2, 5, 12, 1, 12, 24, 0)
crop_rcl <- matrix(c, ncol = 3, byrow = TRUE)

f <- c(0, 12, 0, 12, 13, 2, 13, 14, 1, 14, 24, 0)
forest_rcl <- matrix(f, ncol = 3, byrow = TRUE)

for(e in 1:length(LandCover)){
  LC <- LandCover[e]

  CLU_folders <- list_CLU_folders(inpath = "C:/Bep/Projects/CLUMondo/SSP Implementation/Scenario_", scenario = "SSP2")

  for(i in 1:length(CLU_folders)){
  region <- CLU_folders[i]
  region_name <- basename(region)

  region2000 <- raster(paste0(region, "cov_all.0.asc"))
  region2015 <- raster(paste0(region, "cov_all.15.asc"))

  rcl_LC <- get(paste0(LC, "_rcl"))

  reclass2000 <- reclassify(region2000, rcl_LC, filename = paste0(outpath, "SSP2_", LC, "/Reclassified_", LC, "/2000/", region_name, "_", LC, "_rcl_2000.tif"), right = FALSE, overwrite = TRUE)
  reclass2015 <- reclassify(region2015, rcl_LC, filename = paste0(outpath, "SSP2_", LC, "/Reclassified_", LC, "/2015/", region_name, "_", LC, "_rcl_2015.tif"), right = FALSE, overwrite = TRUE)

  }
}
