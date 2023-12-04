<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/imgBoardHeader.jsp"%>
<title>imgBoardRegistForm</title>
</head>
<script>
$(function(){
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
			url: '/uploadFileImageBoard',
			processData: false, 
			contentType: false, 
			data: formData,
			success: function(result){
				showUploadResult(result);
			}
		});
	});
	
	$("#regist-btn").on("click", function(e){
		e.preventDefault();
		let str = "";
		let item =$(".attached-img div");
			str +="<input type='hidden' name='filename' value='"  + item.data("filename") + "'/>";
			str +="<input type='hidden' name='uuid' value='" + item.data("uuid") + "'/>";
			str +="<input type='hidden' name='uploadpath' value='"  + item.data("path") + "'/>";
		$("#regist-form").append(str).submit();
	});
	
//=====function

	function checkExtension(filename, fileSize){
		if(fileSize >= maxSize){
			alert("파일크기는 5MB를 넘을 수 없습니다");
			return false;
		}
		if(filename.indexOf("jpg") === -1 && filename.indexOf("png") === -1 && filename.indexOf("gif") === -1 && filename.indexOf("jpeg") === -1){
			alert("이미지 파일만 업로드할 수 있습니다.");
			return false;
		}
		return true;
	}
	
	function showUploadResult(result){
		if(!result){return;}
		let attached = $(".attached-img");
		attached.empty();
		let str = "";
		let fileCallPath = encodeURIComponent(result.uploadpath + "\\" + result.uuid + "_" + result.filename);
		let decodedPath = decodeURIComponent(fileCallPath);
			str += "<div data-path='" + result.uploadpath +"'";
			str += "	data-uuid='"+result.uuid+"' data-filename='" + result.filename + "'>";
			str += "	<div>";
			str += "		<img src='/showImg?filename=" + fileCallPath+"' class='img-board-preview'/>";
			str += "	</div>";
			str += "</div>";
		attached.append(str);
	}
})
</script>
<style>
</style>
<body>
	<form action="${pageContext.request.contextPath}/imgBoard/registImgBoard" method="post" id="regist-form">
		<input type="hidden" maxlength="50" readonly="readonly" name="writer" value="${auth.userId}" />
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<main>
			<div class="aligned-box">
				<div style="width:30%">
					<div class="file-box">
						<input type="file" accept="image/*" name="uploadFile" id="uploadFile" class="file-input"/>
						<label for="uploadFile">파일찾기</label> 
					</div>
					<div class="uploadResult">
						<div class="attached-img" style="margin-bottom: 0"></div>
					</div>
				</div>
				<div style="width:70%">
					<div class="article-box" style="width: 100%; height: 35px">
						<input type="text" size="67" maxlength="500" name="title" size="1000" style="height: 35px; width: 100%; font-size: 20px;" />
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
						<select class="articleForm-select" name="bookName">
							<option value="기사단장죽이기">기사단장죽이기</option>
							<option value="노르웨이의숲">노르웨이의숲</option>
							<option value="해변의카프카">해변의카프카</option>
							<option value="애프터다크">애프터다크</option>
						</select> 
						<select class="articleForm-select" name="authors">
							<option value="무라카미하루키">무라카미하루키</option>
						</select> 
						<img src="${contextPath}/resources/icon/font-bold_icon.png" width="13px" height="13px" style="margin-left:20px"> 
						<img src="${contextPath}/resources/icon/font-italic_icon.png" width="13px" height="13px" style="margin-left:20px"> 
						<img src="${contextPath}/resources/icon/font_underLIne_icon.png" width="13px" height="13px" style="margin-left:20px"> 
						<img src="${contextPath}/resources/icon/font_strikethrough_icon.png" width="13px" height="13px" style="margin-left:20px">
					</div>
					<div class="article-box" style="width: 100%; height: 300px">
						<textarea name="content" rows="10" cols="65" maxlength="3000"></textarea>
					</div>
				</div>
				</div>
			</div>
			<div class="aligned-box">
					<button type="submit" class="custom-btn btn-14 img-board-regist" id="regist-btn">작성완료</button>
				</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>