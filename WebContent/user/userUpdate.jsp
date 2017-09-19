<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>找回密码-乐卖网</title>
	<link rel="stylesheet" type="text/css" href="../libs/css/bootstrap.min.css">
	<link rel="shortcut icon" type="text/css" href="../image/favicon.ico" >
	<link rel="stylesheet" type="text/css" href="../css/hfoot.css" >
	<link rel="stylesheet" type="text/css" href="../css/userUpdate.css">
	
</head>
<body>
	<div class="container">
		<jsp:include page="../commonfile/header.jsp"></jsp:include>
		
		<div class="update-pass">
			<div class="update-box">
				<div class="update-box-in">
					<div class="update-header">
						<h4>恭喜，您已通过验证</h4>
						<p>请重置您的密码并妥善保管</p>
					</div>
					
					<div class="update-content">					
						<form>
							<div class="form-group">						
	    						<label>新密码</label>
						  		<input class='form-control' type='password' name='user.user_pass'>
							</div>
							<div class="form-group">
	   							<label>确认密码</label>
						   		<input class='form-control' type='password' name='pass'>
							</div>
							<div class="form-group">
								<input type='button' class='btn btn-primary' style="width:100%;" value="确  定">
							</div>
						</form>	
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
	
<script src="../libs/js/jquery-3.1.1.min.js"></script>
<script>
	$(function(){
		$("input[type='button']").on("click",function(){
			var user_pass = $("input[name='user.user_pass']").val();
			var pass  = $("input[name='pass']").val();
		
			if(user_pass == ""){
				$(".result").remove();
				$(".update-content").prepend("<div class='result'>请输入新密码！</div>");
				return;
			}else if(pass == ""){
				$(".result").remove();
				$(".update-content").prepend("<div class='result'>请再次输入密码！</div>");
				return;
			}else if(user_pass != pass){
				$(".result").remove();
				$(".update-content").prepend("<div class='result'>两次密码输入不一致！</div>");
				return;
			}
		
			$.ajax({
				type:'POST',
				url:'../order/user_updateUserPass.action',
				dataType:'json',
				data:{
					"user.user_pass":user_pass
				},
				beforeSend:function(){
					$("input[type='button']").attr({"disabled":"disabled"}).val("提交中...");
				},
				success:function(data){

					if(data.status == "true"){
						$(".result").remove();
						$(".update-content").prepend("<div class='result-true'>"+data.message+"，返回<a href='userLogin.jsp'>登录</a></div>");
					}
					if(data.status == "false"){
						$(".result").remove();
						$(".update-content").prepend("<div class='result'>"+data.message+"</div>");
					}
				},
				complete:function(){
					$("input[type='button']").removeAttr("disabled").val("确定");
				},
				error:function(error){
					alert(error.status);
				}
			});
		});
		
	});
</script>
</body>
</html>