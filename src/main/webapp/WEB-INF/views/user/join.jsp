<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
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
                document.getElementById("userAddr2").focus();
            }
        }).open();
    }
    
	function idCCheck() // 아이디 체크
	{
		if($.trim($("#userId").val()).length <= 0)
		{
			document.getElementById('id_check').innerHTML = "아이디를 입력하세요.";
			return;
		}
		
		if(id_pwCheck.test($("#userId").val()) == false)
		{
			document.getElementById('id_check').innerHTML = "아이디는 4 - 20 자리로 이루어진 영문, 숫자만 가능합니다.";
			return;
		}
		
		$.ajax({
			type:"POST",
			url:"/user/idDouble",
			data:{
				userId:$("#userId").val()
			},
			datatype:"JSON",
			before:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					document.getElementById('id_check').innerHTML = "사용 가능한 아이디입니다.";
				}
				else if(response.code == 400)
				{
					document.getElementById('id_check').innerHTML = "입력 값이 부족합니다.";
					return;
				}
				else if(response.code == 403)
				{
					document.getElementById('id_check').innerHTML = "중복되는 아이디입니다.";
					return;
				}
				else
				{
					document.getElementById('id_check').innerHTML = "아이디 중복 조회 중 오류가 발생했습니다.";
					return;
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
		
		document.getElementById('id_check').innerHTML = "";
	}
	
	function pwdCCheck() // 비번 체크
	{
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			document.getElementById('pw_check').innerHTML = "비밀번호를 입력하세요.";
			return;
		}
		
		if(id_pwCheck.test($("#userPwd1").val()) == false)
		{
			document.getElementById('pw_check').innerHTML = "비밀번호는 4 - 20 자리로 이루어진 영문, 숫자만 가능합니다.";
			return;
		}
		
		document.getElementById('pw_check').innerHTML = "";
	}
	
	function pwdCCheck2() // 비밀번호 확인 체크
	{
		if($.trim($("#userPwd2").val()).length <= 0)
		{
			document.getElementById('pw2_check').innerHTML = "비밀번호 확인란을 입력하세요.";
			return;
		}

		
		if($("#userPwd1").val() != $("#userPwd2").val())
		{
			document.getElementById('pw2_check').innerHTML = "비밀번호가 일치하지 않습니다.";
			return;
		}
		
		$("#userPwd").val($("#userPwd1").val());
		
		document.getElementById('pw2_check').innerHTML = "";
	}
	
	function nameCCheck() // 이름 체크
	{
		if($.trim($("#userName").val()).length <= 0)
		{
			document.getElementById('name_check').innerHTML = "이름을 입력하세요.";
			return;
		}

		document.getElementById('name_check').innerHTML = "";
	}
		
	function emailCCheck() // 이메일 체크
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
	
	function phoneCCheck()
	{
		if($.trim($("#userPhone").val()).length <= 0)
		{
			document.getElementById('phone_check').innerHTML = "전화번호를 입력해주세요.";
			return;
		}
		
		document.getElementById('phone_check').innerHTML = "";
	}
	
	function addr2CCheck()
	{
		if($.trim($("#userAddr2").val()).length <= 0)
		{
			document.getElementById('addr2_check').innerHTML = "상세주소를 입력해주세요.";
			return;
		}

		document.getElementById('addr2_check').innerHTML = "";
	}
	
	$(document).ready(function(){
	
		var test = "";
		
		$("#btnSend").on("click", function(){
			
			emailCCheck();
			
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
					
					$("#btnTest").prop("disabled", false);
					$("#btnSend").prop("disabled", true); // 전송 버튼 비활성
					
					test = data;
					
					document.getElementById('email2_check').innerHTML = "인증번호를 입력해주세요.";
					
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});
			
			//

		});
		
		$("#btnTest").on("click", function(){
			
			if($("#userEmail2").val() == test)
			{
				document.getElementById('email2_check').innerHTML = "이메일 인증이 완료되었습니다.";
				document.getElementById('email_check').innerHTML = "";
			}
			else 
			{
				document.getElementById('email2_check').innerHTML = "인증번호가 일치하지 않습니다.";
			}
		});
		
		$("#btnAddr").on("click", function(){
			execDaumPostcode();
		});
		
		$("#aReg").on("click", function(){
			
			$("select[name=sel_userFlag]").change(function()
			{
				document.getElementById('userFlag_check').innerHTML = "";
			});
			
			$("#userFlag").val($("select[name=sel_userFlag]").val());
			
			if($("#userFlag").val() == "")
			{
				document.getElementById('userFlag_check').innerHTML = "회원구분을 선택해주세요.";
				return;
			}
			
			if($.trim($("#userZipcode").val()).length <= 0)
			{
				document.getElementById('zip_check').innerHTML = "우편번호를 입력해주세요.";
				return;
			}
			
			document.getElementById('zip_check').innerHTML = "";
			
			if($("#agree1").is(':checked') == false)
			{
				alert("이용약관 동의(필수) 항목을 체크해주세요.");
				$("#agree1").focus();
				return;
			}
			
			if($("#agree2").is(':checked') == false)
			{
				alert("개인정보 수집∙이용 동의(필수) 항목을 체크해주세요.");
				$("#agree2").focus();
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/user/joinUser",
				data:{
					userId:$("#userId").val(),
					userPwd:$("#userPwd").val(),
					userPhone:$("#userPhone").val(),
					userEmail:$("#userEmail").val(),
					userName:$("#userName").val(),
					userFlag:$("#userFlag").val(),
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
						location.href = "/user/login";
					}
					else if(response.code == 400)
					{
						alert("입력 값이 올바르지 않습니다.");
						$("#userId").focus();
					}
					else if(response.code == 403)
					{
						alert("회원가입 중 오류가 발생했습니다.");
						$("#userId").focus();
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
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원가입</h1>
               </div>
            </div>
         </div>
      </div>
   </div>

   <br/><br />
   <div class="container" style="font-size: 20px;"> 
      <div class="form-join" style="font-size: 20px;">
       
         <form id="regForm" name="regForm" action="" method="post"> 
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;회원구분</b></label>
               </div>
               <div class="col-sm-4">
                  <select id="sel_userFlag" name="sel_userFlag" class="form-select form-select mb-3" aria-label=".form-select-lg example" style="font-size: 20px;" >
                     <option value="">선택</option>
                     <option value="U" >개인회원</option>
                     <option value="G" >봉사기관</option>
                  </select>
                  <p class="check_font" id="userFlag_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
                  <input type="hidden" id="userFlag" name="userFlag" value="">
               </div>
            </div><br />
         
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;아이디</b></label>
               </div>
               <div class="col-sm-4"> 
                  <input type="text" class="form-control" name="userId" id="userId" onblur="idCCheck()" value="" placeholder="4 ~ 20자의 영문, 숫자 입력" style="font-size: 20px;">
               	  <p class="check_font" id="id_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
            </div><br />

            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;비밀번호</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" onblur="pwdCCheck()" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자 입력" style="font-size: 20px;">
               	  <p class="check_font" id="pw_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>               
               </div>
            </div><br />
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;비밀번호확인</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" onblur="pwdCCheck2()" name="userPwd2" id="userPwd2" style="font-size: 20px;">
               	  <p class="check_font" id="pw2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>               
               </div>
            </div><br />
                  
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;이름</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" onblur="nameCCheck()" name="userName" id="userName" value="" style="font-size: 20px;">
               	  <p class="check_font" id="name_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
            </div><br />     
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이메일</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" onblur="emailCCheck()" name="userEmail" id="userEmail" value="" placeholder="email@gibong.com" style="font-size: 20px;">
               	  <p class="check_font" id="email_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
               <div class="col-sm-1-1">
                  <a id="btnSend" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>전송</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div><br />   
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>인증번호</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="userEmail" id="userEmail2" value="" placeholder="" style="font-size: 20px;">
               	  <p class="check_font" id="email2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
               <div class="col-sm-1-1">
                  <a id="btnTest" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>인증</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div><br />   
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;휴대전화</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userPhone" onblur="phoneCCheck()" id="userPhone" value="" placeholder="'-'빼고 숫자만 입력" style="font-size: 20px;">
               	  <p class="check_font" id="phone_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
            </div><br />
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>우편번호</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="text" id="userZipcode" name="userZipcode" class="form-control" value="" style="font-size: 20px;">
               	  <p class="check_font" id="zip_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
               <div class="col-sm-1-1">
                  <a id="btnAddr" onclick="execDaumPostCode()" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>검색</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div><br />   
            
            <div class="form-join d-flex justify-content-center" >
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;주소</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" id="userAddr1" name="userAddr1" class="form-control" value="" style="font-size: 20px;">
               	  <p class="check_font" id="addr1_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>   
            </div><br />
               
            <div class="form-join d-flex justify-content-center"> 
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>&nbsp;&nbsp;상세주소</b></label>
               </div>
               <div class="col-sm-4"> 
                  <input type="text" id="userAddr2" onblur="addr2CCheck()" name="userAddr2" class="form-control" value="" style="font-size: 20px;">
               	  <p class="check_font" id="addr2_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
               </div>
            </div><br />
                   
             <div class="text-center">
                 <input id="agree1" type="checkbox" class="form-check-input">&nbsp;
                 <label class="">
                     <a style="color:#554838">이용약관 동의(필수)</a>
                 </label><br/>
                 <input id="agree2" type="checkbox" class="form-check-input">&nbsp;
                 <label class="">
                     <span style="color:#554838">개인정보 수집∙이용 동의(필수)</span>
                 </label>
            </div>
            <input type="hidden" id="userPwd" name="userPwd" value="" /><br/>
            <div class="col-sm-12 text-center" >
               <a id="aReg" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>회원가입</b></a>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <a href="/main" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>취소</b></a>
            </div>
         </form>  
      </div>
   </div><br><br><br><br><br><br>
</body>
</html>