<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap-theme.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/elegant-icons-style.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/font-awesome.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/style-responsive.css" />" rel="stylesheet">

<title>Login</title>
</head>
<body>
<div class="page-404">
    <p class="text-404">404</p>
	<c:set var="contexto" value="${pageContext.request.contextPath}"/>	
    <h2>Ah, não!</h2>
    <p>Está Página não existe. <br><a href="${contexto}/Login">Retorne ao Login</a></p>
 </div>
</body>
</html>