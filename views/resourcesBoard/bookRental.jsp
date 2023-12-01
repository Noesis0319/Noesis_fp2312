<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>bookRental</title>
</head>
<script>
$(function(){
	 if("${result}" !== null && "${result}" !== "") {
	        alert("${result}");
	    }
	 
	 if("${msg}" !== null && "${msg}" !== ""){
		 alert("${msg}");
	 }
})
</script>
<body>
<%@include file="../includes/commonInnerHeader.jsp"%>
<main>
 <form action="${pageContext.request.contextPath}/book/bookRental" method="post">
		<div style="display:flex;">
			<input type="search" name="bookName" placeholder="검색할 작가/책제목">
			<button type="submit" id="book-search-btn" class="custom-btn btn-14 viewArticle-confirm-btn">검색</button>
		</div>
		<hr class="dividingLine">
		<div class="common-box">
			<div class="book-box">
				<div style="display: flex;">
					<c:if test="${not empty searchBook}">
					<c:forEach items="${searchBook}" var="result">
					<div style="margin-left:50px;">
						<img src="${pageContext.request.contextPath}/resources/img/${result.thumbnail}" class="search-book-img"><br>
					<hr class="dividingLine">
					<p><c:out value="${result.bookName}"/></p>
					<hr class="dividingLine">
					<p><c:out value="${result.authors}"/></p>
					<hr class="dividingLine">
					<p><c:out value="${result.publisher}"/></p>
					<hr class="dividingLine">
					<c:choose>
						<c:when test="${result.rental}">
						<p style="color:red;">대출중</p>
						<c:choose>
							<c:when test="${result.reservation}">
								<span style="color:green;">예약중</span><br><br>						
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/book/bookReservation?bookName=${result.bookName}&userId=${auth.userId}" style="color:green;">예약하기</a><br><br>
							</c:otherwise>
						</c:choose>
						<c:if test="${auth.userId eq 'admin'}">
							<a href="${pageContext.request.contextPath}/book/bookRental/returnBook?bookName=${result.bookName}">반납</a>
						</c:if>		
						</c:when>
						<c:otherwise>
						<a href="${pageContext.request.contextPath}/book/bookRental/rental?bookName=${result.bookName}&userId=${auth.userId}" style="color:purple;">대출신청</a>
						</c:otherwise>
					</c:choose>
					<hr class="dividingLine">
					</div>
					</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</form>
</main>
<%@include file="../includes/commonFooter.jsp"%>