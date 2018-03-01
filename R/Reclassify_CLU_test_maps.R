#Reclass SSP2 results for comparison with ESA

require(CLUvalid)

#define scenario
region <- "India"

Tests <- c("orig", "C", "CL", "CL1", "CL1n", "CL1w", "CL1wn", "CL1wn2", "CL1w2n2", "L", "L1", "L1w", "L1wn", "L1wn2", "L1w2n2", "n", "n2", "w", "wn", "wn2", "L3", "L3w", "L3wn", "L3wn2", "L3w2n2", "CL3wn", "C1L1w2n2", "C1L1wn2", "C1", "C2L1wn2", "C2L1n")

inpath <- "C:/Bep/Projects/CLUMondo/SSP Validation/Data prep/Tests/"
outpath <- "C:/Bep/Projects/CLUMondo/SSP Validation/Data prep/Output/Maps/Tests/"

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

  for(i in 1:length(Tests)){
  test <- Tests[i]
  region_name <- basename(test)

  region2015 <- raster(paste0(inpath, region, "/", region, "_", test, "/cov_all.15.asc"))

  rcl_LC <- get(paste0(LC, "_rcl"))

  reclass2015 <- reclassify(region2015, rcl_LC, filename = paste0(outpath, "Tests_", LC, "/Reclassified_", LC, "/2015/", region, "_", test, "_", LC, "_rcl_2015.asc"), overwrite = TRUE)

  reclass2015[reclass2015 == 1 | reclass2015 == 2] <- 1
  writeRaster(reclass2015, filename = paste0(outpath, "Tests_", LC, "/Reclassified_", LC, "/bool/", region, "_", test, "_", LC, "_bool_2015.asc"), overwrite = TRUE)
  }
}
#also create a script calculating quantities
#and adapt 'calculate change'script for tests
