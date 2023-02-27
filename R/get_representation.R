#' @title GET the Representation of a Structure Identifier from CACTUS
#' @description This function is used to GET the Representation of a structure
#'   identifier from the CACTUS Chemical Identifier Resolver API services.
#' @details If the input (\code{structure_identifier}) is an InChIKey, it needs
#'   to be prefixed with \code{"InChIKey="}, i.e.,
#'   \code{"InChIKey=RYYVLZVUVIJVGH-UHFFFAOYSA-N"} for caffeine.
#'
#'   Allowed entries for \code{representation} are: \code{"StdInChI"},
#'   \code{"InChI"}, \code{"StdInChIKey"}, \code{"InChIKey"}, \code{"SMILES"},
#'   \code{"Names"} or \code{"IUPAC_Name"}.
#' @param structure_identifier (Character.) The input; see Details.
#' @param representation (Character.) A character string indicating the desired
#'   output format (NOT case sensitive); see Details.
#' @param xml (Logical.) Should the result be returned as XML string? Defaults
#'   to \code{FALSE}.
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
#' @importFrom XML xmlParse xmlToList
#' @export
get_representation <- function(
    structure_identifier, representation, xml = FALSE
  ) {

  if(!.check_structure_identifier(structure_identifier)) {
    return(NA_character_)
  }

  # ensure representation
  representation <- tolower(representation)

  if(!.check_representation(representation)) {
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

  # define format
  format <- "xml"

  # compose url
  url <- paste(
    base_url, structure_identifier, representation, format,
    sep = "/"
  )

  # create new cURL handle
  handle <- curl::new_handle()

  # specify GET request
  curl::handle_setopt(handle, customrequest = "GET")

  # retrieve results
  result <- curl::curl_fetch_memory(url, handle)

  # transform content
  content <- rawToChar(result$content)

  # check status
  if(result$status_code != 200L) {
    if(xml) {
      return(content)
    } else {
      content <- XML::xmlParse(content)
      content <- XML::xmlToList(content)
      warning(content, call. = FALSE)
      return(NA_character_)
    }
  }

  if(!xml) {
    # transform content
    content <- XML::xmlParse(content)
    content <- XML::xmlToList(content, addAttributes = FALSE, simplify = TRUE)
    content <- unique(as.vector(content, mode = "character"))

    # account for missing values
    content <- sapply(
      content,
      FUN = function(x) {
        if(x == "\n\n") {
          NA_character_
        } else {
          x
        }
      },
      USE.NAMES = FALSE
    )
  }

  # return content
  content

}
