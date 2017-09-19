<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>注册-乐卖网</title>
	<link rel="stylesheet" type="text/css" href="../libs/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../libs/css/font-awesome.min.css">
	<link rel="shortcut icon" type="text/css" href="../image/favicon.ico" >
	<link rel="stylesheet" type="text/css" href="../css/userRegister.css" >

</head>
<body>
	<div class="container">
		<header class="header clearfix">
			<a href="" class="lemai">乐外卖</a>
			<span class="header-title">足不出户 尽享美味</span>
			<p class="header-login">已有账号?返回<a href="userLogin.jsp">登录</a></p>
		</header>

		<div class="register">
			<div class="register-box">
				<div class="register-box-in">
					<div class="register-heder">
						<h3>用户注册</h3>
					</div>
					
					<div class="register-content">					
						<!-- <div class="login-result">用户名错误!</div> --><!-- 登录结果提示区 -->
						<form id="registerForm">
							<div class="form-group">						
							  	<input class='form-control' type='text' name='user.user_name' placeholder='用户名'>
							</div>
							<div class="form-group">							
							   	<input class='form-control' type='password' name='user.user_pass' placeholder='密码'>
							</div>
							<div class="form-group">
							   	<input class='form-control' type='password' name='pass' placeholder='确认密码'>
							</div>
							<div class="form-group">							
							  	<input class='form-control' type='text' name='user.user_mail' placeholder='邮箱'>
							</div>
							<div class="radio">
								<span>性别：</span>
								<label>
									<input name="user.user_sex" type="radio" value="男" checked>男
								</label>
								<label>
									<input name="user.user_sex" type="radio" value="女">女
								</label>
							</div>
							<div class="form-group">
								<input type='button' class='btn btn-primary' name="register" value="免费注册">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="../commonfile/footer.jsp"/>
	</div>
	<script src="../libs/js/jquery-3.1.1.min.js"></script>
	<script>
	//注册ajax
	$("input[name='register']").on("click",function(){
		var user = $("input[name='user.user_name']").val();
		var pwd  = $("input[name='user.user_pass']").val();
		var mail  = $("input[name='user.user_mail']").val();
		var pass = $("input[name='pass']").val();
		var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
		var test = reg.test(mail);
		
		if(user == ""){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>请输入用户名！</div>");
			return;
		}else if(user.length>10 || user.length<4){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>用户名长度应在4到10个字符之间！</div>");
			return;
		}else if(pwd == ""){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>请输入密码！</div>");
			return;
		}else if(pwd.length>6 & pwd.length<12){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>密码长度必须在6到12个字符之间！</div>");
			return;
		}else if(pass == ""){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>请再次输入密码！</div>");
			return;
		}else if(pwd != pass){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>两次密码不一致！</div>");
			return;
		}else if(mail == ""){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>请输入邮箱！</div>");
			return;
		}else if(!test){
			$(".result").remove();
			$(".register-content").prepend("<div class='result'>邮箱格式错误！</div>");
			return;
		}
		
		//发送注册请求
		$.ajax({
			type:'POST',
			url:'../order/user_userRegister.action',
			dataType:'json',
			data:$("#registerForm").serialize(),
			beforeSend:function(){
				$("input[name='register']").attr({"disabled":"disabled"}).val("提交中...");
			},
			success:function(data){
			
				if(data.status == "true"){
					$(".result").remove();
					$(".register-content").prepend("<div class='result success'>"+data.message+"</div>");
					$("#registerForm")[0].reset();
				}
				if(data.status == "false"){
					$(".result").remove();
					$(".register-content").prepend("<div class='result'>"+data.message+"</div>");
				}
			},
			complete:function(){
				$("input[name='register']").removeAttr("disabled").val("同意用户协议并注册");
			},
			error:function(error){
				alert(error.status);
			}	
		});
	});
	</script>
</body>
</html>