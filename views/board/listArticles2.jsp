<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<c:set var="boardName" value="${articlesList[0].boardName}"/>
<title>질문게시판</title>
<style>
</style>
</head>
<script type="text/javascript">
$(function(){
// 	let result = '<c:out value="${result}"/>';

	$(".write_btn").on("click", function(e){
		e.preventDefault;	
		self.location = "/board/articleRegister"
	})
	
	$(".get").on("click", function(e){
		e.preventDefault();
		let form=$('<form></form>');
		form.attr("method", "get");
		form.attr("action", "/board/read");
		form.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='pageNum' value='${pageDTO.criteria.pageNum}'>");
		form.append("<input type='hidden' name='amount' value='${pageDTO.criteria.amount}'>");
		form.append("<input type='hidden' name='boardName' value='${boardName}'>");
// 		alert("Form data: " + form.serialize());
		form.appendTo('body');
		form.submit();
	});
	$(".paginate_btn a").on("click", function(e){
		e.preventDefault();
		let form=$('<form></form>');
		form.attr("method", "get");
		form.attr("action", "/board/board2");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='${pageDTO.criteria.amount}'>");
		form.append("<input type='hidden' name='boardName' value='${boardName}'>");
		form.appendTo('body');
		form.submit();
	})
	
// 	if(result != ""){
// 		result += "번 글이 등록되었습니다."
// 		alert(result);
// 	}
	})
</script>
<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<main>
		<h1>질문게시판</h1>
		<hr>
		<div>
			<table class="listArticles-table">
				<tr>
					<th width="10%" style="text-align: center;">글번호</th>
					<th width="40%" style="text-align: center;" colspan="2">제목</th>
					<th width="6%" style="text-align: center;"></th>
					<th width="14%" style="text-align: center;">작성자</th>
					<th width="15%" style="text-align: center;">작성일</th>
					<th width="15%" style="text-align: center;">조회</th>
				</tr>

				<c:choose>
					<c:when test="${empty articlesList}">
						<td>등록된 글이 없습니다</td>
					</c:when>
					<c:otherwise>
						<c:forEach var="article" items="${articlesList}" varStatus="articleNum">
							<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 100000) %></c:set>
							<tr>
								<td><c:out value="${article.bno}" /></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>'><c:out value="${article.title}"/></a>
								</td>
								<td></td>
								<td style="width: 50px; text-align: center;">
									<!-- 파일업로드 구현 후 수정 --> <img src="${contextPath}/resources/img/80322769_p0.jpg" style="height: 50px; width: 50px; text-align: center;" onclick="window.open(this.src)" />
								</td>

								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.updateDate}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:out value="${random}" /></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<div style="float: right;">
			<a href="${pageContext.request.contextPath}/board/articleRegister" class="custom-btn btn-14 articleForm-confirm-btn">글쓰기</a>
		</div>
		<div class="listArticles-page-wrap">
				<ul class="pagination">
					<c:if test="${pageDTO.prev}">
						<li class="paginate_btn previous"><a href="${pageDTO.startPage-1 }">Prev</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageDTO.startPage }" end="${pageDTO.endPage}">
						<li class="paginate_btn ${pageDTO.criteria.pageNum==num ? 'active_list' : '' }"><a href="${num}">${num}</a></li>
					</c:forEach>
					<c:if test="${pageDTO.next }">
						<li class="paginate_btn next"><a href="${pageDTO.endPage+1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
		<div id="search">
			<div style="display: flex;">
				<select style="margin: 5px">
					<option value="a">전체기간</option>
					<option value="b">1일</option>
					<option value="c">1주</option>
				</select> <select style="margin: 5px">
					<option value="aa">제목</option>
					<option value="bb">작성자</option>
					<option value="cc">본문</option>
				</select> <input type="search" style="height: 25px; border: solid 0.5px rgb(219, 219, 219); margin: 5px;"> <a href="#" class="custom-btn btn-14 articleForm-confirm-btn" style="margin: 5px">검색</a>
			</div>
		</div>
	</main>

	<!-- 	</form> -->
	<%@include file="../includes/commonFooter.jsp"%>