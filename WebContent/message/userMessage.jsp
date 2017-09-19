<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>我的留言记录</title>
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/index.css" rel="stylesheet">
	
	<style>
		.comment{max-width:450px;margin:0 auto;}
		.myComment{margin:20px 0;border-bottom:1px solid #eee;padding-bottom:10px;}
		.myComment span,.myComment a{color:#93999f;font-size:12px;}
		.subject{margin-left:30px;}
		.good{float:right;margin-right:20px;}
		.good .glyphicon-thumbs-up{margin-right:5px;}
		.subject:hover{color:#f01400;text-decoration:none;}
		.good:hover{color:#4d555d;text-decoration:none;}
		.good em{font-style:normal;}
		.message{color:#f22e00;text-align: center;padding: 25px 0;font-size:18px;}
	</style>
</head>
<body>
<div class="navbox">
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
		<div>
			<a href="${pageContext.request.contextPath }/order/mg_messageList.action" class="btn btn-success">返回</a>
			<div class="message">
				<c:if test="${!empty message }">${message }</c:if>
			</div>
			
			<div class="comment">
				<c:if test="${empty message }">
					<c:forEach items="${oneselfList }" var="mg" begin="0" step="1">
						<div class="myComment">	      
					      	<p>${mg.content }</p>
					      	<span>时间：${mg.date }</span>
					      	<a href="#" class="subject">源自主题：${mg.subject }</a>
					      	<a href="javascript:;" class="good"><i class="glyphicon glyphicon-thumbs-up"></i><em>0</em></a>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>
<%session.removeAttribute("message"); %>
</body>
</html>