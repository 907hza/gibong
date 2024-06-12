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
		
		$("#cancel").on("click", function(){
			location.href = "/user/login";
		});
		
		$("#findId").on("click", function(){
			fnSubmit();
		});
	});
	
	function name_check()
	{
   		if($.trim($("#userName").val()).length <= 0)
   		{
   			document.getElementById('name_check').innerHTML = "이름을 입력하세요.";
   			return;
   		}
   		
   		document.getElementById('name_check').innerHTML = "";
	}
	
	function email_check()
	{
   		if($.trim($("#userEmail").val()).length <= 0)
   		{
   			document.getElementById('email_check').innerHTML = "이메일을 입력하세요.";
   			return;
   		}
   		
   		document.getElementById('email_check').innerHTML = "";

	}
	
	function fnSubmit() 
	{
   		if($.trim($("#userName").val()).length <= 0)
   		{
   			document.getElementById('name_check').innerHTML = "이름을 입력하세요.";
   			return;
   		}
   		
   		if($.trim($("#userName").val()).length > 0)
   		{
   			document.getElementById('name_check').innerHTML = "";
   		}
   		
   		if($.trim($("#userEmail").val()).length <= 0)
   		{
   			document.getElementById('email_check').innerHTML = "이메일을 입력하세요.";
   			return;
   		}
   		
   		if($.trim($("#userEmail").val()).length > 0)
   		{
   			document.getElementById('email_check').innerHTML = "";
   		}
   		
   		$.ajax({
   			type:"POST",
   			url:"/user/findIdProc",
   			data:{
   				userName:$("#userName").val(),
   				userEmail:$("#userEmail").val()
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
   					document.findForm.action = "/user/findIdSuccess";
   					document.findForm.submit();
   				}
   				else
   				{
   					document.getElementById('email_check').innerHTML = "입력 값이 올바르지 않습니다.";
   				}
   			},
   			error:function(xhr, status, error)
   			{
   				document.getElementById('email_check').innerHTML = "아이디 찾기 중 알 수 없는 오류가 발생했습니다.";
   				icia.common.error(error);
   				$("#userName").focus();
   			}
   		});
	}
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
   <div class="container">
      <form name="findForm" id="findForm" method="post" class="form-signin">
         <br/>
         <label for="userName" style="font-size: 20px; color:#554838;"><b>이름</b></label>
         <input type="text" id="userName" onblur="name_check()" name="userName" class="form-control" maxlength="20" placeholder="이름" >
         <p class="check_font" id="name_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <label for="userEmail" style="font-size: 20px; color:#554838;"><b>이메일</b></label>
         <input type="text" id="userEmail" onblur="email_check()" name="userEmail" class="form-control" maxlength="20" placeholder="이메일" >
         <p class="check_font" id="email_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p><br/>
         <div class="d-grid gap-2 col-12 mx-auto">
              <a onclick="fnSubmit()" id="findId" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>아이디 찾기</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a id="cancel" style="background-color: #FFCC80 ; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>취소</b></a>
          </div>
      </form>
   </div>
</body>
</html>