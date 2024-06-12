<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

	<!-- title -->
	<title>후원상세페이지</title>

	
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
input[type="submit"] {
  -webkit-transition: 0.3s;
  -o-transition: 0.3s;
  transition: 0.3s;
  border-radius: 50px !important;
  background-color:#f4a0a0;
  color:#fff;
}
input[type="submit"]:hover {
  background-color: #ff6e6e;
  color: #fff;
}
.breadcrumb-text p {
  font-size: 20px;
}
.breadcrumb-text h1 {
  font-size: 40px;

}

</style>


</head>
<body>
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
	
	

	<!-- search area -->
	<div class="search-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<span class="close-btn"><i class="fas fa-window-close"></i></span>
					<div class="search-bar">
						<div class="search-bar-tablecell">
							<h3>Search For:</h3>
							<input type="text" placeholder="Keywords">
							<button type="submit">Search <i class="fas fa-search"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end search arewa -->
	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>후원하기</p>
						<h1>지금, 희주의 후원자가 되어주세요</h1>
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
							<div class="single-artcile-bg"><img src="/resources/images/fund_example.jpg"></div>
							<p class="blog-meta">
								<span class="date"><i class="fas fa-calendar"></i> 27 December, 2019</span>
							</p>
							<h2>후원자님의 참여가 세상을 바꾸는 힘이 됩니다.</h2>
							<p>옥스팜 사업의 중심에는 늘 후원자님들이 자리하고 있습니다.</p>
							<p>한분 한분의 관심과 도움을 통해 옥스팜은 전세계 곳곳에서 가난의 근본적인 해결을 위한 긍정적인 변화를 만들어가고 있습니다.</p>
							<p>지금, 옥스팜 후원자가 되어주세요!</p>
							<p>후원자님께서 보내주신 소중한 후원금은 식수 및 위생지원을 포함한 긴급구호, 자립을 위한 생계 활동 등 옥스팜 주요 사업에 사용됩니다.</p>
						</div>

					</div>
				</div>

	<!-- 기봉 후원 금액 버튼 html 시작-->
				<div class="col-lg-4">
					<div class="sidebar-section"><br/>
						<div class="cart-buttons">
								<a href="#" class="boxed-btn4" ><b>정기후원</b></a>
								<a href="#" class="boxed-btn4 black"><b>일시후원</b></a>
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
										<input type="text"  placeholder="후원금액 직접입력" style="width:85%">
									</p>
									<br/>
										<input type="submit" value="후원하기" style="width:85%" >
									<br/><br/>
									<p style="width:87%"><img src="/resources/images/free-icon-padlock-159069.png" width="15"> 후원을 위해 제공해주신 개인정보는 맨발의기봉이의 <a href="/privacy-policy/" class="color" target="_blank">개인정보처리방침</a>에 따라 안전하게 보호됩니다.</p>
									
								</li>
							</ul>
						<br/>
							  <a href="/user/login" style="background-color: #FFCC80; color: #554838; font-size: 16px" class="cart-btn"><b>수정</b></a>
               				  <a href="/user/login" style="background-color: #FFCC80; color: #554838; font-size: 16px" class="cart-btn"><b>삭제</b></a>
               				  <a href="/user/login" style="background-color: #FFCC80; color: #554838; font-size: 16px" class="cart-btn"><b>목록으로</b></a>
						</div>
					</div>
				</div>
				<div class="col-sm-12 text-center"  >

	<!-- 기봉 후원 금액 버튼 html 끝 -->
			</div>
		</div>
	</div>
	<!-- end single article section -->
	<br/><br/>

</body>
</html>