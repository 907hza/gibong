<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		#volunForm button[type="button"] {
		    /* background-color: #FFCC80; */
		    color: #051922;
		    font-weight: 700;
		    text-transform: uppercase;
		    font-size: 15px;
		    /* border: none !important; */
		    cursor: pointer;
		    /* padding: 15px 25px; */
		    /* border-radius: 3px;
		    }
	    element.style {
		    height: 900px;
		}
		table{
			border:0 white;
		}
		#btnTogether button{
			float: right;   
			background-color: #FFCC80;
			color: #051922;
			font-weight: 700;
			text-transform: uppercase;
			font-size: 15px;
			border: none !important;
			cursor: pointer;
			padding: 10px 15px;
			border-radius: 3px;"
		}
	</style>
	<script>
		function fn_list(curpage)
		{
			document.bbsForm.curPage.value = curpage;
			document.bbsForm.action = "/volun/volunList";
			document.bbsForm.submit();
		}
		
		$(document).ready(function(){
			
			$("#btnUpdate").on("click", function(){
				location.href = "/volun/volunUpdate";
			});
		});
	</script>

</head>
<body>
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
     <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
               	  <p>♥ 오늘도 기봉이와 착한 일 하나 ♥</p>
                  <h1 id="font" style="color: #554838; font-size: 40px">${volun.volunTitle}</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <div class="container"><br />
   <div class="bbttnnw" style="text-align: right;">
   	<c:if test="${user.userId eq cookieUserId}" >
		<button type="button" id="btnUpdate">수정</button>
	</c:if>
		<button type="button" id="btnList" onclick="fn_list(${curPage})">리스트</button>
		<button type="button" id="btnTogether" >신청하기</button>
   </div> 
      </div>
      
      <br>
      <form name="volunForm" id="volunForm" method="post" >
      <div class="form-join d-flex justify-content-center">
         <table style="width:550px; height: 170px">
            
            <tr>
            	<th><i class="bi bi-calendar"></i>&nbsp;모집 기간</th>
            	<td>${volun.regdate} - ${volun.endRegdate}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-bank"></i>&nbsp;봉사 대상</th>
               <td>&nbsp;${volun.volunDae}</td>
               <th>&nbsp;<i class="bi bi-pin-map"></i>&nbsp;봉사 장소</th>
               <td>${user.userAddr1} ${user.userAddr2}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 분야</th>
               <td>&nbsp;${volun.volunType}</td>
               <th>&nbsp;<i class="bi bi-person"></i>&nbsp;모집 인원</th>
               <td>${volun.volunPeople} 명</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 날짜</th>
               <td>&nbsp;${volun.volunDate}</td>
               <th>&nbsp;<i class="bi bi-card-list"></i>&nbsp;봉사 시간</th>
               <td>${volun.volunTime} 시간</td>
            </tr>
            
         </table>
      </div><br />
      <div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
      
      <div class="form-join d-flex justify-content-center">
         <table style="width:560px; height: 100px">
            <tr>
               <th><i class="bi bi-building"></i>&nbsp;봉사기관</th>
               <td>&nbsp;${user.userName}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
               <td>&nbsp;${user.userEmail}</td>
               <th><i class="bi bi-telephone"></i>&nbsp;전화</th>
               <td>&nbsp;${user.userPhone}</td>
            </tr>
         </table>
      </div>
      </form>
	<!-- end breadcrumb section -->

	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
								<c:if test="${empty volun.volunFile}">
								    <img style="width:100%;" src="/resources/assets/img/products/202.jpeg" />
								</c:if>
								<c:if test="${not empty volun.volunFile}">
								    <img style="width:100%;" src="/resources/upload/volun/${volun.volunFile.fileName}.jpeg" />
								</c:if>
							</div>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
								<pre style="font-size:14px;">${volun.volunContent}</pre>
						</div>
						
						<br /><br /><br />
						<div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
						
						
						<div class="single-article-text"><br /><br />
						
						<div id="map" style="width:100%;height:350px;"></div>
						    <em class="link">
						        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
						            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
						        </a>
						    </em>
						
							<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=edb9945ad560b986a9d708ca3c8b67d9&libraries=services"></script>
							<script type="text/javascript">
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = {
						        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    };  

						// 지도를 생성합니다    
						var map = new kakao.maps.Map(mapContainer, mapOption); 

						// 주소-좌표 변환 객체를 생성합니다
						var geocoder = new kakao.maps.services.Geocoder();

						// 주소로 좌표를 검색합니다
						geocoder.addressSearch('${writer.userAddr1}', function(result, status) {

						    // 정상적으로 검색이 완료됐으면 
						     if (status === kakao.maps.services.Status.OK) {

						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

						        // 결과값으로 받은 위치를 마커로 표시합니다
						        var marker = new kakao.maps.Marker({
						            map: map,
						            position: coords
						        });

						        // 인포윈도우로 장소에 대한 설명을 표시합니다
						        var infowindow = new kakao.maps.InfoWindow({
						            content: '<div style="width:150px;text-align:center;padding:6px 0;">${writer.userName}</div>'
						        });
						        infowindow.open(map, marker);

						        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						        map.setCenter(coords);
						    } 
						});
							
							</script>
						
						</div>
					</div><br><br><br><br><br><br><br><br><br>
				</div>
		</div>
	</div>
	<!— end single article section —>
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="volunSeq" id="volunSeq" value="${volun.volunSeq}" />
	</form>
</body>
</html>