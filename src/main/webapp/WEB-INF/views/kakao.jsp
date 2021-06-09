<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript"
 			src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=68f88f64fe07e6432241f07dd216951a"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>카카오검색 API</title>
	<style>
		#header { 
			 overflow: hidden;
			 background: #F18C7E; 
			 color: white;
			 padding: 15px 0px 15px 30px;
		}
		.left-item{ 
		 	float: left;
		 	width:200px;
		 	cursor:pointer;
		}
		#divMap { width:800px;
			 height:230px; 
			 background:#EAEAEA; 
			 border:1px solid green; 
			 margin:auto;}
		 #map{ width:800px; height:500px; }
		 .document {cursor:pointer;}
	</style>
</head>
<body>
	<!-- 메뉴바 ---------------------------------------------------------------->
	<div id="header">
		<div class="left-item" id="book">도서검색</div>
		<div class="left-item" id="local">지역검색</div>
	</div>
	<div id="divBook"></div>
	<script id="temp" type="text/x-handlebars-template">
	<div class="row">
	{{#each documents}}	
	  <div class="col-sm-6 col-md-4" style="width:200px;">
	    <div class="thumbnail">
	      <img src="{{thumbnail}}" alt="{{title}}" width=150>
	      <div class="caption">
	        <h3>{{title}}</h3>
	        <p>{{contents}}</p>
	      </div>
	    </div>
	  </div>
	{{/each}}
	</div>
	</script>
	<!-- ------------------------------------- -->
	<div id="divLocal"></div>
	<script id="temp1" type="text/x-handlebars-template">
	<div class="panel panel-default">
  		<div class="panel-heading">
			<input type="text" placeholder="검색어" />
		</div>
  		<table class="table">
   			<tr>
				<td>Place Name</td>
				<td>Address</td>
				<td>Phone</td>
				<td>지도보기</td>
			</tr>
			{{#each documents}}
			<tr class="document" x="{{x}}" y="{{y}}">
				<td>{{place_name}}</td>
				<td>{{address_name}}</td>
				<td>{{phone}}</td>
				<td><button>지도보기</button></td>
			</tr>
			{{/each}}
  		</table>
	</div>
	</script>
	 <!-- 지도 출력 영역 ----------------------------------------->
	 <div id="divMap">
		 <div id="map"></div>
		 <div style="text-align:center;"><a id="btnClose" href="#">닫기</a></div>
	 </div>
</body>
<script>
	$("#book").on("click", function(){
		$("#divBook").show();
		$("#divLocal").hide();
		$("#divMap").hide();
	});
	
	$("#local").on("click", function(){
		$("#divBook").hide();
		$("#divLocal").show();
		$("#divMap").show();
	});
	
	$("#divLocal").on("click", ".table .document button", function(){
		 var row=$(this).parent().parent();
		 var lat=row.attr("y");
		 var lng=row.attr("x");
		 
		 var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		 //지도를 생성할 때 필요한 기본 옵션
		 var options = { 
				 center: new kakao.maps.LatLng(lat, lng), 
				 level: 3 
		 };
		 var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		 
		 var marker= new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lng) });
		 marker.setMap(map);
		 /*
		 var str ="<div style='padding:5px;font-size:12px;'>";
		 //str += place + "<br>" + tel;
		 str +="</div>";
		 var info=new kakao.maps.InfoWindow({ content:str });
		 kakao.maps.event.addListener(marker, "mouseover", function(){ info.open(map, marker); });
		 kakao.maps.event.addListener(marker, "mouseout", function(){ info.close(map, marker); });
		 */
	});
	//-----------------------------------------------------
	getList1();
	function getList1(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v2/local/search/keyword.json",
			headers:{"Authorization": "KakaoAK 696c16eaa4a3dfc09b778dd60435bb87"},
			dataType:"json",
			data:{"query":"스타벅스","page":1, "size":10},
			success:function(data){
				var temp=Handlebars.compile($("#temp1").html());
				$("#divLocal").html(temp(data));
			}
		})
	}
	//----------------------------------------------------------
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v3/search/book?target=title",
			headers:{"Authorization": "KakaoAK 696c16eaa4a3dfc09b778dd60435bb87"},
			dataType:"json",
			data:{"query":"스프링","page":1, "size":5},
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#divBook").html(temp(data));
			}
		})
	}
</script>
</html>








