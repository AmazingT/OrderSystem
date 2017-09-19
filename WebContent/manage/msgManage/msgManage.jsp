<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>评论管理</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon"/>	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../css/userManage.css" type="text/css"/>

</head>
<body>
	<div class="container-fluid">
		<form action="${pageContext.request.contextPath }/order/mg_deleteMessage.action" id="myForm" method="post">
			<div class="header">
				<button type="button" class="btn btn-danger" id="delete"><i class="icon-remove"></i>删除已选项</button>
			</div>

			<%int i=1;%>		
			<table class="table table-bordered table-responsive">
				<tr class="title">
					<td><input type="checkbox" name="checkAll" value="${msg.messageID }" ></td>
					<td>序号</td>
					<td>用户名</td>
					<td>标题</td>
					<td>内容</td>				
					<td>评论时间</td>
				</tr>
				<c:forEach items="${msgList}" var="msg" begin="0" step="1">
					<tr class="record">
						<td><input type="checkbox" name="messages" value="${msg.messageID }" ></td>
						<td><%=i++%></td>
						<td>${msg.username }</td> 
						<td>${msg.subject }</td>
						<td>${msg.content }</td>
						<td>${msg.date }</td>
					</tr>	
				</c:forEach>
			</table>
		</form>
	</div>
	
	<!-- 分页区 -->
	<div class="pageRow">
		<a href="${pageContext.request.contextPath}/order/mg_msgList.action?currentPage=1" class="btn btn-primary">首页</a>
		<a href="${pageContext.request.contextPath}/order/mg_msgList.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
		
		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
			<c:if test="${page.currentPage == pageCount}">
				<a href="javascript:void(0)" class="btn active">${pageCount}</a>
			</c:if>
			<c:if test="${page.currentPage != pageCount}">
				<a href="${pageContext.request.contextPath}/order/mg_msgList.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
			</c:if>
		</c:forEach>
		
		<a href="${pageContext.request.contextPath}/order/mg_msgList.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
		<a href="${pageContext.request.contextPath}/order/mg_msgList.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
	</div>
	
	<script src="../../libs/js/jquery-3.1.1.min.js"></script>
	<script src="../../libs/js/bootstrap.min.js"></script>
	<script>
		function searchUserMsg()
		{
			var name = document.getElementById("query").value;
			if(name == ""){
				return;
			}
			location.href = "../../order/mg_searchUserMsg.action?username="+name;
		}
		
		var all = $("input[name='checkAll']");
		var check = $("input[name='messages']");

		all.on("change",function(){
			var $this = $(this);
			if($this.is(":checked")){
				check.attr("checked",true);			
			}else{
				check.attr("checked",false);
			}
		});
		
		$("#delete").on("click",function(){
			var str=new Array();
			for(var i=0;i<check.length;i++){
				if(check[i].checked){
					str.push(check[i].value);//这里的value值就是所勾选记录的id
				}
			}
			if(str==""){
				alert("请选择删除的行!");
				return;
			}else{
				$("#myForm").submit();
			}
		});
	</script>
</body>
</html>