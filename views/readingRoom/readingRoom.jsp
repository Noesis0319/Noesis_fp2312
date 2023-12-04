<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/readingRoomHeader.jsp"%>
<%@ page import="java.util.Calendar" %>
<%
Calendar cal = Calendar.getInstance();
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
pageContext.setAttribute("lastDay", lastDay);
%>
<title>readingRoom</title>
</head>
<script>
$(function(){
	let fromObj = $("#seat-form");
	let result = '<c:out value="${result}"/>';
	let res = false;
		if(result !== ""){
			alert(result);	
		}

		$("#select-date").on("change", function(e){
			fromObj.attr("action", "/readingRoom/");
			fromObj.submit();
		})
		
		<c:if test="${!empty voList}">
			<c:forEach items="${voList}" var="vo">
				$("#" + ${vo.sno}).empty();
				$("#" + ${vo.sno}).removeClass("available");
				$("#" + ${vo.sno}).addClass("unavailable");
				$("#" + ${vo.sno}).append("예약 불가")
				<c:if test="${auth.userId eq vo.userId}">
					$("#" + ${vo.sno}).append("<br><br><button class='cancel-btn'>예약 취소</button>")
					res = true;
				</c:if>
			</c:forEach>
		</c:if>
	$(".seat-table a").on("click", function(e){
		if(res){
			alert("다른 좌석을 이미 예약하셨습니다");
			return;
		}
		let sno = $(this).closest("td").attr("id");
		$("input[name='sno']").val(sno);
		$("#seat-form").submit();
	})

	$(".seat-table button").on("click", function(e){
		console.log("click");
		let sno = $(this).closest("td").attr("id");
		$("input[name='sno']").val(sno);
		$("#seat-form").attr("action","/readingRoom/cancel" )
		$("#seat-form").submit();
	})
})
</script>
<body>
<%@include file="../includes/commonInnerHeader.jsp"%>
<form action="${pageContext.request.contextPath}/readingRoom/reservation" method="post" id="seat-form">
<input type="hidden" name="sno" value=""/>
<input type="hidden" name="resDate" value="${resDate}"/>
<input type="hidden" name="userId" value="${auth.userId}"/>
<main>
	<select name="onlyDate" id="select-date">
		<c:forEach begin="1" end="${lastDay}" varStatus="n">
			<option value="${n.count}" <c:out value="${n.count eq onlyDate ? 'selected' : '' }"/>><c:out value="${n.count}"/>일</option>
		</c:forEach>
	</select>
	<table class="seat-table">
		<tr>
			<td id="1" class="available" >
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="2" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="3" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="4" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
		</tr>
		<tr>
			<td id="5" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="6" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="7" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="8" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
		</tr>
		<tr>
			<td id="9" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="10" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="11" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="12" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
		</tr>
		<tr>
			<td id="13" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="14" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="15" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
			<td id="16" class="available">
				<a href="#"> 예약 하기 </a>
			</td>
		</tr>
	</table>
</main>
</form>
<%@include file="../includes/commonFooter.jsp"%>
