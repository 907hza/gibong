<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btnClose").on("click",function(){
				opener.movePage(); // 창 교환하고 
				window.close(); // 내 창 닫기
			});
		});
	</script>
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${!empty kakaoPayApprove}" >
				<h2>카카오페이 결제가 정상적으로 완료되었습니다.</h2>
				결제일시 : ${kakaoPayApprove.approved_at} <br />
				주문번호 : ${kakaoPayApprove.partner_order_id} <br />
				결제금액 : ${kakaoPayApprove.amount.total} <br />
				결제방법 : ${kakaoPayApprove.payment_method_type} <br />
			</c:when>
			<c:otherwise>
				<h2>카카오페이 결제 중 오류가 발생했습니다.</h2>
			</c:otherwise>
		</c:choose>
	</div>
	<button id="btnClose" name="btnClose" type="button" >닫기</button>
</body>
</html>