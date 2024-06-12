<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
   .form-signin {
     max-width: 700px;
     padding: 200px;
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
   
	$("#btnReg").on("click",function(){
		location.href = "/user/join";
	});
	
 	$("#btnLogin").on("click", function() {
 		fn_loginCheck();
    });
 	
 	$("#findId").on("click", function(){
 		location.href = "/user/findId";
 	});
 	
 	$("#findPwd").on("click", function(){
 		location.href = "/user/findPwd";
 	});
   
});

function idCheck()
{
	if($.trim($("#userId").val()).length <= 0)
	{
		document.getElementById('id_check').innerHTML = "아이디를 입력하세요.";
		return;
	}
	
	document.getElementById('id_check').innerHTML = "";
}

function pwdCheck()
{
	if($.trim($("#userPwd").val()).length <= 0)
	{
		document.getElementById('pwd_check').innerHTML = "비밀번호를 입력하세요.";
		return;
	}
	
	document.getElementById('pwd_check').innerHTML = "";
}

function fn_loginCheck()
{
		
	if($.trim($("#userId").val()).length <= 0)
	{
		document.getElementById('id_check').innerHTML = "아이디를 입력하세요.";
		return;
	}
	
	document.getElementById('id_check').innerHTML = "";
	
	if($.trim($("#userPwd").val()).length <= 0)
	{
		document.getElementById('pwd_check').innerHTML = "비밀번호를 입력하세요.";
		return;
	}
	
	document.getElementById('pwd_check').innerHTML = "";
	
	$.ajax({
		type:"POST",
		url:"/user/loginProc",
		data:{
			userId:$("#userId").val(),
			userPwd:$("#userPwd").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response)
		{
			if(response.code == 0)
			{
				location.href = "/main";
			}
			else if(response.code == 400)
			{
				document.getElementById('pwd_check').innerHTML = "입력값이 올바르지 않습니다.";
			}
			else if(response.code == 404)
			{
				document.getElementById('pwd_check').innerHTML = "존재하지 않는 사용자입니다.";
			}
			else if(response.code == 410)
			{
				document.getElementById('pwd_check').innerHTML = "입력값이 일치하지 않습니다.";
			}
			else if(response.codee == 430)
			{
				document.getElementById('pwd_check').innerHTML = "로그인이 불가능한 사용자입니다.";
			}
			else
			{
				document.getElementById('pwd_check').innerHTML = "로그인 중 오류가 발생했습니다.";
			}
		},
		error:function(xhr, status, error)
		{
			document.getElementById('pwd_check').innerHTML = "로그인 중 알 수 없는 오류가 발생했습니다.";
			icia.common.error(error);
		}
	});
}

</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">로그인</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="container" style="padding-top: 10px; margin-top: 10px">
      <form name="loginForm" id="loginForm" method="post" class="form-signin" style="padding-top: 10px; margin-top: 10px">
         <!--  <br/>
          <h2 class="form-signin-heading m-b3" align="center" style="color:#554838"><b>로그인</b></h2><br/>-->
         <label for="userId" style="font-size: 20px; color:#554838;"><b>아이디</b></label>
         <input type="text" id="userId" onblur="idCheck()" name="userId" class="form-control" maxlength="20" placeholder="아이디">
         <p class="check_font" id="id_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <label for="userPwd" style="font-size: 20px; color:#554838;"><b>비밀번호</b></label>
         <input type="password" id="userPwd" onblur="pwdCheck()" name="userPwd" class="form-control" maxlength="20" placeholder="비밀번호">
         <p class="check_font" id="pwd_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <div align="center">
              <a id="findId" style="font-size: 16px; text-decoration:none; color:#554838" >아이디 찾기</a>
              <span style="color: #554838; font-size: 16px;">/</span>
              <a id="findPwd" style="font-size: 16px; text-decoration:none; color:#554838">비밀번호 찾기</a>
         </div><br/>  
           <div class="d-grid gap-2 col-12 mx-auto">
              <a id="btnLogin" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>로그인</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a id="btnReg" style="background-color: #FFCC80 ; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>회원가입</b></a>
          </div>
      </form>
   </div>
</body>
</html>