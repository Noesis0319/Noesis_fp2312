<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>aricleRegistForm</title>
<style>
td {
	text-align: center;
}
</style>
</head>
<script>
$(function(){
	let regex = new RegExp("(.*)\.(exp|zip|alz)$");
	let maxSize = 5*1024*1024;
	
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
				processData: false, //데이터를 문자열로 변환하지 않도록 지정
				contentType: false, //데이터의 contentType을 설정하지 않도록 지정
				data: formData,
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		$("#board-select").on("change", function(){
			if($(this).val() === "tbl_board"){
				$("#subject-select").attr("disabled", false);
			}else{
				$("#subject-select").attr("disabled", true);
			}
		});
		
		$("#submit-btn").on("click", function(e){
			e.preventDefault();
			const boardName = $("#board-select").val();
			const subject =$("#subject-select").val();
			if( boardName === "tbl_board" && subject === null){
				alert("말머리를 선택해주세요");
				return;
			}
			let str = "";
			let formObj = $(".register_form")
			$(".uploadResult ul li").each(function(i, listItem){
				let liObj = $(listItem);
				str +="<input type='hidden' name='attachList[" + i + "].filename' value='"  + liObj.data("filename") + "'/>";
				str +="<input type='hidden' name='attachList[" + i + "].uuid' value='" + liObj.data("uuid") + "'/>";
				str +="<input type='hidden' name='attachList[" + i + "].uploadpath' value='"  + liObj.data("path") + "'/>";
				str +="<input type='hidden' name='attachList[" + i + "].filetype' value='"  + liObj.data("type") + "'/>";
			});
			$(formObj).append(str);
			$("form").submit();
		});
		
		$(".uploadResult").on("click", "li button", function(e){
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			let targetLi = $(this).parent().closest("li");
			let attach ={filename : targetFile , type : type};			
			$.ajax({
	            type :'delete',
	            url : '/deleteFile',
	            data : JSON.stringify(attach),
	            contentType : "application/json; charset=utf-8",
	            success : function(result){
	            	alert(result);
	            	targetLi.remove();
	            }
	        });
		});
		
//=====function

	function checkExtension(filename, fileSize){
		if(fileSize >= maxSize){
			alert("파일크기는 5MB를 넘을 수 없습니다");
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
				console.log("obj.image : true");
				let fileCallPath = encodeURIComponent(obj.uploadpath+ "\\s_"+obj.uuid + "_" + obj.filename);
				str += "<li data-path='" + obj.uploadpath +"'";
				str += "	data-uuid='"+obj.uuid+"' data-filename='"+ obj.filename +"' data-type='"+obj.image+"'>";
				str += "	<div>";
				str += "		<span> " + obj.filename + "</span>";
				str += "		<button type='button' data-file=\'"+fileCallPath+"\'";
				str += "			data-type='image' class='btn btn-warning btn-circle'>x<i class='fa fa-times'></i></button><br>";
				str += "		<img src='/display?filename=" + fileCallPath+"' class='attached-img'/>";
				str += "	</div>";
				str += "</li>";
			}else{
				console.log("obj.image : false");
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
});
</script>
<body>
	<form action="${contextPath}/board/articleRegister" method="post" class="register_form">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<input type="hidden" maxlength="50" readonly="readonly" name="writer" value="${auth.userId}" />
		<main>
			<h1>자유게시판</h1>
			<hr>
			<div class="articleForm-table">
				<div>
					<div class="articleForm-title">
						<select class="articleForm-select" name="boardName" id="board-select">
							
							<c:if test="${auth.userId eq 'admin'}">
							<optgroup label="알림광장">
								<option value="tbl_admin_board">공지사항</option>
								<option value="tbl_admin_board2">홍보</option>
								<option value="tbl_admin_board3">행사</option>
							</optgroup>
							</c:if>
							
							<optgroup label="소통광장">
								<option value="tbl_board">자유게시판</option>
								<option value="tbl_board2">질문게시판</option>
								<option value="tbl_board3">게시판1</option>
							</optgroup>
							<optgroup label="참여광장">
								<option value="c">게시판2</option>
								<option value="d">게시판3</option>
							</optgroup>
							<optgroup label="게시판그룹3">
								<option value="e">게시판4</option>
								<option value="f">게시판5</option>
							</optgroup>
						</select> <select class="articleForm-select" name="subject" id="subject-select" disabled="disabled">
							<option disabled="disabled" selected="true">말머리</option>
							<option value="자유">자유</option>
							<option value="유머">유머</option>
							<option value="오늘하루">오늘하루</option>
							<option value="정보">정보</option>
							<option value="홍보">홍보</option>
						</select>
						<div class="article-box aligned-box" style="width: 100%; height: 35px">
							<input type="text" size="67" maxlength="500" name="title" size="1000" style="height: 35px; width: 100%; font-size: 20px;" />
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
						</select> 
						<select class="articleForm-select">
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
						<textarea name="content" rows="10" cols="65" maxlength="4000"></textarea>
					</div>
				</div>
				<div>
					<div class="file-box">
						<label for="uploadFile">파일찾기</label> 
						<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple />
					</div>
					<div class="uploadResult">
						<ul class="attached-img-ul" style="margin-bottom: 0"></ul>
					</div>
				</div>
				<div class="articleForm-confirm-box">
					<button type="submit" class="custom-btn btn-14 articleForm-confirm-btn" id="submit-btn">작성완료</button>
				</div>
			</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>