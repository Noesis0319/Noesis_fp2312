<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<c:set var="boardName" value="${articlesList[0].boardName}"/>
<title>자유게시판</title>
<style>
	.m1 {
}

.m2 {
	display: none;
}

.m3 {
	display: none;
}

.m4 {
	display: none;
}

.m5 {
	display: none;
}

.m6 {
	display: none;
}

#bt1 {
	font-weight: bold;
}

</style>
</head>
<script type="text/javascript">
$(function(){
	const menu1 = $(".m1");
	const menu2 = $(".m2");
	const menu3 = $(".m3");
	const menu4 = $(".m4");
	const menu5 = $(".m5");
	const menu6 = $(".m6");
	const bt1 = $("#bt1");
	const bt2 = $("#bt2");
	const bt3 = $("#bt3");
	const bt4 = $("#bt4");
	const bt5 = $("#bt5");
	const bt6 = $("#bt6");
	let list = new Array();
	let form = $("<form></form>");
	let type = $("select[name=type]").val();
	let dateType = $("select[name=dateType]").val();
	let keyword = $("input[name=keyword]").val();
	let searchForm = $("#searchForm");
	
    <c:forEach items="${articlesList}" var="article">
    	list.push(<c:out value="${article.bno}"/>);
    </c:forEach>
    if(list.length == 0){
    	return;
    }
	 $.getJSON("/replies/cnt", {list : list} , 
    		function(data){
				let keys = Object.keys(data);
				$(keys).each(function(i, bno){
					let replyCnt = data[bno];
					let append = "<span class='reply-cnt'>[" + replyCnt + "]</span>";
					let text = $("a[name=" + bno + "]").html();
					$("a[name=" + bno + "]").html(text + append);
				});
    		});
	 
	 $.getJSON("/board/getAttachListOnList", {list : list},
			 function(data){
		 	let keys = Object.keys(data);
		 	$(keys).each(function(i, bno){
				let attach = JSON.parse(data[bno]);
		 		if(attach !== null){
		 			let fileCallPath = encodeURIComponent(attach.uploadpath + "\\s_"+attach.uuid + "_" + attach.filename);
					let imgTag = "<img src='/display?filename=" + fileCallPath + "' class='attached-img'/>";
		 			$("a[name=" + bno + "]").parent().parent().find(".content-img-box").append(imgTag);
		 		}
		 	});
	 });
	 
	 $("#searchForm button").on("click", function(e){
		 if(!searchForm.find("input[name='keyword']").val()){
			 alert("검색어를 입력하세요");
			 return false;
		 }
		 searchForm.find("input[name='pageNum']").val("1");
		 e.preventDefault();
		 searchForm.submit();
	 })
		bt1.on("click", function(){
             menu1.show();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#cc00ff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt2.on("click", function(){
             menu1.hide();
             menu2.show();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#cc00ff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt3.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.show();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#cc00ff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt4.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.show();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#cc00ff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt5.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.show();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#cc00ff");
             bt6.css("color", "#ffffff");
        })
        bt6.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.show();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#cc00ff");
        })
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
		form.append("<input type='hidden' name='type' value='" + type + "'>");
		form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
		form.append("<input type='hidden' name='dateType' value='" + dateType + "'>");
		form.appendTo('body');
		form.submit();
	});
	
	$(".paginate_btn a").on("click", function(e){
		e.preventDefault();
		let form=$('<form></form>');
		form.attr("method", "get");
		form.attr("action", "/board/");
		form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
		form.append("<input type='hidden' name='amount' value='${pageDTO.criteria.amount}'>");
		form.append("<input type='hidden' name='boardName' value='${article.boardName}'>");
		form.append("<input type='hidden' name='type' value='" + type + "'>");
		form.append("<input type='hidden' name='keyword' value='" + keyword + "'>");
		form.append("<input type='hidden' name='dateType' value='" + dateType + "'>");
		form.appendTo('body');
		form.submit();
	});
});
</script>
<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<main>
		<h1>자유게시판</h1>
		<hr class="dividingLine">
		<div class="mini-list-name-box">
			<button class="mini-list-btn" id="bt1" style="color: #cc00ff;">전체</button>
			<button class="mini-list-btn" id="bt2">자유</button>
			<button class="mini-list-btn" id="bt3">유머</button>
			<button class="mini-list-btn" id="bt4">오늘하루</button>
			<button class="mini-list-btn" id="bt5">정보</button>
			<button class="mini-list-btn" id="bt6">홍보</button>
		</div>
		<div>
			<table class="listArticles-table">
				<tr style="height:60px">
					<th width="10%" style="text-align: center; height:60px">글번호</th>
					<th width="10%" style="text-align: center; height:60px"></th>
					<th width="36%" style="text-align: center; height:60px" colspan="2">제목</th>
					<th width="14%" style="text-align: center; height:60px">작성자</th>
					<th width="15%" style="text-align: center; height:60px">작성일</th>
					<th width="15%" style="text-align: center; height:60px">조회</th>
				</tr>

				<c:choose>
					<c:when test="${empty articlesList}">
						<td>등록된 글이 없습니다</td>
					</c:when>
					<c:otherwise>
						<c:forEach var="article" items="${articlesList}" varStatus="articleNum">
							<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 100000) %></c:set>
							<c:choose>
								<c:when test="${article.subject eq '자유'}">
									<tr class="m2"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> 
									<c:out value="${article.title}"/></a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td>
								<c:choose>
									<c:when test="${article.regDate} == ${article.updateDate}">
										<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
									</c:when>
									<c:otherwise>
										<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
									</c:otherwise>
								</c:choose>
								</td>
								<td><c:out value="${random}" /></td>
							</tr>
								</c:when>
								<c:when test="${article.subject eq '유머'}">
								<tr class="m3"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> <c:out value="${article.title}"/></a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:out value="${random}" /></td>
							</tr>
								</c:when>
								<c:when test="${article.subject eq '오늘하루'}">
								<tr class="m4"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> <c:out value="${article.title}"/></a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:out value="${random}" /></td>
							</tr>
								</c:when>
								<c:when test="${article.subject eq '정보'}">
								<tr class="m5"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> <c:out value="${article.title}"/></a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:out value="${random}" /></td>
							</tr>
								</c:when>
								<c:when test="${article.subject eq '홍보'}">
								<tr class="m6"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> <c:out value="${article.title}"/></a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								 
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
										</c:otherwise>
									</c:choose></td>
								<td><c:out value="${random}" /></td>
							</tr>
								</c:when>
			</c:choose>
							<tr class="m1"  style="height:60px">
								<td><c:out value="${article.bno}" /></td>
								<td><c:if test="${!empty article.subject}">
										[<c:out value="${article.subject}" />]
									</c:if></td>
								<td>
									<a class="get" href='<c:out value="${article.bno}"/>' name='<c:out value="${article.bno}"/>'> </a>
								</td>
								<td style="width: 50px; text-align: center;" class="content-img-box">
								</td>
								<td>
								<a href="${pageContext.request.contextPath}/member/userInfo?userId=${article.writer}">${article.writer}</a>
								</td>
								<td><c:choose>
										<c:when test="${article.regDate} == ${article.updateDate}">
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.regDate}" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${article.updateDate}" />
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
		<div id="search" class="searchform" >
			<form action="/board/" id="searchForm">
				<div style="display:flex">
				<select name="dateType" style="margin: 5px"  class="select-style">
					<option value="MD" <c:out value="${pageDTO.criteria.dateType eq 'MD' ? 'selected' : ''}"/>>전체기간</option>
					<option value="M" <c:out value="${pageDTO.criteria.dateType eq 'M' ? 'selected' : ''}"/>>1개월</option>
					<option value="D" <c:out value="${pageDTO.criteria.dateType eq 'D' ? 'selected' : ''}"/>>1일</option>
				</select> 
				<select name="type" class="select-style" style="margin: 5px">
					<option value="TWC" <c:out value="${pageDTO.criteria.type eq 'TWC' ? 'selected' : '' }"/>>전체</option>
					<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : '' }"/>>제목</option>
					<option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : '' }"/>>내용</option>
					<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
					<option value="TC" <c:out value="${pageDTO.criteria.type eq 'TC' ? 'selected' : '' }"/>>제목+내용</option>
					<option value="TW" <c:out value="${pageDTO.criteria.type eq 'TW' ? 'selected' : '' }"/>>제목+작성자</option>
				</select>
				<input type="text" class="select-style" name="keyword" value="<c:out value='${pageDTO.criteria.keyword}'/>"/>
				<input type="hidden" name="pageNum" value="<c:out value='${pageDTO.criteria.pageNum}'/>"/>
				<input type="hidden" name="amount" value="<c:out value='${pageDTO.criteria.amount}'/>"/>
				<button class="custom-btn btn-14 articleForm-confirm-btn" style="margin: 5px">검색</button>
				</div>
			</form>
		</div>	
	</main>
	
	<!-- 	</form> -->
	<%@include file="../includes/commonFooter.jsp"%>