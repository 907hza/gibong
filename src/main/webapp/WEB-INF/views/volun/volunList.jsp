<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
  body {
    font-family: 'Open+Sans', sans-serif;
  }
</style>

<script>
	function fn_write()
	{
		document.bbsForm.action = "/volun/volunWrite";
		document.bbsForm.submit();
	}
	
	function fn_list(curpage)
	{
		document.bbsForm.curPage.value = curpage;
		document.bbsForm.action = "/volun/volunList";
		document.bbsForm.submit();
	}
	
	function fn_volunList()
	{
		document.bbsForm.action = "/volun/volunList";
		document.bbsForm.submit();
	}
	
	function fn_view(volunseq)
	{
		document.bbsForm.volunSeq.value = volunseq;
		document.bbsForm.action = "/volun/volunView";
		document.bbsForm.submit();
	}
	
	function fn_moList()
	{
		document.bbsForm.action = "/volun/volunMoList";
		document.bbsForm.submit();
	}
	
	$(document).ready(function(){
		
		$("#btnMagam").on("click", function(){
			alert("모집이 마감되었습니다.");
			return;
		});
	});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
               	  <p>♥ 오늘도 기봉이와 착한 일 하나 ♥</p>
                  <h1 id="font" style="color: #554838; font-size: 50px">봉사활동</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <br/>
    <!-- Main Content -->
    <div class="container" >
      <div class="row">
          <div class="col-md-12">
              <div class="product-filters">
                  <ul>
                      <li class="active" data-filter="*"><a href="#" style="color:#554838;" onclick="fn_volunList()">All</a></li>
                      <li data-filter="."><a href="#" style="color:#554838;" onclick="fn_volunList()">최신순</a></li>
                      <li data-filter="."><a href="#" onclick="fn_moList()" style="color:#554838;">모집 중</a></li>
                      
                      <c:if test="${user.userFlag eq 'G'}" >
                      <li style="background-color:aliceblue; border:white;"><a href="#" style="color:#554838;" onclick="fn_write()">글쓰기</a></li>
                      </c:if>
                      
                  </ul>
              </div>
          </div>
      </div>
      
      <div style="display: flex; justify-content: center;">
         <table class="table-auto " style="width:900px; justify-content: center;" >
           <tbody>
           <c:if test="${!empty list}">
           <c:forEach var="volun" items="${list}" varStatus="status" >
             <tr>
               <td class="align-top">
              <c:if test="${empty volun.volunFile}" >
                 <img style="width:300px; height:170px;" src="/resources/assets/img/products/202.jpeg">
              </c:if>
              <c:if test="${not empty volun.volunFile}">
			     <img style="width:300px; height:170px;" src="/resources/upload/volun/${volun.volunFile.fileName}.jpeg">
			  </c:if>
               </td>
               <td class="px-4">
                 <p style="font-size: 20px" class="font-semibold">${volun.volunTitle}</p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">모집기간 : ${volun.regdate} ~ ${volun.endRegdate}</p>
               </td>
               <td>
               <c:if test="${volun.volunDelFlag eq 'Y'}" >
                 <button type="button" id="btnMagam" style="float: right; background-color:silver;border-radius:10px; width:70px;margin-top:35px;">	
                 	모집 마감
                 </button>
               </c:if>
               <c:if test="${volun.volunDelFlag eq 'X'}" >
                 <button type="button" id="btnTogether" style="float: right; background-color:powderblue; border-radius:10px;width:70px;margin-top:35px;" onclick="fn_view(${volun.volunSeq})">	
                 	<strong>모집 중</strong>
                 </button>
               </c:if>
               </td>
             </tr>
             <tr>
               <td colspan="4" class="py-4">
                 <div class="border-t-2 border-gray-200"></div>
               </td>
             </tr>
             </c:forEach>
             </c:if>
           </tbody>
         </table>
      </div>
      
      <c:if test="${!empty paging}" >
       <div class="row">
            <div class="col-lg-12 text-center">
               <div class="pagination-wrap">
                  <ul>
                  <c:if test="${paging.prevBlockPage gt 0}" >
                     <li><a href="#" onclick="fn_list(${paging.prevBlockPage})">이전 페이지</a></li>
                  </c:if>
                  <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" varStatus="status" >
                  <c:choose>
                  <c:when test="${i ne curPage}">
                     <li><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                  </c:when>
                  <c:otherwise>
                     <li><a class="active" href="javascript:void(0)">${i}</a></li>
                  </c:otherwise>
                  </c:choose>
                  </c:forEach>
                  <c:if test="${pagingnextBlockPage gt 0}" >
                     <li><a href="#" onclick="fn_list(${paging.nextBlockPage})">다음 페이지</a></li>
                  </c:if>
                     
                  </ul>
               </div>
            </div>
         </div>
        </c:if>
        
    </div>
    <br><br><br><br><br><br><br><br><br>
    <form name="bbsForm" id="bbsForm" method="post" >
    	<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="volunSeq" id="volunSeq" value="" />
    </form>

</body>
</html>
</body>
</html>