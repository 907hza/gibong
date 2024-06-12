<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
		textarea{
		    min-width: 100%;
		    min-height: 100rem;
		    overflow-y: hidden;
		    resize: none;
		    border: 0 white;
		}
		textarea:focus{
			outline: none;
		}
	</style>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script>
	function showFileName() 
	{ 
		var input = document.getElementById('customFile'); 
		var fileName = input.files[0].name; 
		var label = document.getElementById('fileName'); label.textContent = fileName; 
	}
	
	$(document).ready(function(){
		
		$("#btnList").on("click", function(){
			
			document.bbsForm.action = "/review/reviewList";
			document.bbsForm.submit();
		});
		
		$("#btnUpload").on("click", function(){
			
			if($.trim($("#reviewTitle").val()).length <= 0)
			{
				alert("제목을 입력해주세요.");
				$("#reviewTitle").val("");
				$("#reviewTitle").focus();
				return;
			}
		
			if($.trim($("#reviewContent").val()).length <= 0)
			{
				alert("내용을 입력해주세요.");
				$("#reviewContent").val("");
				$("#reviewContent").focus();
				return;
			}
	
			var form = $("#UpdateForm")[0];
			var formData = new FormData(form);
			
			$.ajax({
				type:"POST",
				enctype:"multipart/form-data",
				url:"/review/reviewUpdateProc",
				data:formData,
				contentType: false,
		         processData: false,
				beforeSend:function(xhr)
				{
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response)
				{
					if(response.code == 0)
					{
						alert("게시물이 수정되었습니다.");
						
						document.bbsForm.reviewSeq.value = '<c:out value="${review.reviewSeq}" />';
						document.bbsForm.action = "/review/reviewView";
						document.bbsForm.submit();
					}
					else if(response.code == 400)
					{
						alert("입력 값이 올바르지 않습니다.");
					}
					else if(response.code == 404)
					{
						alert("해당 게시물이 존재하지 않습니다.");
					}
					else if(response.code == 410)
					{
						alert("게시물을 수정할 수 있는 권한이 없습니다.");
					}
					else if(response.code == 510)
					{
						alert("게시물 수정 중 오류가 발생했습니다.");
					}
					else
					{
						alert("게시물 수정 중 알 수 없는 오류가 발생했습니다.");
					}
				},
				error:function(error)
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
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
						<p>♥ 오늘도 기봉이와 착한 일 하나 ♥</p>
						<h1 id="font" style="color: #554838; font-size: 50px">봉사후기 글 수정</h1>
							<div>
							</div>
						<div class="bbttnnw" style="text-align: right;">
						 <button type="button" id="btnUpload">등록</button>
						 <button type="button" id="btnList">리스트</button>
						</div>
						<span>
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i> 봉사활동 내역</th>
								      </tr>
								    </thead>
								    <br />
								    <tbody>
								      <tr>
								        <td>글쓴이</td>
								        <td>${review.userName}</td>
								      </tr>
								      <tr>
								        <td>작성일자</td>
								        <td>${review.regdate}</td>
								      </tr>
								      <tr>
								        <td>봉사분야</td>
								        <td>생활편의지원</td>
								      </tr>
								      <tr>
								        <td>모집기관</td>
								        <td>사랑의 집</td>
								      </tr>
								    </tbody>
								 </table><br />
						</span>	  

					<form name="UpdateForm" id="UpdateForm" method="post" enctype="multipart/form-data">
							<!-- 이미지 미리보기 시작 -->
							  <div id="image_preview">
							    <div class="custom-file"> <input class="custom-file-input" id="customFile" type="file" name="reviewFiles" onchange="showFileName()" multiple="multiple"/> 
							    <label class="custom-file-label" for="customFile" id="fileName">파일선택</label> </div>
							  </div>
							
							<span>
							<div style = "padding: 5px 1px 7px 3px;"></div>
							<h2><input type="text" id="reviewTitle" name="reviewTitle" placeholder="제목" style="outline: none; border:0px;" value="${review.reviewTitle}"/></h2>
							<hr class="hr-3" />
							<img id="preview" onchange="readURL(this);" onkeydown="resize(this)" onkeyup="resize(this)"/>
						
							<textarea class="newTweetContent" id="reviewContent" name="reviewContent" onkeydown="resize(this)" onkeyup="resize(this)" >${review.reviewContent}</textarea>
							</span>
							<input type="hidden" name="reviewSeq" id="reviewSeq" value="${review.reviewSeq}" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!-- end single article section -->
	
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="${review.reviewSeq}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
	</form>
	
</body>
</html>