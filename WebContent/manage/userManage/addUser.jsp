<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加用户</title>
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
			<a href="userManage.jsp" class="btn btn-primary"><i class="icon-arrow-left"></i>返回</a>
		</div>
		<div class="addUser-box">
			<div class="add-title"><h3>添加用户信息</h3></div>
			<form action="${pageContext.request.contextPath}/order/user_addUser.action" method="post">
				<div class="form-group">
					用户名：<input class="form-control" name="user.user_name" type="text">
				</div>
				<div class="form-group">
					密码：<input class="form-control" name="user.user_pass" type="password">
				</div>
				<div class="form-group">
					 确认密码：<input class="form-control" name="changePass" type="password">
				</div>
				<div class="form-group">
					姓名：<input class="form-control"  name="user.user_realname" type="text">
				</div>
				<div class="form-group">
					邮箱：<input class="form-control" name="user.user_mail" type="text">
				</div>
				
				<div class="radio">
					<label class="radio-tip">性别：</label>
					<label>
						<input name="user.user_sex" type="radio" checked="checked" value="男">男 
					</label>
				  	<label>
				  		<input name="user.user_sex" type="radio" value="女">女
				  	</label>
			   	</div>		
			   			
				<div class="radio">
					<label class="radio-tip">身份：</label>
					<label>
						<input name="user.user_flag" type="radio" checked="checked" value="0">普通用户
					</label>
					<label>
						<input name="user.user_flag" type="radio" value="1">VIP会员		
					</label>
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
				var user = $("input[name='user.user_name']").val();
				var pass = $("input[name='user.user_pass']").val();
				var changePass = $("input[name='changePass']").val();
				var name = $("input[name='user.user_realname']").val();
				var mail = $("input[name='user.user_mail']").val();
				var str = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
				
				if(user == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入用户名！</div>");
					return;
				}else if(pass == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入密码！</div>");
					return;
				}else if(pass != changePass){
					$(".result").remove();
					$(".add-title").after("<div class='result'>两次密码不一致！</div>");
					return;
				}else if(name == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入姓名！</div>");
					return;
				}else if(mail == ""){
					$(".result").remove();
					$(".add-title").after("<div class='result'>请输入邮箱！</div>");
					return;
				}else if(!mail.match(str)){
					$(".result").remove();
					$(".add-title").after("<div class='result'>邮箱格式不正确！</div>");
					return;
				}
				
				form.submit();
			});	
		});
	</script>
</body>
</html>