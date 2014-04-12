# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

PieChart = (css_selector, color_array)->
  width = 200
  height = 200
  radius = Math.min(width, height) / 2
  color = d3.scale.ordinal().range([
    color_array[0]
    color_array[1]
    color_array[2]
    color_array[3]
    color_array[4]
    color_array[5]
    color_array[6]
  ])
  arc = d3.svg.arc().outerRadius(radius - 10).innerRadius(0)
  pie = d3.layout.pie().sort(null).value((d) ->
    d.population
  )
  svg = d3.select(css_selector).append("svg").attr("width", width).attr("height", height).append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
  d3.csv "data.csv", (error, data) ->
    g = undefined
    data.forEach (d) ->
      d.population = +d.population
      return

    g = svg.selectAll(".arc").data(pie(data)).enter().append("g").attr("class", "arc")
    g.append("path").attr("d", arc).style "fill", (d) ->
      color d.data.age

    g.append("text").attr("transform", (d) ->
      "translate(" + arc.centroid(d) + ")"
    ).attr("dy", ".35em").style("text-anchor", "middle").text (d) ->
      d.data.age

    return

  return


showHeart = ->
  $('#heart').show(2000, 'linear')
  return

showRsvp = ->
  $('#show_me').on 'click', (event) ->
    event.preventDefault()
    $('.rsvpying').show()
    $(this).hide()
    return
showNews = ->
  $('#show_me2').on 'click', (event) ->
    event.preventDefault()
    $('.newsing').show()
    $(this).hide()
    return





ready = ->
  showRsvp()
  showNews()
  $('#heart').hide()
  $('.rsvpying').hide()
  $('.newsing').hide()
  color_one = [ "rgba(152,171,197,1)",
    "rgba(138,137,166,1)",
    "rgba(123,104,136,1)",
    "rgba(107,72,107,1)",
    "rgba(160,93,86,1)",
    "rgba(208,116,60,1)",
    "rgba(255,140,0,1)"]
  color_two = [ "rgba(107,72,107,1)",
    "rgba(160,93,86,1)",
    "rgba(208,116,60,1)",
    "rgba(152,171,197,1)",
    "rgba(138,137,166,1)",
    "rgba(123,104,136,1)",
    "rgba(255,140,0,1)"]    
  pieChart = new PieChart('.chart_one', color_one)
  pieChart2 = new PieChart('.chart_two', color_two)
  setTimeout(showHeart, 2000)
  return

$(document).ready ready
$(document).on "page:load", ready



