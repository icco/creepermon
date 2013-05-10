(function() {
  var margin = {top: 20, right: 10, bottom: 20, left: 10};
  var width = 960 - margin.left - margin.right;
  var height = 500 - margin.top - margin.bottom;

  d3.selectAll('.graph').each(function() {
    var svg = d3.select(this).append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scale.linear()
        .range([0, width]);

    var y = d3.scale.linear()
          .range([height, 0]);

  var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

  var yAxis = d3.svg.axis()
    .scale(y)
    .orient("right");

  svg.append("g")
        .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
                .call(xAxis);

  svg.append("g")
        .attr("class", "y axis")
            .attr("transform", "translate(" + width + ",0)")
                .call(yAxis);


  });
})();
