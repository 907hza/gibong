<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

   <!-- title -->
   <title>후원상세페이지</title>

   <!-- favicon -->
   <link rel="shortcut icon" type="image/png" href="/resources/assets/img/favicon.png">
   <!-- google font -->
   <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
   <!-- fontawesome -->
   <link rel="stylesheet" href="/resources/assets/css/all.min.css">
   <!-- bootstrap -->
   <link rel="stylesheet" href="/resources/assets/bootstrap/css/bootstrap.min.css">
   <!-- owl carousel -->
   <link rel="stylesheet" href="/resources/assets/css/owl.carousel.css">
   <!-- magnific popup -->
   <link rel="stylesheet" href="/resources/assets/css/magnific-popup.css">
   <!-- animate css -->
   <link rel="stylesheet" href="/resources/assets/css/animate.css">
   <!-- mean menu css -->
   <link rel="stylesheet" href="/resources/assets/css/meanmenu.min.css">
   <!-- main style -->
   <link rel="stylesheet" href="/resources/assets/css/main.css">
   <!-- responsive -->
   <link rel="stylesheet" href="/resources/assets/css/responsive.css">
   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
input[type="button"] {
  -webkit-transition: 0.3s;
  -o-transition: 0.3s;
  transition: 0.3s;
  border-radius: 50px !important;
  width:60px;
  height:50px;
  border: white;
  background-color:#9c615d;
  color:#fff;
}
input[type="button"]:hover {
  background-color: white;
  color: #fff;
}
.boxed-btn3:focus {
  box-shadow: 0 0 0 3px purple;
}
.breadcrumb-text p {
  font-size: 20px;
}
</style>

<script>
	var cookieUserId = '<c:out value="${cookieUserId}"/>';
	var su = /^[0-9]$/;
	
	$(document).ready(function(){
		
		$("#pay").on("click", function(){
			
			if(cookieUserId == '')
			{
				alert("후원을 원하면 로그인을 해야합니다.");
				location.href = "/user/login";
				return;
			}
		
			if($.trim($("#totalAmount").val()).length <= 0)
			{
				alert("후원 금액을 입력해주셔야합니다.");
				$("#totalAmount").focus();
				return;
			}
			
			if(su.test($("#totalAmount").val()))
			{
				alert("후원 금액은 숫자만 입력 가능합니다.");
				$("#totalAmount").val("");
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/kakao/payReady",
				data:{
					totalAmount:$("#totalAmount").val(),
					itemName:$("#pay").val(),
					itemCode:$("#itemCode").val()
				},
				beforeSned:function(xhr)
				{
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response)
				{
					icia.common.log(response);
					
					if(response.code == 0)
					{
						var orderId = response.data.orderId;
						var tId = response.data.tId;
						var pcUrl = response.data.pcUrl;
						
						$("#orderId").val(orderId);
						$("#tId").val(tId);
						$("#pcUrl").val(pcUrl);
						
						var win = window.open('', 'kakaoPopUp',
							'toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no, width=540, height=700, left=100, top=100')
						// 맨 앞은 경로, 두번째는 해당 페이지 이름, 세번째는 스타일
						// 처음에는 경로를 지정 안해서 아래의 폼과 동일하기에 폼의 action을 통해서 화면에 띄운다
							
						$("#kakaoForm").submit();
					}
					else
					{
						alert("오류가 발생했습니다.");
					}
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});
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
                  <p>${donate.donateTitle}</p>
                  <h1 id="font" style="color: #554838; font-size: 50px">후원하기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <!-- single article section -->
   <div class="mt-150 mb-150">
      <div class="container">
         <div class="row">
            <div class="col-lg-8">
               <div class="single-article-section">
                  <div class="single-article-text">
                     <div >
                     
                    <c:if test="${empty donate.donateFile}">
					    <img style="width:100%;" src="/resources/assets/img/products/33.avif" alt="">
					</c:if>
					<c:if test="${not empty donate.donateFile}">
					    <img style="width:100%;" src="/resources/upload/donate/${donate.donateFile.fileName}.jpeg" alt="">
					</c:if>
                     
                     </div>
                     <p class="blog-meta">
                        <span class="date"><i class="fas fa-calendar"></i>${donate.regdate} - ${donate.endRegdate}</span>
                     </p>
                     <h2>후원자님의 참여가 세상을 바꾸는 힘이 됩니다.</h2>
                     <pre>${donate.donateContent}</pre>
                  </div>

               </div>
            </div>

   <!-- 기봉 후원 금액 버튼 html 시작-->
            <div class="col-lg-4">
               <div class="sidebar-section"><br/>
                  <div class="cart-buttons">
                        <a href="javascript:void(0)" class="boxed-btn4" ><b>정기후원</b></a>
                        <a href="javascript:void(0)" class="boxed-btn4 black"><b>일시후원</b></a>
                  </div>
                  <div class="vote_tab_contbx">
                     <ul class="no_dot" >
                        <li class="step1 active"><!-- 최소 정기후원금액 20,000원 이하로 등록시 팝업노출 (하단에 숨김처리되어있습니다.) -->
                           <!-- <form id="pay-frm1" action="https://with.oxfam.or.kr/oxfam/pay/step1_direct?" target="_blank"> -->
									<input type="hidden" style="display:none;" name="dontype" value="P10101">
									<input type="hidden" style="display:none;" name="period" value="pledge">
									<input type="hidden" style="display:none;" name="price" value="30000"><!--밑에 선택하는 대로 value값 설정 -->
									<h5>후원금 선택</h5>
									<div class="price-buttons">
										<a class="boxed-btn3">50000</a>
										<a class="boxed-btn3">30000</a>
										<a class="boxed-btn3">20000</a>
                           			</div>
                           <br/>
                           <p>
                           	  <input type="hidden" id="itemCode" name="itemCode" value="후원" />
                              <input type="text" id="totalAmount" name="totalAmount" placeholder="후원금액 직접입력" style="width:85%">
                           </p>
                           <br/>
                              <input type="button" id="pay" name="pay" value="후원하기" style="width:85%; height:50px;" >
                           <br/><br/>
                           <p style="width:87%"> 후원을 위해 제공해주신 개인정보는 <br />맨발의기봉이의 <a href="/privacy-policy/" class="color" target="_blank">개인정보처리방침</a>에 따라 <br />안전하게 보호됩니다.</p>
                           
                        </li>
                     </ul>
                  </div>
               </div>
            </div>
   <!-- 기봉 후원 금액 버튼 html 끝 -->
         </div>
      </div>
   </div>
   <!-- end single article section -->
   <br/><br/>
	
	<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp" >
		<input type="hidden" name="orderId" id="orderId" value="" />
		<input type="hidden" name="tId" id="tId" value="" />
		<input type="hidden" name="pcUrl" id="pcUrl" value="" />
	</form>
</body>
</html>