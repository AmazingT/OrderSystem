<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>菜单显示</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon"/>	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../css/userManage.css" type="text/css"/>
</head>
<body>

<div class="container-fluid">
	<div class="header">
		<a href="addMenu.jsp" class="btn btn-primary"><i class="icon-plus"></i>添加</a>
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
					<h4 class="modal-title" id="myModalLabel">请输入查询的菜单：</h4>
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
				<td>菜单ID</td>
				<td>菜名</td>
				<td>单价（元）</td>
				<td>描述</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${menuList}" var="m" begin="0" step="1">
				<tr class="record">
					<td><input type="checkbox" name="check" value="${m.menu_id}"></td>
					<td>${m.menu_id }</td>
					<td>${m.menu_name }</td>
					<td>${m.menu_price }</td>		
					<td>${m.menu_content }</td>
					
					<td>
						<a href="${pageContext.request.contextPath }/order/menu_deleteMenuById.action?id=${m.menu_id}">删除</a>
						<span>|</span>
						<a href="${pageContext.request.contextPath }/order/menu_searchMenuById.action?id=${m.menu_id}">修改</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 分页区 -->
		<div class="pageRow">
			<a href="${pageContext.request.contextPath}/order/menu_menuList.action?currentPage=1" class="btn btn-primary">首页</a>
			<a href="${pageContext.request.contextPath}/order/menu_menuList.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
			
			<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
				<c:if test="${page.currentPage == pageCount}">
					<a href="javascript:void(0)" class="btn active">${pageCount}</a>
				</c:if>
				<c:if test="${page.currentPage != pageCount}">
					<a href="${pageContext.request.contextPath}/order/menu_menuList.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
				</c:if>
			</c:forEach>
			
			<a href="${pageContext.request.contextPath}/order/menu_menuList.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
			<a href="${pageContext.request.contextPath}/order/menu_menuList.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
		</div>
	</div>
</div>

<script src="../../libs/js/jquery-3.1.1.min.js"></script>
<script src="../../libs/js/bootstrap.min.js"></script>
<script src="../../js/menuManage.js"></script>
</body>
</html>