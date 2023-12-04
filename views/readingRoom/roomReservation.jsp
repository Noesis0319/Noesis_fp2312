<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/commonHeader.jsp"%>
<%@ page import="java.util.Calendar" %>
<%
  Calendar cal = Calendar.getInstance();
  int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
  pageContext.setAttribute("lastDay", lastDay);
%>
<title>Reservation</title>
</head>
<body>
<%@include file="../includes/commonInnerHeader.jsp"%>
<main>
 <c:out value="${lastDay}"/>
<c:forEach begin="1" end="${lastDay}" varStatus="n">
	<a href=""></a>
	<c:out value="${n.count}"/>
</c:forEach>

</main>
<%@include file="../includes/commonFooter.jsp"%>