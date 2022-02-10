#' @importFrom curl curl_fetch_memory handle_setopt new_handle
#' @importFrom utils URLencode
#' @export
get_resolved_id <- function(x, out) {

  if (missing(x)) {
    warning("Invalid input.", call. = FALSE)
    return(NA_character_)
  }

  x <- utils::URLencode(x)
  x <- gsub(pattern = "#", replacement = "%23", x)
  x <- gsub(pattern = "\\?", replacement = "%3F", x)

  out <- tolower(out)

  if (out == "inchikey") {
    out <- "stdinchikey"
  }

  if (out == "inchi") {
    out <- "stdinchi"
  }

  if (missing(out) || !(out %in%
        c("stdinchikey", "stdinchi", "smiles", "iupac_name"))) {
    warning("Invalid or unsupported output format.", call. = FALSE)
    return(NA_character_)
  }

  base_url <- "https://cactus.nci.nih.gov/chemical/structure"

  url <- paste(base_url, x, out, sep = "/")

  handle <- curl::new_handle()

  curl::handle_setopt(handle, customrequest = "GET")

  result <- curl::curl_fetch_memory(url, handle)

  if (result$status_code != 200L) {
    warning("Not found.", call. = FALSE)
    return(NA_character_)
  }

  content <- rawToChar(result$content)

  content

}
