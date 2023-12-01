<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>메세지 보내기</title>
</head>
<style>
</style>

<script>
</script>
<body>
	<form action="/member/sendMSG" class="login-form" method="post">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<main>
			<div class="formContainer">
				<div class="panner_wrap">
				<h3>메세지</h3>
					<div class="id_pw_wrap">
						<div style="display: flex;" class="form-id aligned-box">
							<img src="${contextPath}/resources/icon/receive_icon.png" width="30px" height="30px">
							<input type="text" class="id-control full" name="receiver" value="${receiver}" readonly/>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;" class="form-id aligned-box">
							<img src="${contextPath}/resources/icon/send_icon.png" width="30px" height="30px"> 
							<input type="text" class="id-control full" name="sender" value="${auth.userId}" readonly/>
						</div>
						<hr class="dividingLine">
						<div class="article-box" style="width: 100%; height: 300px">
						<textarea name="content" rows="10" cols="65" maxlength="2000"></textarea>
					</div>
					<hr class="dividingLine">
					</div>
					<div style="padding-top: 30px;" class="form__login-btn">
						<button class="custom-btn btn-15 login-btn" id="submitBtn" type="submit">메세지 보내기</button>
					</div>
				</div>
			</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>