<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>添加菜单</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css">
	
	<style>
		.back i{margin-right: 10px;}
		.addUser-box{width:300px;margin:0 auto;}
		.addUser-box .add-title{text-align:center;color:#0377c5;font-family: "华文行楷";}
		.radio .radio-tip{padding-left:0;}
		.addUser-box .btn{width:45%;}
		.result{color: #c00;font-size: 14px;margin:15px 0;padding: 0 10px;line-height: 35px;height: 35px;background-color: #fff2f2;border: 1px solid #ff8080;border-radius: 4px;}
	</style>
</head>
<body>
	<div class="container-fluid">
		<div class="back">
			<a href="menuManage.jsp" class="btn btn-primary"><i class="icon-arrow-left"></i>返回</a>
		</div>
		<div class="addUser-box">
			<div class="add-title"><h3>添加菜单信息</h3></div>
			<form action="${pageContext.request.contextPath }/order/menu_addMenu.action" method="post">
				<div class="form-group">
					菜名：<input class="form-control" name="menu.menu_name" type="text">
				</div>
				<div class="form-group">
					单价：<input class="form-control" name="menu.menu_price" type="text">
				</div>
				<div class="form-group">
					 描述：<textarea class="form-control" name="menu.menu_content" cols="40" rows="4" ></textarea>
				</div>
		
				<button type="button" class="btn btn-primary">提 交</button>
				<button type="reset" class="btn btn-info pull-right">重 置</button>						
			</form>
		</div>
	</div>
	
	<script src="../../libs/js/jquery-3.1.1.min.js"></script>
	<script>
		$(function(){
			$("button[type='button']").on("click",function(){
				var form = $("form");
				var name = $("input[name='menu.menu_name']").val();
				var price = $("input[name='menu.menu_price']").val();
				var content = $("textarea").val();
				
				if(name == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入菜名！</div>");
					return;
				}else if(price == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入价格！</div>");
					return;
				}else if(content == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入描述内容！</div>");
					return;
				}
				form.submit();
			});	
		});
	</script>
</body>
</html>