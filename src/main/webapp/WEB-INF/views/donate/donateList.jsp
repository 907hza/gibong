<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<script>
	function fn_donateView(donateseq)
	{
		document.bbsForm.donateSeq.value = donateseq;
		document.bbsForm.action = "/donate/donateView";
		document.bbsForm.submit();
	}
</script>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />   
   
   <!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg"  style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <p>♥ 오늘도 기봉이와 착한 일 하나 ♥</p>
                  <h1 id="font" style="color: #554838; font-size: 50px">후원</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->

   <!-- products -->
   <div class="product-section mt-150 mb-150">
      <div class="container">
         <div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                            <li class="active" data-filter="*">All</li>
                            <li data-filter=".정기후원">정기후원</li>
                            <li data-filter=".일시후원">일시후원</li>
                        </ul>
                    </div>
                </div>
            </div>
         <div class="row product-lists">
         <c:if test="${!empty list}" > 
         <c:forEach var="donate" items="${list}" varStatus="status" >
         	<div class="col-lg-4 col-md-6 text-center 정기후원">
         	<div class="single-product-item">
                <div class="product-image">
                
                	 <c:if test="${empty donate.donateFile}" >
                     <a onclick="fn_donateView(${donate.donateSeq})"><img src="/resources/assets/img/products/33.avif" alt=""></a>
                     </c:if>
                     
                     <c:if test="${not empty donate.donateFile}" >
                     	<a onclick="fn_donateView(${donate.donateSeq})"><img src="/resources/upload/donate/${donate.donateFile.fileName}.jpeg"></a>
                     </c:if>
                     
                </div>
                  <h3>${donate.donateTitle}</h3>
                  <p class="product-price" align="center"><span>${donate.donateContent}</span></p>
                  <div class="progress">
                 <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                   <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 50%" value="0"></div>
                   <!-- 다수의 프로그래스바 --><div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
              </div><br />
              <span><b>현재모금액/목표액</b> <br /> <fmt:formatNumber type='number' maxFractionDigits='3' value='${donate.donateNowAmt}' />원 /
               <fmt:formatNumber type='number' maxFractionDigits='3' value='${donate.donateGoalAmt}' />원</span><br />
              <span><b>후원기간</b> ${donate.regdate} - ${donate.endRegdate}</span><br /><br />
            <a onclick="fn_donateView(${donate.donateSeq})" class="cart-btn"><span class="material-symbols-outlined">volunteer_activism</span></i>후원하러 가기</a> 
			</div>
		</div>
		</c:forEach>
		</c:if>
         </div>
      </div>
   </div>
   <!-- end products -->

   <!-- logo carousel -->
   <div class="logo-carousel-section">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="logo-carousel-inner">
                  <div class="single-logo-item">
                     <img src="/resources/assets/img/company-logos/1.png" alt="">
                  </div>
                  <div class="single-logo-item">
                     <img src="/resources/assets/img/company-logos/2.png" alt="">
                  </div>
                  <div class="single-logo-item">
                     <img src="/resources/assets/img/company-logos/3.png" alt="">
                  </div>
                  <div class="single-logo-item">
                     <img src="/resources/assets/img/company-logos/4.png" alt="">
                  </div>
                  <div class="single-logo-item">
                     <img src="/resources/assets/img/company-logos/5.png" alt="">
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end logo carousel -->
	<form name="bbsForm" id="bbsForm" >
		<input type="hidden" name="donateSeq" id="donateSeq" />
	</form>
</body>
</html>