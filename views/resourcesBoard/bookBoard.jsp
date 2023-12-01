<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<title>Insert title here</title>
<style>
#book-search-container {
	display: flex;
}
.book-search-result {
	width: 200px;
	height: 400px;
}
.book-search-result p {
	font-size: 13px;
	text-decoration: underline;
}
</style>
</head>
<body>
	<%@include file="../includes/commonInnerHeader.jsp"%>
	<main>
		<div class="search-book-box">
			<input type="text" id="search-book"  placeholder="검색할 작가 / 도서명">
			<button id="bt1" class="custom-btn btn-14 viewArticle-confirm-btn">검색</button>
		</div>
		<hr class="dividingLine">
		<div id="book-search-container1" class="book-search-container"></div>
		<div id="book-search-container2" class="book-search-container"></div>
		<div id="book-search-container3" class="book-search-container"></div>
		<div id="book-search-container4" class="book-search-container"></div>
<script>
 $(function(){
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
					let child = '<div class="book-search-result"><img src = "' 
					+ msg.documents[i].thumbnail + '"/>' + '<p>' + msg.documents[i].title + '</p>' 
					+ '<p>' + msg.documents[i].authors + '</p>'  + '<p>' + msg.documents[i].publisher + '</p></div>';
	            $(container).append(child);
	        	}
         });
 	$("#bt1").on("click", function(e){
		let book = $("#search-book").val();
 		$.ajax({
            method: "GET",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: { query : book },
            headers : {Authorization: "KakaoAK 409ce1accb5ba453c43c46776db24f5d"}
        }).done(function (msg) {
         $(".book-search-container").empty();
	        console.log(msg)       ;
	        console.log(msg.documents[0].title);
	        console.log(msg.documents[1].title);
	        let length = msg.documents.length;
	        let row = 1;
	        console.log("length : " + length)
				for(let i = 0 ; i < length; i++){
					console.log("a");
					if(i%6 == 0){
						row++;
					}
					let container = '#book-search-container' + row; 
					let child = '<div class="book-search-result"><img src = "' 
					+ msg.documents[i].thumbnail + '"/>' + '<p>' + msg.documents[i].title + '</p>' 
					+ '<p>' + msg.documents[i].authors + '</p>'  + '<p>' + msg.documents[i].publisher + '</p></div>';
	            $(container).append(child);
	        	}
            });
    });
});
</script>
	</main>
	<%@include file="../includes/commonFooter.jsp"%>