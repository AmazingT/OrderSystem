<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>配送信息填写</title>
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/index.css" rel="stylesheet">
	<link href="../libs/css/style.css" rel="stylesheet">
	<style>
		.info-content{width: 350px;margin:0 auto;}
		.info-content h4{margin: 25px 0;color:#f22e00;}
		.result{font-size: 16px;padding-left: 26px;padding-bottom: 10px;}
	</style>
</head>

<body>
<div class="navbox">
	<div class="container">
	<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
			<div class="info-content">
				<h4 class="title">请详细填写您的送餐信息！</h4>
				<form id="form" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-4 control-label">送餐地址：</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="userInfo.address">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label">配送时间：</label>
						<div class="col-sm-8">
							<input class="form-control" id="ECalendar_date" type="text" name="userInfo.send_date">
						</div>
					</div>		
					<div class="form-group">
						<label class="col-sm-4 control-label">移动电话：</label>
						<div class="col-sm-8">
							<input class="form-control" type="text" name="userInfo.mobile">
						</div>
					</div>							
					<div class="form-group">
						<label class="col-sm-4 control-label">支付方式：</label>
						<div class="col-sm-8">
							<select class="form-control" name="payWay">
								<option>支付宝</option>
								<option>微信</option>
								<option>QQ钱包</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-4 control-label">备注信息：</label>
						<div class="col-sm-8">
							<textarea class="form-control" name="userInfo.notice" cols="50" rows="3"></textarea>
						</div>
					</div>

					<input type="button" style="float:right;" class="btn btn-danger" value="确认并付款">
				</form>
			</div>
		<jsp:include page="../commonfile/footer.jsp"></jsp:include>
	</div>
</div>

<script src="../libs/js/jquery-3.1.1.min.js"></script>
<script src="../libs/js/Ecalendar.jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#ECalendar_date").ECalendar({
			 type:"date",   //模式，time: 带时间选择; date: 不带时间选择;
			 stamp : false,   //是否转成时间戳，默认true;
			 offset:[0,2],   //弹框手动偏移量;
			 format:"yyyy年mm月dd日",   //时间格式 默认 yyyy-mm-dd hh:ii;
			 skin:3,   //皮肤颜色，默认随机，可选值：0-8,或者直接标注颜色值;
			 step:10,   //选择时间分钟的精确度;
			 callback:function(v,e){} //回调函数
		});
		
		$(".btn").click(function(){
			var address = $("input[name='userInfo.address']");
			var date = $("input[type='hidden']");
			var mobile = $("input[name='userInfo.mobile']");
			var payWay = $("select[name='payWay']").find("option:selected"); 
			var notice = $("textarea[name='userInfo.notice']");
			
			if(address.val() == ""){
				$(".title").after("<div class='result'>地址不能为空！</div>");
				return;
			}else if(date.val() == ""){
				$(".result").remove();
				$(".title").after("<div class='result'>配送日期不能为空！</div>");
				return;
			}else if(mobile.val() == ""){
				$(".result").remove();
				$(".title").after("<div class='result'>手机号不能为空！</div>");
				return;
			}
			
			$.ajax({
				type:'POST',
				url:'../order/info_account.action',
				dataType:'json',
				data:$("#form").serialize(),
				beforeSend:function(){
					$(".btn").attr({"disabled":"disabled"}).val("提交中...");
					$("#form")[0].reset();
				},
				success:function(data){
					alert(data.message);
				},
				complete:function(){
					$(".btn").removeAttr("disabled").val("确认并付款");
				},
				error:function(e){
					alert(e.status);
				}
			});
		});
	})
</script>
				
</body>
</html>
