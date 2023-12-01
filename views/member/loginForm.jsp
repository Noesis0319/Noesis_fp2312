<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>로그인</title>
</head>
<style>
</style>

<script>
	$(function(){
		if("${userId}" != null && "${userId}" != ""){
			alert("회원님의 아이디는 ${userId} 입니다");
			$("#userId").val("${userId}");
		}
		let error = "<c:out value='${error}'/>" 
		if(error === noneUser){
			$("#userId").focus();
			alert("존재하지 않는 ID입니다");
		}else if(error === noMatch){
			$("#userPw").focus();
			alert("비밀번호가 일치하지 않습니다");
		}
		
		$("#submitBtn").on("click", function(e){
			e.preventDefault();
			if(isValid()){
				$("form").submit();	
			}
		})
		function isValid(){
			const userId = $("#userId").val();
			const userPw = $("#userPw").val();
			let validation = true;
			
			$("#error__userId").text("");
			$("#error__userPw").text("");
			
			if(userId.length === 0){
				$("#error__userId").text("아이디를 입력해주세요");
				$("#userId").focus();
				validation = false;
			}
			if(userPw.length === 0){
				$("#error__userPw").text("비밀번호를 입력해주세요");
				$("#userPw").focus();
				validation = false;
			}
			return validation;
		}
	})
</script>
<body>
	<form action="/member/login" class="login-form" method="post">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<main>
			<div class="formContainer">
				<div>
					<h1>로그인</h1>
				</div>
				<div class="panner_wrap">
					<div class="id_pw_wrap">
						<div style="display: flex;" class="form-id aligned-box">
							<img src="${contextPath}/resources/icon/login_icon.png" width="30px" height="30px"> 
							<input type="text" class="id-control full" id="userId" name="userId" placeholder="아이디(E-mail)를 입력해주세요" value="${memberVO.userId}" />
						</div>
						<hr class="dividingLine">
						<div style="display: flex;" class="form-pw aligned-box">
							<img src="${contextPath}/resources/icon/password_icon.png" width="30px" height="30px">
							<input type="password" class="pw-control full" id="userPw" name="userPw" placeholder="비밀번호를 입력해주세요" />
						</div>
						<hr class="dividingLine">
						<div class="error" id="error__userId"></div>
						<div class="error" id="error__userPw"></div>
					</div>
					<div style="padding-top: 30px;" class="form__login-btn">
						<button class="custom-btn btn-15 login-btn" id="submitBtn" type="submit">로그인</button>
					</div>
				</div>
				<div class="find-wrap">
					<a href="${pageContext.request.contextPath}/member/findUserId" class="custom-btn btn-15">아이디 찾기</a> 
					<a href="${pageContext.request.contextPath}/member/findUserPw" class="custom-btn btn-15">비밀번호 찾기</a> 
					<a href="${contextPath}/member/signup" class="custom-btn btn-15">회원가입</a>
				</div>
			</div>
		</main>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>