<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>找回密码-乐卖网</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="../libs/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../libs/css/font-awesome.min.css">
		<link rel="shortcut icon" type="text/css" href="../image/favicon.ico" >
		<link rel="stylesheet" type="text/css" href="../css/findPass.css"  >
		<link rel="stylesheet" type="text/css" href="../css/hfoot.css">
  </head>
  
  <body>
	<% request.setCharacterEncoding("utf-8"); %>
	<div class="container">
		<jsp:include page="../commonfile/header.jsp"></jsp:include>
	
		<div class="find-pass">
			<div class="find-box">
				<div class="find-box-in">
					<div class="find-heder">
						<h3>找回用户名</h3>
					</div>
					
					<div class="find-content">					
						<form>
							<div class="form-group">		    					
							  	<input class='form-control' type='text' name='mail' placeholder='请填写注册的邮箱'>
							</div>
							<div class="form-group">
								<input class='form-control code' type='text' name='code' placeholder='验证码'>							
								<img id="code" src='${pageContext.request.contextPath }/order/user_Code' alt='验证码' width="100" height="30"/>
								<a href='javascript:reloadCode()'>换一张</a>
							</div>
							<div class="form-group">
								<input type='button' class='btn btn-primary' style="width:100%;" value="确定">
							</div>
							<div class="form-group">
								<p><a href="userLogin.jsp">已找回？返回登录</a></p>
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
		function reloadCode(){
			document.getElementById("code").src = "../order/user_Code?q="+Math.random();
		}
	
	
		$("input[type='button']").on("click",function(){
			var mail = $("input[name='mail']").val();
			var validateCode = $("input[name='code']").val();
			var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
			var test = reg.test(mail);
			
			if(mail == ""){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>请输入邮箱！</div>");
				return;
			}
			if(validateCode == ""){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>请输入验证码！</div>");
				return;
			}else if(!test){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>邮箱格式不正确！</div>");
				return;
			}
			
			$.ajax({
				type:"post",
				url:"../order/user_findUserName.action",
				data:{
					'mail':mail,
					'validateCode':validateCode
				},
				beforeSend:function(){
					$("input[type='button']").attr({"disabled":"disabled"}).val("提交中...");
				},
				success:function(data){
					if(data.status == "success"){
						$(".result").remove();
						$(".find-content").prepend("<div class='success'>"+data.message+"</div>");
					}
					if(data.status == "fail"){
						$(".result").remove();
						$(".find-content").prepend("<div class='result'>"+data.message+"</div>");
					}
				},
				complete:function(){
					$("input[type='button']").removeAttr("disabled").val("确定");
				},
				error:function(e){
					alert(e.status);
				}
			});	
		});	
	</script>
  </body>
</html>
