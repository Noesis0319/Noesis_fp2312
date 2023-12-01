<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aa</title>
</head>
<body>
	<div class="container">
		<div class="wrapper">
			<div class="wrapper_title">
				<span>Spring project</span>
			</div>
		</div>
		<nav class="wrapper_menu">
		<a href="/board/list"><span class="menu-item">게시판</span></a>
			<a href="/member/signup"><span class="menu-item">회원가입</span></a>
			<c:choose>
			<c:when test="${not empty auth}">
				<a href="/member/logout"><span class="menu-item">로그아웃</span></a>
			</c:when>
			<c:otherwise>
				<a href="/member/login"><span class="menu-item">로그인</span></a>
			</c:otherwise>
			</c:choose>
		</nav>
	</div>