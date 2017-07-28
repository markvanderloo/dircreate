#' Alternatief voor dir.create
#'
#' @param path character vector containing a single path name. Tilde expansion (see path.expand) is done.
#' @param showWarnings logical; should the warnings on failure be shown?
#' @param recursive	logical. Should elements of the path other than the last be created? If true, like the Unix command mkdir -p.
#' @param mode the mode to be used on Unix-alikes: it will be coerced by as.octmode. For Sys.chmod it is recycled along paths.
#'
#' @export
dir.create <- function(path,showWarnings=TRUE, recursive=FALSE,mode="0777"){
  if(!recursive) {
    return( invisible(
      base::dir.create(path=path, showWarnings=showWarnings, recursive=FALSE, mode=mode) ))
  } else {
    # expandeer pad (inclusief ~)
    p <- normalizePath(path, mustWork = FALSE)
    # Uitrekenen welke onderdelen nog gemaakt moeten worden
    cr <- character(0)
    while( p != basename(p) && !dir.exists(p) ){
      cr <- c(basename(p),cr)
      p <- dirname(p)
    }
    # stap voor stap aanmaken
    for ( dir in cr ){
      p <- file.path(p,dir)
      base::dir.create(p,showWarnings=showWarnings,recursive=FALSE, mode=mode)
    }
    invisible(dir.exists(path))
  }
}



