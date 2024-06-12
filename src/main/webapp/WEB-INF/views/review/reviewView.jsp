<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		table {
		  border-collapse: collapse;
		  width: 100%;
		  background-color: white;
		}
		
		thead{
		  box-shadow: 4px 4px 10px rgba(0,0,0,0.1);
		}
		
		/* 테이블 행 */
		td {
		  padding: 5px;
		  text-align: left;
		  border-bottom: 1px solid #ddd;
		  text-align: center;
		}
		
		th {
			padding: 7px;
		}
		
		/* 테이블 비율 */
		th:nth-child(1),
		td:nth-child(1) {
		  width:20%;
		}
		
		th:nth-child(2),
		td:nth-child(2) {
		  width: 40%;
		}
		
		th:nth-child(3),
		td:nth-child(3) {
		  width: 90%;
		}
		
		th, td {
		  border-left: none;
		  border-right: none;
		}
		
		textarea, button {
			vertical-align: middle;
		}
	</style>
	<script type="text/javascript">
    
	var cookieUserId = '<c:out value="${cookieUserId}" />';
	
	function fn_delete(reviewReplyseq) // 댓글 삭제용 함수
	{
		$("#reviewReplySeq").val(reviewReplyseq);
		
		if(confirm("댓글을 삭제하시나요?") == true)
		{
			$.ajax({
				type:"POST",
				url:"/review/replyDelete",
				data:{
					reviewSeq:'${reviewSeq}',
					reviewReplySeq:$("#reviewReplySeq").val()
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
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					else if(response.code == 404)
					{
						alert("해당 글이 존재하지 않습니다.");
					}
					else if(response.code == 405)
					{
						alert("해당 댓글이 존재하지 않습니다.");
					}
					else if(response.code == 410)
					{
						alert("댓글 삭제 중 오류가 발생했습니다.");
					}
					else
					{
						alert("댓글 삭제 중 알 수 없는 오류가 발생했습니다.");
					}
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});
		}
	}
	
	 function fnReply2() 
	 {
	        var replyFormContainer = $("#replyFormContainer");
	        
	       replyFormContainer.show(); 
	 }
		
    $(document).ready(function(){
			
			$("#btnReply").on("click", function(){
				
				if($.trim('<c:out value="${cookieUserId}" />').length <= 0)
				{
					document.getElementById('cookie_check').innerHTML = "댓글 작성은 로그인이 필요합니다.";
					return;
				}
				
				if($.trim($("#comment").val()).length <= 0)
				{
					document.getElementById('cookie_check').innerHTML = "내용을 입력해주세요";
					return;
				}
				
				$.ajax({
					type:"POST",
					url:"/review/replyProc",
					data:{
						reviewSeq:'${reviewSeq}',
						comment:$("#comment").val()
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
							location.reload();
						}
						else if(response.code == 400)
						{
							alert("입력값이 올바르지 않습니다.");
						}
						else if(response.code == 404)
						{
							alert("해당 게시물이 존재하지 않습니다.");
						}
						else if(response.code == 450)
						{
							alert("댓글 등록 중 오류가 발생했습니다.");
						}
						else
						{
							alert("댓글 등록 중 알 수 없는 오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
				
			});
			
			$("#btnReply2").on("click", function(){
				
				if($.trim('<c:out value="${cookieUserId}" />').length <= 0)
				{
					document.getElementById('cookie_check').innerHTML = "댓글 작성은 로그인이 필요합니다.";
					return;
				}
				
				if($.trim($("#comment2").val()).length <= 0)
				{
					document.getElementById('cookie_check').innerHTML = "내용을 입력해주세요";
					return;
				}
				
				$.ajax({
					type:"POST",
					url:"/review/replyProc2",
					data:{
						reviewSeq:'${reviewSeq}',
						comment:$("#comment2").val()
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
							location.reload();
						}
						else if(response.code == 400)
						{
							alert("입력값이 올바르지 않습니다.");
						}
						else if(response.code == 404)
						{
							alert("해당 게시물이 존재하지 않습니다.");
						}
						else if(response.code == 450)
						{
							alert("댓글 등록 중 오류가 발생했습니다.");
						}
						else
						{
							alert("댓글 등록 중 알 수 없는 오류가 발생했습니다.");
						}
					},
					error:function(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
			})
			
			$("#btnList").on("click", function(){
				
				document.bbsForm.reviewSeq.value = '<c:out value="${reviewSeq}" />';
				document.bbsForm.action = "/review/reviewList";
				document.bbsForm.submit();
			});
			
			$("#btnUpdate").on("click", function(){
				
				document.bbsForm.reviewSeq.value = '<c:out value="${reviewSeq}" />';
				document.bbsForm.action = "/review/reviewUpdate";
				document.bbsForm.submit();
			});
			
			$("#btnDelete").on("click", function(){
				
				if(confirm("글을 삭제하시나요?") == true)
				{
					$.ajax({
						type:"POST",
						data:{
							reviewSeq:<c:out value="${reviewSeq}" />	
						},
						url:"/review/reviewDeleteProc",
						beforeSend:function(xhr)
						{
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response)
						{
							if(response.code == 0)
							{
								alert("게시물이 삭제되었습니다.");
								location.href = "/review/reviewList";
							}
							else if(response.code == 400)
							{
								alert("입력 값이 올바르지 않습니다.");
							}
							else if(repsonse.code == 404)
							{
								alert("해당하는 게시물이 존재하지 않습니다.");
							}
							else if(response.code == 410)
							{
								alert("삭제 권한이 존재하지 않습니다.");
							}
							else if(response.code == 450)
							{
								alert("게시물 삭제 중 오류가 발생했습니다.");
							}
							else
							{
								alert("게시물 삭제 중 알 수 없는 오류가 발생했습니다.");
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
<body>
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
					<p>♥ 오늘도 기봉이와 착한 일 하나 ♥</p>
						<h1 id="font" style="color: #554838; font-size: 50px">봉사후기</h1>
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
						
							<div>
							<c:if test="${not empty review.reviewFile}">
							<c:forEach var="reviewFile" items="${review.reviewFile}" varStatus="status" >
									<img style="width:100%;" src="/resources/upload/review/${reviewFile.fileName}" />
							</c:forEach>
							</c:if>
							</div>
							
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i> 봉사활동 내역</th>
								      </tr>
								    </thead>
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
								  </table>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
							<h2>${review.reviewTitle}</h2>
							<pre style="font-size:17px;">${review.reviewContent}</pre>
						</div>
						
						<div class="comments-list-wrap">
						
						<div class="bbttnnw" style="text-align: right;">
						 <button type="button" id="btnList">리스트</button>
					<c:if test="${cookieUserId eq review.userId}" >	 
						 <button type="button" id="btnUpdate">수정</button>
						 <button type="button" id="btnDelete">삭제</button>
					</c:if>	 
						</div>
						
							<hr class="hr-8" style="border: 0; background-color: #fff; border-top: 2px dotted #8c8c8c;">
						
						<div class="comment-template"><br />
							<h4>댓글달기</h4>
							<form>
								<p><textarea name="comment" id="comment" cols="30" rows="10" placeholder="댓글을 남겨보세요.">
								   </textarea> <button type="button" id="btnReply" style="float: right;   background-color: #FFCC80;
																										  color: #051922;
																										  font-weight: 700;
																										  text-transform: uppercase;
																										  font-size: 15px;
																										  border: none !important;
																										  cursor: pointer;
																										  padding: 10px 15px;
																										  border-radius: 3px;">등록</button>
								   </p>
								   <p class="check_font" id="cookie_check" style="color:#fd8505; font-size: 13px; margin-top: 0px;"></p>
							</form>
						</div>
						
						
						<!--                  댓글                   -->
							<div class="comment-list">
								<div class="single-comment-body">
									<br /><br />
									<p>
									<c:forEach var="reply" items="${review.reviewReply}" varStatus="status" >
									<c:choose>
									<c:when test="${reply.reviewReplyIndent eq 0}">
									<div class="comment-text-body">
									<c:if test="${reply.replyDelFlag eq 'X'}">
										<h5>${reply.userName} <span class="comment-date">${reply.regdate}</span> <a href="javascript:void(0);" onclick="fnReply2()">답글쓰기</a>
											<c:if test="${cookieUserId eq reply.userId}" >
											<a href="javascript:void(0)" onclick="fn_delete(${reply.reviewReplySeq})">삭제</a>
											</c:if></h5>
										<p>${reply.reviewReplyContent}</p>
										
									<div class="comment-template" id="replyFormContainer" style="display: none;">
				                        <img src="/resources/images/icon_reply.gif" style="margin-left:1em" />
				                        <form id="replyForm2" name="replyForm2" method="POST">
				                        <div>
				                           <textarea name="comment2" id="comment2" cols="10" rows="10" placeholder="댓글을 남겨보세요." style="height: 100px"></textarea>
				                           <a href="javascript:void(0);" onclick="fnReply2()">답글쓰기</a>&nbsp;&nbsp;&nbsp;
				                           <c:if test="${cookieUserId eq reply.userId}" >
				                           <a href="javascript:void(0)" onclick="fn_delete(${reply.reviewReplySeq})">  삭제</a>
				                           </c:if>
				                        </div>   
				                        </form>
				                        <br/>
				                    </div>
									</c:if>
									 

				                    
									<c:if test="${reply.replyDelFlag eq 'Y'}" >
										<h5><span class="comment-date"></span></h5>
										<p>삭제된 댓글입니다.</p>
									</c:if>
									</div>
									</c:when>
									
									<c:otherwise>
									<div class="single-comment-body child">
										<div class="comment-text-body">
										<c:if test="${reply.replyDelFlag eq 'X'}">
											<h5>${reply.userName} <span class="comment-date">${reply.regdate}</span> <a href="javascript:void(0);" onclick="fnReply2()">답글쓰기</a> 
												<c:if test="${cookieUserId eq reply.userId}" >
												<a href="javascript:void(0)" onclick="fn_delete(${reply.reviewReplySeq})">삭제</a>
												</c:if></h5>
											<p>${reply.replyContent}</p>
										</c:if>
										 <div class="comment-template" id="replyFormContainer" style="display: none;">
										 <img src="/resources/images/icon_reply.gif" style="margin-left:1em" />
					                        <form id="replyForm2" name="replyForm2" method="POST">
					                        <div>
					                           <textarea name="comment2" id="comment2" cols="10" rows="10" placeholder="댓글을 남겨보세요." style="height: 100px"></textarea>
					                           <button type="button" id="btnReply2" style="float: right; margin-top:35px;">  등록</button>
					                        </div>   
					                        </form>
					                        <br/>
					                    </div>
					                    
										<c:if test="${reply.reviewReplyDelFlag eq 'Y'}" >
											<div class="comment-text-body">
											<p>삭제된 댓글입니다.</p></div>
										</c:if>
										</div>
									</div>
									</c:otherwise>
									</c:choose>
									</c:forEach>
									
									<div class="comment-template" id="replyFormContainer" style="display: none;">
                        			<form id="replyForm2" name="replyForm2" method="POST">
                       			    <div>
                       			    <img src="/resources/images/icon_reply.gif" style="margin-left:1em" />
                                    <textarea name="comment2" id="comment2" cols="10" rows="10" placeholder="댓글을 남겨보세요." style="height: 100px"></textarea>
                                    <button type="button" id="btnReply2" style="float: right; margin-top:35px;">등록</button>
                        </div>   
                        </form>
                        <br/>
                        </div>
								</div>
							</div>
						<!--                  댓글                   -->
						</div>

					</div>
				</div>
				<div class="col-lg-4">
					<div class="sidebar-section">
						<div class="recent-posts">
						<c:if test="${!empty list}">
							<h4>최근 게시물</h4>
							<ul>
							<c:forEach var="review" items="${list}" varStatus="status">
								<li><a href="/review/reviewView?reviewSeq=${review.reviewSeq}">${review.reviewTitle}</a></li>
							</c:forEach>
							</ul>
						</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end single article section -->
	
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="reviewReplySeq" id="reviewReplySeq" value="" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="${reviewSeq}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
	</form>
</body>
</html>