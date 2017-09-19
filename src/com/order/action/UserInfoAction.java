package com.order.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.order.dao.OrdersDao;
import com.order.dao.UserDao;
import com.order.dao.UserInfoDao;
import com.order.entity.Orders;
import com.order.entity.User;
import com.order.entity.UserInfo;

@Controller
public class UserInfoAction {
	@Resource private UserDao userDao;
	@Resource private OrdersDao orderDao;
	@Resource private UserInfoDao userInfoDao;
	private UserInfo userInfo;
	//保存用户的配送信息
	public void account() throws IOException{
		ActionContext ac = ActionContext.getContext();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");
		Map<String,String> ma = new HashMap<String,String>();
		
		String name = (String) ac.getSession().get("user_name");
		User u = userDao.findByName(name);
		
		Set<Orders> order = userDao.find(u.getUser_id());
		for(Orders o:order){
			o.setStates("0");;//该订单已付款
			orderDao.update(o);;
		}
		
		userInfo.setUser(u);
		
		userInfoDao.save(userInfo);
		
		String message = "付款成功，感谢您的信任！";
		
		ma.put("message", message);
		response.getWriter().print(new Gson().toJson(ma));
	}
	
	//  setter/getter方法
	public void setUserInfo(UserInfo userInfo){
		this.userInfo = userInfo;
	}
	
	public UserInfo getUserInfo(){
		return userInfo;
	}
}
