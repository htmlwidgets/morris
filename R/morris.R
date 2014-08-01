#' @export
#' @import htmltools
#' @import htmlwidgets
morris <- function(x, data, ..., width = NULL, height = NULL){
  params = fixLayerMorris(getLayer(x, data, ...))
  config = params[names(params) != 'type']
  type = params$type
  opts = list(config = config, type = type, height = height, width = width)
  structure(opts, 
    class = c('morris', 'htmlwidget'),
    config = "lib/morris.js/config.yaml",
    jsfile = "lib/morris.js/initialize.js"
  )
}


#' @export
morrisOutput <- function(outputId, width, height){
  cx = structure(list(value = 10),
    class = c('morris', 'htmlwidget'),
    config = "lib/morris.js/config.yaml",
    jsfile = "lib/morris.js/initialize.js"
  )
  html <- htmltools::tagList(
    widget_html(cx, id = outputId, class = "morris", 
      style = sprintf("width:%dpx; height:%dpx", width, height)
    )
  )
  dependencies = widget_dependencies(cx)
  htmltools::attachDependencies(html, dependencies)
}
