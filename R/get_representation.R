#' @title GET the Representation of a Structure Identifier from CACTUS
#' @description This function is used to GET the Representation of a structure
#'   identifier from the CACTUS Chemical Identifier Resolver API services.
#' @details If the input (\code{structure_identifier}) is an InChIKey, it needs
#'   to be prefixed with \code{"InChIKey="}, i.e.,
#'   \code{"InChIKey=RYYVLZVUVIJVGH-UHFFFAOYSA-N"} for caffeine.
#'
#'   Allowed entries for \code{representation} are: \code{"StdInChI"},
#'   \code{"InChI"}, \code{"StdInChIKey"}, \code{"InChIKey"}, \code{"SMILES"},
#'   and \code{"Names"}.
#' @param structure_identifier (Character.) The input; see Details.
#' @param representation (Character.) A character string indicating the desired
#'   output format (NOT case sensitive); see Details.
#' @return Returns the representation as (character) \code{vector}.
#' @seealso \url{https://cactus.nci.nih.gov/chemical/structure}
#' @examples \dontrun{
#' ## GET the standard InChI of caffeine
#' structure_identifier <- "caffeine"
#' representation <- "StdInChI"
#' get_representation(
#'   structure_identifier = structure_identifier,
#'   representation = representation
#' )
#' }
#' @importFrom curl curl_fetch_memory handle_setopt new_handle
#' @importFrom utils URLencode
#' @export
get_representation <- function(structure_identifier, representation) {

  if (!.check_structure_identifier(structure_identifier)) {
    return(NA_character_)
  }

  # ensure representation
  representation <- tolower(representation)

  if (!.check_representation(representation)) {
    return(NA_character_)
  }

  # transform x
  structure_identifier <- utils::URLencode(structure_identifier)
  structure_identifier <- gsub(
    pattern = "#", replacement = "%23", structure_identifier
  )
  structure_identifier <- gsub(
    pattern = "\\?", replacement = "%3F", structure_identifier
  )

  # define url base
  base_url <- "https://cactus.nci.nih.gov/chemical/structure"

  # compose url
  url <- paste(base_url, structure_identifier, representation, sep = "/")

  # create new cURL handle
  handle <- curl::new_handle()

  # specify GET request
  curl::handle_setopt(handle, customrequest = "GET")

  # retrieve results
  result <- curl::curl_fetch_memory(url, handle)

  # check status
  if (result$status_code != 200L) {
    warning(
      "Sorry, your structure identifier could not be resolved.",
      call. = FALSE
    )
    return(NA_character_)
  }

  # transform content
  content <- rawToChar(result$content)

  if (representation == "names" && grepl(pattern = "\n", content)) {
    content <- unlist(strsplit(content, split = "\n"), use.names = FALSE)
  }

  # return content
  content

}
