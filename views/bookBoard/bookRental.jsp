<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>bookRental</title>
</head>
<script>
$(function(){
	let searchBookType =$("select[name=searchBookType]").val();
	let bookKeyword = $("input[name=bookKeyword]").val();
	let form = $("#book-serach-form");
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
	<form action="${pageContext.request.contextPath}/book/bookRental" method="post" id="book-serach-form">
		<div style="display:flex;">
			<select name="searchBookType"  style="margin: 5px"  class="select-style">
			<option value="AB" <c:out value="${bookCri.searchBookType eq 'AB' ? 'selected' : '' }"/>>작가+책제목</option>
			<option value="B" <c:out value="${bookCri.searchBookType eq 'B' ? 'selected' : '' }"/>>책제목</option>
			<option value="W" <c:out value="${bookCri.searchBookType eq 'A' ? 'selected' : '' }"/>>작가</option>
			</select>
			<input type="search" name="bookKeyword" placeholder="검색할 작가/책제목" value="<c:out value='${bookCri.bookKeyword}'/>">
			<button type="submit" id="book-search-btn" class="custom-btn btn-14 viewArticle-confirm-btn">검색</button>
		</div>
		<hr class="dividingLine">
		<div class="common-box">
			<div class="book-box">
				<div style="display: flex;">
					<c:if test="${not empty bookList}">
						<c:forEach items="${bookList}" var="bookVO">
							<div style="margin-left:50px;" class="result-book">
								<a href="${pageContext.request.contextPath}/book/viewBook?bookName=${bookVO.bookName}&searchBookType=${bookCri.searchBookType}&bookKeyword=${bookCri.bookKeyword}">
									<img src="${pageContext.request.contextPath}/resources/img/${bookVO.thumbnail}" class="search-book-img">
								</a><br>
								<hr class="dividingLine">
								<p><c:out value="${bookVO.bookName}"/></p>
								<hr class="dividingLine">
								<p><c:out value="${bookVO.authors}"/></p>
								<hr class="dividingLine">
								<p><c:out value="${bookVO.publisher}"/></p>
								<hr class="dividingLine">
								<c:choose>
									<c:when test="${bookVO.rental}">
									<p style="color:red;">대출중</p>
										<c:choose>
											<c:when test="${bookVO.reservation}">
												<span style="color:green;">예약중</span><br><br>						
											</c:when>
											<c:otherwise>
												<span style="color:green;">예약가능</span><br><br>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<p style="color:red;">대출가능</p>
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