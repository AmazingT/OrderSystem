<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=gb2312"
	pageEncoding="gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>购物车</title>
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/index.css" rel="stylesheet">
	<link href="../css/Cart.css" rel="stylesheet">
</head>

<body>
<div class="navbox">
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
			<c:if test="${!empty message }">
				<div class="message">${message }</div>
			</c:if>
			
			<c:if test="${empty message }">
				<div class="table-responsive">
					<table class="table table-bordered">		
						<tr class="title">
							<th>编号</th>
							<th>菜名</th>
							<th>数量</th>
							<th>口味</th>
							<th>单价</th>
							<th>总价</th>
							<th>备注</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${list }" var="m" begin="0" step="1">
							<tr>
								<td>${m.menuId }</td>
								<td>${m.name }</td>
								<td>
									<button class="btn-num-left" type="button">-</button>
									<input  class="order-num"  type="text" maxlength="9" value="${m.count }">
									<button class="btn-num-right" type="button">+</button>
								</td>
								<td>${m.taste }</td>
								<td>${m.price }</td>
								<td>${m.total }</td>
								<td>${m.content }</td>
								<td><a href="${pageContext.request.contextPath }/order/order_deleteMenu.action?orderID=${m.orderID }">删除</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="table-bottom">
					<span>总价：<span class="totalprice">${totalprice }</span></span>
					<a href="${pageContext.request.contextPath }/orderPage/sendInfo.jsp" class="btn btn-danger">去结算</a>		
				</div>
			</c:if>				
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>
<%session.removeAttribute("count"); %>
<script src="../libs/js/jquery-3.1.1.min.js"></script>
<script>
	$(function(){
		$(".btn-num-left").each(function(){
			$(this).click(function(){
				var n = $(this).next().val();
				var num = parseInt(n)-1;
				if(num<1) num=1;
			    $(this).next().val(num);
			});
		});
		
		$(".btn-num-right").each(function(){
			$(this).click(function(){
				var n = $(this).prev().val();
				var num = parseInt(n)+1;
				if(num>9) num=1;
			    $(this).prev().val(num);
			});
		});
	});
</script>
</body>
</html>
