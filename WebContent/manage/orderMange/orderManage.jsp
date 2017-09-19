<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>订单显示</title>
	<link rel="icon" href="image/favicon.ico" type="image/x-icon"/>	
	<link rel="stylesheet" href="../../libs/css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../libs/css/font-awesome.min.css" type="text/css"/>
	<link rel="stylesheet" href="../../css/userManage.css" type="text/css"/>
</head>
<body>
	<div class="header">
		<c:if test="${pay==0 }"><button class="btn btn-primary">已付款订单</button></c:if>
		<c:if test="${pay!=0 }">
			<a href="${pageContext.request.contextPath }/order/order_orderList.action?pay=0" class="btn btn-default">
				已付款订单
			</a>
		</c:if>

		<c:if test="${pay==1 }"><button class="btn btn-primary">未付款订单</button></c:if>
		<c:if test="${pay!=1 }">
			<a href="${pageContext.request.contextPath }/order/order_orderList.action?pay=1" class="btn btn-default">
				未付款订单
			</a>
		</c:if>
		<button style="margin-left: 45px;" type="button" class="btn btn-success" data-toggle="modal" data-target="#queryModal"><i class="icon-search"></i>查询用户订单信息</button>
	</div>
	
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
			          <div class="form-group">
			            <input  type="text" id="query" class="query form-control"/>
			          </div>						         																		
				</div>
				<div class="modal-footer">									
					<button onclick="searchUserOrder()" id="confirm" type="submit" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<form action="" name="orderform" method="post">
		<table class="table table-bordered table-responsive">
			<tr class="title">
			  <td>订单ID</td>
			  <td>用户ID</td>
			  <td>用户名</td>
			  <td>菜名</td>
			  <td>数量</td>
			  <td>单价（元）</td>
			  <td>总价（元）</td>
			  <td>电话</td>
			  <td>送餐时间</td>
			  <td>地址</td>
			  <td>
				  <c:if test="${pay==1 }">确认核查</c:if>
				  <c:if test="${pay==0 }">审核状态</c:if>
			  </td>
			 </tr>

			<c:forEach items="${orderList}" var="o" begin="0" step="1">
				<tr class="record">
					<td>${o.orderID }</td>
					<td>${o.userID }</td>
					<td>${o.username }</td>
					<td>${o.name }</td>
					<td>${o.count }</td>
					<td>${o.price }</td>
					<td>${o.total }</td>
					<td>${o.userTel }</td>
					<td>${o.sendTime }</td>	
					<td>${o.userAddress }</td>		
					<td>
						<input id="orderid" type="hidden" value="${o.orderID }"/>
						<c:if test="${pay==1 }">				
							<input type="submit" class="btn btn-primary" value="确认" onclick="confirmCheck()"/>			
						</c:if>
						<c:if test="${pay==0 }">已核查</c:if>
					</td>
				</tr>
			</c:forEach> 					
		</table>
		</form>
		
		<!-- 分页区 -->
		<div class="pageRow">
			<a href="${pageContext.request.contextPath}/order/order_orderList.action?currentPage=1" class="btn btn-primary">首页</a>
			<a href="${pageContext.request.contextPath}/order/order_orderList.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
			
			<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
				<c:if test="${page.currentPage == pageCount}">
					<a href="javascript:void(0)" class="btn active">${pageCount}</a>
				</c:if>
				<c:if test="${page.currentPage != pageCount}">
					<a href="${pageContext.request.contextPath}/order/order_orderList.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
				</c:if>
			</c:forEach>
			
			<a href="${pageContext.request.contextPath}/order/order_orderList.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
			<a href="${pageContext.request.contextPath}/order/order_orderList.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
		</div>
		<% session.removeAttribute("pay"); %>
		
	<script src="../../libs/js/jquery-3.1.1.min.js"></script>
	<script src="../../libs/js/bootstrap.min.js"></script>
	<script>
		function confirmCheck()
		{
			var id = document.getElementById("orderid").value;
			var forms = document.orderform;
			forms.action="../../order/order_confirmCheck.action?orderID="+id;
			forms.submit();
		}
		function searchUserOrder()
		{
			var name = document.getElementById("query").value;
			if(name == ""){
				return;
			}
			location.href = "../../order/order_searchOrdersByName.action?name="+name;
		}
	</script>
	
</body>
</html>
