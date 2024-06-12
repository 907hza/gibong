<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>	
<style type="text/css">
	.excerpt {
        display: block;
        font-size: 14px;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
	}
	
	.img {
	    width:350px;
	    height:200px;
	    overflow:hidden;
	    margin:0 auto;
	}

	#author {
		font-size : 15px;
	}
	
	#date {
		font-size : 15px;
	}
	
	#title {
        display: block;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 1 ;
        -webkit-box-orient: vertical;
	}
	
	#news {
		width: 350px; height: 500px
	}
	
	.select {
  width: 120px;
  height: 32px;
  background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
  background-size: 20px;
  padding: 5px 30px 5px 10px;
  border-radius: 4px;
  outline: 0 none;
}
.select option {
  width: 120px;
  height: 32px;
  background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
  background-size: 20px;
  padding: 5px 30px 5px 10px;
  border-radius: 4px;
  outline: 0 none;
}

 .btn55{
  background-color: #bccc80;
  color: #051922;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 15px;
  border: none !important;
  cursor: pointer;
  padding: 4px 20px;
  border-radius: 8px;
}
	
</style>
<script>

	function fn_view()
	{
		document.bbsForm.viewFlag.value = "read";
		document.bbsForm.action = "/review/reviewList";
		document.bbsForm.submit();
	}
	
	function fn_like()
	{
		document.bbsForm.viewFlag.value = "like";
		document.bbsForm.action = "/review/reviewList";
		document.bbsForm.submit();
	}
	
	function fn_recent()
	{
		document.bbsForm.viewFlag.value = "recently";
		document.bbsForm.action = "/review/reviewList";
		document.bbsForm.submit();
	}
	
	function fn_reviewView(reviewseq)
	{
		document.bbsForm.reviewSeq.value = reviewseq;
		document.bbsForm.action = "/review/reviewView";
		document.bbsForm.submit();
	}
	
	function fn_list(curPage)
	{
		document.bbsForm.curPage.value = curPage;
		document.bbsForm.action = "/review/reviewList";
		document.bbsForm.submit();
	}
	
	$(document).ready(function(){

		$("#btnSearch").on("click", function(){
			
			document.bbsForm.searchType.value = $("#searchType").val();
			document.bbsForm.searchValue.value = $("#searchValue").val();
			document.bbsForm.reviewSeq.value = "";
			document.bbsForm.action = "/review/reviewList";
			document.bbsForm.submit();
			
		});
	});
</script>

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="height:80px" >
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
	</div><br />

	<div style="float:right;width:35%;">
	<select id="searchType" name="searchType" class="select">
		<option value="name" <c:if test="${searchType eq 'name'}"> selected </c:if> >작성자</option>
		<option value="title" <c:if test="${searchType eq 'title'}"> selected </c:if> >제목</option>
		<option value="content" <c:if test="${searchType eq 'content'}"> selected </c:if> >내용</option>
	</select>
	<input type="text" name="searchValue" id="searchValue" value="${searchValue}" />
	<input type="button" name="btnSearch" id="btnSearch" class="btn55" value="조회" />
	</div>
	
	<!-- latest news -->
	<div class="latest-news mt-150 mb-150" style="margin-top: 50px" >
		<div class="container">
			<div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                            <li class="active" data-filter="*" onclick="fn_recent()" >최신순</li>
                            <li data-filter=".정기후원" onclick="fn_view()" >조회순</li>
                            <li data-filter=".일시후원" onclick="fn_like()" >추천순</li>
                        </ul>
                    </div>
                </div>
            </div>
  <div class="row">
<c:if test="${!empty list}">
    <c:forEach var="review" items="${list}" varStatus="status">
        <div class="col-lg-4 col-md-6">
            <div class="single-latest-news" id="news">
                <div class="latest-news-bg">
                        <c:if test="${not empty review.reviewFile}">
                            <img class="img" src="/resources/upload/review/${review.reviewFile[0].fileName}" />
                        </c:if>
                        <c:if test="${empty review.reviewFile}">
                            <img class="img" src="/resources/upload/review/05.jpeg" />
                        </c:if>
                </div>
                <div class="news-text-box">
                    <h3 id="title"><a href="javascript:void(0)" onclick="fn_reviewView(${review.reviewSeq})">${review.reviewTitle}</a></h3>
                    <p class="blog-meta">
                        <span class="author" id="author"><i class="fas fa-user"></i>${review.userName}</span>
                        <span class="date" id="date"><i class="fas fa-calendar"></i>${review.regdate}</span>
                    </p>
                    <p id="excerpt" class="excerpt">${review.reviewContent}</p>
                    <div>
                        <div align="left" style="font-size: 16px">
                            <i class="bi bi-suit-heart-fill"></i>&nbsp;${review.reviewReadCnt}&nbsp;
                            <i class="bi bi-chat-dots"></i>&nbsp;${review.reviewLikeCnt}
                        </div>
                    </div>
                    <a href="javascript:void(0)" onclick="fn_reviewView(${review.reviewSeq})" class="read-more-btn">자세히 <i class="fas fa-angle-right"></i></a>
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>

</div>
<c:if test="${!empty paging}" >
				<div class="row">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<div class="pagination-wrap">
								<ul>
								
								<c:if test="${paging.prevBlockPage gt 0}">
								<li><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전 페이지</a></li>
								</c:if>
								
								<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
									<c:choose>
										<c:when test="${i ne curPage}" >
											<li><a href="javascript:void(0)" onclick="fn_list(${i})" >${i}</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="javascript:void(0)" >${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
									
								<c:if test="${paging.nextBlockPage gt 0}" >
								<li><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음 페이지</a></li>
								</c:if>
								
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		  </div>
	  </div><br /><br /><br /><br />
</c:if>
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="viewFlag" id="viewFlag" value="${viewFlag}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="${reviewSeq}" />
	</form>
</body>
</html>