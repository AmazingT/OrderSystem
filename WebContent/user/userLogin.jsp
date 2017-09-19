<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>登录-乐卖网</title>
	<link rel="stylesheet" type="text/css" href="../libs/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../libs/css/font-awesome.min.css">
	<link rel="shortcut icon" type="text/css" href="../image/favicon.ico" >
	<link rel="stylesheet" type="text/css" href="../css/userLogin.css">
	
</head>
<body>

	<div class="container">
		<jsp:include page="../commonfile/header.jsp"></jsp:include>
		
		<div class="login clearfix">
			<a href="${pageContext.request.contextPath }/index.jsp" class="img-box">
				<img src="../image/logo-login.jpg" alt="" width="480" height="370">
			</a>

			<div class="login-box">
				<div class="login-box-in">
					<div class="login-heder">
						<h3>登 录</h3>
					</div>
					
					<div class="login-content">					
						
						<form>
							<div class="form-group">
								<div class="input-group">
      								<div class="input-group-addon"><i class="icon-user"></i></div>
							  		<input class='form-control' type='text' name='user.user_name' placeholder='用户名'>
							  	</div>
							</div>
							<div class="form-group">
								<div class="input-group">
     								<div class="input-group-addon"><i class="icon-lock" style="font-size:16px;"></i></div>
							   		<input class='form-control' type='password' name='user.user_pass' placeholder='密码'>
							   	</div>
							</div>
							<div class="form-group">
								<input class='form-control code' type='text' name='user.user_code' placeholder='验证码'>							
								<img id="code" src='../order/user_Code' alt='验证码' width="100" height="30"/>
								<a href='javascript:reloadCode()'>换一张</a>
							</div>
							<div class='form-group'>
								<div class="checkbox">
									<label for="autologin">
										<input type="checkbox">记住密码
									</label>
									<a href='findPass.jsp' class="forget">忘记密码？</a>
								</div>	
							</div>
							<div class="form-group">
								<input type='button' value="登 录" class='btn btn-success' name="login">
							</div>
							<div class="form-group">
								<p>还没账号？<a href="userRegister.jsp">立即注册</a><a href="findUserName.jsp" style="float:right;">忘记用户名？</a></p>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="../commonfile/footer.jsp"/>
	</div>
	
	<script src="../libs/js/jquery-3.1.1.min.js"></script>
	<script src="../js/userCheck.js"></script>
</body>
</html>