<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<meta name="keywords" content="外卖">
	
	<title>乐卖后台管理系统</title>
	
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="libs/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="css/manage.css" type="text/css">
	
</head>
<body>
	<!-- 顶部 -->
	<div class="header navbar navbar-inverse navbar-fixed-top">
		<div class="inner-navbar">
			<div class="container-fluid">
				<a class="brand" href="index.html">
					<span>乐卖后台管理系统</span>
				</a>
				<div  class="nav-content">
					<span><i class="icon-user"></i>管理员：${sessionScope.adminName}</span>
					<c:if test="${!empty adminName}">
						<a href="order/admin_adminExit.action" class="signout">
							<i class="icon-signout"></i>
							注销
						</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 主体 -->
	<div class="page-container clear">
		<!-- 左侧导航栏 -->
		<div class="page-left-list" id="page-left-list">
			<div class="menu">
				<p>导航菜单</p>
			</div>
			<!-- 底部导航栏 -->
			<div class="list" id="list">
					<a href="javascript:void(0)" name="order/user_userList.action?currentPage=1" class="active">
						<i class="icon-user"></i>
						<span>用户管理</span>
					</a>
					<a href="javascript:void(0)" name="order/menu_menuList.action?currentPage=1">
						<i class="icon-food"></i>
						<span>菜单管理</span>
					</a>
					<a href="javascript:void(0)" name="order/order_orderList.action?currentPage=1&pay=0">
						<i class="icon-book"></i>
						<span>订单管理</span>
					</a>
					<a href="javascript:void(0)" name="order/mg_msgList.action?currentPage=1">
						<i class="icon-comments"></i>
						<span>评论管理</span>
					</a>
			</div>
		</div>
		<!-- 右侧内容 -->
		<div class="page-right-content" id="page-right-content">
			<div class="page-content container-fluid">
				<iframe class="iframe" src="order/user_userList.action?currentPage=1" frameborder="0"></iframe>		
			</div>
		</div>
	</div>
	
	<script src="libs/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
		$(function(){		
			var select = $("#list>a");
			select.click(function(){
				var url = $(this).attr("name");
				$(this).addClass("active").siblings().removeClass();
				$(".iframe").attr("src",url);
			});
		});
	</script>
</body>
</html>