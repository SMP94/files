<html>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script src = "/home/spatil/pyfiles/static/test.js"></script> 
<script>
/* $(document).ready(function () {
        $.get('http:localhost:80/check/', function (data) {
            var output = data; }
            $('#main').html(output);
	    
        });
    });

*/
%import json
%temp = json.dumps(result['hist'])
var stream = JSON.parse({{!temp}});
%end
confirm(stream);
 
        stream.forEach(function(d){ document.write(d[0] + "<br>"); } ); 
      
</script>

<div id='container'>
<div id=hist>
</div>
<div id=2tpl 'visibility=hidden'>
</div>
</div>

</html>
