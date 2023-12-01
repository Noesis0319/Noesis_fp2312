<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>modify</title>
</head>
<script type="text/javascript">
	$(function(){
		let formObj = $("form");
		let bno = "<c:out value='${article.bno}'/>"; 
		$("button").on("click", function(e){
			e.preventDefault();
			let operation = $(this).data("oper");
			if(operation === 'delete'){
				formObj.attr("action", "/board/delete");
			}else if(operation === 'list'){
				let pageNumTag = $("input[name='pageNum']").clone();
				let amountTag = $("input[name='amount']").clone();
				let type = $("input[name='type']").clone();
				let dateType = $("input[name='dateType']").clone();
				let keyword = $("input[name='keyword']").clone();
				formObj.empty();
				formObj.attr("action", "/board/").attr("method", "get");
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(type);
				formObj.append(dateType);
				formObj.append(keyword);
			}else if(operation === 'modify'){
				let str = "";
				$(".uploadResult ul li").each(function(i, listItem){
					let liObj = $(listItem);
					str += "<input type='hidden' name='attachList[" + i + "].filename' value='" + liObj.data("filename") + "'/>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + liObj.data("uuid") + "'/>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadpath' value='" + liObj.data("path") + "'/>";
					str += "<input type='hidden' name='attachList[" + i + "].filetype' value='" + liObj.data("type") + "'/>";
				})
				formObj.append(str).submit();
			}
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
					str += "	<div>";
					str += "		<button type='button' data-file=\'" + fileCallPath+"\'";
					str += "			data-type='image' class='btn btn-warning btn-circle'>x<i class='fa fa-times'></i></button><br>";
					str += "	</div>";
					str += "</li>";
				}else{
					let fileCallPath = encodeURLComponent(attach.uploadpath + "\\" + attach.uuid + " " + attach.filename);
					str += "<li data-path='" + attach.uploadpath +"'";
					str += "	data-uuid='"+attach.uuid+"' data-filename='"+ attach.filename +"' data-type='"+attach.filetype+"'>";
					str += "	<div>";
					str += "		<span> " + attach.filename + "</span>";
					str += "		<img src='/resources/icon/download_icon.png' class='download-icon'/>";
					str += "	</div>";
					str += "	<div>";
					str += "		<button type='button' data-file=\'" + fileCallPath+"\'";
					str += "			data-type='file' class='btn btn-warning btn-circle'>x<i class='fa fa-times'></i></button><br>";
					str += "	</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
		
		$(".uploadResult").on("click", "li button", function(e){
			if(confirm("삭제 하시겠습니까?")){
				let targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		$("#uploadFile").on("change", function(e){
			let formData = new FormData();
			let inputFile = $("#uploadFile");
			let files = inputFile[0].files;
			for(let i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				type: 'post',
				url: '/uploadFileAjax',
				processData: false,
				contentType: false,
				data: formData,
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		function checkExtension(filename, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(filename)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}	
		
		function showUploadResult(result){
			if(!result || result.length == 0 ){return;}
			let uploadUL = $(".uploadResult ul");
			let str = "";
			$(result).each(function(i, obj){
				if(obj.image){
					let fileCallPath = encodeURIComponent(obj.uploadpath+ "\\s_"+obj.uuid + "_" + obj.filename);
					str += "<li data-path='" + obj.uploadpath +"'";
					str += "	data-uuid='"+obj.uuid+"' data-filename='"+ obj.filename +"' data-type='"+obj.image+"'>";
					str += "	<div>";
					str += "		<span> " + obj.filename + "</span>";
					str += "		<img src='/display?filename=" + fileCallPath+"' class='attached-img'/>";
					str += "		<button type='button' data-file=\'"+fileCallPath+"\'";
					str += "			data-type='image' class='btn btn-warning btn-circle'>x<i class='fa fa-times'></i></button><br>";
					str += "	</div>";
					str += "</li>";
				}else{
					let fileCallPath = encodeURIComponent(obj.uploadpath+"\\"+ obj.uuid + "_" + obj.filename);
					str += "<li data-path='"+ obj.uploadpath +"'";
					str += "	data-uuid='"+ obj.uuid +"' data-filename='" + obj.filename + "' data-type='" + obj.image+ "'>";
					str += "	<div class='upload-box'>";
					str += "		<img src='/resources/icon/file_icon.png' class='upload-file-icon'/>";
					str += "		<span style='margin-right: 20px;'>" + obj.filename + "</span>";
					str += "		<button type='button' data-file=\'" + fileCallPath+"\'";
					str += "			data-type='file' class='btn btn-warning btn-circle'>x<i class='fa fa-times'></i></button><br>";
					str += "	</div>";
					str += "</li>";
				}
			});
			uploadUL.append(str);
		}

		let regex = new RegExp("(.*)\.(exp|zip|alz)$");
		let maxSize = 5*1024*1024;
	})
</script>
<body>
	<form action="/board/modify" method="post">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<main>
			<div>
				<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
				<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
				<input type="hidden" name="boardName" value='<c:out value="${article.boardName}"/>' > 
				<input type="hidden" name="bno" value='<c:out value="${article.bno}"/>' class="form-control"> 
				<input type="hidden" name="writer" value="<c:out value='${article.writer}'/>" class="form-control"> 
				<input type="hidden" name="regDate" value="<c:out value='${article.regDate}'/>" class="form-control" >
				<input type="hidden" name="type" value="<c:out value='${criteria.type}'/>">
				<input type="hidden" name="dateType" value="<c:out value='${criteria.dateType}'/>">
				<input type="hidden" name="keyword" value="<c:out value='${criteria.keyword}'/>">
			</div>
			<div class="right-aligend-box" style="margin-bottom: 20px;">
				<button data-oper="delete" class="custom-btn btn-14 articleForm-confirm-btn" type="submit">삭제</button>
				<button data-oper="list" class="custom-btn btn-14 articleForm-confirm-btn" type="submit">목록</button>
			</div>
			<div class="articleForm-table">
				<div>
					<div class="articleForm-title">
						<c:if test="${article.boardName eq 'TBL_BOARD'}">
							<select class="articleForm-select" name="subject" id="subject-select">
								<option disabled="disabled" selected="true">말머리</option>
								<option value="${article.subject}" selected style="display:none">${article.subject}</option>
								<option value="자유">자유</option>
								<option value="유머">유머</option>
								<option value="오늘하루">오늘하루</option>
								<option value="정보">정보</option>
								<option value="홍보">홍보</option>
							</select>
						</c:if>

						<div class="article-box aligned-box" style="width: 100%; height: 35px">
							<input class="form-control" name="title" value="<c:out value='${article.title}'/>">
						</div>
					</div>
				</div>
				<div>
					<div class="font-tool-box article-box">
						<select class="articleForm-select">
							<option value="a">글꼴</option>
							<option value="b">글꼴1</option>
							<option value="c">글꼴2</option>
							<option value="d">글꼴3</option>
						</select> <select class="articleForm-select">
							<option value="a">15</option>
							<option value="b">16</option>
							<option value="c">17</option>
							<option value="d">18</option>
						</select> 
						<img src="${contextPath}/resources/icon/font-bold_icon.png" width="13px" height="13px"> 
						<img src="${contextPath}/resources/icon/font-italic_icon.png" width="13px" height="13px"> 
						<img src="${contextPath}/resources/icon/font_underLIne_icon.png" width="13px" height="13px"> 
						<img src="${contextPath}/resources/icon/font_strikethrough_icon.png" width="13px" height="13px">
					</div>
					<div class="article-box" style="width: 100%; height: 500px">
						<textarea class="read_content" name="content"><c:out value="${article.content}" /></textarea>
					</div>
				</div>
				<div>
					<div class="file-box">
						<label for="uploadFile">파일찾기</label> <input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
					</div>
					<div class="uploadResult">
						<ul class="attached-img-ul" style="margin-bottom: 0"></ul>
					</div>
				</div>
				<div class="aligned-box">
					<button data-oper="modify" class="custom-btn btn-14 articleForm-confirm-btn" type="submit" id="submit-btn">수정완료</button>
				</div>
			</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>
	