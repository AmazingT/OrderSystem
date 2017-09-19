<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--头部导航栏-->
<div class="header">
	<div class="header-left">
		<c:if test="${empty user_name}">		
			<ul>
		       <li class="drop-login"><a href="${pageContext.request.contextPath }/user/userLogin.jsp"><span>登 录</span></a></li>
		       <li class="drop-register"><a href="${pageContext.request.contextPath }/user/userRegister.jsp"><span>免费注册</span></a></li>
	   		</ul>
	   	</c:if>
	   	<c:if test="${!empty user_name}">
	   		<ul>
		       <li class="drop-menu menu-user"><a href="javascript:void(0)"><span>${user_name}</span></a>
		       		<div class="submenu" style="display: none;">
			            <div class="menu-header">
				             <div class="menu-main-left">
					              <div class="menu-main-content clearfix">
					                  <div class="user-left-img">
					                  	   <c:if test="${empty uploadFileName }">
					                  	   		<img src="${pageContext.request.contextPath }/image/${user_head }" width="80" height="80"/>
					                  	   </c:if>
					                  	   <c:if test="${!empty uploadFileName }">
					                  	  	    <img src="${pageContext.request.contextPath }/image/${uploadFileName}" width="80" height="80"/>
					                  	   </c:if>
					                  </div>
					                  <div class="user-right-info">
					                  	   <c:if test="${user_flag == '0'}">
					                  	   		<p>你是普通用户哦<br>会员用户拥有更多的特权，赶快加入我们吧</p>
					                  	   </c:if>
					                  	   <c:if test="${user_flag == '1'}">
					                  	   		<p class="vip-user">你是尊贵的VIP用户，可享有特权</p>
					                  	   </c:if>
					                  </div>
					              </div>
					          </div>
				              <div class="menu-main-right">
				                 <a href="${pageContext.request.contextPath }/order/order_searchUserOrder.action?name=${user_name }"><i class="icon-user"></i>个人中心</a>
				                 <span class="line">|</span>
				                 <a href="order/user_exit"><i class="icon-signout"></i>退出</a>
				              </div>
			            </div>
			        </div>
		       </li>     
	   		</ul>
	   	</c:if>
	</div>
	<div class="header-right">
	   	<ul>
	   		<li><a href="${pageContext.request.contextPath }/index.jsp"><span><i class="icon-home" style="margin-right:5px;"></i>首页</span></a></li>
	   		<c:if test="${empty user_name}">
	   			<li><a href="${pageContext.request.contextPath }/user/userLogin.jsp"><span><i class="icon-shopping-cart"></i>购物车<i class="icon-angle-down"></i></span></a></li>
	   		</c:if>
	   		<c:if test="${!empty user_name}">
  	      	 	<li class="drop-menu"><a href="${pageContext.request.contextPath}/order/query_menuList.action">
  	      	 	<span>
  	      	 	<i class="icon-shopping-cart"></i>购物车
	  	      	 	<i class="badge">
	  	      	 		<c:if test="${empty counts}">0</c:if>
	  	      	 		<c:if test="${!empty counts}">${counts}</c:if>
	  	      	 	</i>
  	      	 	</span>
  	      	 	</a>	
     	  		</li>
     	  	</c:if>
     	  	<%session.removeAttribute("counts"); %>
     	  <li class="drop-menu-message"><a href="${pageContext.request.contextPath }/order/mg_messageList.action"><span><i class="icon-comments" style="margin-right:5px;"></i>用户评论</span></a></li>
     	  <c:if test="${empty user_name}">
     	  	   <li class="drop-menu-order"><a href="${pageContext.request.contextPath }/user/userLogin.jsp"><span>我的订单</span></a></li>
     	  </c:if>
     	  <c:if test="${!empty user_name}">
     	  	   <li class="drop-menu-order"><a href="${pageContext.request.contextPath }/order/order_searchUserOrder.action?name=${user_name }"><span>我的订单</span></a></li>
     	  </c:if>
     	  
          <li class="drop-menu">
	          <a href="https://v2.live800.com/live800/chatClient/chatbox.jsp?companyID=402791&configID=123801&jid=1820947377&enterurl=http%3A%2F%2Fr.ele.me%2Ftest-restaurant-01&pagetitle=test_restaurant_01+-+%E4%B8%8A%E6%B5%B7%E5%B8%82%E6%B9%96%E5%8D%97%E5%B7%A5%E4%B8%9A%E5%A4%A7%E5%AD%A620%E6%A0%8B3%2E%2E%2E+-+%E5%8F%AB%E5%A4%96%E5%8D%96%E4%B8%8Aele%2Eme&pagereferrer=http%3A%2F%2Fele%2Eme%2Fpremium%2Fgeohash%2Fwtw3djeuu587&firstEnterUrl=http%3A%2F%2Fr%2Eele%2Eme%2Fbigmama">
		          <span>
		          	在线客服<i class="icon-angle-down"></i>
		          </span>
		      </a>
		      <div class="submenu" style="display: none;">
		            <div class="menu-header-online">
			             <div class="menu-main-left">
				              <div class="menu-main-content clearfix">
				              		<p>每天24小时为您解答疑惑</p>
				              		<p>24小时客服热线：</p>
				              		<p class="tel" style="font-weight:600;font-size:18px;color:#337ab7;">184-3516-5484</p>
				              </div>
				         </div>		              
		            </div>
		        </div>
	      </li> 
      </ul> 
 </div> 
</div>