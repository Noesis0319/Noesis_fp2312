<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
nav {
	background: #c77dff;
}

nav ul {
	margin: 0;
	padding: 0;
}

nav ul li {
	display: inline-block;
	width: 140px;
	position: relative;
}

nav ul li a {
	color: #fff;
	display: block;
	font-size: 14px;
	padding: 15px 14px;
	transition: 0.3s linear;
}

nav ul li:hover {
	background: #ce91fc;
}

nav ul li ul {
	border-bottom: 5px solid #c8b6ff;
	display: none;
	position: absolute;
}

nav ul li ul li {
	border-top: 1px solid #c8b6ff;
	display: block;
}

nav ul li ul li:first-child {
	border-top: none;
}

nav ul li ul li a {
	background: #e7c6ff;
	display: block;
	padding: 10px 14px;
}

nav ul li ul li a:hover {
	background: #c77dff;
}
</style>
<script>
	$(function() {
		let msg = "${msg}";
		let txt;
		
		$('nav li').hover(function() {
			$('ul', this).stop().slideDown(200);
		}, function() {
			$('ul', this).stop().slideUp(200);
		});
		
		if(msg === ""){
			return;
		}
		
		if(msg === "logout"){
			txt = "로그아웃 되셨습니다"
		}
		alert(txt);
	})
</script>
<header>
	<div class="common-header-top" style="background-image: url(${contextPath}/resources/img/vackground-com-6XNIVSDzA2g-unsplash.jpg); background-repeat: no-repeat; background-size: 100% 100% ;">
		<div>	
			<a href="${contextPath}/"> <img src="${contextPath}/resources/icon/logo1_icon.png" style="height: 130px; width: 130px;">
			</a>
		</div>
		<div style="margin: 0 auto">
		</div>
		<div class="common-box" style="width: 25%; margin-left: auto;">
			<div class="common-profileBox">
				<div style="width: 20%;">
					<c:if test="${not empty auth}">
					
						<img src="${contextPath}/resources/img/97589071_p13_master1200.jpg" class="common-profileBox__img">
						
					</c:if>
				</div>
				<div style="width: 75%;">
					<div style="display: flex;">
						<div style="width: 80%;color:#ffffff">
							<a href="${contextPath}/member/userInfo?userId=${auth.userId}" style="color:#ffffff;font-weight:bold"><c:out value="${auth.userName}" /></a>
							<c:choose>
								<c:when test="${not empty auth}"> 님</c:when>
								<c:otherwise>
								<a href="${contextPath}/member/login" class="custom-btn btn-15" style="width: 200px; height: 50px; font-size: 30px">로그인</a>
								</c:otherwise>
							</c:choose>
							<br> <a href="${contextPath}/member/userInfo?userId=${auth.userId}" style="color:#ffffff;font-weight:bold"><c:out value="${auth.userId}" /></a>
						</div>
						<div style="width: 20%;">
							<c:if test="${not empty auth}">
							
							<a href="${contextPath}/member/logout" class="custom-btn btn-15" style="width: 50px; height: 25px;">로그아웃</a>
								
							</c:if>
						</div>
					</div>
					<div style="width: 100%; display:flex;">
						<c:if test="${empty auth}">
			
						<a href="${contextPath}/member/signup" class="custom-btn btn-15" style="width: 70px; height: 25px;">회원가입</a>
						<a href="${pageContext.request.contextPath}/member/findUserId" class="custom-btn btn-15" style="width: 70px; height: 25px;">아이디 찾기</a> 
						<a href="${pageContext.request.contextPath}/member/findUserPw" class="custom-btn btn-15" style="width: 70px; height: 25px;">비밀번호 찾기</a>
						
						</c:if>
					</div>
				</div>
			</div>
			<div class="common-box-quick-menu">
				<ul class="common-quick-menu">
				<c:if test="${not empty auth}">
				
				<li>
					<a href="#"><img src="${contextPath}/resources/icon/github_icon.png" class="common-quick-menu__icon"></a><br> 퀵 메뉴1
				</li>
				<li>
					<a href="#"><img src="${contextPath}/resources/icon/instar_icon.png" class="common-quick-menu__icon"></a><br> 퀵 메뉴2
				</li>
				<li>
					<a href="#"><img src="${contextPath}/resources/icon/twiter_icon.png" class="common-quick-menu__icon"></a><br> 퀵 메뉴3
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/member/readMessage?userId=${auth.userId}">
						<img src="${contextPath}/resources/icon/talk_icon.png" class="common-quick-menu__icon">
					</a><br> 메세지 
				</li>
				<li>
					<a href="#"><img src="${contextPath}/resources/icon/config_icon.png" class="common-quick-menu__icon"></a><br> 퀵 메뉴5
				</li>
				<li>
					<a href="#"><img src="${contextPath}/resources/icon/config_icon.png" class="common-quick-menu__icon"></a><br> 퀵 메뉴6
				</li>
				
				</c:if>
				</ul>
			</div>
		</div>
	</div>
	<nav>
		<ul>
			<li></li>
			<li>
				<a href="${contextPath}/">Home</a>
			</li>
			<li>
				<a href="#">알림광장</a>
				<ul>
					<li>
						<a href="${contextPath}/board/adminBoard">공지사항</a>
					</li>
					<li>
						<a href="${contextPath}/board/adminBoard2">홍보</a>
					</li>
					<li>
						<a href="${contextPath}/board/adminBoard3">행사</a>
					</li>
				</ul>
			</li>
			<li class='sub-menu'>
				<a href="#">소통광장</a>
				<ul>
					<li>
						<a href="${contextPath}/board/">자유게시판</a>
					</li>
					<li>
						<a href="${contextPath}/board/board2">질문게시판</a>
					</li>
					<li>
						<a href="${contextPath}/board/board3">책나눔/기증</a>
					</li>
				</ul>
			</li>
			<li class='sub-menu'>
				<a href="#">참여광장</a>
				<ul>
					<li>
						<a href="#">공모전1</a>
					</li>
					<li>
						<a href="#">공모전2</a>
					</li>
					<li>
						<a href="#">공모전3</a>
					</li>
					<li>
						<a href="#">참여교육 </a>
					</li>
					<li>
						<a href="#">학습센터 </a>
					</li>
					<li>
						<a href="#">설문조사 </a>
					</li>
				</ul>
			</li>
			<li class='sub-menu'>
				<a href="#">이용안내</a>
				<ul>
					<li>
						<a href="#">도서관 이용안내</a>
					</li>
					<li>
						<a href="${contextPath}/book/bookBoard">도서조회</a>
					</li>
					<li>
						<a href="#">신청안내 </a>
					</li>
					<li>
						<a href="#">도서관 일정</a>
					</li>
					<li>
						<a href="#">자주하는 질문 </a>
					</li>
					<li>
						<a href="#">분실물찾기 </a>
					</li>
				</ul>
			</li>
			<li class='sub-menu'>
				<a href="#">도서관 소개</a>
				<ul>
					<li>
						<a href="#">도서관 안내</a>
					</li>
					<li>
						<a href="#">도서관 협력망</a>
					</li>
					<li>
						<a href="#">정보공개</a>
					</li>
					<li>
						<a href="#">관내사이트 안내</a>
					</li>
					<li>
						<a href="#">편의시설</a>
					</li>
				</ul>
			</li>
		</ul>
	</nav>
</header>
