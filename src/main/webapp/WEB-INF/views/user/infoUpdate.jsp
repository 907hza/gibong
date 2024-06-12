<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
	label{
		font-size: 20px; width:500px; color: #554838;
	}
	
	.mar{
		margin-left: 50px; font-size: 20px;
	}
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
   .ws_input{
       margin:20px auto;
       max-width: 800px;
       display:flex;
       justify-content:center;
   }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>	
	var id_pwCheck = /^[0-9a-zA-Z]{4,20}$/;
	var mailCheck = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;

	function execDaumPostcode() // 다음 도로명 주소 api
	{
	    new daum.Postcode({
	        oncomplete: function(data) 
	        {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("userAddr1").value = extraAddr;
	            
	            } else {
	                document.getElementById("userAddr").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('userZipcode').value = data.zonecode;
	            document.getElementById("userAddr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("userAddr2").value = '';
	            document.getElementById("userAddr2").focus();
	        }
	    }).open();
	}
	
	function pw_check() // 비번 체크
	{
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			document.getElementById('pwd1_check').innerHTML = "비밀번호를 입력하세요.";
			return;
		}
		
		if(id_pwCheck.test($("#userPwd1").val()) == false)
		{
			document.getElementById('pwd1_check').innerHTML = "비밀번호는 4 - 20 자리로 이루어진 영문, 숫자만 가능합니다.";
			return;
		}
		
		document.getElementById('pwd1_check').innerHTML = "";
	}
	
	function pw2_check() // 비밀번호 확인 체크
	{
		if($.trim($("#userPwd2").val()).length <= 0)
		{
			document.getElementById('pwd2_check').innerHTML = "비밀번호 확인란을 입력하세요.";
			return;
		}

		
		if($("#userPwd1").val() != $("#userPwd2").val())
		{
			document.getElementById('pwd2_check').innerHTML = "비밀번호가 일치하지 않습니다.";
			return;
		}
		
		$("#userPwd").val($("#userPwd1").val());
		
		document.getElementById('pwd2_check').innerHTML = "";
	}
	
	function name_check() // 이름 체크
	{
		if($.trim($("#userName").val()).length <= 0)
		{
			document.getElementById('name_check').innerHTML = "이름을 입력하세요.";
			return;
		}

		document.getElementById('name_check').innerHTML = "";
	}
		
	function email_check() // 이메일 체크
	{
		if($.trim($("#userEmail").val()).length <= 0)
		{
			document.getElementById('email_check').innerHTML = "이메일을 입력하세요.";
			return;
		}
		
		if(mailCheck.test($("#userEmail").val()) == false)
		{
			document.getElementById('email_check').innerHTML = "이메일 형식이 올바르지 않습니다.";
			return;
		}
		
		document.getElementById('email_check').innerHTML = "";
			
		$.ajax({
			type:"POST",
			url:"/user/emailDouble",
			data:{
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
					document.getElementById('email_check').innerHTML = "사용 가능한 이메일 입니다.";
				}
				else if(response.code == 400)
				{
					document.getElementById('email_check').innerHTML = "이메일 입력값이 올바르지 않습니다.";
					$("#userEmail").focus();
				}
				else if(response.code == 403)
				{
					document.getElementById('email_check').innerHTML = "중복되는 이메일로 사용이 불가능합니다.";
					$("#userEmail").focus();
				}
				else
				{
					document.getElementById('email_check').innerHTML = "이메일 중복 확인 중 알 수 없는 오류가 발생했습니다.";
					$("#userEmail").focus();
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	}
	
	function phone_check()
	{
		if($.trim($("#userPhone").val()).length <= 0)
		{
			document.getElementById('phone_check').innerHTML = "전화번호를 입력해주세요.";
			return;
		}
		
		document.getElementById('phone_check').innerHTML = "";
	}
	
	function addr2_check()
	{
		if($.trim($("#userAddr2").val()).length <= 0)
		{
			document.getElementById('addr2_check').innerHTML = "상세주소를 입력해주세요.";
			return;
		}

		document.getElementById('addr2_check').innerHTML = "";
	}
	
	$(document).ready(function(){
		
		$("#btnReg").on("click", function(){
			
			if(confirm("회원 정보를 수정하시나요?") == true)
			{
				$.ajax({
					type:"POST",
					url:"/user/userUpdate",
					data:{
						userId:$("#userId").val(),
						userPwd:$("#userPwd2").val(),
						userPhone:$("#userPhone").val(),
						userEmail:$("#userEmail").val(),
						userName:$("#userName").val(),
						userFlag:"Y",
						userZipcode:$("#userZipcode").val(),
						userAddr1:$("#userAddr1").val(),
						userAddr2:$("#userAddr2").val()
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
							location.href = "/user/infoList";
						}
						else if(response.code == 400)
						{
							alert("입력 값이 올바르지 않습니다.");
						}
						else if(response.code == 403)
						{
							alert("회원가입 중 오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
			}

		});
	});
</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원정보수정</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="ws_input" >
	<div class="container"> 
		<div class="form-join"> 
			<form id="updateForm" name="updateForm" method="post"> 
			<br /><br />
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="flag" style="font-size: 20px; width:500px"><b>회원구분</b></label>
					</div>
					<div class="col-sm-4 mar">
						<c:if test="${user.userFlag eq 'G'}" >기업 회원</c:if>
						<c:if test="${user.userFlag eq 'U'}" >일반 회원</c:if>
					</div>
				</div><br />
			
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label style="font-size: 20px; width:500px"><b>아이디</b></label>
					</div>
					<div class="col-sm-4 mar"> 
						${user.userId}
					</div>
				</div><br />
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwd"><b>비밀번호</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="password" onblur="pw_check()" class="form-control" name="userPwd1" id="userPwd1" value="${user.userPwd}" placeholder="4 ~ 20자의 영문, 숫자와 특수문자 가능" style="font-size: 20px;">
						<p class="check_font" id="pwd1_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
				</div><br />
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="pwdCheck"><b>&nbsp;&nbsp;비밀번호확인</b></label>
					</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="col-sm-4 mar">
						<input type="password" onblur="pw2_check()" class="form-control" name="userPwd2" id="userPwd2" value="${user.userPwd}" style="font-size: 20px;">
						<p class="check_font" id="pwd2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
				</div><br />
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="name"><b>이름</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" onblur="name_check()" class="form-control" name="userName" id="userName" value="${user.userName}" style="font-size: 20px;">
						<p class="check_font" id="name_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
				</div><br />       
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="email"><b>이메일</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="email" onblur="email_check()" class="form-control" name="userEmail" id="userEmail" value="${user.userEmail}" style="font-size: 20px;">
						<p class="check_font" id="email_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
				</div><br />  
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="phone"><b>휴대전화</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" onblur="phone_check()" class="form-control" name="userPhone" id="userPhone" value="${user.userPhone}" style="font-size: 20px;">
						<p class="check_font" id="phone_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
				</div><br />
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-1 control-label">
						<label id="postcode"><b>우편번호</b></label>
					</div>
					<div class="col-sm-3 mar">
						<input type="text" onblur="zipcode_check()" id="userZipcode" name="userZipcode" class="form-control" value="${user.userZipcode}" style="font-size: 20px;">
						<p class="check_font" id="zipcode_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>
					<div class="col-sm-1-1">
						<input type="button" onclick="execDaumPostcode();" value="검색" class="btn" style="background-color:#ffe896; font-size: 20px;">
					</div>
				</div><br />   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-1 control-label">
						<label id="address"><b>주소</b></label>
					</div>
					<div class="col-sm-4 mar">
						<input type="text" onblur="addr1_check()" id="userAddr1" name="userAddr1" class="form-control" value="${user.userAddr1}" style="font-size: 20px;">
						<p class="check_font" id="addr1_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
					</div>   
				</div><br />
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-1 control-label">
						<label id="detailAddress"><b>상세주소</b></label>
					</div>
					<div class="col-sm-4 mar"> 
						<input type="text" onblur="addr2_check()" id="userAddr2" name="userAddr2" class="form-control" value="${user.userAddr2}" style="font-size: 20px;">
						<p class="check_font" id="addr2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p> 
					</div>
				</div>
			    <br><br> 
				<input type="hidden" id="userId" name="userId" value="${user.userId}" />
				<input type="hidden" id="userPwd" name="userPwd" value=""> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="btn">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" onClick="location.href='/user/infoList'" id="btnReset" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="btn">취소</button>
				</div>
			</form>  
		</div>
	</div>
</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br />  
</body>
</html>