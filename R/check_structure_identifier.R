.check_structure_identifier <- function(structure_identifier) {

  if (
    length(structure_identifier) == 1L &&
      !is.null(structure_identifier) &&
      !is.na(structure_identifier)
  ) {
    return(TRUE)
  } else {
    return(FALSE)
  }

}
