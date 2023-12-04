<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>viewBook</title>
</head>
<style>

</style>
<script>
$(function(){
	let form = $("#book-form");
	let keyword = `${bookVO.bookName}`.replace(/[0-9]*$/, '');
	$("input[name='keyword']").val(keyword);
	
	$("#return-btn").on("click", function(e){
		form.attr("action", "/book/returnBook");
		form.submit();
	})
	$("#rental-btn").on("click", function(e){
		form.attr("action", "/book/rental");
		form.submit();		
	})
	$("#view-recomend-btn").on("click", function(e){
		form.attr("action", "/imgBoard/board");
		form.attr("method", "get");
		form.submit();
	})
})
</script>
<body>
<%@include file="../includes/commonInnerHeader.jsp"%>
<form action="${pageContext.request.contextPath}/book/bookReservation" method="post" id="book-form">
<input type="hidden" name="" value="${bookVO}"/>
<input type="hidden" name="bookName" value="${bookVO.bookName}"/>
<input type="hidden" name="authors" value="${bookVO.authors}"/>
<input type="hidden" name="publisher" value="${bookVO.publisher}"/>
<input type="hidden" name="userId" value="${auth.userId}"/>
<input type="hidden" name="searchBookType" value="${bookCri.searchBookType}"/>
<input type="hidden" name="bookKeyword" value="${bookCri.bookKeyword}"/>
<input type="hidden" name="keyword" value=""/>
<input type="hidden" name="type" value="B"/>
	<main>
		
		<div class="common-box">
			<div class="book-box">
				<div style="display: flex;">
					<div style="margin-left:50px;" class="result-book">
					<img src="${pageContext.request.contextPath}/resources/img/${bookVO.thumbnail}" class="search-book-img"><br>
					<hr class="dividingLine">
					<p><c:out value="${bookVO.bookName}"/></p>
					<hr class="dividingLine">
					<p><c:out value="${bookVO.authors}"/></p>
					<hr class="dividingLine">
					<p><c:out value="${bookVO.publisher}"/></p>
					<hr class="dividingLine">
					<button style="border:none" id="view-recomend-btn">추천글 보기</button><br>
					<hr class="dividingLine">
					<c:choose>
						<c:when test="${bookVO.rental}">
						<p style="color:red;margin-left:5px">대출중</p>
						<c:choose>
							<c:when test="${bookVO.reservation}">
								<span style="color:green;">예약중</span><br><br>						
							</c:when>
							<c:otherwise>
								<button style="border:none" id="reserve-btn">예약하기</button><br><br>
							</c:otherwise>
						</c:choose>
						<c:if test="${auth.userId eq 'admin'}">
							<button id="return-btn" type="button">반납</button>
						</c:if>		
						</c:when>
						<c:otherwise>
							<button id="rental-btn" type="button">대출신청</button>
						</c:otherwise>
					</c:choose>
					<hr class="dividingLine">
					</div>
				</div>
			</div>
		</div>
	</main>
</form>
<%@include file="../includes/commonFooter.jsp"%>