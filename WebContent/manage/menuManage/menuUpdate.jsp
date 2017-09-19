<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>更新菜单信息</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="../../css/updateUser.css" type="text/css">
</head>
<body>
<div class="container-fluid">
		<div class="back">
			<a href="menuManage.jsp" class="btn btn-primary"><i class="icon-arrow-left"></i>返回</a>
		</div>
		<div class="update-box">
			<div class="update-title">
				<h3>修改菜单信息</h3>
			</div>
			<form  action="${pageContext.request.contextPath}/order/menu_updateMenu.action" method="post">
				<input type="hidden" name="menu.menu_id" value="${menu.menu_id }">
				<div class="form-group">
					<label>菜单名：</label>
					<input class="form-control" type="text" name="menu.menu_name" value="${menu.menu_name}" placeholder="菜单名">				
				</div>	
				<div class="form-group">
					<label>单价（元）：</label>		
					<input class="form-control" type="text" name="menu.menu_price" value="${menu.menu_price}" placeholder="单价">	
				</div>
				<div class="form-group">
					<label>描述：</label>	
					<input class="form-control" type="text" name="menu.menu_content" value="${menu.menu_content}" placeholder="描述">
				</div>
				
				<button class="btn btn-primary" type="submit">提 交</button>
				<button class="btn btn-success pull-right" type="reset">重 置</button>					
			</form>
		</div>
	</div>
</body>
</html>