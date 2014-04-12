# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(->
  
  ###
  draw the fancy line chart
  
  @param {String} elementId elementId
  @param {Array}  data      data
  ###
  drawLineChart = (elementId, data) ->
    
    # parse helper functions on top
    
    # data manipulation first
    
    # TODO code duplication check how you can avoid that
    
    # Compute the minimum and maximum date, and the maximum price.
    
    # hacky hacky hacky :(
    
    # Add the line path.
    
    # Add the area path.
    
    # Helper functions!!!
    drawCircle = (datum, index) ->
      circleContainer.datum(datum).append("circle").attr("class", "lineChart--circle").attr("r", 0).attr("cx", (d) ->
        x(d.date) + detailWidth / 2
      ).attr("cy", (d) ->
        y d.value
      ).on("mouseenter", (d) ->
        d3.select(this).attr("class", "lineChart--circle lineChart--circle__highlighted").attr "r", 7
        d.active = true
        showCircleDetail d
        return
      ).on("mouseout", (d) ->
        d3.select(this).attr("class", "lineChart--circle").attr "r", 6
        if d.active
          hideCircleDetails()
          d.active = false
        return
      ).on("click touch", (d) ->
        if d.active
          showCircleDetail d
        else
          hideCircleDetails()
        return
      ).transition().delay(DURATION / 10 * index).attr "r", 6
      return
    drawCircles = (data) ->
      circleContainer = svg.append("g")
      data.forEach (datum, index) ->
        drawCircle datum, index
        return

      return
    hideCircleDetails = ->
      circleContainer.selectAll(".lineChart--bubble").remove()
      return
    showCircleDetail = (data) ->
      details = circleContainer.append("g").attr("class", "lineChart--bubble").attr("transform", ->
        result = "translate("
        result += x(data.date)
        result += ", "
        result += y(data.value) - detailHeight - detailMargin
        result += ")"
        result
      )
      details.append("path").attr("d", "M2.99990186,0 C1.34310181,0 0,1.34216977 0,2.99898218 L0,47.6680579 C0,49.32435 1.34136094,50.6670401 3.00074875,50.6670401 L44.4095996,50.6670401 C48.9775098,54.3898926 44.4672607,50.6057129 49,54.46875 C53.4190918,50.6962891 49.0050244,54.4362793 53.501875,50.6670401 L94.9943116,50.6670401 C96.6543075,50.6670401 98,49.3248703 98,47.6680579 L98,2.99898218 C98,1.34269006 96.651936,0 95.0000981,0 L2.99990186,0 Z M2.99990186,0").attr("width", detailWidth).attr "height", detailHeight
      text = details.append("text").attr("class", "lineChart--bubble--text")
      text.append("tspan").attr("class", "lineChart--bubble--label").attr("x", detailWidth / 2).attr("y", detailHeight / 3).attr("text-anchor", "middle").text data.label
      text.append("tspan").attr("class", "lineChart--bubble--value").attr("x", detailWidth / 2).attr("y", detailHeight / 4 * 3).attr("text-anchor", "middle").text data.value
      return
    tween = (b, callback) ->
      (a) ->
        i = (interpolate = ->
          (t) ->
            a.map (datum, index) ->
              date: datum.date
              value: datum.value + b[index].value * t

        )()
        (t) ->
          callback i(t)
    parse = d3.time.format("%Y-%m-%d").parse
    data = data.map((datum) ->
      datum.date = parse(datum.date)
      datum
    )
    console.log data
    containerEl = document.getElementById(elementId)
    width = containerEl.clientWidth
    height = width * 0.4
    margin =
      top: 30
      right: 10
      left: 10

    detailWidth = 98
    detailHeight = 55
    detailMargin = 10
    container = d3.select(containerEl)
    svg = container.select("svg").attr("width", width).attr("height", height + margin.top)
    x = d3.time.scale().range([
      0
      width - detailWidth
    ])
    xAxis = d3.svg.axis().scale(x).ticks(8).tickSize(-height)
    xAxisTicks = d3.svg.axis().scale(x).ticks(16).tickSize(-height).tickFormat("")
    y = d3.scale.linear().range([
      height
      0
    ])
    yAxisTicks = d3.svg.axis().scale(y).ticks(12).tickSize(width).tickFormat("").orient("right")
    area = d3.svg.area().interpolate("linear").x((d) ->
      x(d.date) + detailWidth / 2
    ).y0(height).y1((d) ->
      y d.value
    )
    line = d3.svg.line().interpolate("linear").x((d) ->
      x(d.date) + detailWidth / 2
    ).y((d) ->
      y d.value
    )
    startData = data.map((datum) ->
      date: datum.date
      value: 0
    )
    circleContainer = undefined
    x.domain [
      data[0].date
      data[data.length - 1].date
    ]
    y.domain [
      0
      d3.max(data, (d) ->
        d.value
      ) + 700
    ]
    svg.append("g").attr("class", "lineChart--xAxisTicks").attr("transform", "translate(" + detailWidth / 2 + "," + height + ")").call xAxisTicks
    svg.append("g").attr("class", "lineChart--xAxis").attr("transform", "translate(" + detailWidth / 2 + "," + (height + 7) + ")").call xAxis
    svg.append("g").attr("class", "lineChart--yAxisTicks").call yAxisTicks
    svg.append("path").datum(startData).attr("class", "lineChart--areaLine").attr("d", line).transition().duration(DURATION).delay(DURATION / 2).attrTween("d", tween(data, line)).each "end", ->
      drawCircles data
      return

    svg.append("path").datum(startData).attr("class", "lineChart--area").attr("d", area).transition().duration(DURATION).attrTween "d", tween(data, area)
    return
  
  ###
  draw the fancy pie chart
  
  @param {String} elementId elementId
  @param {Array}  data      data
  ###
  drawPieChart = (elementId, data) ->
    
    # TODO code duplication check how you can avoid that
    drawChartCenter = ->
      centerContainer = pie.append("g").attr("class", "pieChart--center")
      centerContainer.append("circle").attr("class", "pieChart--center--outerCircle").attr("r", 0).attr("filter", "url(#pieChartDropShadow)").transition().duration(DURATION).delay(DELAY).attr "r", radius - 60
      centerContainer.append("circle").attr("id", "pieChart-clippy").attr("class", "pieChart--center--innerCircle").attr("r", 0).transition().delay(DELAY).duration(DURATION).attr("r", radius - 55).attr "fill", "#fff"
      return
    drawDetailedInformation = (data, element) ->
      bBox = element.getBBox()
      infoWidth = width * 0.3
      if (bBox.x + bBox.width / 2) > 0
        infoContainer = detailedInfo.append("g").attr("width", infoWidth).attr("transform", "translate(" + (width - infoWidth) + "," + (bBox.height + bBox.y) + ")")
        anchor = "end"
        position = "right"
      else
        infoContainer = detailedInfo.append("g").attr("width", infoWidth).attr("transform", "translate(" + 0 + "," + (bBox.height + bBox.y) + ")")
        anchor = "start"
        position = "left"
      infoContainer.data([data.value * 100]).append("text").text("0 %").attr("class", "pieChart--detail--percentage").attr("x", ((if position is "left" then 0 else infoWidth))).attr("y", -10).attr("text-anchor", anchor).transition().duration(DURATION).tween "text", (d) ->
        i = d3.interpolateRound(+@textContent.replace(/\s%/g, ""), d)
        (t) ->
          @textContent = i(t) + " %"
          return

      infoContainer.append("line").attr("class", "pieChart--detail--divider").attr("x1", 0).attr("x2", 0).attr("y1", 0).attr("y2", 0).transition().duration(DURATION).attr "x2", infoWidth
      infoContainer.data([data.description]).append("foreignObject").attr("width", infoWidth).attr("height", 150).append("xhtml:body").attr("class", "pieChart--detail--textContainer " + "pieChart--detail__" + position).html data.description
      return
    containerEl = document.getElementById(elementId)
    width = containerEl.clientWidth
    height = width * 0.4
    radius = Math.min(width, height) / 2
    container = d3.select(containerEl)
    svg = container.select("svg").attr("width", width).attr("height", height)
    pie = svg.append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
    detailedInfo = svg.append("g").attr("class", "pieChart--detailedInformation")
    twoPi = 2 * Math.PI
    pieData = d3.layout.pie().value((d) ->
      d.value
    )
    arc = d3.svg.arc().outerRadius(radius - 20).innerRadius(0)
    pieChartPieces = pie.datum(data).selectAll("path").data(pieData).enter().append("path").attr("class", (d) ->
      "pieChart__" + d.data.color
    ).attr("filter", "url(#pieChartInsetShadow)").attr("d", arc).each(->
      @_current =
        startAngle: 0
        endAngle: 0

      return
    ).transition().duration(DURATION).attrTween("d", (d) ->
      interpolate = d3.interpolate(@_current, d)
      @_current = interpolate(0)
      (t) ->
        arc interpolate(t)
    ).each("end", handleAnimationEnd = (d) ->
      drawDetailedInformation d.data, this
      return
    )
    drawChartCenter()
    return
  ready2 = ->
    drawPieChart "pieChart", data.pieChart
    return
  data =
    lineChart: [
      {
        date: "2006-02-22"
        label: "foo"
        value: 950
      }
      {
        date: "2006-08-22"
        label: "bar"
        value: 1000
      }
      {
        date: "2007-01-11"
        label: "baz"
        value: 700
      }
      {
        date: "2008-10-01"
        label: "boing"
        value: 534
      }
      {
        date: "2009-02-24"
        label: "loool"
        value: 1423
      }
      {
        date: "2010-12-30"
        label: "YEAH"
        value: 1222
      }
      {
        date: "2011-05-15"
        label: "Hurray"
        value: 948
      }
      {
        date: "2012-04-02"
        label: "WTF"
        value: 1938
      }
      {
        date: "2013-08-19"
        label: "OMG"
        value: 1245
      }
      {
        date: "2013-11-11"
        label: "ROFL"
        value: 888
      }
    ]
    pieChart: [
      {
        color: "red"
        description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur, doloremque dolores eaque quia labore sit facilis magni enim praesentium nihil eveniet quaerat similique est porro quisquam accusamus ut error consectetur..long para.sublime-snippet"
        title: "flowers"
        value: 0.62
      }
      {
        color: "blue"
        description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur, doloremque dolores eaque quia labore sit facilis magni enim praesentium nihil eveniet quaerat similique est porro quisquam accusamus ut error consectetur..long para.sublime-snippet"
        title: "trains"
        value: 0.38
      }
    ]

  DURATION = 1500
  DELAY = 500
  
  # drawLineChart(    'lineChart',    data.lineChart );
  
  # yeah, let's kick things off!!!
  $(document).ready ready2
  $(document).on "page:load", ready2
  return
)()