<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户信息</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon">	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="../../css/userManage.css" type="text/css">
</head>
<body>

<div class="container-fluid">
	<div class="header">
		<a href="addUser.jsp" class="btn btn-primary"><i class="icon-plus"></i>添加</a>
		<button class="btn btn-danger" id="delete"><i class="icon-remove"></i>删除</button>
		<button type="button" class="btn btn-success" data-toggle="modal" data-target="#queryModal"><i class="icon-search"></i>查询</button>
	</div>
	<div class="query-result"></div>
	<!-- 模态框 -->
	<div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">请输入查询的用户名：</h4>
				</div>
				<div class="modal-body">
					<form>
			          <div class="form-group">
			            <input  type="text" id="query" class="query form-control">
			          </div>							         
			        </form>																					
				</div>
				<div class="modal-footer">									
					<button id="confirm" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="table-responsive">
		<table class="table table-bordered table-responsive">
			<tr class="title">
				<td><input type="checkbox" name="allSelect"></td>
				<td>用户ID</td>
				<td>用户名</td>
				<td>姓名</td>
				<td>性别</td>
				<td>邮箱</td>
				<td>邮箱激活状态</td>
				<td>身份</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${userList}" var="m" begin="0" step="1">
				<tr class="record">
					<td><input type="checkbox" name="check" value="${m.user_id}"></td>
					<td>${m.user_id }</td>
					<td>${m.user_name }</td>
					<td>${m.user_realname }</td>
					<td>${m.user_sex }</td>
					<td>${m.user_mail }</td>
					
					<c:if test="${m.status=='0' }"><td style="color:#d9534f;">未激活</td></c:if>
					<c:if test="${m.status=='1' }"><td>已激活</td></c:if>
					
					<td>
						<c:if test="${m.user_flag=='0' }">普通用户</c:if>
						<c:if test="${m.user_flag=='1' }">VIP会员</c:if>
					</td>
					<td>
						<a href="${pageContext.request.contextPath }/order/user_deleteUser.action?id=${m.user_id}">删除</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath }/order/user_updateUI.action?id=${m.user_id}">修改</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 分页区 -->
		<div class="pageRow">
			<a href="${pageContext.request.contextPath}/order/user_userList.action?currentPage=1" class="btn btn-primary">首页</a>
			<a href="${pageContext.request.contextPath}/order/user_userList.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
			
			<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
				<c:if test="${page.currentPage == pageCount}">
					<a href="javascript:void(0)" class="btn active">${pageCount}</a>
				</c:if>
				<c:if test="${page.currentPage != pageCount}">
					<a href="${pageContext.request.contextPath}/order/user_userList.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
				</c:if>
			</c:forEach>
			
			<a href="${pageContext.request.contextPath}/order/user_userList.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
			<a href="${pageContext.request.contextPath}/order/user_userList.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
		</div>
	</div>
</div>

<script src="../../libs/js/jquery-3.1.1.min.js"></script>
<script src="../../libs/js/bootstrap.min.js"></script>
<script src="../../js/userManage.js"></script>
</body>
</html>