#' Start local OSRM server
#'
#' run_server() starts your local OSRM server by using a shell command (depending on
#' your OS). A local (pre-built) version of the OSRM-engine must be on your device.
#' (https://github.com/Project-OSRM/osrm-backend/wiki/Building-OSRM).
#'
#' @param map_name A character (name of your pre-built map - e.g. "switzerland-latest.osrm")
#' @param osrm_path A string pointing to your local OSRM installation. Default is the environment variable "OSRM_PATH".
#'
#' @return error_code A character
#' @export
#' @examples
#' \dontrun{
#' Sys.setenv("OSRM_PATH"="C:/OSRM_API4")
#' osrmr::run_server("switzerland-latest.osrm")
#' # 0
#' Sys.setenv("OSRM_PATH"="C:/OSRM_API5")
#' osrmr::run_server("switzerland-latest.osrm")
#' # 0
#' Sys.unsetenv("OSRM_PATH")}
run_server <- function(map_name, osrm_path = Sys.getenv("OSRM_PATH")){
  wd <- getwd()
  setwd(osrm_path)

  if (.Platform$OS.type == "windows") {
    error_code <- shell(paste0("osrm-routed ", map_name, " >nul 2>nul"), wait = F)
  } else {
    error_code <- system(paste0(
      osrm_path, "osrm-routed ", map_name), wait = F)
  }

  Sys.sleep(3) # OSRM needs time
  setwd(wd)
  return(error_code)
}

#' Quit local OSRM server
#'
#' quit_server() quits your local OSRM server by using a taskkill shell command (depending on
#' your OS).
#'
#' @return NULL
#' @export
#' @examples
#' \dontrun{
#' osrmr::quit_server()
#' # NULL}
quit_server <- function() {
  if (.Platform$OS.type == "windows") {
    shell("TaskKill /F /IM osrm-routed.exe >nul 2>nul")
  } else {
    system("pkill osrm-routed")
  }
  return(NULL)
}


#' server_address() returns the URL address of the OSRM localhost or OSRM webserver,
#' depending on the value of the variable 'use_localhost'.
#' This is an internal function. The address is used as a part of a OSRM server-request.
#'
#' @param use_localhost A logical, indicating whether to use the localhost or not.
#'
#' @return character, the address of an OSRM server
#'
#' @examples
#' osrmr:::server_address(TRUE)
#' # [1] "http://localhost:5000"
#' osrmr:::server_address(FALSE)
#' # [1] "http://router.project-osrm.org"
server_address <- function(use_localhost) {
  if (use_localhost == T) {
    address <- "http://localhost:5000"
  } else {
    address <- "http://router.project-osrm.org"
  }
  return(address)
}
