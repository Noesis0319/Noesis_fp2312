<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./includes/commonHeader.jsp"%>
<title>Home</title>

</head>
<style>
.slideshow-image {
	border-radius: 3%;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.mySlides {
	border-radius: 3%;
	width: 100%;
	height: 300px;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0px 15px 15px rgba(0, 0, 0, 0.5);
}

.slideshow-container {
	/*     display: flex; */
	/*     justify-content: center; */
	/*     position: relative; */
	/* 	margin: auto; */
	
}

#m1 {
	height: 300px;
	width: 550px;
}

#m2 {
	height: 300px;
	width: 550px;
	display: none;
}

#m3 {
	height: 300px;
	width: 550px;
	display: none;
}

#m4 {
	height: 300px;
	width: 550px;
	display: none;
}

#m5 {
	height: 300px;
	width: 550px;
	display: none;
}

#m6 {
	height: 300px;
	width: 550px;
	display: none;
}

#bt1 {
	font-weight: bold;
}
</style>
<script>
	$(function() {
		let location = '<c:out value="${location}"/>';
		switch (location) {
		case "서울":
			callCity = "seoul"
			break;
		case "경기도":
			callCity = "Gyeonggi-do"
			break;
		case "인천":
			callCity = "Incheon "
			break;
		case "대전":
			callCity = "Daejeon "
			break;
		case "광주":
			callCity = "Gwangju "
			break;
		case "대구":
			callCity = "Daegu "
			break;
		case "부산":
			callCity = "Busan "
			break;
		case "울산":
			callCity = "Ulsan "
			break;
		case "경상도":
			callCity = "Gyeongsang-do"
			break;
		case "충청도":
			callCity = "Chungcheong-do"
			break;
		case "강원도":
			callCity = "Gangwon"
			break;
		case "전라도":
			callCity = "Jeolla-do"
			break;
		case "제주도":
			callCity = "Jeju"
			break;
		}
		let url = "https://api.openweathermap.org/data/2.5/weather?q="
				+ callCity + "&appid=80dc49c0f772e91e61042e798255bb7c";

		$.getJSON(url).done(
				function(result) {
					let icon = "https://openweathermap.org/img/wn/"
							+ result.weather[0].icon + "@2x.png";
					let img = $("#icon").attr("src", icon);
					$(".temp").text((result.main.temp - 273.15).toFixed(1));
					$(".city").text(location);
				}).fail(function(result) {
			console.log(result);
			alert("연결실패");
		});
		
        const menu1 = $("#m1");
        const menu2 = $("#m2");
        const menu3 = $("#m3");
        const menu4 = $("#m4");
        const menu5 = $("#m5");
        const menu6 = $("#m6");
        const bt1 = $("#bt1");
        const bt2 = $("#bt2");
        const bt3 = $("#bt3");
        const bt4 = $("#bt4");
        const bt5 = $("#bt5");
        const bt6 = $("#bt6");
        
        bt1.on("click", function(){
             menu1.show();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#cc00ff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt2.on("click", function(){
             menu1.hide();
             menu2.show();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#cc00ff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt3.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.show();
             menu4.hide();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#cc00ff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt4.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.show();
             menu5.hide();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#cc00ff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#ffffff");
        })
        bt5.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.show();
             menu6.hide();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#cc00ff");
             bt6.css("color", "#ffffff");
        })
        bt6.on("click", function(){
             menu1.hide();
             menu2.hide();
             menu3.hide();
             menu4.hide();
             menu5.hide();
             menu6.show();
             bt1.css("color", "#ffffff");
             bt2.css("color", "#ffffff");
             bt3.css("color", "#ffffff");
             bt4.css("color", "#ffffff");
             bt5.css("color", "#ffffff");
             bt6.css("color", "#cc00ff");
        })
       
        $.ajax({
                method: "GET",
                url: "https://dapi.kakao.com/v3/search/book?target=title",
                data: { query : "무라카미 하루키" },
                headers : {Authorization: "KakaoAK 409ce1accb5ba453c43c46776db24f5d"}
            }).done(function (msg) {
             $(".book-search-container").empty();
    	        let length = msg.documents.length;
    	        let row = 1;
    	        console.log(msg.documents[0].title);
    				for(let i = 0 ; i < length; i++){
    					console.log("a");
    					if(i%6 == 0){
    						row++;
    					}
    					let container = '#book-search-container' + row; 
    					let child = '<div class="mini-book-search"><img class="mini-book-img" src = "' 
    					+ msg.documents[i].thumbnail + '"/>' + '<p>' + msg.documents[i].title + '</p>' 
    					+ '<p>' + msg.documents[i].authors + '</p>'  + '<p>' + msg.documents[i].publisher + '</p></div>';
    	            $(container).append(child);
    	        	}
                });
        
        $("#book-search-btn").on("click", function(e){
    		let book = $("#search-book").val();
     		$.ajax({
                method: "GET",
                url: "https://dapi.kakao.com/v3/search/book?target=title",
                data: { query : book },
                headers : {Authorization: "KakaoAK 409ce1accb5ba453c43c46776db24f5d"}
            }).done(function (msg) {
             $(".book-search-container").empty();
    	        let length = msg.documents.length;
    	        let row = 1;
    				for(let i = 0 ; i < length; i++){
    					console.log("a");
    					if(i%6 == 0){
    						row++;
    					}
    					let container = '#book-search-container' + row; 
    					let child = '<div class="mini-book-search"><img class="mini-book-img" src = "' 
    					+ msg.documents[i].thumbnail + '" />' + '<p>' + msg.documents[i].title + '</p>' 
    					+ '<p>' + msg.documents[i].authors + '</p>'  + '<p>' + msg.documents[i].publisher + '</p></div>';
    	            $(container).append(child);
    	        	}
                });
        });
       
	})
</script>

<body>
	<%@include file="./includes/commonInnerHeader.jsp"%>
	<main>
		<div class="slideshow-container">
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test1.jpg" class="slideshow-image">
			</div>
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test1.jpg" class="slideshow-image">
			</div>
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test2.jpg" class="slideshow-image">
			</div>
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test3.jpg" class="slideshow-image">
			</div>
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test4.jpg" class="slideshow-image">
			</div>
			<div class="mySlides">
				<img src="${pageContext.request.contextPath}/resources/img/test5.jpg" class="slideshow-image">
			</div>
		</div>
		<script>
        let slideIndex = 0;
        showSlides();
        function showSlides() {
            let i;
            let slides = $(".mySlides");
           
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) {
                slideIndex = 1
            }
            slides[slideIndex - 1].style.display = "block";
        
            setTimeout(showSlides, 1000);
        }
    </script>
		<div class="home-div1">
			<div class="weather-box">
			<c:if test="${not empty auth.userId}">
				<div class="aligned-box">
					<span class="city"></span> <span> 의 현재 기온은 &nbsp;</span> <span class="temp" id="temp"></span>℃입니다
				</div>
				<img src="#" id="icon">
			</c:if>
		</div>
			<div style="margin-left: 400px;">
				<ul class="common-quick-menu2">
					<li style="margin-left:20px;">
						<a href="${pageContext.request.contextPath}/book/bookRental">
							<img src="${contextPath}/resources/icon/book2_icon.png" class="common-quick2-menu__icon">
						</a>
						<br>대출/예약
					</li>
					<li style="margin-left:20px;">
						<a href="${pageContext.request.contextPath}/readingRoom/">
							<img src="${contextPath}/resources/icon/desk_icon.png" class="common-quick2-menu__icon">
						</a>
						<br>열람실 예약
					</li>
					<li style="margin-left:20px;">
						<a href="#">
							<img src="${contextPath}/resources/icon/map2_icon.png" class="common-quick2-menu__icon">
						</a>
						<br>오시는길
					</li>
					<li style="margin-left:20px;">
						<a href="#">
							<img src="${contextPath}/resources/icon/qna_icon.png" class="common-quick2-menu__icon">
						</a><br>이용문의
					</li>
					<li style="margin-left:20px;">
						<a href="#">
							<img src="${contextPath}/resources/icon/clock_icon.png" class="common-quick2-menu__icon">
						</a>
						<br>이용시간
					</li>
				</ul>
			</div>
		</div>
		<div class="home-div1">
			<div>
			<div class="mini-list-box">
				<div class="mini-list-name-box">
					<button class="mini-list-btn" id="bt1">공지사항</button>
					<button class="mini-list-btn" id="bt2">홍보</button>
					<button class="mini-list-btn" id="bt3">행사</button>
					<button class="mini-list-btn" id="bt4">자유게시판</button>
					<button class="mini-list-btn" id="bt5">질문게시판</button>
					<button class="mini-list-btn" id="bt6">게시판1</button>
				</div>
				<div>
					<div id="m1">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>
							<c:choose>
								<c:when test="${empty articlesList}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
										[		<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
													<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div id="m2">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>

							<c:choose>
								<c:when test="${empty articlesList2}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList2}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
												[<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
													<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div id="m3">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>

							<c:choose>
								<c:when test="${empty articlesList3}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList3}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
												[<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
													<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div id="m4">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>
							<c:choose>
								<c:when test="${empty articlesList4}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList4}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
												[<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
													<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div id="m5">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>
							<c:choose>
								<c:when test="${empty articlesList5}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList5}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
												[<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
												<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					<div id="m6">
						<table class="mini-articlesList">
							<tr>
								<th width="15%" style="text-align: center;">글번호</th>
								<th width="40%" style="text-align: center;">제목</th>
								<th width="20%" style="text-align: center;">작성자</th>
								<th width="25%" style="text-align: center;">작성일</th>
							</tr>
							<c:choose>
								<c:when test="${empty articlesList6}">
									<td>등록된 글이 없습니다</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="article" items="${articlesList6}" varStatus="articleNum" begin="0" end="12">
										<tr>
											<td>
												<c:out value="${article.bno}" />
											</td>
											<td>
												<c:if test="${!empty article.subject}">
												[<c:out value="${article.subject}" />]
												</c:if> 
												<a href="${pageContext.request.contextPath}/board/read?bno=${article.bno}&boardName=${article.boardName}">
												<c:out value="${article.title}" />
												</a>
											</td>
											<td>${article.writer}</td>
											<td>
												<c:choose>
													<c:when test="${article.regDate} == ${article.updateDate}">
														<fmt:formatDate pattern="yy-MM-dd" value="${article.regDate}" />
													</c:when>
													<c:otherwise>
														<fmt:formatDate pattern="yy-MM-dd" value="${article.updateDate}" />
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
			<div class="home-book-search">
			<div class="search-book-box">
				<input type="text" id="search-book"  placeholder="검색할 작가 / 도서명">
				<button id="book-search-btn" class="custom-btn btn-14 viewArticle-confirm-btn">검색</button>
				<a href="${pageContext.request.contextPath}/book/bookBoard" class="custom-btn btn-14 viewArticle-confirm-btn">상세검색</a>
			</div>
				<hr class="dividingLine">
				<div id="book-search-container1" class="book-search-container"></div>
				<div id="book-search-container2" class="book-search-container"></div>
				<div id="book-search-container3" class="book-search-container"></div>
				<div id="book-search-container4" class="book-search-container"></div>
			</div>
		</div>
	</main>


	<%@include file="./includes/commonFooter.jsp"%>