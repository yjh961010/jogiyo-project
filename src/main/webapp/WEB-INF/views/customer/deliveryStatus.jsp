<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center"><h2>배달상태 확인</h2>
<c:choose>
<c:when test="${delivery.run eq 0}">
	<h3>음식조리중</h3>
</c:when>
<c:when test="${delivery.run eq 1}">
	<h3>음식배달중</h3>
</c:when>
<c:when test="${delivery.run eq 2}">
	<h3>배달완료</h3>
</c:when>
</c:choose>
<div id="map" style="width: 350px; height: 350px;"></div></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${key}&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = {
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	};

	// 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var positions = [ {
		title : '배달도착지',
		address : '${delivery.destiaddress}'
	}, {
		title : '가게',
		address : '${delivery.storeaddress}'
	} ];

	positions.forEach(function(position) { //추가한 코드
				// 주소로 좌표를 검색합니다
		geocoder.addressSearch(position.address,function(result, status) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			map.setCenter(coords);
			// 정상적으로 검색이 완료됐으면
			if (status === kakao.maps.services.Status.OK) {
				for (var i = 0; i < positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var marker = new kakao.maps.Marker(
						{
							map : map, // 마커를 표시할 지도
							position : coords, // 마커를 표시할 위치
							title : positions[i].title // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						});
				}
				var infowindow = new kakao.maps.InfoWindow({
			         content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'
			        });
			        
			       infowindow.open(map, marker);
			            map.relayout();
			            map.setCenter(coords);
			}
		})
	});
</script>

<jsp:include page="../footer.jsp" />