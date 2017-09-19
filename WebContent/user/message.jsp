<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>邮箱激活状态</title>
	
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/userLogin.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">

	<style>
		.panel{width:350px;margin:0 auto;font-size:16px;margin-top:50px;}
	</style>
</head>
<body>
<div class="container">
	<jsp:include page="../commonfile/header.jsp"></jsp:include>
	<div class="panel panel-primary">
		  <div class="panel-heading">
		    	<h3 class="panel-title">${message}</h3>
		  </div>
		  <div class="panel-body">
		   		您可以选择返回进行<a href="${pageContext.request.contextPath }/user/userLogin.jsp">登录</a>
		  </div>
	</div>
	<jsp:include page="../commonfile/footer.jsp"/>
</div>
	<% request.getSession().removeAttribute("message");%>
</body>
</html>