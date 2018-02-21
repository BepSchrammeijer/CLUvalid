#Reclass SSP2 results for comparison with ESA

require(CLUvalid)

#define scenario
Tests <- c()

path <- "C:/Bep/Projects/CLUMondo/SSP Validation/Data prep/Output/Maps/Tests/"

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

  region2015 <- raster(paste0(path, test, "/cov_all.15.asc"))

  rcl_LC <- get(paste0(LC, "_rcl"))

  reclass2015 <- reclassify(region2015, rcl_LC, filename = paste0(outpath, scenario, "_", LC, "/Reclassified_", LC, "/2015/", region_name, "_", LC, "_rcl_2015.tif"), overwrite = TRUE)

  }
}
#need to adapt still to structure of test regions eg - test regions in diff folders, then subdivided into tests, or vice versa. And
#where do the results go ie reclassified and change
#also create a script calculating quantities
#and adapt 'calculate change'script for tests
