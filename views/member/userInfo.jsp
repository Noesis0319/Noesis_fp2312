<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>회원정보</title>
<script>
$(function(){
	if("${sendResult}" !==  null && "${sendResult}" !== ""){
		alert("${sendResult}");
	}
});
</script>
</head>
<body>
<form action="${pageContext.request.contextPath}/member/modMyInfo" method="post">
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<main>
			<div class="common-box-noradius">
				<div class="userInfo-box">
				<div>
					<table class="userInfo-table">
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">아이디(이메일)</th>
						<td style="height:50px; font-size:20px; display: flex;align-items: center;justify-content: center;margin-left:20px">${userInfo.userId}
						<c:if test="${userInfo.userId ne auth.userId}">
						<a href="${pageContext.request.contextPath}/member/sendMSG?receiver=${userInfo.userId}" class="custom-btn btn-14 articleForm-confirm-btn" style="margin-left:20px; width:70px">메세지 보내기</a>
						</c:if>
						</td>
					</tr>
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">이름</th>
						<td style="height:50px; font-size:20px">${userInfo.userName}</td>
					</tr>
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">거주지역</th>
						<td style="height:50px; font-size:20px">${userInfo.location}</td>
					</tr>
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">성별</th>
						<c:choose>
						<c:when test="${userInfo.gender eq 'men'}">
							<td style="height:50px; font-size:20px"><img src="${contextPath}/resources/icon/female2_icon.png" width="30px" height="30px"></td>
						</c:when>
						<c:otherwise>
							<td style="height:50px; font-size:20px"><img src="${contextPath}/resources/icon/male2_icon.png" width="30px" height="30px"></td>
						</c:otherwise>
						</c:choose>
						
					</tr>
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">가입일</th>
						<td style="height:50px; font-size:20px">${userInfo.regDate}</td>
					</tr>
					<tr style="height:50px; font-size:20px">
						<th style="height:50px; font-size:20px">대출중</th>
						<td style="height:50px; font-size:20px">
							<c:forEach var="book" items="${rentalList}">
								<c:out value="${book}" />
							</c:forEach>
						</td>
					</tr>
				</table>
				<c:if test="${userInfo.userId eq auth.userId}">
						<a href="${pageContext.request.contextPath}/member/modMyInfo" class="custom-btn btn-14 articleForm-confirm-btn" style="margin:0 auto">정보수정</a>
				</c:if>
				</div>
				</div>
			</div>
		</main>
	
</form>
	<%@include file="../includes/commonFooter.jsp"%>