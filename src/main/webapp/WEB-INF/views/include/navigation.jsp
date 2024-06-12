<%@page import="com.gibong.web.util.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<%	
	if(com.gibong.web.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
	{
%>
<!-- header -->
   <div class="top-header-area" id="sticker" style="background-color: #FSDFCF;" align="right">
      <div class="container">
         <div class="row">
            <div class="col-lg-12 col-sm-12 text-center">
               <div class="main-menu-wrap" align="right">
                  <!-- logo -->
                  <!--<div class="site-logo" style="padding-top:0px;">-->
                  <div style="width: 300px; text-align: left; padding-left:10px; padding-top:0px; margin-top:0px;"  align="left" class="site-logo">
                     <a id="font" class="navbar-brand js-scroll-trigger" href="/main" style="color: #442917; font-size: 55px;" >맨발의 기봉이</a>
                  </div>
                  <!-- logo -->

                  <!-- menu start -->
                  <nav class="main-menu" style="padding-top:15px;">
                     <ul style="font-size: 20px">
                        <li><a href="/volun/volunList">봉사신청</a></li>
                        <li><a href="/review/reviewList">봉사후기</a></li>
                        <li><a href="/donate/donateList">후원하기</a></li>
                        <li><a  href="/user/myPage">마이페이지</a>
                           <ul class="sub-menu">
                              <li><a href="/user/myPage">마이페이지</a></li>
                              <li><a href="/user/infoUpdate">회원정보수정</a></li>
                           	  <li><a href="/user/logOut">로그아웃</a></li>
                           </ul>
                        </li>
                        <li><a class="shopping-cart" href=""><i class="bi bi-bell-fill"></i></a></li>
                        <li><a class="mobile-show search-bar-icon"><i class="fas fa-search"></i></a></li>
                     </ul>
                  </nav>
                  <!-- menu end -->
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end header -->
<%
	}
	else
	{
%>
   <div class="top-header-area" id="sticker" style="background-color: #FSDFCF;" align="right">
      <div class="container">
         <div class="row">
            <div class="col-lg-12 col-sm-12 text-center">
               <div class="main-menu-wrap" align="right">
                  <!-- logo -->
                  <!--<div class="site-logo" style="padding-top:0px;">-->
                  <div style="width: 300px; text-align: left; padding-left:10px; padding-top:0px; margin-top:0px;"  align="left" class="site-logo">
                     <a id="font" class="navbar-brand js-scroll-trigger" href="/main" style="color: #442917; font-size: 55px;" >맨발의 기봉이</a>
                  </div>
                  <!-- logo -->

                  <!-- menu start -->
                  <nav class="main-menu" style="padding-top:15px;">
                     <ul style="font-size: 20px">
                        <li><a href="/volun/volunList">봉사신청</a></li>
                        <li><a href="/review/reviewList">봉사후기</a></li>
                        <li><a href="/donate/donateList">후원하기</a></li>
                        <li><a href="/user/login">로그인</a></li>
                        </li>
                        <li><a class="shopping-cart" href=""><i class="bi bi-bell-fill"></i></a></li>
                     </ul>
                  </nav>
                  <!-- menu end -->
               </div>
            </div>
         </div>
      </div>
   </div>
<%
	}
%>