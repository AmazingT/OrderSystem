<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>菜品详情</title>
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/index.css" rel="stylesheet">
	<link href="../css/menuInfo.css" rel="stylesheet">
	
</head>

<body>
<div class="navbox">
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
		
			<div class="main-header">
	   	 	  <div class="row">
					<div class="col-md-2">
						<img src="../image/logo.jpg" alt="" width="120" height="120">
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
	   	  <div class="row">
	   	  		<div class="menuInfo clearfix">
	   	  				<h4>【${menu.menu_name }】</h4>
	   	  				<div class="menu-img">
	   	  					<img width="260" src="../menu-img/${menu.menu_id }.jpg" />
	   	  				</div>
	   	  				<div class="menu-content">
	   	  					<form action="${pageContext.request.contextPath }/order/order_addMenu.action" method="post">
								<input type="hidden" name="userID" value="${user_id }">
								<input type="hidden" name="username" value="${user_name }">
								<input type="hidden" name="menuID" value="${menu.menu_id }">
								
								<p>单价：<span class="menu-price">¥ ${menu.menu_price }</span> 元</p>
								<p>描述：${menu.menu_content }</p>
								<p>口味：
								<input name="orders.order_notice" type="radio" value="不放辣">不放辣
								<input name="orders.order_notice" type="radio" value="微辣" checked>微辣 
								<input name="orders.order_notice" type="radio" value="中辣">中辣 
								<input name="orders.order_notice" type="radio" value="特辣">超辣 
								<p>数量： 
									<button class="btn-num-left" type="button" onclick="reduce()">-</button>
									<input id="num" class="order-num" name="orders.order_num" type="text" maxlength="9" value="1">
									<button class="btn-num-right" type="button" onclick="plus()">+</button>
								</p>
									
								<p>留言：									
									<textarea class="form-control" name="orders.other_notice" id="order_notic" cols="30"></textarea>
								</p>
								
								<button class="btn btn-danger" type="submit">提交订单</button>	
							</form>
	   	  				</div>					
	   	  		</div>
	   	  </div>
			
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>

<script src="../libs/js/jquery-3.1.1.min.js"></script>
<script>
	var num = document.getElementById("num")
	
	function reduce(){
		num.value = parseInt(num.value) - 1;
		if(num.value < 1){
			num.value = 1;
		}
	}
	
	function plus(){
		num.value = parseInt(num.value) + 1;
		if(num.value > 9){
			num.value = 1;
		}
	}
</script>
</body>
</html>
