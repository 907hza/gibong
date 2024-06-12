<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
.font {
	color: #554838;
	font-size: 20px;
}
</style>

<script>
	$(document).ready(function(){
		
		$("#btnReset").on("click", function(){
			
			if(confirm("정말 기봉이를 떠나실건가요?") == true)
			{
				if(confirm("마지막으로 물어볼게요.. 진심인가요?") == true)
				{
					$.ajax({
						type:"POST",
						url:"/user/statusUpdate",
						datatype:"JSON",
						beforeSend:function(xhr)
						{
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response)
						{
							if(response.code == 0)
							{
								alert("회원 탈퇴가 완료되었습니다.");
								location.href = "/main";
							}
							else if(response.code == 400)
							{
								alert("입력 값이 올바르지 않습니다.");
							}
							else if(response.code == 404)
							{
								alert("해당 회원이 존재하지 않습니다.");
							}
							else if(response.code == 410)
							{
								alert("회원 탈퇴 중 오류가 발생했습니다.");
							}
							else
							{
								alert("회원 탈퇴 중 알 수 없는 오류가 발생했습니다.");
							}
						},
						error:function(xhr, status, error)
						{
							icia.common.error(error);
						}
					});
				}
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
                  <h1 id="font" style="color: #554838; font-size: 50px">나의 정보</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
	<div class="container">
	<br><br />
		<div style="width:100%" align="center" class="font"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="flag"><b>회원구분</b></label>
					</div>
					<div class="col-sm-2" style="font-size: 20px">
						<c:if test="${user.userFlag eq 'G'}">기업 회원</c:if>
						<c:if test="${user.userFlag eq 'U'}">개인 회원</c:if>
					</div>
				</div><br />
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label><b>아이디</b></label>
					</div>
					<div class="col-sm-2"> 
						${user.userId}
					</div>
				</div><br />
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="name"><b>이름</b></label>
					</div>
					<div class="col-sm-2">
						${user.userName}
					</div>
				</div><br />        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="email"><b>이메일</b></label>
					</div>
					<div class="col-sm-2">
						${user.userEmail}
					</div>
				</div><br />   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="phone"><b>휴대전화</b></label>
					</div>
					<div class="col-sm-2">
						${user.userPhone}
					</div>
				</div><br />
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="postcode"><b>우편번호</b></label>
					</div>
					<div class="col-sm-2">
						${user.userZipcode}
					</div>
				</div><br />   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-2 control-label">
						<label id="address"><b>주소</b></label>
					</div>
					<div class="">
						 ${user.userAddr1}
					</div>   
				</div><br />
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-2 control-label">
						<label id="detailAddress"><b>상세주소</b></label>
					</div>
					<div class="col-sm-2"> 
						${user.userAddr2}
					</div>
				</div><br />
			    <br>      
				<input type="hidden" id="userId" name="userId" value="" /> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg btn-warning" onclick="location.href='/user/infoUpdate'" style="font-size: 20px; background-color: #FFCC80;">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg btn-warning" style="font-size: 20px; background-color: #FFCC80;">탈퇴</button>
				</div><br><br><br><br><br><br><br><br><br>
		</div>
	</div>
</body>
</html>