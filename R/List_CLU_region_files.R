#'List the locations of CLU files
#
#

#'@param x the path to the folder containing the CLU folders
#'@param y the file name
#'@return The locations of the files as a list


list_CLU_region_files <- function(inpath, file){
  EAF <- paste0 (inpath, "/Africa/EAF/", file)
  NAF <- paste0 (inpath, "/Africa/NAF/", file)
  SAF <- paste0 (inpath, "/Africa/SAF/", file)
  WAF <- paste0 (inpath, "/Africa/WAF/", file)
  China <- paste0 (inpath, "/China+/China/", file)
  Japan <- paste0 (inpath, "/China+/Japan/", file)
  Korea <- paste0 (inpath, "/China+/Korea/", file)
  EUE <- paste0 (inpath, "/Europe/EUE/", file)
  EUW <- paste0 (inpath, "/Europe/EUW/", file)
  Turkey <- paste0 (inpath, "/Europe/Turkey/", file)
  Ukraine <- paste0 (inpath, "/Europe/Ukraine/", file)
  India <- paste0 (inpath, "/IME/India/", file)
  ME <- paste0 (inpath, "/IME/ME/", file)
  Canada <- paste0 (inpath, "/NAM/Canada/", file)
  Mexico <- paste0 (inpath, "/NAM/Mexico/", file)
  USA <- paste0 (inpath, "/NAM/USA/", file)
  Russia <- paste0 (inpath, "/Russia_Stan/Russia/", file)
  Stan <- paste0 (inpath, "/Russia_Stan/Stan/", file)
  Brazil <- paste0 (inpath, "/SAM/Brazil/", file)
  CAM <- paste0 (inpath, "/SAM/CAM/", file)
  SAM <-  paste0 (inpath, "/SAM/SAM/", file)
  Indonesia <- paste0 (inpath, "/SEA/Indonesia/", file)
  Oceania <- paste0 (inpath, "/SEA/Oceania/", file)
  SEA <- paste0 (inpath, "/SEA/SEA/", file)

  CLU_file_list <- c(EAF, NAF, SAF, WAF, China, Japan, Korea, EUE, EUW, Turkey, Ukraine, India, ME, Canada, Mexico, USA, Russia, Stan, Brazil, CAM, SAM, Indonesia, Oceania, SEA)
}

