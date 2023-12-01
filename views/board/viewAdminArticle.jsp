<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
    <title>공지사항</title>
</head>
<style>
</style>
<script>
	$(function(){
		$("#to-top").on("click",function(e){
			$("#articleHeader").focus();
		})
	})
</script>
<body>
<%@include file="../includes/commonInnerHeader.jsp"%>
	<main id="articleMain"> 
		<div style="display: flex;">
		<div id="boardPath">
			<span>알림광장 > 공지사항</span>
		</div>
			<div class="rightUlMenu">
				<ul style="display: flex;">
					<c:if test="${auth.userId eq 'admin'}">
					<li>
						<a href="${pageContext.request.contextPath}/board/delete?bno=${article.bno}&boardName=${article.boardName}" class="custom-btn btn-14 viewArticle-confirm-btn" style="text-align: center;">삭제</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/board/modify?bno=${article.bno}&boardName=${article.boardName}" class="custom-btn btn-14 viewArticle-confirm-btn" style="text-align: center;">수정</a>
					</li>
					</c:if>
					<li>
						<a href="#" class="custom-btn btn-14 viewArticle-confirm-btn">이전글</a>
					</li>
					<li>
						<a href="${contextPath}/board/" class="custom-btn btn-14 viewArticle-confirm-btn">다음글</a>
					</li>
				</ul>
			</div>
		</div>
		<hr>
		
		<div id="articleHeader">
			<div id="articleTitle">
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno" value="<c:out value='${article.bno}'/>">
				</form>
				<input type="text" value="${article.title}" name="title" id="i_title" disabled/>
			</div>
			<div id="articleUserInfo">
				<div>
					<div>
						<c:choose>
							<c:when test="${article.regDate}== ${article.updateDate}">
								<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.regDate}"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.updateDate}"/>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
<hr class="dividingLine">
		<textarea  class="read_content" id="articleTextarea" rows="20" cols="60"  name="content" readonly="readonly">${article.content}</textarea>
<hr class="dividingLine">
		<div class="rightUlMenu">
				<ul style="display: flex;">
					<li>
						<a href="${contextPath}/board/" class="custom-btn btn-14 viewArticle-confirm-btn">목록</a>
					</li>
					<c:if test="${auth.userId eq 'admin'}">
						<li>
						<a href="${contextPath}/board/articleRegister" class="custom-btn btn-14 viewArticle-confirm-btn">글쓰기</a>
					</li>
					</c:if>
					<li><a href="#" class="custom-btn btn-14 viewArticle-confirm-btn" id="to-top">TOP</a></li>
				</ul>
			</div>
	</main>
<%@include file="../includes/commonFooter.jsp"%>