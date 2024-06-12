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
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">나의 봉사활동</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <br/>
    <!-- Main Content -->
    <div class="container" >
      <div style="display: flex; justify-content: center;">
         <table class="table-auto " style="width:900px; justify-content: center;" >
           <tbody>
             <tr >
               <td class="px-4" style="width:500px; height:100px; margin-right:10px">
                 <p style="font-size: 20px;" class="font-semibold"><a href="/volunteer/volunView" style="color: #554838">한파대비 연탄봉사</a></p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">봉사일 : 2024.05.06</p>
               </td>
               <td>
                 <button type="button" id="btnReply" style="float: right; margin-top:35px; background-color: #dede9e; margin-right: 0px">승인대기</button>
               </td>
               <td>
               
               </td>
             </tr>
             <tr >
               <td class="px-4" style="width:500px; height:100px; margin-right:10px;color: #554838">
                 <p style="font-size: 20px; color:#554838" class="font-semibold"><a href="/volunteer/volunView" style="color: #554838">사랑의 로켓배송 : 도시락 배달</a></p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">봉사일 : 2024.03.06</p>
               </td>
               <td>
                 <button type="button" id="btnReply" style="float: right; margin-top:35px; margin-right: 0px">봉사완료</button>
               </td>
            <td style="margin-left: 0px; width:100px">
                  <button type="button" id="btnReply" style="float: right; margin-top:35px; background-color: #B9E0FD;" onclick="location.href='/review/reviewWrite'">후기작성</button>
               </td>
             </tr>
           </tbody>
         </table>
      </div>
       <div class="row">
            <div class="col-lg-12 text-center">
               <div class="pagination-wrap">
                  <ul>
                     <li><a href="#">Prev</a></li>
                     <li><a href="#">1</a></li>
                     <li><a class="active" href="#">2</a></li>
                     <li><a href="#">3</a></li>
                     <li><a href="#">Next</a></li>
                  </ul>
               </div>
            </div>
         </div>
    </div>
    <br><br>
</body>
</html>
</body>
</html>