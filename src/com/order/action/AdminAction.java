package com.order.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.order.dao.AdminDao;
import com.order.entity.Admin;

@Controller @Scope("prototype")
public class AdminAction {
	@Resource private AdminDao adminDao;
	private Admin admin;
	
	//管理员后台登录
	public void adminLogin() throws IOException{
		Admin a = adminDao.admin(admin);
		ActionContext ac = ActionContext.getContext();
		HttpServletResponse response = ServletActionContext.getResponse();
		//设置返回json数据，否则中文将会乱码
		response.setContentType("application/json;charset=utf-8");  
		
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		
		String status = "";
		String message = "";
		
		if(a!=null){		
			status = "true";
			msg.put("status", status);
			ac.getSession().put("adminName", a.getUsername());
			
			out.println(new Gson().toJson(msg));
		}else{
			status = "false";
			message = "账号或密码错误！";
			msg.put("status", status);
			msg.put("message", message);

			out.println(new Gson().toJson(msg));	
		}
	}
	
	//管理员退出
	public String adminExit(){
		ActionContext ac = ActionContext.getContext();
		ac.getSession().remove("adminName");
		return "adminExit";	
	}
		
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
}
