<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>replyForm</title>
</head>
<script>
	$(function(){
		let replyForm = $("#replyForm");
		$("#replyForm input").on("click", function(e){
			let operation = $(this).data("oper");
			console.log(operation);
			if(operation === 'list'){
				replyForm.attr("action", "${contextPah}/board/listArticles.do");
				replyForm.submit();
			}
		});
		
		$("#imageFileName").change(function(){
			if(this.files && this.files[0]){
				let reader = new FileReader();
				reader.onload = function(e){
					$('#preview').attr('src', e.target.result);
				};
				reader.readAsDataURL(this.files[0]);
			}
		})
		
	})
</script>
<body>
	<form action="${contextPath}/board/addReply.do" method="post" enctype="multipart/form-data" id="replyForm" name="replyForm">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<main>
			<h1>답글</h1>
				<hr>
				<table class="articleForm-table">
				<tr>
					<td align="right"> 글쓴이:&nbsp;</td>
					<td><input type="text" size="5" value="<c:out value='${writer}'/>" disabled/></td>
				</tr>
				<tr>
					<td align="right">글제목 :</td>
					<td><input type="text" size="67" maxlength="100"
						name="title" size="1000" style="width: 80%;" />
				</tr>
				<tr>
					<td align="right">글내용 :</td>
					<td colspan="2"><textarea name="content" rows="10" cols="65"
							maxlength="4000" style="width: 95%; height: 90%;"></textarea></td>
				</tr>
				<tr>
					<td align="right" rowspan="2">이미지파일 첨부 :</td>
					 <td><input type="file" id="imageFileName" name="imageFileName"/></td>
				</tr>
    			
				<tr>
					<td style="width: 85%; height: 300;"><img id="preview" src="#"
						width=80% height=80% /></td>
				</tr>
				<tr>
					<td align="right"></td>
					<td colspan="2" style="display:flex;">
						<a href="#" data-oper='add' class="custom-btn btn-14 articleForm-confirm__btn">글쓰기</a>
						<a href="${contextPath}/board/listArticles" data-oper='list' class="custom-btn btn-14 articleForm-confirm__btn">취소</a>
					</td>
				</tr>
			</table>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>