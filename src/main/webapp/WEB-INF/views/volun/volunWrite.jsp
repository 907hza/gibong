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
   function uploadSummernoteImageFile(file, el) 
   {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}


   $(document).ready(function() {
      //여기 아래 부분
      $('#summernote').summernote({
           height: 900,                 // 에디터 높이
           minHeight: null,             // 최소 높이
           maxHeight: null,             // 최대 높이
           focus: true,                 // 에디터 로딩후 포커스를 맞출지 여부
           lang: "ko-KR",            // 한글 설정
           callbacks : 
           { 
           	onImageUpload : function(files, editor, welEditable) 
           	{
           // 파일 업로드(다중업로드를 위해 반복문 사용)
           for (var i = files.length - 1; i >= 0; i--) 
           {
           uploadSummernoteImageFile(files[i],
           this);
           		}
           	}
           }
      });
      
      $("#btnUpload").on("click", function(){
    	  
    	  if($.trim($("#endRegDate").val()).length <= 0)
    	  {
    		  alert("모집 마감일을 선택해주세요.");
    		  $("#endRegdate").focus();
    		  return;
    	  }
    	  
    	  if($.trim($("#volunDae").val()).length <= 0)
    	  {
    		  alert("봉사 대상을 입력해주세요.");
    		  $("#volunDae").focus();
    		  return;
    	  }
    	  
    	  if($.trim($("#volunType").val()).length <= 0)
    	  {
    		  alert("봉사 분야를 선택해주세요.");
    		  $("#volunType").focus();
    		  return;
    	  }
    	  
    	  if($.trim($("#volunPeople").val()).length <= 0)
    	  {
    		  alert("모집 인원을 입력해주세요.");
    		  $("#volunPeople").focus();
    		  return;
    	  }
    	  
    	  if($.trim($("#volunDate").val()).length <= 0)
    	  {
    		  alert("봉사 날짜를 입력해주세요.");
    		  $("#volunDate").focus();
    		  return;
    	  }
    	  
    	  if($.trim($("#volunTime").val()).length <= 0)
    	  {
    		  alert("봉사 시간을 입력해주세요.");
    		  $("#volunTime").focus();
    		  return;
    	  }
    	  
    	  var form = $("#volunForm")[0];
    	  var formData = new FormData(form);
    	  
    	  $.ajax({
    		 type:"POST",
    		 enctype:"multipart/form-data",
    		 url:"/volun/writeProc",
    		 data:formData,
    		 processData:false,
			 contentType:false,
    		 cache:false,
    		 beforeSend:function(xhr)
    		 {
    			 xhr.setRequestHeader("AJAX", "true");
    		 },
    		 success:function(response)
    		 {
    			 
    		 },
    		 error:function(xhr, status, error)
    		 {
    			 icia.common.error(error);
    		 }
    		 
    	  });
      });
   });
   
	function fn_list()
	{
		document.bbsForm.action = "/volun/volunList";
		document.bbsForm.submit();
	}
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
                  <h1 id="font" style="color: #554838; font-size: 50px">봉사 작성</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <div class="container" ><br />
   <div class="bbttnnw" style="text-align: right;">
      <button type="button" id="btnUpload">등록</button>
      <button type="button" id="btnList" onclick="fn_list()">리스트</button>
   </div> 
   </div>
   
   <form name="volunForm" id="volunForm" method="post" enctype="multipart/form-data">
      <div align="center" style="width:100%;">
         <i class="bi bi-calendar"></i>&nbsp;<b>모집 마감일</b> <div class="col-sm-3">
            <input type="date" id="endRegdate" name="endRegdate" class="form-control" min="yyy" max="zzz">
            <input type="hidden" id="expDate" name="expDate">
         </div>
      </div>
      <br>
      <div class="form-join d-flex justify-content-center">
         <table style="width:550px; height: 170px">
            
            <tr>
               <th><i class="bi bi-bank"></i>&nbsp;봉사 대상</th>
               <td>&nbsp;<input type="text" id="volunDae" name="volunDae" value="" /></td>
               <th>&nbsp;<i class="bi bi-pin-map"></i>&nbsp;봉사 장소</th>
               <td><input type="text" id="userAddr" name="userAddr" value="${user.userAddr1} ${user.userAddr2}" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 분야</th>
               <td>&nbsp;<select id="volunType" style="width:165px; height:30px;" >
                     <option value="" selected >선택</option>
                     <option value="sang" <c:if test="${volunType eq 'sang'}" > selected </c:if>>생활편의지원</option>
                     <option value="ju" <c:if test="${volunType eq 'ju'}" > selected </c:if>>주거환경</option>
                     <option value="bo" <c:if test="${volunType eq 'bo'}" > selected </c:if>>보건의료</option>
                     <option value="dam" <c:if test="${volunType eq 'dam'}" > selected </c:if>>상담</option>
                     <option value="gyo" <c:if test="${volunType eq 'gyo'}" > selected </c:if>>교육</option>
                     <option value="ho" <c:if test="${volunType eq 'ho'}" > selected </c:if>>환경보호</option>
                  </select></td>
               <th>&nbsp;<i class="bi bi-person"></i>&nbsp;모집 인원</th>
               <td><input type="text" id="volunPeople" name="volunPeople" value="" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 날짜</th>
               <td>&nbsp;<input type="text" id="volunDate" name="volunDate" value="" /></td>
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
               <td>&nbsp;<input type="text" id="userName" name="userName" value="${user.userName}" /></td>
            </tr>
            
            <tr>
               <th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
               <td>&nbsp;<input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" /></td>
               <th><i class="bi bi-telephone"></i>&nbsp;전화</th>
               <td>&nbsp;<input type="text" id="userPhone" name="userPhone" value="${user.userPhone}" /></td>
            </tr>
         </table>
      </div>
   <!-- end breadcrumb section -->
   
   <!-- single article section -->
   <div class="mt-150 mb-150">
      <div class="container">
            <div class="col-lg-8" style="margin: 0 auto;">
               <div class="single-article-section" style="margin: 0 auto;">
                  <div class="single-article-text">
                     <div>
                     </div> 
                       <textarea id="summernote" name="editordata"></textarea>
                  </form>
                  </div>
               </div>
            </div>
      </div>
   </div>
   <!-- end single article section -->
       <br><br><br><br><br><br><br><br><br>
    <form name="bbsForm" id="bbsForm" method="post" >
    	<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="" />
    </form>
</body>
</html>