<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<!-- 관리자 -->
<title>관리자</title>
<link rel="shortcut icon" href="/resources/manager/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/resources/manager/css/styles.css">
<link type="text/css" href="/resources/manager/css/jquery.colorbox.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/manager/js/jquery.js"></script>
<script type="text/javascript" src="/resources/manager/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="/resources/manager/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/manager/js/icia.ajax.js"></script>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
html, body{
  color:  #525252;
}
table{
  width:100%;
  border: 1px solid #c4c2c2;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding-left: .5rem;
  padding-right: 1rem;
}
table th{
  background-color: #e0e4fe;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
}
button{
  width: 5rem;
  margin-top: 1rem;
  border: .1rem solid rgb(204,204,204);
  border-radius: .2rem;
  box-shadow: 1px 1px #666;
}
button:active {
  background-color: rgb(186,186,186);
  box-shadow: 0 0 1px 1px #666;
  transform: translateY(1px);
}
</style>
<script type="text/javascript" src="/resources/js/colorBox.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
   $("#schName").focus();
});

function fn_userUpdate()
{
   icia.ajax.post({

   });
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

function fn_idPwdCheck(val)
{
   var regex = /^[a-zA-Z0-9]{4,12}$/;

   return regex.test(val);
}
</script>
</head>
<body>
<div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">사용자 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
               <tr>
                  <th scope="row">아이디</th>
                  <td>
                     아이디
                     <input type="hidden" id="userId" name="userId" value="아이디" />
                  </td>
                  <th scope="row">비밀번호</th>
                  <td>
                     <input type="text" id="userPwd" name="userPwd" value="비밀번호" style="font-size:1rem;;" maxlength="15" placeholder="비밀번호" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">이름</th>
                  <td>
                     <input type="text" id="userName" name="userName" value="이름" style="font-size:1rem;;" maxlength="50" placeholder="이름" />
                  </td>
                  <th scope="row">이메일</th>
                  <td>
                     <input type="text" id="userEmail" name="userEmail" value="이메일" style="font-size:1rem;;" maxlength="50" placeholder="이메일" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">상태</th>
                  <td>
                     <select id="status" name="status" style="font-size: 1rem; width: 7rem; height: 2rem;">
                        <option value="Y">정상</option>
                        <option value="N">정지</option>
                     </select>
                  </td>
                  <th scope="row">등록일</th>
                  <td>등록일</td>
               </tr>
            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>
</body>
</html>