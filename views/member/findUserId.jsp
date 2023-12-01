<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>아이디 찾기</title>
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
		const userName = $("#userName").val();
		$("#error__name").text("");
		if(userName === ""){
			$("#error__name").text("이름을 입력해 주세요.");
			$("#userName").focus();
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
<form method="post" action="${pageContext.request.contextPath}/member/findUserId">
<%@include file="../includes/commonInnerHeader.jsp"%>
<div class="wrapper-signup">
			<main>
				<div class="formContainer">
					<div class="panner-wrap">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/login_icon.png" width="30px" height="30px"> <input type="text" class="main__input" id="userName" name="userName" placeholder="이름을 입력해 주세요" maxlength="8">
							<div class="error" id="error__name"></div>
						</div>
						<hr class="dividingLine">
					</div>
					<hr class="dividingLine">
					<div class="panner-wrap">
						<div style="display: flex;">
							<img src="${contextPath}/resources/icon/tower_icon.png" width="30px" height="30px"> <select style="border: 0px; border-radius: 10%; width: 100px; font-size: 15px; text-align: center;">
								<option>SKT</option>
								<option>KT</option>
								<option>LG U+</option>
							</select>
						</div>
						<hr class="dividingLine">
						<div style="display: flex;" class="wrap__phone">
							<img src="${contextPath}/resources/icon/phone_icon.png" width="30px" height="30px"> <input class="phone__input" id="phone1" type="text" maxlength="3" /> <span>-</span> <input class="phone__input" id="phone2" type="text" maxlength="4" /> <span>-</span> <input class="phone__input" id="phone3" type="text" maxlength="4" />
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
						</div>
					</div>
					<div class="wrap__confirm">
						<button class="confirm__btn" id="signup__btn" type="submit" disabled="disabled">아이디찾기</button>
					</div>
				</div>
			</main>
		</div>
</form>
<%@include file="../includes/commonFooter.jsp"%>