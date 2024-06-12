<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		#volunForm button[type="button"] {
		    /* background-color: #FFCC80; */
		    color: #051922;
		    font-weight: 700;
		    text-transform: uppercase;
		    font-size: 15px;
		    /* border: none !important; */
		    cursor: pointer;
		    /* padding: 15px 25px; */
		    /* border-radius: 3px;
		    }
	    element.style {
		    height: 900px;
		}
		table{
			border:0 white;
		}
	</style>
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>

	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<script>
	$(document).ready(function() {
		//여기 아래 부분
		$('#summernote').summernote({
			  height: 900,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                 // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",			   // 한글 설정
	          
		});
	});
	</script>
</head>
<body>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
     <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">봉사 수정</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <div class="container"><br />
   <div class="bbttnnw" style="text-align: right;">
		<button type="button" id="btnUpload">등록</button>
		<button type="button" id="btnList">리스트</button>
   </div> 
   
   <form name="volunForm" id="volunForm" method="post" >
      <div align="center" style="width:100%;">
	      <i class="bi bi-calendar"></i>&nbsp;<b>모집 마감일</b> <div class="col-sm-3">
            <input type="date" id="datepicker" class="form-control" min="yyy" max="zzz">
            <input type="hidden" id="expDate" name="expDate">
         </div>
      </div>
      <br>
      <div class="form-join d-flex justify-content-center">
         <table style="width:550px; height: 170px">
            
            <tr>
               <th><i class="bi bi-bank"></i>&nbsp;봉사 대상</th>
               <td>&nbsp;<input type="text" id="volunHumen" name="volunHumen" value="" /></td>
               <th>&nbsp;<i class="bi bi-pin-map"></i>&nbsp;봉사 장소</th>
               <td><input type="text" id="volunPlace" name="volunPlace" value="" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 분야</th>
               <td>&nbsp;<input type="text" id="volunKind" name="volunKind" value="" /></td>
               <th>&nbsp;<i class="bi bi-person"></i>&nbsp;모집 인원</th>
               <td><input type="text" id="volunMyung" name="volunMyung" value="" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 날짜</th>
               <td>&nbsp;<input type="text" id="volunDay" name="volunDay" value="" /></td>
               <th>&nbsp;<i class="bi bi-card-list"></i>&nbsp;봉사 시간</th>
               <td><input type="text" id="volunTime" name="volunTime" value="" /></td>
            </tr>
            
         </table>
      </div><br />
      <div class="form-join d-flex justify-content-center" style="width:600px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
      <div class="form-join d-flex justify-content-center">
         <table style="width:560px; height: 100px">
            <tr>
               <th><i class="bi bi-building"></i>&nbsp;봉사기관</th>
               <td>&nbsp;<input type="text" id="userName" name="userName" value="" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
               <td>&nbsp;<input type="text" id="userEmail" name="userEmail" value="" /></td>
               <th><i class="bi bi-telephone"></i>&nbsp;전화</th>
               <td>&nbsp;<input type="text" id="userPhone" name="userPhone" value="" /></td>
            </tr>
         </table>
      </div>
      </form>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
							</div> 

							<form method="post">
							  <textarea id="summernote" name="editordata"></textarea>
							</form>
						</div>
					</div>
				</div>
		</div>
	</div>
	<!-- end single article section -->
</body>
</html>