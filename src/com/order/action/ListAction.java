package com.order.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.order.common.Calculate;

@Controller @Scope("prototype")
public class ListAction {
	@Resource
	private Calculate calculate;
	/**
	 * 显示已经加入购物车的菜单列表
	 */
	public String menuList(){
		HttpServletRequest req = ServletActionContext.getRequest();
		boolean flag = calculate.calculate(req);
		
		if(flag){
			return "list";
		}else{
			String message = "您的购物车空空如也!!!";
			req.getSession().setAttribute("message", message);
			return "noMenu";
		}
	}
}
