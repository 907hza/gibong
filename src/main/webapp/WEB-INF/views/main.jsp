<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
h2.widget-title {
  font-size: 23px;
  font-weight: 500;
  position: relative;
  padding-bottom: 5px;
  color: #fff ;
}

h2.widget-title:after {
  height: 3px;
  width: 130px;
  background-color: #F28123;
}
.footer-area {

  padding: 60px 20;

}

 
</style>


</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section" style="padding-bottom: 10px;">
      <div class="container">
         <div class="breadcrumb-text">
            <img src="/resources/images/main.png">
         </div>
      </div>
   </div>
   
      <!-- footer -->
     <div class="footer-area">
      <div class="container">
         <div >
            <div class="col-lg-3 col-md-6" style="display: inline-block;">
               <div class="footer-box about-widget" style="width:700px;">
                  <h2 class="widget-title">Introduce</h2>
                  <p style="font-size:16px; "><b>맨발의 기봉이는 오늘도 누구보다 먼저 맨발 벗고 나섭니다. <br/><br/>
                  세상을 바꿀 수 있는 힘은 기봉이와 함께하는 후원자님과 <br/>
                  이를 통해 일어선 사람들의 삶의 변화로 부터 나옵니다.</b> <br/>

                  <b>맨발의 기봉이의  다양한 이벤트와 활동에 참여하여 여러분의 재능과 열정을 나눠주세요!</b></p>
               </div>
            </div>
            <div class="col-lg-3 col-md-6" style="display: inline-block; position: absolute;  right:  160px;">
               <div class="footer-box get-in-touch">
                  <h2 class="widget-title" >Contack</h2>
                  
                    <p style="font-size:15px; "> 
                     <b>쌍용교육센터 - E 강의실 맨발의 기봉이<br/><br/>
                     서울특별시 마포구 월드컵북로21 풍성빌딩<br/>
                     쌍용강북교육센터</b><br/>
                     Tel.02-336-8546~8 <br />
                     Fax.02-334-5405</p>
                  
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end footer -->
   
</body>
</html>

