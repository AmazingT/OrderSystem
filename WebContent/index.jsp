<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title> 欢迎你的到来</title>
	
	<link href="image/favicon.ico" rel="shortcut icon">
	<link href="libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="css/index.css" rel="stylesheet">
	<link href="css/footer.css" rel="stylesheet">

</head>
<% 	
	String flag = request.getParameter("flag");
	session.setAttribute("flag",flag);
%>
<%
	if(request.getSession().getAttribute("allMenuList") == null){
		response.sendRedirect("order/menu_showMenu.action");
	}
%>
<body onload="getTime()">
<div class="navbox">
  <span style="float:left;line-height:40px;margin-left:25px;">你好，欢迎来到乐卖！</span>
  <div class="container">
  	  <jsp:include page="commonfile/mainHeader.jsp"></jsp:include>
   	  <!-- 主体部分 -->
   	  <div class="main-header">
   	 	  <div class="row">
				<div class="col-md-2">
					<img src="image/logo.jpg" alt="" width="120" height="120">
				</div>
				<div class="col-md-4 search-box">
					<form name="myForm" action="${pageContext.request.contextPath}/order/menu_searchMenu.action" method="get">
						<div class="form-group">
							<input id="searchContent" name="name" class="form-control" type="text" placeholder="请输入搜索的内容...">
						</div>
						<!--添加一个隐藏的元素来使search图标可以点击！-->
						<button type="button" onclick="searchMenu()" class="btn btn-danger search">搜索</button>
					</form>					
				</div>
				<div id="time" class="col-md-2"></div>
		   </div>
   	  </div>
   	  
   	  <div class="row">
   	  	  <div class="classify">
   	  	  	  <ul>
   	  	  	  	 <li><a href="#">小吃快餐</a></li>
   	  	  	  	 <li><a href="#">日韩料理</a></li>
   	  	  	  	 <li><a href="#">川湘菜系</a></li>
   	  	  	  	 <li><a href="#">早餐美食</a></li>
   	  	  	  	 <li><a href="#">果蔬生鲜</a></li>
   	  	  	  	 <li><a href="#">甜品饮品</a></li>
   	  	  	  	 <li><a href="#">特色菜系</a></li>
   	  	  	  </ul>
   	  	  </div>
   	  </div>
   	  
   	  <!-- 菜单主体部分 -->
   	  <div class="row clearfix">
   	  	  <!-- 公告信息展示 -->
  		  <div class="main-left">
  		  	  <div class="main-left-header">
  		  	  	  <div class="main-title"><i class="point"></i>网站公告</div>
  		  	  	  <div class="main-left-content">
  		  	  	  	  <p>节假日期间10:30-12:30；16:30-17:30外卖时间会有延迟，周末16:30-17:30外卖时间会有延迟。
						 <br/>---乐卖订餐欢迎您的到来</p>
  		  	  	  </div>
  		  	  </div>
  		  	  <div class="main-left-middle">
  		  	  	  <div class="main-title"><i class="point"></i>优惠活动</div>
  		  	  	  	<marquee onMouseOut=this.start(); onMouseOver=this.stop() direction="up" scrollamount="2">
						<a href="">消费满100元，立减10元</a>
						<a href="">消费满200元，立减25元</a>
						<a href="">订购大盘鸡一份，送10个馒头</a>
						<a href="">订购四道家常菜，可获赠水果沙拉一份</a>
						<a href="">情人节，情侣订餐可获赠甜蜜蜜一份</a>
						<a href="">团购享受8折超值优惠</a>
					</marquee>
  		  	  </div>
  		  	  <div class="main-left-footer">
  		  	  	  <div class="main-title"><i class="point"></i>销售Top</div>
  		  	  	  <ul>
		  	  	  		<li><i class="count">1.</i><a href="${pageContext.request.contextPath}/order/menu_queryMenuById?menu_id=20">黑椒鸡饭</a></li>
		  	  	  		<li><i class="count">2.</i><a href="${pageContext.request.contextPath}/order/menu_queryMenuById?menu_id=16">私房小炒肉</a></li>
		  	  	  		<li><i class="count">3.</i><a href="${pageContext.request.contextPath}/order/menu_queryMenuById?menu_id=4">宫爆鸡丁</a></li>
		  	  	  		<li><i class="count">4.</i><a href="${pageContext.request.contextPath}/order/menu_queryMenuById?menu_id=6">黑椒牛柳炒面</a></li>
  		  	  	  </ul>
  		  	  </div>
  		  </div>
  		  <!-- 菜品显示 -->
  		  <div class="main-middle">
  		  		<div class="menu-show clearfix">
  		  			<div class="menu clearfix">
						<c:forEach items="${sessionScope.allMenuList }" var="m" begin="0" step="1">
							<div class="menu-box">
								<a href="order/menu_queryMenuById.action?menu_id=${m.menu_id }">
									<img src="menu-img/${m.menu_id }.jpg" width="120" height="120" title="${m.menu_name }" />
								</a>
								<span class="name">【${m.menu_name }】</span><br/>
								<span class="content">描述：${m.menu_content }</span><br/>
								<span>价格：<span class="price">¥ ${m.menu_price }</span></span> 
							</div>
						</c:forEach>
					</div>
					<!-- 分页区 -->
					<c:if test="${!empty allMenuList }">
						<div class="pageRow clearfix">
							<a href="${pageContext.request.contextPath}/order/menu_showMenu.action?currentPage=1" class="btn btn-primary">首页</a>
							<a href="${pageContext.request.contextPath}/order/menu_showMenu.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
							
							<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
								<c:if test="${page.currentPage == pageCount}">
									<a href="javascript:void(0)" class="btn active">${pageCount}</a>
								</c:if>
								<c:if test="${page.currentPage != pageCount}">
									<a href="${pageContext.request.contextPath}/order/menu_showMenu.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
								</c:if>
							</c:forEach>
							
							<a href="${pageContext.request.contextPath}/order/menu_showMenu.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
							<a href="${pageContext.request.contextPath}/order/menu_showMenu.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
						</div>
					</c:if>
				</div>
  		  </div>
   	  </div>
   	  <jsp:include page="commonfile/footer.jsp"></jsp:include>
   </div>
</div>
<script src="libs/js/jquery-3.1.1.min.js"></script>
<script src="libs/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<% request.getSession().removeAttribute("allMenuList");%>
</body>
</html>