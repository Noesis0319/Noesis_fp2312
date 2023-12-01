<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>회원 리스트</title>
<script>
</script>
</head>
<body>
	<main>
	<%@include file="../includes/commonInnerHeader.jsp"%>
		<h1>등록된 회원 목록</h1>
		<table class="listMembers-table">
			<tr>
				<td width="15%">아이디</td>
				<td width="10%">이름</td>
				<td width="10%">거주지</td>
				<td width="9%">성별</td>
				<td width="23%">가입일</td>
				<td width="23%">수정날짜</td>
				<td width="6%">수정</td>
				<td width="6%">삭제</td>
			</tr>
			<c:choose>
				<c:when test="${empty memberList}">
					<td>등록된 회원이 없습니다</td>
				</c:when>
				<c:otherwise>
					<c:forEach var="mem" items="${memberList}">
						<tr>
							<td><c:out value="${mem.userId}" /></td>
							<td><c:out value="${mem.userName}" />
							<td><c:out value="${mem.location}" /></td>
							<td><c:out value="${mem.gender}" /></td>
							<td><c:out value="${mem.regDate}" /></td>
							<td><c:out value="${mem.updateDate}" /></td>
							<td><a href="${contextPath}/member/modMember?id=${mem.userId}">수정</a></td>
							<td><a href="${contextPath}/member/delMember?id=${mem.userId}">삭제</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</main>
	<%@include file="../includes/memberFooter.jsp"%>
	