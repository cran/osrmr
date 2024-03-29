% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/viaroute.R
\name{viaroute}
\alias{viaroute}
\title{travel time or full information of a route}
\usage{
viaroute(
  lat1,
  lng1,
  lat2,
  lng2,
  instructions,
  api_version,
  localhost,
  timeout = 0.001
)
}
\arguments{
\item{lat1}{A numeric (-90 < lat1 < 90) -> start-destination}

\item{lng1}{A numeric (-180 < lng1 < 180) -> start-destination}

\item{lat2}{A numeric (-90 < lat2 < 90) -> end-destination}

\item{lng2}{A numeric (-180 < lng2 < 180) -> end-destination}

\item{instructions}{A logical. If FALSE, only the traveltime (in seconds, as numeric) will be returned.
If TRUE, more details of the route are returned (as list).}

\item{api_version}{A numeric (either 4 or 5)}

\item{localhost}{A logical (TRUE = localhost is used, FALSE = onlinehost is used)}

\item{timeout}{A numeric indicating the timeout between server requests (in order to prevent queue overflows). Default is 0.001s.}
}
\value{
a numeric or a list (depending on instructions)
}
\description{
For a given start- and end-destination, viaroute() calculates route informations using OSRM.
OSRM chooses the nearest point which can be accessed by car for the start- and end-destination.
The coordinate-standard is WGS84.
Attention: The OSRM API-4 is only working locally, but not with the onlinehost.
}
\examples{
# direct examples of the online API
\dontrun{
#' link <- "http://router.project-osrm.org/route/v1/driving/8.1,47.1;8.3,46.9?steps=false"
a <- rjson::fromJSON(file = link)

# example with onlinehost API5
osrmr:::viaroute(47.1, 8.1, 46.9, 8.3, FALSE, 5, FALSE)

# examples with localhost API4/API5
Sys.setenv("OSRM_PATH"="C:/OSRM_API4")
osrmr::run_server("switzerland-latest.osrm")
osrmr::viaroute(47.1, 8.1, 46.9, 8.3, FALSE, 4, TRUE)
osrmr::quit_server()
Sys.unsetenv("OSRM_PATH")

Sys.setenv("OSRM_PATH"="C:/OSRM_API5")
osrmr::run_server("switzerland-latest.osrm")
osrmr::viaroute(47.1, 8.1, 46.9, 8.3, FALSE, 5, TRUE)
osrmr::quit_server()
Sys.unsetenv("OSRM_PATH")}
}
