<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>		
	 	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		 <title>구글 차트 라이브러리</title>
	</head>
	<body>
		<div>
			<select id="dept">
				<c:forEach items="${dept}" var="d">					
						<option value="${d}">${d}</option>					
				</c:forEach>
			</select>
		</div>		
		<div id="chart_div" style="width:900px; height: 500px;"></div>
		<hr/>
		<div id="chart_div2" style="width:900px; height: 500px;"></div>
	</body>
	<script>	
		$("#dept").on("change",function(){
			drawVisualization();
		});
		//차트1
		 google.charts.load('current', {'packages':['corechart']});
		 google.charts.setOnLoadCallback(drawVisualization);
		 function drawVisualization() { 
			 var dept=$("#dept").val();
			 $.ajax({
				 type:"get",
				 url:"students.json",
				 dataType:"json",
				 data:{"dept":dept},
				 success:function(result){
					 /* 데이터 셋팅 */
					 var data = google.visualization.arrayToDataTable(result);
					 /* 옵션 셋팅 */
					 var options = {
						 title : '학생별 평균점수',						 
						 hAxis: {title: '학생'},
						 seriesType: 'bars'
					 };
					 /* 차트 그리기 */
					 var chart = new google.visualization.ComboChart(
							 document.getElementById('chart_div'));
					 chart.draw(data, options);
				 }
			 });			
		 }
		//차트2
		 google.charts.load('current', {'packages':['corechart']});
		 google.charts.setOnLoadCallback(drawVisualization2);
		 function drawVisualization2() { 
			 $.ajax({
				 type:"get",
				 url:"courses.json",
				 dataType:"json",
				 success:function(result){
					 /* 데이터 셋팅 */
					 var data = google.visualization.arrayToDataTable(result);
					 /* 옵션 셋팅 */
					 var options = {
						 title : '강좌별 평균점수',						 
						 hAxis: {title: '강좌'},
						 seriesType: 'bars'
					 };
					 /* 차트 그리기 */
					 var chart = new google.visualization.ComboChart(
							 document.getElementById('chart_div2'));
					 chart.draw(data, options);
				 }
			 });			
		 }
	</script>
</html>