#' S3 Method to get  layer
#' 
#' @importFrom lattice latticeParseFormula
#' @keywords internal
#' @noRd
#' @examples
#' getLayer(mpg ~ wt, data = mtcars)
#' getLayer('mpg', 'wt', data = mtcars, color = 'cyl')
getLayer <- function(x, ...){
  UseMethod('getLayer')
}

getLayer.formula <- function(x, data, ...){
  fml = lattice::latticeParseFormula(x, data = data)
  params_ = list(x = fml$right.name, y = fml$left.name, 
    data = data, ...)
  fixLayer(params_) 
}

getLayer.default <- function(x, y, data, ...){
  params_ = list(x = x, y = y, data = data, ...)
  fixLayer(params_)
}

#' Fix an incomplete layer by adding relevant summaries and modifying the data
#' 
#' @keywords internal
#' @noRd
#' 
fixLayer <- function(params_){
  if (length(params_$y) == 0){
    variables = c(params_$x, params_$group)
    params_$data = count(params_$data, variables[variables != ""])
    params_$y = 'freq'
  }
  return(params_)
}

#' @importFrom plyr rename
fixLayerMorris = function(params_){
  require(reshape2)
  if (!is.null(params_$group)){
    fml = as.formula(paste("...", "~", params_$group))
    y = params_$y
    params_$y = unique(params_$data[[params_$group]])
    params_$data = dcast(params_$data, fml, value.var = y)
    params_$group = NULL
  }
  params_ = plyr::rename(params_, c("x" = "xkey", "y" = "ykeys"))
  params_$labels = as.list(params_$labels %||% params_$y)
  params_$data = to_json(params_$data, orient = "records", json = FALSE)
  params_$ykeys = as.list(params_$ykeys)
  return(params_)
}

`%||%` <- function(x, y){
  if (is.null(x)) y else x
}