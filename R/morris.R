#' @export
#' @import htmltools
#' @import htmlwidgets
morris <- function(x, data, ..., width = NULL, height = NULL){
  params = fixLayerMorris(getLayer(x, data, ...))
  config = params[names(params) != 'type']
  type = params$type
  opts = list(config = config, type = type, height = height, width = width)
  structure(opts, class = c('morris', 'htmlwidget'))
}


#' @export
morrisOutput <- htmlwidgets::widgetOutput('morris')