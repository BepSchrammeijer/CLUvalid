#'List the locations of the CLU folders
#so that new files can be placed in them
#or so that the results can be used for global results

#'@param x the path to the folder containing the scenario folder
#'@param y the scenario name
#'@return The locations of the folders as a list
#'@examples
#' CLU_folders <- list_CLU_folders(inpath = "C:/Bep/Projects/CLUMondo/SSP Implementation/Scenario_", scenario = "SSP2")
#'
#'neighmat <- "C:/Bep/Projects/CLUMondo/Model documentation/Model_codes_templates/neighmat.txt"
#'
#'for(i in 1:length(CLU_folders)){
#'  folder <- CLU_folders[i]
#'
#'  file.copy(alloc2, folder, overwrite = TRUE)
#'}

list_CLU_folders <- function(inpath, scenario){
  EAF <- paste0 (inpath, scenario, "/Africa/EAF/")
  NAF <- paste0 (inpath, scenario, "/Africa/NAF/")
  SAF <- paste0 (inpath, scenario, "/Africa/SAF/")
  WAF <- paste0 (inpath, scenario, "/Africa/WAF/")
  China <- paste0 (inpath, scenario, "/China+/China/")
  Japan <- paste0 (inpath, scenario, "/China+/Japan/")
  Korea <- paste0 (inpath, scenario, "/China+/Korea/")
  EUE <- paste0 (inpath, scenario, "/Europe/EUE/")
  EUW <- paste0 (inpath, scenario, "/Europe/EUW/")
  Turkey <- paste0 (inpath, scenario, "/Europe/Turkey/")
  Ukraine <- paste0 (inpath, scenario, "/Europe/Ukraine/")
  India <- paste0 (inpath, scenario, "/IME/India/")
  ME <- paste0 (inpath, scenario, "/IME/ME/")
  Canada <- paste0 (inpath, scenario, "/NAM/Canada/")
  Mexico <- paste0 (inpath, scenario, "/NAM/Mexico/")
  USA <- paste0 (inpath, scenario, "/NAM/USA/")
  Russia <- paste0 (inpath, scenario, "/Russia_Stan/Russia/")
  Stan <- paste0 (inpath, scenario, "/Russia_Stan/Stan/")
  Brazil <- paste0 (inpath, scenario, "/SAM/Brazil/")
  CAM <- paste0 (inpath, scenario, "/SAM/CAM/")
  SAM <-  paste0 (inpath, scenario, "/SAM/SAM/")
  Indonesia <- paste0 (inpath, scenario, "/SEA/Indonesia/")
  Oceania <- paste0 (inpath, scenario, "/SEA/Oceania/")
  SEA <- paste0 (inpath, scenario, "/SEA/SEA/")

  CLU_folder_list <- c(EAF, NAF, SAF, WAF, China, Japan, Korea, EUE, EUW, Turkey, Ukraine, India, ME, Canada, Mexico, USA, Russia, Stan, Brazil, CAM, SAM, Indonesia, Oceania, SEA)
}

