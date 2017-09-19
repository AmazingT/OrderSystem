<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>管理员登录-乐卖网</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="../libs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../libs/css/font-awesome.min.css">
		<link rel="shortcut icon" type="text/css" href="../image/favicon.ico" >
		<link rel="stylesheet" type="text/css" href="../css/adminLogin.css"  >	
  </head>
  
  <body>
	<% request.setCharacterEncoding("utf-8"); %>
	<div class="main">
		<div class="container">
			<div class="admin-pass">
				<div class="admin-box">
					<div class="admin-box-in">
						<div class="admin-header">
							<h3>后台登录系统</h3>
						</div>
						
						<div class="admin-content">					
							<form>
								<div class="form-group">
									<div class="input-group">
			    						<div class="input-group-addon"><i class="icon-user" style="font-size:18px;"></i></div>
								  		<input class='form-control' type='text' name="admin.username" placeholder='用户名'/>
								  	</div>
								</div>
								<div class="form-group">
									<div class="input-group">
			   							<div class="input-group-addon"><i class="icon-envelope"></i></div>
								   		<input class='form-control' type='password' name="admin.password" placeholder='密码'/>
								   	</div>
								</div>
								<div class="form-group">
									<button type='button' class='btn btn-primary form-control' name="adminLogin">登 录</button>
								</div>
							</form>
								
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../libs/js/jquery-3.1.1.min.js"></script>
	<script>
		//登录，注册ajax请求
		$("button[name='adminLogin']").on("click",function(){
	
			var admin = $("input[name='admin.username']").val();
			var pass  = $("input[name='admin.password']").val();
		
			if(admin == ""){
				$(".result").remove();
				$(".admin-content").prepend("<div class='result'>用户名不能为空！</div>");
				return;
			}else if(pass == ""){
				$(".result").remove();
				$(".admin-content").prepend("<div class='result'>密码不能为空！</div>");
				return;
			}
			//发送登陆请求
			$.ajax({
				type:'POST',
				url:'../order/admin_adminLogin.action',
				dataType:'json',
				data:{
					"admin.username":admin,
					"admin.password":pass
				},
				success:function(data){
	
					if(data.status == "true"){
						location.href = "manage.jsp";
					}
					if(data.status == "false"){
						$(".result").remove();
						$(".admin-content").prepend("<div class='result'>"+data.message+"</div>");
					}
				},
				error:function(error){
					alert(error.status);
				}
			});
		});
	</script>
  </body>
</html>
