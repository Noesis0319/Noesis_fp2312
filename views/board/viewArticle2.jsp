<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
    <title>article</title>
</head>
<style>
</style>
<script>
	$(function(){
		//좋아요 버튼
		$(".like_article").on("click", function(e){
			console.log("like-btn");
			$(".like_img").attr("src", contextPath + "/resources/icon/heart_icon.png");
		})
		
		$("#to-top").on("click",function(e){
			$("#articleHeader").focus();
		})
	});

</script>


<body>

<%@include file="../includes/commonInnerHeader.jsp"%>
	<main id="articleMain"> 
		<div style="display: flex;">
		<div id="boardPath">
			<span>게시판 > 질문게시판</span> <!-- 게시판 루트? -->
		</div>
			<div class="rightUlMenu">
				<ul style="display: flex;">
					<c:if test="${(auth.userId eq article.writer) or (auth.userId eq 'admin')}">
					<li>
						<a href="${pageContext.request.contextPath}/board/delete?bno=${article.bno}&boardName=${article.boardName}" class="custom-btn btn-14 viewArticle-confirm-btn" style="text-align: center;">삭제</a>
					</li>
					</c:if>
					<c:if test="${auth.userId eq article.writer}">
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
					<img src="${contextPath}/resources/img/99282416_p0_master1200.jpg" class="userProfileImg" onclick="window.open(this.src)">
				</div>
				<div>
					<div>
						<a href="${contextPath}/member/userInfo" class="viewInfo">${article.writer}</a>
						<input type="hidden" name= "id" value="${article.writer }"/>	
					</div>
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
	<div>
		<a href="#" class="like_article">
		<img src="${contextPath}/resources/icon/empty_heart_icon.png" width="20px" height="20px" class="like_img">
		<span>좋아요 </span>
		<span>
			<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 100) %></c:set>
			<c:out value="${random}" />
		</span>
	</a>
	</div>
<hr class="dividingLine">
		<div id="articleComment">
			<div class="commentArea">
				<div>
					<img src="${contextPath}/resources/img/97589071_p13_master1200.jpg" class="userProfileImg" onclick="window.open(this.src)">
				</div>
				<div>
					<div>
						<span class="commentContent">ID1</span>
					</div>
					<div>
						<span class="commentContent">댓글1 </span>
					</div>
				</div>
			</div>
			<div class="commentArea">
				<div>
					<img src="${contextPath}/resources/img/82365724_p0_master1200.jpg" class="userProfileImg" onclick="window.open(this.src)">
				</div>
				<div>
					<div>
						<span class="commentContent">ID2</span>
					</div>
					<div>
						<span class="commentContent">댓글2 </span>
					</div>
				</div>
			</div>
			<div class="commentArea">
				<div>
					<img src="${contextPath}/resources/img/82936493_p0.jpg" class="userProfileImg" onclick="window.open(this.src)">
				</div>
				<div>
					<div>
						<span class="commentContent">ID3</span>
					</div>
					<div>
						<span class="commentContent">댓글3 </span>
					</div>
				</div>
			</div>
		</div>
		<textarea id="commentWritter">	</textarea>댓글 기능구현, 신고, 공유, 글 최상단 포커스
		<div class="rightUlMenu">
				<ul style="display: flex;">
					<li>
						<a href="#" class="custom-btn btn-14 viewArticle-confirm-btn">답변</a>
					</li>
					<li>
						<a href="${contextPath}/board/board2" class="custom-btn btn-14 viewArticle-confirm-btn">목록</a>
					</li>
					<li>
						<a href="${contextPath}/board/articleRegister" class="custom-btn btn-14 viewArticle-confirm-btn">글쓰기</a>
					</li>
					<li><a href="#" class="custom-btn btn-14 viewArticle-confirm-btn" id="to-top">TOP</a></li>
				</ul>
			</div>
	</main>
<%@include file="../includes/commonFooter.jsp"%>