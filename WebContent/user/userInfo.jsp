<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>个人信息</title>
	
	<link href="../image/favicon.ico" rel="shortcut icon">
	<link href="../libs/css/bootstrap.min.css" rel="stylesheet">
	<link href="../libs/css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/index.css" rel="stylesheet">
	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/userInfo.css" rel="stylesheet">
	<link href="../css/findPass.css" rel="stylesheet">
	<link href="../css/Cart.css" rel="stylesheet">

</head>
<body>
<div class="navbox">
	<div class="container">
		<jsp:include page="../commonfile/mainHeader.jsp"></jsp:include>
		<div>
			<ol class="breadcrumb">
				  <li><a href="../index.jsp">首页</a></li>
				  <li class="active">个人中心</li>
			</ol>
		</div>
		
		<div class="info-box">
			<div class="col-md-2">
			
				<ul id="nav" class="nav nav-pills nav-stacked">
					<li class="active"><a href="#myInfo" data-toggle="tab">我的信息</a></li>
					<li><a href="#myMenu" data-toggle="tab">我的订单</a></li>
					<li><a href="#security" data-toggle="tab">账号安全</a></li>
					<li><a href="#about" data-toggle="tab">关于我们</a></li>
					<li><a href="#question" data-toggle="tab">常见问题</a></li>
					<li><a href="#link" data-toggle="tab">友情链接</a></li>
				</ul>
			</div>
			<div class="tab-content col-md-10">
				<!-- fade淡入淡出效果,in默认显示 -->
				<div class="tab-pane active fade in" id="myInfo">
					<div class="update-box">
						<div class="update-title">您的信息如下，点击可以编辑</div>
						<div class="content_top">
							<label for="file">头像 :</label>
							<div>
								<div>
									<img id="img" src="../image/${user_head}" class="img-circle" alt="" width=80 height=80>
								</div>
								
								<div>	
									<form action="${pageContext.request.contextPath }/order/upload_fileUpload.action" method="post" enctype="multipart/form-data">						
										<input type="file" name="upload" id="upload" style="display:none;"/>					
										<button type="button" id="select" class="btn btn-primary">选择头像</button>		
										<button class="btn btn-danger" type="submit">上传头像</button>	
									</form>				
								</div>
							</div>
						</div>
						<form id="myform">
							<input type="hidden" name="user.user_id" value="${user_id}">
							<div class="form-group">
								<label>用户名：</label>
								<input class="form-control" type="text" name="user.user_name" value="${user_name}" placeholder="用户名">				
							</div>									
							<div class="form-group">
								<label>姓名：</label>	
								<input class="form-control" type="text" name="user.user_realname" value="${user_realname}" placeholder="姓名">
							</div>
							<div class="form-group">
								<label>邮箱：</label>					
								<input class="form-control" type="text" name="user.user_mail" value="${user_mail}" placeholder="邮箱">	
							</div>
							<div class="radio">
								<label class="radio-tip">性别：</label>
								<c:if test="${user_sex=='女'}">					
									<span>女</span>		
								</c:if>
								
								<c:if test="${user_sex=='男'}">
									<span>男</span>						
								</c:if>
							</div>
							
							<div class="radio">
								<label class="radio-tip">身份：</label>
								<c:if test="${user_flag=='0'}">
									<span>普通用户</span>
								</c:if>
								
								<c:if test="${user_flag=='1'}">																				
									<span>VIP会员</span>											
								</c:if>	
							</div>
							
							<input class="btn btn-primary form-control" type="submit" id="submit" value="提  交">										
						</form>
					</div>
				</div>
				<div class="tab-pane fade" id="myMenu">						
					
						<% int i=1;%>
						<h4 class="result" style="text-align:center;">${message }</h4>
						<c:if test="${!empty list }">
							<table class="table table-bordered table-responsive">
								<tr class="title">
									<td>编号</td>
									<td>菜名</td>
									<td>数量</td>
									<td>单价（元）</td>
									<td>总价（元）</td>
									<td>订单时间</td>
									<td>状态</td>
								</tr>
								<c:forEach items="${list}" var="list" begin="0" step="1">
									<tr class="record">
										<td><%=i++ %></td>
										<td>${list.name }</td>
										<td>${list.count }</td>
										<td>${list.price }</td>
										<td>${list.total }</td>
										<td>${list.sendTime }</td>
										
										<c:if test="${list.state=='0' }"><td>已付款</td></c:if>
										<c:if test="${list.state=='1' }"><td style="color:#f60;">未付款</td></c:if>
										
									</tr>	
								</c:forEach>
							</table>
						</c:if>
						<%session.removeAttribute("list"); %>
				</div>
				<div class="tab-pane fade" id="security">	
					<div class="find-pass">
						<div class="find-box">
							<div class="find-box-in">
								<div class="find-heder">
									<h3>修改密码</h3>
								</div>
								
								<div class="find-content">									
									<form id="passForm">
										<input type="hidden" name="user.user_name" value="${user_name}">
										<div class="form-group">
											<div class="input-group">
					    						<div class="input-group-addon"><i class="icon-lock" style="font-size:18px;"></i></div>
										  		<input class='form-control' id="pass" type='password' name='user.user_pass' placeholder='密码'>
										  	</div>
										</div>
										<div class="form-group">
											<div class="input-group">
					   							<div class="input-group-addon"><i class="icon-lock" style="font-size:18px;"></i></div>
										   		<input class='form-control' id="chpass" type='password' placeholder='确认密码'>
										   	</div>
										</div>
										<div class="form-group">
											<input type='button' class='btn btn-primary' style="width:100%;" id="btn" value="提 交"/>
										</div>
									</form>
										
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="about">
					<h3>关于乐卖</h3>
					<p>
					“乐卖”是中国专业的餐饮O2O平台，由xxx有限公司开发运营。公司创立于2009年4月，起源于太原理工大学明向校区。截至2014年10月，公司业务覆盖全国近200个城市，加盟餐厅数共计18万家，日均订单超过100万单，团队规模超过2000人。 作为中国餐饮业数字化领跑者，“乐卖”秉承激情、极致、创新之信仰，以建立全面完善的数字化餐饮生态系统为使命，为用户提供便捷服务极致体验，为餐厅提供一体化运营解决方案，推进整个餐饮行业的数字化发展进程。
					</p>
					<h3>发展历史</h3>
					<p>
					2016年1月27日，乐卖获得中信产业基金、腾讯、京东、红杉资本、大众点评3.5亿美元E轮投资。<br/>
					2016年8月28日，乐卖宣布完成6.3亿美元F轮融资。本轮融资由中信产业基金、华联股份领投，华人文化产业基金、歌斐资产等新投资方以及腾讯、京东、红杉资本等原投资方跟投。<br/> 
					2016年11月24日，乐卖获滴滴出行入战略投资。<br/>
					2016年12月17日，乐卖获得阿里巴巴12.5亿美元投资。<br/>
					2017年3月1日，乐卖公布“食安服务”APP上线。乐卖可在App上将涉嫌食安违规的餐厅同步至监管部门，目前监管范围覆盖上海全部餐厅。<br/>
					2017年3月8日，乐卖宣布一周内查出并下线违规餐厅5257家  ，四川省内下线违规商家258家。<br/>
					</p>
				</div>
				<div class="tab-pane fade" id="question">
					<h4>支付问题：</h4>
					<p>
					1. 使用余额支付不了？ 先确认下您的乐卖账户是否有绑定手机号，使用余额支付必须先绑定手机号。<br/>
					2. 在线支付订单取消后，钱怎么返还？ 使用乐卖账户余额支付（包括：余额、余额+红包），订单无效后，所有款项（包括红包）将退到您的乐卖账户；使用第三方支付（包括：第三方支付、第三方支付+红包），订单无效后，支付款项将于2个工作日内返还到您的第三方支付账户，红包退还到乐卖账户。<br/>						
					3. 在线支付的过程中，订单显示未支付成功，款项却被扣了，怎么办？ 该问题属于第三方（银行/支付宝/微信等）数据传输延迟问题。您可以再等待一下， 如果超过15分钟，订单还是未支付状态，第三方会把款项返还到您的付款账户。具体到账时间依银行而定，一般会在2个工作日内。	<br/>				
					4. 乐卖账户里的款项怎么提现？ 在个人中心 > 我的余额 > 提现处进行提现操作。操作日起2个工作日内，款项会返还至您最近消费过的账户中。
					</p>
					<h4>配送问题：</h4>
					<p>
					1. 下单后，餐厅长时间未确认订单，怎么办？ 这个情况可能由于餐厅出现网络信号问题无法及时查看到您的订单，您可以在订单上查找到餐厅电话，致电餐厅进行确认订单。如果联系不上餐厅可以致电客服。<br/>
					2. 餐厅确认订单了，我要催单，怎么办？ 如果餐厅页面支持留言，您可以直接给餐厅留言催单。如果餐厅页面不支持留言，您可以到饿单中心，查找到餐厅电话，直接致电餐厅进行催单。如果联系不上餐厅可以致电客服。<br/>
					3. 乐卖提供自配送服务 - 在【蜂鸟专送】的所有餐厅都是乐卖提供配送服务，只要您下单成功，我们会分配专属骑手为您取餐、送餐，我们也会短信通知您骑手的电话，方便您随时联系。 - 【蜂鸟专送】需要支付配送费的呦，您也可以购买我们的会员卡，享受免配送和订单优惠的活动<br/>
					</p>
				</div>
				<div class="tab-pane fade" id="link">
					<p><a href="https://www.ele.me/home">[1] 饿了吗</a></p>
					<p><a href="http://ty.meituan.com">[2] 美团</a></p>
					<p><a href="https://www.alipay.com/">[3] 支付宝</a></p>
				</div>
			</div>
		</div>   
	</div>
	<div class="container">
	   <jsp:include page="../commonfile/footer.jsp"></jsp:include>	
	</div>
</div>
	<script src="../libs/js/jquery-3.1.1.min.js"></script>
	<script src="../libs/js/bootstrap.min.js"></script>
	<script>
		$("#select").click(function(){
			$("#upload").trigger("click");
		});
	
		$("#submit").on("click",function(){
			$.ajax({
				type:'post',
				url:'../order/user_changeUser.action',
				data:$('#myform').serialize(),
				beforeSend:function(){
					$('#submit').attr("disabled",true).val("提交中...");
				},
				success:function(r){
					alert(r.message);
				},
				complete:function(){
					$('#submit').attr("disabled",false).val("提   交");
				},
				error:function(error){
					alert(error.status);
				}
			});
		});
		
		//更改密码
		$('#btn').on("click",function(){
			var pass = $("#pass").val();
			var chpass = $("#chpass").val();
			
			if(pass==""){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>请输入密码！</div>");
				return;
			}else if(chpass==""){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>请再次输入密码！</div>");
				return;
			}else if(pass != chpass){
				$(".result").remove();
				$(".find-content").prepend("<div class='result'>两次密码输入不一致！</div>");
				return;
			}
			
			$.ajax({
				type:'post',
				url:'../order/user_updatePass.action',
				data:$('#passForm').serialize(),
				beforeSend:function(){
					$('#btn').attr("disabled",true).val("提交中...");
				},
				success:function(data){
					$(".result").remove();
					$(".find-content").prepend("<div class='success'>"+data.message+"</div>");
					$("#passForm")[0].reset();//重置表单
					$(".success").fadeOut(3000);
				},
				complete:function(){
					$('#btn').attr("disabled",false).val("提 交");
				},
				error:function(error){
					alert(error.status);
				}
			});
		});
	
	</script>
	<%request.getSession().removeAttribute("message"); %>
</body>
</html>