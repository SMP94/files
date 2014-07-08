function look()
{
confirm("srGSG");
}

function histogram(data, tab)   
{
    
   // $(tab).empty();
    var margin = {top: 40, right: 20, bottom: 70, left: 40},
        width = 3000 - margin.left - margin.right,
        height = 1000 - margin.top - margin.bottom;

    var x = d3.scale.ordinal().rangeRoundBands([0, width], .06);

    var y = d3.scale.linear().range([height, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");


    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")
        .ticks(10);

    var svg = d3.select("body").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", 
              "translate(" + margin.left + "," + margin.top + ")");

        data.forEach(function(d) { d[1] = +d[1];
        });

      x.domain(data.map(function(d) { return d[0]; }));
      y.domain([0, d3.max(data, function(d) { return d[1]; })]);

      svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis)
          .selectAll("text")
          .style("text-anchor", "end")
          .attr("dx", "-.8em")
          .attr("dy", "-.95em")
          .attr("transform", "rotate(-90)" )
          .style("text-anchor", "end");

      svg.append("g")
          .attr("class", "y axis")
          .call(yAxis)
          .append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Calls(base10)");

      svg.selectAll("bar")
          .data(data)
          .enter().append("rect")
          .style("fill", "steelblue")
          .attr("x", function(d) { return x(d[0]); })
          .attr("width", x.rangeBand())
          .attr("y", function(d) { return y(d[1]); })
          .attr("height", function(d) { return height - y(d[1]); });
}
