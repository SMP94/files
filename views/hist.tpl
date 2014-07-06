<html>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<body>
<form action="/login">
    <input type="submit" value="LOGIN">
</form>
<script>

function print()
{
    $(document).ready(function(){
        $.get('http://localhost:80/check', function(result){

           
	   result = JSON.parse(result);
	   //d3.json(result,function(error, data){
		//document.write(data); }); 
	   //result = btoa(result);
	   
	   var t = Object.keys(result);
	      alert("successs");
            $('#main').html(result);
	    document.write(result);	
        });
    });
}

var margin = {top: 40, right: 20, bottom: 70, left: 40},
    width = 3000 - margin.left - margin.right,
    height = 1000 - margin.top - margin.bottom;
// Parse the date / time
//var	parseDate = d3.time.format("%Y-%m").parse;
 
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

var url='http://localhost:8080/givemethehash/'+hash
d3.json(url, function(error, data){
	//data.forEach(function(d){ document.write(d + "<br>"); } ); 
	var key = Object.keys(data); 
	data.forEach(function(d) { 
	d[1] = +d[1]; }) 	
	
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
      .style("text-anchor", "end")
      //.text("OPCODES");
 
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
})
//print();

</script>
</body>
</html>
