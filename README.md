## Morris

This is an experimental R package that provides the [Morris](http://morrisjs.github.io/morris.js/) visualization library as a html widget for R. The implementation in this package borrows heavily from some utility functions in [rCharts](http://github.com/ramnathv/rCharts), but uses the `htmlwidgets` package to deliver the widget.

### Installation

You can install it from github

```r
pkgs <- c('rstudio/htmltools', 'ramnathv/htmlwidgets', 'ramnathv/morris')
devtools::install_github(pkgs)
```

### Usage

Here are some simple examples that you can play with.

__Line Chart__

```r
dat = data.frame(
  year = as.character(2008:2012),
  value = c(20, 10, 5, 5, 20)
)
morris(value ~ year, data = dat, type = 'Line')
```

![morris1](http://i.imgur.com/Vo5DLOq.png)

__Bar Chart__

```r
haireye = as.data.frame(HairEyeColor)
dat <- subset(haireye, Sex == "Female" & Eye == "Blue")
morris(Freq ~ Hair, data = dat, type = 'Bar', labels = list("Count"))
```

![morris2](http://i.imgur.com/1l3LnrE.png)

__MultiBar Chart__


```r
haireye = as.data.frame(HairEyeColor)
dat = subset(haireye, Sex == "Female")

morris(Freq ~ Eye, 
  group = "Hair", 
  data = dat, 
  type = "Bar", 
  labels = levels(dat$Hair),
  barColors = c('black', 'brown', 'red', '#FAF0BE')  
)
```

![morris3](http://i.imgur.com/aBgtzbU.png)

You can also use it in a Shiny app

```r
library(shiny)
library(htmlwidgets)
library(morris)

dat = data.frame(
  year = as.character(2008:2012),
  value = c(20, 10, 5, 5, 20)
)

ui = bootstrapPage(
  selectInput('type', 'Choose Type', c('Line', 'Bar')),
  textInput('units', 'Choose', 'Km'),
  morrisOutput('myplot', 600, 400)
)

server = function(input, output, session){
  output$myplot <- renderWidget({
    morris(value ~ year, data = dat, type = input$type, labels = list("Value"),
      yLabelFormat = sprintf("function(y){return y.toString() + ' %s'}", 
        input$units)       
    )
  })
}

runApp(list(ui = ui, server = server))
```

