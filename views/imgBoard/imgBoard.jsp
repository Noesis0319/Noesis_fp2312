<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/imgBoardHeader.jsp"%>
<title>imgBoard</title>
</head>
<script>
$(function(){
	let list = new Array();
	let searchForm = $("#searchForm");
	
	<c:forEach items="${articlesList}" var="article">
		list.push(<c:out value="${article.bno}"/>);
	</c:forEach>
	
	$.getJSON("/imgBoard/getAttachListOnList", {list : list},
			 function(data){
		 	let keys = Object.keys(data);
		 	$(keys).each(function(i, bno){
				let attach = JSON.parse(data[bno]);
		 		if(attach !== null){
		 			let fileCallPath = encodeURIComponent(attach.uploadpath + "\\" + attach.uuid + "_" + attach.filename);
					let imgTag = "<img src='/showImg?filename=" + fileCallPath + "' class='img-board-view'/>";
					$("a[name=" + bno + "]").append(imgTag);
		 		}
		 	});
	 });
	
	 $("#searchForm button").on("click", function(e){
		 if(!searchForm.find("input[name='keyword']").val()){
			 alert("검색어를 입력하세요");
			 return false;
		 }
		 searchForm.find("input[name='pageNum']").val("1");
		 searchForm.submit();
	 })
	
	$(".paginate_btn a").on("click", function(e){
		e.preventDefault();
		let form=$('<form></form>');
		form.attr("method", "get");
		form.attr("action", "/imgBoard/board");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='${pageDTO.criteria.amount}'>");
		form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
		form.append("<input type='hidden' name='dateType' value='" + dateType + "'>");
		form.appendTo('body');
		form.submit();
	});
})
</script>
<style>
</style>
<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<main>
		<h3>이 책 어때요?</h3>
		<hr class="dividingLine">
		<div>
			<c:choose>
			<c:when test="${empty articlesList}">
				<td>등록된 글이 없습니다</td>
			</c:when>
			<c:otherwise>
				<c:forEach var="article" items="${articlesList}" varStatus="i">
				<c:choose>
				<c:when test="${i.index == 0}">
					<ul class="img-board-ul">
				</c:when>
				<c:otherwise>
					<c:if test="${i.index % 5 == 0}">
						</ul>
					<br><ul class="img-board-ul">
				</c:if>
				</c:otherwise>
				</c:choose>
				<li>
				<div class="img-board-box">
					<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'></a>
					<p>
						<c:out value="${article.title}"/>
					</p>
					<p>
						<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
					</p>
					<p>
						<c:choose>
							<c:when test="${article.regDate} == ${article.updateDate}">
								<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
							</c:otherwise>
						</c:choose>
					</p>
				</div>
				</li>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</div>
		<div style="float: right;">
			<a href="${pageContext.request.contextPath}/imgBoard/registImgBoard" class="custom-btn btn-14 img-board-confirm" style="margin-left:100px;">글쓰기</a>
		</div>				
		<div id="search" class="searchform" >
			<form action="/imgBoard/board" id="searchForm">
				<div class="aligned-box">
					<select name="dateType" style="margin: 5px"  class="select-style">
						<option value="MD" <c:out value="${pageDTO.criteria.dateType eq 'MD' ? 'selected' : ''}"/>>전체기간</option>
						<option value="M" <c:out value="${pageDTO.criteria.dateType eq 'M' ? 'selected' : ''}"/>>1개월</option>
						<option value="D" <c:out value="${pageDTO.criteria.dateType eq 'D' ? 'selected' : ''}"/>>1일</option>
					</select> 
					<select name="type" class="select-style" style="margin: 5px">
						<option value="TWBA" <c:out value="${pageDTO.criteria.type eq 'TWBA' ? 'selected' : '' }"/>>전체</option>
						<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : '' }"/>>제목</option>
						<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
						<option value="B" <c:out value="${pageDTO.criteria.type eq 'B' ? 'selected' : '' }"/>>책제목</option>
						<option value="A" <c:out value="${pageDTO.criteria.type eq 'A' ? 'selected' : '' }"/>>작가</option>
					</select>
					<input type="text" class="select-style" name="keyword" value="<c:out value='${pageDTO.criteria.keyword}'/>"/>
					<input type="hidden" name="pageNum" value="<c:out value='${pageDTO.criteria.pageNum}'/>"/>
					<input type="hidden" name="amount" value="<c:out value='${pageDTO.criteria.amount}'/>"/>
					<button class="custom-btn btn-14 img-board-confirm" style="margin: 5px">검색</button>
				</div>
			</form>
		</div>	
		<div class="page-wrap">
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
	</main>
	
	<%@include file="../includes/commonFooter.jsp"%>