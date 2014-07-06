<html>
<script src="http://d3js.org/d3.v3.min.js"></script>
<body>
%for key in hash:
   <table>
   <tr>
   <td>{{key}}</td>
   <td><button type="button" onclick="javascript:location.href='http://localhost/getData/{{key}}'" name = "button">Visualize"</button></td>
   </tr>
   </table>
%end

</body>
</html>
