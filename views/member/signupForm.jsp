<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>회원가입</title>
<script>

	$(function(){
		$("#phone1").on("input", function(e){
			let phone1 = $(this).val();
			if(phone1.length === 3){
				$("#phone2").focus();
			}
		})
		$("#phone2").on("input", function(e){
			let phone2 = $(this).val();
			if(phone2.length === 4){
				$("#phone3").focus();
			}
		})
		$("#phone3").on("input", function(e){
			let phone3 = $(this).val();
			if(phone3.length === 4){
				$("#phone1").focus();
			}
		})
		$(".phone__input").on("input", function(e){
			let p1Length = $("#phone1").val().length;
			let p2Length = $("#phone2").val().length;
			let p3Length = $("#phone3").val().length;
			if(p1Length == 3 && p2Length == 4 && p3Length == 4){
				$("#send").attr("disabled", false);
				$("#send").addClass("btn-15");
			}else{	
				$("#send").attr("disabled", true);
				$("#send").removeClass("btn-15");
	 		}
		})
		
		$("#signup__btn").on("click", function(e){
			e.preventDefault();
			if(isValid()){
				$("form").submit();	
			}
		})
		
		$("#send").on("click", function(e){
			getToken();
		});
		
		$("#finished").on("click", function(e){
			getTimerIntervalConfirm();
		})
		
		function isValid(){
			const userId = $("#userId").val();
			const userName = $("#userName").val();
			const password1 = $("#pw1").val();
			const password2 = $("#pw2").val();
			const location = $("#location").val();
			const genderWoman = $("#gender__woman").is(":checked");
			const genderMan = $("#gender__man").is(":checked");
			const validLocations = ["서울", "경기도", "인천", "대전", "광주", "대구", "부산", "울산", "경상도", "충청도", "강원도", "전라도", "제주도"];
			
			$("#error__email").text("");
			$("#error__name").text("");
			$("#error__password1").text("");
			$("#error__password2").text("");
			$("#error__location").text("");
			$("#error__gender").text("");
			
			let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			if(regExp.test(userId) === false){
				$("#error__email").text("아이디(이메일)가 올바르지 않습니다.");
				$("#userId").focus();
				return false;
			}
			if(userName === ""){
				$("#error__name").text("이름을 입력해 주세요.");
				$("#userName").focus();
				return false;
			}
			if(password1 === ""){
				$("#error__password1").text("비밀번호를 입력해 주세요");
				$("#pw1").focus();
				return false;
			}
			
			if(password2 === ""){
				$("#error__password2").text("비밀번호를 한번 더 입력해 주세요");
				$("#pw2").focus();
				return false;
			}
			if(password1 !== password2){
				$("#error__password1").text("비밀번호가 일치하지 않습니다");
				$("#error__password2").text("비밀번호가 일치하지 않습니다");
				$("#pw2").focus();
				return false;
			}
			
			if(!validLocations.includes(location)){
				$("#error__location").text("지역을 선택해 주세요");
				$("#location").focus();
				return false;
			}
			
			if(genderWoman === false && genderMan === false){
				$("#error__gender").text("성별을 선택해 주세요");
				$("#gender__woman").focus();
				return false;
			}
			return true;
		}
		
		function getToken(){
			const token = String(Math.floor(Math.random()*1000000)).padStart(6,"0");
			$("#token").text(token);
			$("#send").attr("disabled", true);
			
			$("#finished").addClass("btn-15");
			$("#finished").attr("disabled", false);
			getTimerInterval();
		}
		
		function getTimerInterval(){
			let time = 179;
			interval = setInterval(()=>{
				if(time >= 0){
					const minutes = Math.floor(time/60);
					const seconds = time % 60;
					$("#timer").text(minutes + ":" + String(seconds).padStart(2, "0"));
					time -= 1;
				}else{
					$("#token").text("000000");
					$("#send").removeClass("btn-15");
					$("#sned").attr("disabled", true);
					$("timer").text("3:00");
					$("#finished").removeClass("btn-15");
					$("#finished").attr("disabled", true);
					clearInterval(interval);
				}
			}, 1000)
		}
		
		function getTimerIntervalConfirm(){
			clearInterval(interval)
			$("#finished").attr("disabled", true);
			$("#finished").removeClass("btn-15");
			$("#send").removeClass("btn-15");
			$("#finished").text("인증완료");
			alert("인증이 완료되었습니다.");
			$("#signup__btn").addClass("btn-15");
			$("#signup__btn").attr("disabled", false);
		}
	})
	

	
</script>
</head>
<body>
	<form role="form" action="/member/signup" method="post">
		<%@include file="../includes/commonInnerHeader.jsp"%>
		<div class="wrapper-signup">
			<main>
				<div class="formContainer">
					<div class="panner-wrap">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/email_icon.png" width="30px" height="30px"> 
							<input type="text" class="main__input" id="userId" name="userId" placeholder="아이디(이메일)를 입력해주세요">
							<div class="error" id="error__email"></div>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/login_icon.png" width="30px" height="30px"> 
							<input type="text" class="main__input" id="userName" name="userName" placeholder="이름을 입력해 주세요" maxlength="8">
							<div class="error" id="error__name"></div>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/password_icon.png" width="30px" height="30px"> 
							<input type="password" class="main__input" id="pw1" name="userPw" placeholder="비밀번호를 입력해 주세요" maxlength="20">
							<div class="error" id="error__password1"></div>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/password_icon.png" width="30px" height="30px"> 
							<input type="password" class="main__input" id="pw2" name="pwd" placeholder="비밀번호를 한번 더 입력해 주세요" maxlength="20">
							<div class="error" id="error__password2"></div>
						</div>
						<hr class="dividingLine">
					</div>
					<hr class="dividingLine">
					<div class="panner-wrap">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/tower_icon.png" width="30px" height="30px"> 
							<select style="border: 0px; border-radius: 10%; width: 100px; font-size: 15px; text-align: center;">
								<option>SKT</option>
								<option>KT</option>
								<option>LG U+</option>
							</select>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;" class="wrap__phone">
							<img src="${contextPath}/resources/icon/phone_icon.png" width="30px" height="30px"> 
							<input class="phone__input" id="phone1" type="text" maxlength="3" /> 
							<span>-</span> 
							<input class="phone__input" id="phone2" type="text" maxlength="4" /> 
							<span>-</span> 
							<input class="phone__input" id="phone3" type="text" maxlength="4" />
						</div>
						<hr class="dividingLine">
						<div class="wrap__auth">
							<div id="auth__target">
								<button class="auth__btn custom-btn" id="send" type="button" disabled="disabled">인증번호 전송</button>
								<span id="token">000000</span>
							</div>
							<div class="wrap__auth">
								<div id="auth__timer">
									<button class="auth__btn custom-btn" id="finished" type="button" disabled="disabled">인증완료</button>
									<span id="timer">3:00</span>
								</div>
							</div>
							<hr class="dividingLine">
							<img src="${contextPath}/resources/icon/pin2_icon.png" width="30px" height="30px"> 
							<select class="select__box" id="location" name="location">
								<option disabled="disabled" selected="true">지역을 선택하세요</option>
								<option value="서울">서울</option>
								<option value="인천">인천</option>
								<option value="대전">대전</option>
								<option value="광주">광주</option>
								<option value="대구">대구</option>
								<option value="부산">부산</option>
								<option value="울산">울산</option>
								<option value="경기도">경기도</option>
								<option value="충청도">충청도</option>
								<option value="강원도">강원도</option>
								<option value="전라도">전라도</option>
								<option value="경상도">경상도</option>
								<option value="제주도">제주도</option>
							</select>
							<div class="error" id="error__location"></div>
							<hr class="dividingLine">
							<div class="wrap__radio">
								<div>
									<img src="${contextPath}/resources/icon/female2_icon.png" width="30px" height="30px"> 
									<input class="radio1" type="radio" name="gender" value="woman" id="gender__woman" /> 
									<span class="gender">여성</span>
								</div>
								<div>
									<img src="${contextPath}/resources/icon/male2_icon.png" width="30px" height="30px"> 
									<input class="radio2" type="radio" name="gender" value="man" id="gender__man" /> 
									<span class="gender">남성</span>
								</div>
							</div>
							<div class="error" id="error__gender"></div>
							<hr class="dividingLine">
						</div>
					</div>
					<hr />
					<div class="wrap__confirm">
						<button class="confirm__btn" id="signup__btn" type="submit" disabled="disabled">가입하기</button>
					</div>
				</div>
			</main>
		</div>
	</form>
	<%@include file="../includes/commonFooter.jsp"%>