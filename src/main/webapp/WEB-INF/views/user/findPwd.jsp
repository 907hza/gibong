<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script>

	function idCheck()
	{
   		if($.trim($("#userId").val()).length <= 0)
   		{
   			document.getElementById('id_check').innerHTML = "아이디를 입력하세요.";
   			return;
   		}
   		
   		document.getElementById('id_check').innerHTML = "";
	}
	
	function emailCheck()
	{
   		if($.trim($("#userEmail").val()).length <= 0)
   		{
   			document.getElementById('email_check').innerHTML = "이메일을 입력하세요.";
   			return;
   		}
   		
   		document.getElementById('email_check').innerHTML = "";
	}
	
	$(document).ready(function(){
		
		var test = "";
		
		$("#btnSend").on("click", function(){
			
			idCheck();
			emailCheck();
			
			$("#btnSend").prop("disabled", true); // 전송 버튼 비활성
			
			$.ajax({
				type:"POST",
				url:"/user/idEmailCheck",
				data:{
					userId:$("#userId").val(),
					userEmail:$("#userEmail").val()
				},
				beforeSend:function(xhr)
				{
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response)
				{
					if(response.code == 0)
					{
						document.getElementById('email_check').innerHTML = "";
						
						// 메일 전송
						
						$.ajax({
							type:"POST",
							url:"/email/mailAuth",
							data:{
								mail : $("#userEmail").val()
							},
							success:function(data)
							{		
								document.getElementById('email_check').innerHTML = "이메일이 전송되었습니다.";

								$("#userEmail2").focus();
								
								test = data;
								
								document.getElementById('email2_check').innerHTML = "인증번호를 입력해주세요.";
								
							},
							error:function(xhr, status, error)
							{
								icia.common.error(error);
							}
						});
						
						//
					}
					else if(response.code == 400)
					{
						document.getElementById('email_check').innerHTML = "입력 값이 올바르지 않습니다.";
					}
					else if(response.code == 404)
					{
						document.getElementById('email_check').innerHTML = "해당 아이디가 존재하지 않습니다.";
					}
					else if(response.code == 410)
					{
						document.getElementById('email_check').innerHTML = "해당 아이디와 일치하는 이메일이 존재하지 않습니다.";
					}
					else
					{
						document.getElementById('email_check').innerHTML = "이메일 조회 중 알 수 없는 오류가 발생했습니다.";
					}
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});

		});
		
		$("#btnTest").on("click", function(){
			
			$("#btnTest").prop("disabled", true); // 전송 버튼 비활성
			
			if($("#userEmail2").val() == test)
			{
				document.getElementById('email2_check').innerHTML = "이메일 인증이 완료되었습니다.";
				
				// 임시 비밀번호 전송
				
				$.ajax({
					type:"POST",
					url:"/email/mailAuthPwd",
					data:{
						userId:$("#userId").val(),
						mail : $("#userEmail").val()
					},
					success:function(data)
					{		
						document.getElementById('email2_check').innerHTML = "이메일로 임시 비밀번호를 발급했습니다.";

						$("#userEmail2").focus();
						
						$("#btnSend").prop("disabled", true); // 전송 버튼 비활성
						
						test = data;
						
					},
					error:function(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
				
			}
			else 
			{
				document.getElementById('email2_check').innerHTML = "인증번호가 일치하지 않습니다.";
			}
		});
	});
</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">비밀번호 찾기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   </br></br>
   <div class="container">
   </br></br></br>
               <div class="form-join d-flex justify-content-center">
	               <div class="col-sm-2 control-label">
	                  <label style="color:#554838; font-size:18px;float:right;"><b>아이디</b></label>
	               </div>
	               <div class="col-sm-4">
	                  <input type="text" class="form-control" onblur="idCheck()" name="userId" id="userId" placeholder="아이디를 입력하세요." style="font-size: 20px;width:260px;">
	               	  <p class="check_font" id="id_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
	               </div>
	           </div><br />
	           
	           <div class="form-join d-flex justify-content-center">
	               <div class="col-sm-2 control-label">
	                   <label style="color:#554838;font-size:18px;float:right"><b>이메일</b></label>
	               </div>
	               <div class="col-sm-4">
	                  <input type="text" class="form-control" onblur="emailCheck()" name="userEmail" id="userEmail" placeholder="이메일을 입력하세요." style="font-size: 20px; width:260px;">
	               	  <p class="check_font" id="email_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p><br >
	               	  <button type="button" id="btnSend" style="width:150px; background-color:#ffcc80; color: #554838; font-size: 16px; text-align: center; display: block; float:right;" class="btn"><b>인증번호 발송</b></button><br />
	               	  
	               </div>
	           </div>
		       
			   <br />
			   <hr style="border: 0; border-bottom: 2px dashed #eee; width : 50%;" /><br />
			   
			   <div class="form-join d-flex justify-content-center">
	               <div class="col-sm-2 control-label">
	                  <label style="color:#554838; font-size:18px;float:right;" id="testValue"><b>인증번호</b></label>
	               </div>
	               <div class="col-sm-4">
	                  <input type="text" class="form-control" name="userEmail2" id="userEmail2" value="" placeholder="인증번호를 입력하세요." style="font-size: 20px;width:260px;">
	               	  <p class="check_font" id="email2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"><br ></p>
	               	  <button type="button" id="btnTest" style="width:100px; background-color:#ffcc80; color: #554838; font-size: 16px; text-align: center; display: block; float:right;" class="btn"><b>인증</b></button><br />
	               	  
	               	  
	               </div>
	           </div><br />
			   
			   <br/><br/>
      			
         <div align="center">
              <a href="/user/login" style="font-size: 16px; text-decoration:none; color:#554838" >로그인 화면</a>
              <span style="color: #554838; font-size: 16px;">/</span>
              <a href="/main" style="font-size: 16px; text-decoration:none; color:#554838">취소</a>
         </div>
         <br><br><br><br><br>
</div>
</body>
</html>