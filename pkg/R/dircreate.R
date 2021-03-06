#' Alternative for dir.create
#'
#' This function behaves similar \code{\link[base]{dir.create}}, except that for
#' \code{recursive=TRUE} no attempt is made to (re)create existing directories.
#' This avoids a problem on Windows network drives. Use \code{base::dir.create}
#' to call the original version.
#'
#'
#' @param path character vector containing a single path name. Tilde expansion (see path.expand) is done.
#' @param showWarnings logical; should the warnings on failure be shown?
#' @param recursive	logical. Should elements of the path other than the last be created? If true, like the Unix command mkdir -p.
#' @param mode the mode to be used on Unix-alikes: it will be coerced by as.octmode. For Sys.chmod it is recycled along paths.
#'
#' @examples 
#' p <- file.path(Sys.getenv("HOME"),"foo","bar","baz")
#' # dir.create(p)
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



