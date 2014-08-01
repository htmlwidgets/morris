HTMLWidgets.widget({
  type: "output",
  name: "morris",
  initialize: function(el) {
    
  },
  renderValue: function(el, data) {
    var payload = JSONfn.parse(JSONfn.stringify(data))
    payload.config.element = el
    $(el).empty()
    var newChart = new Morris[payload.type](payload.config);
    return newChart
  }
});