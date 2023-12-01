<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--코어 라이브러리 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%--XML 라이브러리 --%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
    
<%--FMT 라이브러리 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<%--SQL 라이브러리 --%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
    
<%--함수 라이브러리 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%--context 경로 변수 지정 --%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>    
<c:set var="auth" value="${seesionScope.auth}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<link href="${contextPath}/resources/css/board.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/css/includes.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/css/commonCss.css" rel="stylesheet" type="text/css">



	