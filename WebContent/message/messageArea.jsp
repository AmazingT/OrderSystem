<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>用户留言区</title>
	
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/messageArea.css" rel="stylesheet">
	
	<style>
		.media-body h4{font-weight:600;padding-bottom:10px;}
		.media{max-width:800px;margin:50px auto;border-top:1px solid #eee;border-bottom:1px solid #eee;padding:20px 0;}
		.media-body span,.media-body a{color:#93999f;font-size:12px;position:relative;}
		.media-body .subject{margin-left:30px;}
		.media-body .good{float:right;margin-right:20px;}
		.media-body .good .glyphicon-thumbs-up{margin-right:5px;}
		.media-body .subject:hover{color:#f01400;text-decoration:none;}
		.media-body .good:hover{color:#4d555d;text-decoration:none;}
		.media-body .good em{font-style:normal;}
		.pageRow{text-align:center;}
		.msg-box{margin-top:25px;background-color: #f2f2f5;}
		.message-area .content{position:relative;border:1px solid #ccc;padding: 11px 10px 11px 16px;box-shadow: 0 3px 3px rgba(0,0,0,.05);background-color:#fff;border-radius:5px;}
		</style>
</head>
<body>
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
			 <div class="msg-box">
				 <button class="btn btn-success" data-toggle="modal" data-target="#myModal">我要吐槽</button>
				 <a class="btn btn-success" href="${pageContext.request.contextPath }/order/mg_queryMessage.action">我的评论记录</a>
				 <!-- 模态框 -->
				 <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
					  <div class="modal-dialog modal-sm" role="document">
						    <div class="modal-content">
							      <div class="modal-header">
							        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        	<h4 class="modal-title" id="myModalLabel">我要吐槽</h4>
							      </div>
							      <div class="modal-body">	      		
							        	<form action="${pageContext.request.contextPath}/order/mg_saveUserMessage.action" method="post">
											<div class="form-group">
												<label>主题：</label>
												<input class="form-control" name="message.subject" type="text">
											</div>
												<input class="form-control" name="message.username" type="hidden" value="${user_name }"/>
											<div class="form-group">
												<label>内容：</label>
												<textarea class="form-control" name="message.content" cols="50" rows="6"></textarea>
											</div>
											<div class="form-group">
												<input class="btn btn-danger form-control"  type="submit" value="提 交">
											</div>	
										</form>
							      </div>				   
						    </div>
					  </div>
					</div>
				 	
				 	<div class="message-area">
						<!-- 媒体对象 -->
						<c:forEach items="${mgList }" var="m" begin="0" step="1">
							<div class="media">
								  <div class="media-left">
									  <a href="#">
									      <img src="../image/${m.headImg }" class="img-circle" width="60" height="60" alt="..."/>
									  </a>
								  </div>
								  <div class="media-body">
								      <h4 class="media-heading">${m.username }</h4>			      
								      <p class="content">${m.content }</p>
								      <span>时间：${m.date }</span>
								      <a href="#" class="subject">源自主题：${m.subject }</a>
								      <a href="javascript:;" class="good"><i class="glyphicon glyphicon-thumbs-up"></i><em>0</em></a>
								  </div>
							</div>
						</c:forEach>
					</div>
					<!-- 分页区 -->
					<c:if test="${!empty mgList }">
						<div class="pageRow clearfix">
							<a href="${pageContext.request.contextPath}/order/mg_messageList.action?currentPage=1" class="btn btn-primary">首页</a>
							<a href="${pageContext.request.contextPath}/order/mg_messageList.action?currentPage=${page.currentPage-1}" class="btn btn-primary">上一页</a>
							
							<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pageCount">
								<c:if test="${page.currentPage == pageCount}">
									<a href="javascript:void(0)" class="btn active">${pageCount}</a>
								</c:if>
								<c:if test="${page.currentPage != pageCount}">
									<a href="${pageContext.request.contextPath}/order/mg_messageList.action?currentPage=${pageCount}" class="btn btn-default">${pageCount}</a>
								</c:if>
							</c:forEach>
							
							<a href="${pageContext.request.contextPath}/order/mg_messageList.action?currentPage=${page.currentPage+1>page.pageNum?page.pageNum:page.currentPage+1}" class="btn btn-primary">下一页</a>
							<a href="${pageContext.request.contextPath}/order/mg_messageList.action?currentPage=${page.endPage}" class="btn btn-primary">尾页</a>
						</div>
					</c:if>	
			</div>
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
	
	<script src="../libs/js/jquery-3.1.1.min.js"></script>
	<script src="../libs/js/bootstrap.min.js"></script>
	<script>
		var click = true;
		$(".good").on("click",function(){
			var count = $(".good").find("em");
			if(click){
				count.text(parseInt(count.text())+1);//不能用val(),表单使用
				click = false;//只能加一次
			}
		
			$.ajax({		
				type:"post",
				url:"../order/mg_messageList.action?good="+count.text().toString(),
				success:function(data){
					
				},
				error:function(){
					
				}
			});
		});
	</script>
</body>
</html>