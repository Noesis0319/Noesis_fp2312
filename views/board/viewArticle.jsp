<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>article</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="${contextPath}/resources/js/replyService.js"></script>
</head>
<style>
</style>
<script>
	$(function(){
		const operForm =$("#operForm");
		let pageNum = 1;
		let replyPageFooter = $(".panel-footer");
		let bno = "<c:out value='${article.bno}'/>";
		
		
		getReplyList();
		getReplyListWithPaging(pageNum);
		
		$("#list_btn").on("click", function(e){
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			let type = $("input[name='type']").clone();
			let dateType = $("input[name='dateType']").clone();
			let keyword = $("input[name='keyword']").clone();
			operForm.empty();
			operForm.attr("action", "/board/").attr("method", "get");
			operForm.append(pageNumTag);
			operForm.append(amountTag);
			operForm.append(type);
			operForm.append(dateType);
			operForm.append(keyword);
			operForm.submit();
		})
		
		$.getJSON("/board/getAttachList/" + bno, function(attachList){
			let str = "";
			$(attachList).each(function(i, attach){
				if((attach.filetype).indexOf("true") != -1){
					let fileCallPath = encodeURIComponent(attach.uploadpath + "\\s_"+attach.uuid + "_" + attach.filename);
					str += "<li data-path='" + attach.uploadpath +"'";
					str += "	data-uuid='"+attach.uuid+"' data-filename='"+ attach.filename +"' data-type='"+attach.filetype+"'>";
					str += "	<div>";
					str += "		<span> " + attach.filename + "</span>";
					str += "		<img src='/display?filename="+ fileCallPath+"' class='attached-img'/>";
					str += "	</div>";
					str += "</li>";
				}else{
					str += "<li data-path='" + attach.uploadpath +"'";
					str += "	data-uuid='"+attach.uuid+"' data-filename='"+ attach.filename +"' data-type='"+attach.filetype+"'>";
					str += "	<div>";
					str += "		<span> " + attach.filename + "</span>";
					str += "		<img src='/resources/icon/download_icon.png' class='download-icon'/>";
					str += "	</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
		
		$("#modify-btn").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		})

		$(".like_article").on("click", function(e){
			if($(".like_img").attr("src").includes("empty")){
				$(".like_img").attr("src", "/resources/icon/heart_icon.png");
			}else{
				$(".like_img").attr("src", "/resources/icon/empty_heart_icon.png");
			}
			
		})
	
		$("#addReplyBtn").on("click", function() {
			$("#reply").val("");
			$("#modalModBtn").hide();
			$("#modalRegisterBtn").show();
			$("#modalCloseBtn").show();
			$(".modal").modal("show");
		})
		
		$("#modalCloseBtn").on("click", function(){
			$(".modal").modal("hide");
		})
		
		$("#modalRegisterBtn").on("click", function(e) {
			let reply = {
				reply : $("#reply").val(),
				replyer : $("#replyer").val(),
				bno : '<c:out value="${article.bno}"/>'
			};

			ReplyService.add(reply, function(result) {
				$(".modal").modal("hide");
				getReplyListWithPaging(PageNum);
			}, function(error) {
				alert(error);
			});
		})

		$(".reply").on("click", "li #modify", function(e) {
			let replyer = $(this).parent().closest('div').data("replyer");
			let rno = $(this).parent().closest('div').data("rno");
			let auth = "${auth.userId}";
			if (auth !== replyer) {
				return;
			}
			ReplyService.get(rno, function(reply) {
				$("#reply").val(reply.reply);
				$("#replyer").val(reply.replyer);
				$(".modal").data("rno", reply.rno);
				$("#modalModBtn").show();
				$("#modalRegisterBtn").hide();
				$(".modal").modal("show");
			})
		})

		$("#modalModBtn").on("click", function(e) {
			let reply = {
				rno : $(".modal").data("rno"),
				reply : $("#reply").val()
			};
			ReplyService.update(reply, function(result) {
				$(".modal").modal('hide');
				getReplyListWithPaging(pageNum);
			}, function(error) {
				console.log(error);
			});
		})

		$("#to-top").on("click", function(e) {
			$("#articleHeader").focus();
		})

		$(".reply").on("click", "li #remove", function(e) {
			let rno = $(this).parent().closest('div').data("rno");
			ReplyService.remove(rno, function(result) {
				getReplyList();
			}, function(error) {
				alert(error);
			});
		})

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			let targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			getReplyListWithPaging(pageNum);
		});
		
		$(".uploadResult").on("click", "li", function(e){
			let liObj = $(this);
			let path = encodeURIComponent(liObj.data("path") + "\\" + liObj.data("uuid") + "_" + liObj.data("filename"));
			if((liObj.data("type")).indexOf("true") != -1){
				showImage(path);
			}else{
				if(path.toLowerCase().endsWith('pdf')){
					window.open("/pdfviewer?filename=" + path);
				}else{
					self.location = "/downloadFile?filename=" + path;
				}
			}
		});
		
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPictureWrapper").hide();
		})
		
		// 		========== function ==========

		function getReplyList() {
			ReplyService.getList({
				bno : '<c:out value="${article.bno}"/>'
			}, function(list) {
				showReplyList(list);
			}, function(error) {
				alert(error);
			});
		}

		function showReplyList(list) {
			let str = "";
			let replyUL = $(".reply");
			if (list == null || list.length == 0) {
				replyUL.html(str);
				return;
			}

			for (let i = 0, len = list.length || 0; i < len; i++) {
				str += "<li>";
				str += "	<div class='reply-area'>";
				str += "		<div class='reply-img-box'>";
				str += "		<img src='${contextPath}/resources/img/82936493_p0.jpg' class='userProfileImg' onclick='window.open(this.src)'>";
				str += "		</div>";
				str += "		<div>";
				str += "			<div><strong>" + list[i].replyer + "</strong>";
				str += "			</div>";
				str += "			<div data-rno='" + list[i].rno + "' data-replyer='" + list[i].replyer + "'>";
				str += "				<span id='modify' class='reply-content'>"
						+ list[i].reply + "</span>";
				str += "				<small class='reply-date'>"
						+ ReplyService.displayTime(list[i].regDate)
						+ "</small>";
				if ("${auth.userId}" === list[i].replyer) {
					str += "<button id = 'remove' type='button' class='reply-remove-btn' data-rno='" + list[i].rno+"'>";
					str += "<small>삭제</small></button>";
				}
				str += "			</div>";
				str += "		</div>";
				str += "	</div>";
				str += "</li>";
				str += "<hr class='dividingLine'>";
			}
			replyUL.html(str);
		}

		function getReplyListWithPaging(pageNum) {
			ReplyService.getListWithPaging({
				bno : '<c:out value="${article.bno}"/>',
				page : pageNum
			}, function(replyCnt, list) {
				showReplyList(list);
				showReplyPaging(replyCnt);
			}, function(error) {
				alert(error);
			});
		}

		function showReplyPaging(replyCnt) {
			let endNum = Math.ceil(pageNum / 10.0) * 10;
			let startNum = endNum - 9;
			let prev = startNum != 1;
			let next = false;
			let str = "";
			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			if (endNum * 10 < replyCnt) {
				next = true;
			}

			str += "<ul class='pagination'>";
			if (prev) {
				str += "<li class='paginate_button'><a href='" + (startNum - 1)
						+ "'>Previous</a></li>";
			}
			for (let i = startNum; i <= endNum; i++) {
				let active = pageNum == i ? "active_list" : "";
				str += "<li class='paginate_button " + active + " '><a href='"+i+"'>"
						+ i + "</a></li>";
			}
			if (next) {
				str += "<li class='paginate_button'><a href='" + (endNum + 1)
						+ "'> Next</a</li>";
			}
			str += "</ul></div>"
			replyPageFooter.html(str);
		}
		
		function showImage(fileCallPath){
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='/display?filename=" + fileCallPath+"' class='attached-big-img'>").animate({width:'100%', top:'0'}, 600);
		}
		
	});
</script>


<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value="<c:out value='${article.bno}'/>"> 
		<input type="hidden" id="boardName" name="boardName" value="<c:out value='${article.boardName}'/>">
		<input type="hidden" id="pageNum" name="pageNum" value="<c:out value='${criteria.pageNum}'/>"> 
		<input type="hidden" id="amount" name="amount" value="<c:out value='${criteria.amount}'/>">
		<input type="hidden" name="type" value="<c:out value='${criteria.type}'/>">
		<input type="hidden" name="dateType" value="<c:out value='${criteria.dateType}'/>">
		<input type="hidden" name="keyword" value="<c:out value='${criteria.keyword}'/>">
	<main id="articleMain">
		<div style="display: flex;">
			<div id="boardPath">
				<span>게시판 > 자유게시판</span>
			</div>
			<div class="rightUlMenu">
				<ul style="display: flex;">
					<c:if test="${(auth.userId eq article.writer) or (auth.userId eq 'admin')}">
					<li>
						<a href="${pageContext.request.contextPath}/board/delete?bno=${article.bno}&boardName=${article.boardName}" 
						class="custom-btn btn-14 viewArticle-confirm-btn" style="text-align: center;">삭제</a>
					</li>
					</c:if>
					
					<c:if test="${auth.userId eq article.writer}">
					<li>
						<button id="modify-btn" class="custom-btn btn-14 viewArticle-confirm-btn" style="text-align: center;">수정</button>
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
				<input type="text" value="[${article.subject}]" name="subject" disabled style="width: 20%" /> 
				<input type="text" value="${article.title}" name="title" disabled style="width: 75%" />
			</div>
			<div id="articleUserInfo">
				<div>
					<img src="${contextPath}/resources/img/99282416_p0_master1200.jpg" class="userProfileImg" onclick="window.open(this.src)">
				</div>
				<div>
					<div>
						<a href="${contextPath}/member/userInfo" class="viewInfo">${article.writer}</a> 
						<input type="hidden" name="id" value="${article.writer }" />
					</div>
					<div>
						<c:choose>
							<c:when test="${article.regDate}== ${article.updateDate}">
								<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.regDate}" />
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="yy-MM-dd hh:mm" value="${article.updateDate}" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<hr class="dividingLine">
			<div class="article-bottom">
				<div class="field3 get-td">
					<div class="uploadResult">
						<span class="aligned-box"><b>첨부파일:</b></span>
						<ul class="attached-img-ul" style="margin-bottom: 0"></ul>
					</div>
				</div>
			</div>
			<div class="bigPictureWrapper">
				<div class="bigPicture"></div>
			</div>
			<hr class="dividingLine">
		<textarea class="read_content" id="articleTextarea" rows="20" cols="60" name="content" readonly="readonly">${article.content}</textarea>
		<div>
			<button class="like_article" type="button" >
				<img src="${contextPath}/resources/icon/empty_heart_icon.png" width="20px" height="20px" class="like_img"> 
				<span> 
					<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 100) %></c:set> <c:out value="${random}" />
				</span>
				<span>좋아요 </span>
			</button>
		</div>
		<hr class="dividingLine">
		<div class="read_reply">
			<c:if test="${not empty auth}">
				<button id="addReplyBtn" class="custom-btn btn-14 viewArticle-confirm-btn" type="button">댓글 작성</button>
			</c:if>
		</div>
		<div class="reply_list">
			<ul class="reply"></ul>
			<div class="panel-footer"></div>
		</div>
		<div class="modal" tabindex="-1" role="dialog">
			<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<input class="form-control" id='reply' name='reply'>
						</div>
						<input class="form-control" id='replyer' name='replyer' value="${auth.userId}" type="hidden">
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="custom-btn btn-14 viewArticle-confirm-btn">수정</button>
						<button id='modalRegisterBtn' type="button" class="custom-btn btn-14 viewArticle-confirm-btn">등록</button>
						<button id='modalCloseBtn' type="button" class="custom-btn btn-14 viewArticle-confirm-btn">취소</button>
					</div>
				</div>
		</div>
		<div class="rightUlMenu">
			<ul style="display: flex;">
				<li><a href="#" class="custom-btn btn-14 viewArticle-confirm-btn">답변</a></li>
				<li><button id="list_btn" class="custom-btn btn-14 viewArticle-confirm-btn">목록</button></li>
				<li><a href="${contextPath}/board/articleRegister" class="custom-btn btn-14 viewArticle-confirm-btn">글쓰기</a></li>
				<li><a href="#" class="custom-btn btn-14 viewArticle-confirm-btn" id="to-top">TOP</a></li>
			</ul>
		</div>
	</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>