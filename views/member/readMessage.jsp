<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>메세지</title>
</head>
<script>
$(function(){
	if("${delResult}" !== null & "${delResult}" !== ""){
		alert("${delResult}");
	}
	$("#allChk-btn").on("click", function(){
		console.log("#allChk-btn clicked")
		if($("#allChk-btn").is(":checked")){
			console.log("#allChk-btn true")
			$("input[name=mno]").prop("checked", true);
		}else{
			console.log("#allChk-btn false")
			$("input[name=mno]").prop("checked", false);
		} 
	});
// 	$("#delChkMsg-btn").on("click", function(){
	
// 	});
});
</script>
<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<form method="post" action="${pageContext.request.contextPath}/member/delMSG">
		<main>
			<div class="aligned-box">
				<div class="common-box">
					<h1 style="margin-left: 30px; font-size: 25px;">받은 메세지함</h1>
					<hr class="dividingLine">
					<div class="aligned-box">
						<input type="hidden" value="${auth.userId}" name="userId" />
						<table class="common-table">
							<c:choose>
								<c:when test="${!empty msgVO}">
									<tr>
										<th><input type="checkbox" id="allChk-btn" />전체체크</th>
										<td><button id="delChkMsg-btn" type="submit" class="custom-btn btn-14 articleForm-confirm-btn">선택된 메세지삭제</button></td>
									</tr>
									<c:forEach var="msg" items="${msgVO}">
										<tr>
											<th>${msg.sender}</th>
											<td style="width: 400px">${msg.content}</td>
											<td style="width: 100px"><input type="checkbox" name="mno" value="${msg.mno}" /></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									받은 메세지가 없습니다.
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>