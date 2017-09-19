<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>提交订单</title>
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
			<div class="table-responsive">		
				<h4>订单提交成功，您当前订购的清单如下：</h4>			
				<table class="table table-bordered">
					<tr class="title">
						<td>编号</td>
						<td>菜名</td>
						<td>数量</td>
						<td>口味</td>
						<td>单价</td>
						<td>总价</td>
						<td>付款状态</td>
					</tr>
					<c:forEach items="${list }" var="m" begin="0" step="1">
						<tr>
							<td>${m.menuId }</td>
							<td>${m.name }</td>
							<td>${m.count }</td>
							<td>${m.taste }</td>
							<td>${m.price }</td>
							<td>${m.total }</td>	
							<td>
								<c:if test="${m.state == '0'}">已付款</c:if>
								<c:if test="${m.state == '1'}">未付款</c:if>
							</td>											
						</tr>
					</c:forEach>
				</table>
		</div>	
		<div class="table-bottom">
			<span>总计：<span class="totalprice">${totalprice }</span></span>
			<a href="${pageContext.request.contextPath }/orderPage/sendInfo.jsp" class="btn btn-danger">结算</a>	
		</div>
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>
</body>
</html>
