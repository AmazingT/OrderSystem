<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>搜索菜单</title>
	
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="../libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="../libs/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="../css/userManage.css" type="text/css">
	<link rel="stylesheet" href="../css/footer.css" type="text/css">
	<link rel="stylesheet" href="../css/index.css" >
	<link rel="stylesheet" href="../css/searchMenu.css" >
</head>

<body>
<div class="navbox">
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
		
		<div class="menu-content">
			<div class="noMenu">${message }</div>
			<div class="result-title">查找成功，找到<span class="searchName">  "${searchName}"  </span>的结果共<span class="number">  ${number}  </span>个</div>
			<div class="menu-show clearfix">
				<c:forEach items="${sessionScope.searchList }" var="m" begin="0" step="1">
					<div class="menu-box">
						<a href="${pageContext.request.contextPath }/order/menu_queryMenuById.action?menu_id=${m.menu_id }">
							<img src="../menu-img/${m.menu_id }.jpg" width="130" height="120" title="${m.menu_name }" />
						</a>
						<span class="name">【${m.menu_name }】</span><br/>
						<span class="content">描述：${m.menu_content }</span><br/>
						<span>价格：<span class="price">¥ ${m.menu_price }元</span></span> 
					</div>
				</c:forEach>
			
				<!-- 分页区 -->
				<div class="pageRow clearfix" style="margin:0;">
					<a href="${pageContext.request.contextPath}/order/menu_searchMenu.action?currentPage=1&name=${searchName}" class="btn btn-primary">首页</a>
					<a href="${pageContext.request.contextPath}/order/menu_searchMenu.action?currentPage=${page.currentPage-1}&name=${searchName}" class="btn btn-primary">上一页</a>
					
					<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
						<c:if test="${page.currentPage == pageCount}">
							<a href="javascript:void(0)" class="btn active">${pageCount}</a>
						</c:if>
						<c:if test="${page.currentPage != pageCount}">
							<a href="${pageContext.request.contextPath}/order/menu_searchMenu.action?currentPage=${pageCount}&name=${searchName}" class="btn btn-default">${pageCount}</a>
						</c:if>
					</c:forEach>
					
					<a href="${pageContext.request.contextPath}/order/menu_searchMenu.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}&name=${searchName}" class="btn btn-primary">下一页</a>
					<a href="${pageContext.request.contextPath}/order/menu_searchMenu.action?currentPage=${page.endPage}&name=${searchName}" class="btn btn-primary">尾页</a>
				</div>
			</div>
		</div>	
		
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>
</body>
</html>