.check_representation <- function(representation) {

  if (
    length(representation) == 1L &&
      !is.null(representation) &&
      !is.na(representation)
  ) {
    if (
      representation %in% c(
        "stdinchi", "inchi", "stdinchikey", "inchikey", "smiles", "names",
        "iupac_name"
      )
    ) {
      return(TRUE)
    } else  {
      return(FALSE)
    }
  } else {
    return(FALSE)
  }

}
