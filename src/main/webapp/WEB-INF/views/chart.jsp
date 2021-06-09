<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
	 <title>구글 차트 라이브러리</title>
	 	<!-- 라이브러리 Load -->
		 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		 <script type="text/javascript">
		 google.charts.load('current', {'packages':['corechart']});
		 google.charts.setOnLoadCallback(drawVisualization);
		 function drawVisualization() { 
			 /* 데이터 셋팅 */
			 var data = google.visualization.arrayToDataTable([
			 ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'], 
			 ['2004/05', 165, 938, 522, 998, 450, 614.6], 
			 ['2005/06', 135, 1120, 599, 1268, 288, 682], 
			 ['2006/07', 157, 1167, 587, 807, 397, 623], 
			 ['2007/08', 139, 1110, 615, 968, 215, 609.4], 
			 ['2008/09', 136, 691, 629, 1026, 366, 569.6] ]);
			 /* 옵션 셋팅 */
			 var options = {
			 title : 'Monthly Coffee Production by Country', vAxis: {title: 'Cups'}, hAxis: {title: 'Month'}, 
			 seriesType: 'bars', series: {4: {type: 'line'}}
			 };
			 /* 차트 그리기 */
			 var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			 chart.draw(data, options);
		 }
		 </script>
	</head>
<body>
 	<div id="chart_div" style="width:900px; height: 500px;"></div>
</body>
</html>