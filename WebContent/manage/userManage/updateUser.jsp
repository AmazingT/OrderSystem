<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>更新用户信息</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="../../css/updateUser.css" type="text/css">
</head>
<body>
	<div class="container-fluid">
		<div class="back">
			<a href="userManage.jsp" class="btn btn-primary"><i class="icon-arrow-left"></i>返回</a>
		</div>
		<div class="update-box">
			<div class="update-title">
				<h3>修改用户信息</h3>
			</div>
			<form  action="${pageContext.request.contextPath}/order/user_updateUser.action" method="post">
				<input type="hidden" name="user.user_id" value="${u.user_id}">
				<div class="form-group">
					<label>用户名：</label>
					<input class="form-control" type="text" name="user.user_name" value="${u.user_name}" placeholder="用户名">				
				</div>	
				<div class="form-group">
					<label>密码：</label>		
					<input class="form-control" type="password" name="user.user_pass" value="${u.user_pass}" placeholder="密码">	
				</div>
				<div class="form-group">
					<label>姓名：</label>	
					<input class="form-control" type="text" name="user.user_realname" value="${u.user_realname}" placeholder="姓名">
				</div>
				<div class="form-group">
					<label>邮箱：</label>					
					<input class="form-control" type="text" name="user.user_mail" value="${u.user_mail}" placeholder="邮箱">	
				</div>
				<div class="radio">
					<label class="radio-tip">性别：</label>
					<c:if test="${u.user_sex=='女'}">					
						<label class="radio-inline">					
							<input name="user.user_sex" type="radio"  value="男">男
						</label>
						<label class="radio-inline">
							<input name="user.user_sex" type="radio"  checked="checked" value="女">女
						</label>				
					</c:if>
					
					<c:if test="${u.user_sex=='男'}">
						<label class="radio-inline">										
							<input name="user.user_sex" type="radio"  checked="checked" value="男">男
						</label>
						<label class="radio-inline">	
							<input name="user.user_sex" type="radio"  value="女">女			
						</label>							
					</c:if>
				</div>
				
				<div class="radio">
					<label class="radio-tip">身份：</label>
					<c:if test="${u.user_flag=='0'}">
						<label class="radio-inline">	
							<input name="user.user_flag" type="radio" checked="checked" value="0">普通用户
						</label>
						<label class="radio-inline">	
							<input name="user.user_flag" type="radio" value="1">VIP会员
						</label>
					</c:if>
					
					<c:if test="${u.user_flag=='1'}">	
						<label class="radio-inline">											
							<input name="user.user_flag" type="radio" checked="checked" value="1">VIP会员	
						</label>
						<label class="radio-inline">	
							<input name="user.user_flag" type="radio"  value="0">普通用户	
						</label>		
					</c:if>	
				</div>
	
				<button class="btn btn-primary" type="submit">提 交</button>
				<button class="btn btn-success pull-right" type="reset">重 置</button>					
			</form>
		</div>
	</div>
</body>
</html>