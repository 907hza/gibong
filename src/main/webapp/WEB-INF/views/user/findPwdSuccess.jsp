<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
   .form-signin {
     max-width: 330px;
     padding: 15px;
     margin: 0 auto;
   }
   .form-signin .form-signin-heading,
   .form-signin .checkbox {
     margin-bottom: 10px;
   }
   .form-signin .checkbox {
     font-weight: 400;
   }
   .form-signin .form-control {
     position: relative;
     -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
     box-sizing: border-box;
     height: auto;
     padding: 10px;
     font-size: 20px;
   }
   .form-signin .form-control:focus {
     z-index: 2;
   }
   .form-signin input[type="text"] {
     margin-bottom: 5px;
     border-bottom-right-radius: 0;
     border-bottom-left-radius: 0;
   }
   .form-signin input[type="password"] {
     margin-bottom: 10px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
   }
</style>
<script>

	$(document).ready(function(){
		
		$("#login").on("click", function(){
			location.href = "/user/login";
		});
		
		$("#findPwd").on("click", function(){
			location.href = "/user/findPwd";
		});
	});
	
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">아이디 찾기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="d-grid gap-2 col-12 mx-auto">
      <form name="findForm" id="findForm" method="post" class="form-signin">
         <br/>
         <c:if test="${!empty user}">
         	<p class="check_font" id="id_check" style="text-align:center; color:#fd8505; font-size: 20px; margin-top: 0px"><b>"${user.userId}"</b></p><br />
         </c:if>
         <c:if test="${empty user}">
         	<p class="check_font" id="id_check" style="text-align:center; color:#fd8505; font-size: 20px; margin-top: 0px"><b>"조회하신 정보와 일치하는 아이디가 존재하지 않습니다."</b></p>
         </c:if>
         
           <div align="center">
              <a id="login" style="font-size: 16px; text-decoration:none; color:#554838" >로그인</a>
              <span style="color: #554838; font-size: 16px;">/</span>
              <a id="findPwd" style="font-size: 16px; text-decoration:none; color:#554838">비밀번호 찾기</a>
           </div>
      </form>
   </div>
</body>
</html>