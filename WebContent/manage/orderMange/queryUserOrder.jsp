<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>显示查询的用户订单信息</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon"/>	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../css/userManage.css" type="text/css"/>
	<style>
		.result{font-size: 16px;color: #0377c5;margin-bottom: 25px;}
		.back{margin-bottom: 25px;}
	</style>
</head>
<body>
	<% int i=1;%>
	<div class="container-fluid">
		<div class="result">${message }</div>
		<table class="table table-bordered table-responsive">
			<tr class="title">
				<td>编号</td>
				<td>菜名</td>
				<td>数量</td>
				<td>单价（元）</td>
				<td>总价（元）</td>
				<td>订单时间</td>
				<td>状态</td>
			</tr>
			<c:forEach items="${lists}" var="list" begin="0" step="1">
				<tr class="record">
					<td><%=i++ %></td>
					<td>${list.name }</td>
					<td>${list.count }</td>
					<td>${list.price }</td>
					<td>${list.total }</td>
					<td>${list.sendTime }</td>
					<td>
						<c:if test="${list.state=='0' }">已付款</c:if>
						<c:if test="${list.state=='1' }">未付款</c:if>
					</td>
				</tr>	
			</c:forEach>
		</table>
		<%session.removeAttribute("lists"); %>
	</div>	
</body>
</html>