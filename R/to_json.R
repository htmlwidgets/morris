#' @export
#' @import RJSONIO
to_json = function(df, orient = "columns", json = TRUE){
  dl = as.list(df)
  dl = switch(orient, 
    columns = dl,
    records = do.call('zip_vectors_', dl),
    values = do.call('zip_vectors_', setNames(dl, NULL))
  )
  if (json){
    dl = RJSONIO::toJSON(dl)
  }
  return(dl)
}

# ORIENTATION
# columns  {"x":[1,2],"y":["a","b"]}
# records [{"x":1,"y":"a"},{"x":2,"y":"b"}]
# values  [[1,"a"],[2,"b"]]

zip_vectors_ = function(..., names = F){
  x = list(...)
  y = lapply(seq_along(x[[1]]), function(i) lapply(x, pluck_(i)))
  if (names) names(y) = seq_along(y)
  return(y)
}

pluck_ = function (element){
  function(x) x[[element]]
}
