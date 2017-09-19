package com.order.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.order.common.NextPage;

import com.order.common.QueryResult;
import com.order.dao.MenuDao;
import com.order.entity.Menu;

@Controller @Scope("prototype")
public class MenuAction {
	@Resource private MenuDao menuDao;
	@Resource private NextPage nextPage;// 分页
	private String name;// 前台搜索框输入的信息,struts2根据前台input标签的name="name"属性自动获取输入框中的值(故不需要request对象来获取参数)
	private Menu menu;
	private int currentPage = 1;

	// 查询出数据库中的菜单信息显示到首页
	public String showMenu() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String orderby = "order by o.menu_id";// 菜单按menu_id默认升序排序

		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;// 执行删除和更新操作时会重定向到该处执行，此时的currentPage为null

		int currentPage = Integer.parseInt(Page);
		if (currentPage < 1)
			currentPage = 1;
		
		QueryResult<Menu> qr = nextPage.viewList(menuDao, currentPage, 12, Menu.class,orderby);// 查询出Menu的结果集
		request.getSession().setAttribute("allMenuList", qr.getResultSet());
		
		return "show";
	}

	// 根据菜单id来查出该菜单的详细信息，首页菜单点击后进入菜单详细信息页
	public String queryMenuById() {
		HttpServletRequest req = ServletActionContext.getRequest();
		int menuId = Integer.parseInt(req.getParameter("menu_id"));
	
		Menu menu = menuDao.find(Menu.class, menuId);
		req.getSession().setAttribute("menu", menu);//保存menu对象，在菜单信息页显示该菜信息

		return "menuInfo";
	}

	// 根据搜索框中的输入信息查询出菜单信息，若没有则显示数据库中已有的菜单信息
	public String searchMenu() {
		ActionContext ac = ActionContext.getContext();
		HttpServletRequest request = ServletActionContext.getRequest();

		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;// 执行删除和更新操作时会重定向到该处执行，此时的currentPage为null

		int currentPage = Integer.parseInt(Page);
		if (currentPage < 1)
			currentPage = 1;
		
		String message = "";
		
		String orderby = "where o.menu_name like '%";
		for (int i = 0; i < name.length() - 1; i++) {
			orderby += name.charAt(i) + "%' or o.menu_name like '%";
		}
		orderby += name.charAt(name.length() - 1) + "%'order by o.menu_id asc";

		QueryResult<Menu> list = nextPage.viewList(menuDao, currentPage, 10, Menu.class, orderby);

		if (list.getTotalRecord() == 0) {// 如果没有查询到匹配的信息，就查询出所有菜单信息
			QueryResult<Menu> qr = nextPage.viewList(menuDao, currentPage, 10, Menu.class, "");
			ac.getSession().put("searchList", qr.getResultSet());
			message = "对不起，没有查询到您输入的相关菜单信息！不过我们为您精心准备了其他美食。";
			
			ac.getSession().put("number", "0");
			ac.getSession().put("message", message);
		} else {
			ac.getSession().put("searchList", list.getResultSet());
			ac.getSession().put("number", list.getTotalRecord());
			message = "";
			
			ac.getSession().put("message", message);			
		}
		ac.getSession().put("searchName",name);
		return "searchMenu";
	}

	// 查找出所有的菜单并分页显示，供管理员管理
	// 购物车显示添加的菜单
	public String menuList() {
		ActionContext ac = ActionContext.getContext();
		HttpServletRequest request = ServletActionContext.getRequest();

		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;// 执行删除和更新操作时会重定向到该处执行，此时的currentPage为null

		int currentPage = Integer.parseInt(Page);
		if (currentPage < 1)
			currentPage = 1;

		String orderby = "order by o.menu_id";
		QueryResult<Menu> qr = nextPage.viewList(menuDao, currentPage, 15, Menu.class, orderby);// 返回实体类的结果集并分页

		ac.getSession().put("menuList", qr.getResultSet());

		return "menuList";
	}

	//管理员添加菜单
	public String addMenu() {
		menuDao.save(menu);
		return "success";
	}

	// 管理员删除指定Menu_id的菜单信息
	public String deleteMenuById() {
		HttpServletRequest req = ServletActionContext.getRequest();
		int menuId = Integer.parseInt(req.getParameter("id"));
		menuDao.delete(Menu.class, menuId);

		return "success";
	}
	
	//删除选中的菜单记录
	public String deleteSelectMenu(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String str = request.getParameter("str");
		String[] idList = str.split(",");
		
		for(int i=0;i<idList.length;i++){
			int id = Integer.parseInt(idList[i]);
			menuDao.delete(Menu.class, id);
		}
		
		return "success";
	}

	// 管理员根据id找出该菜单，并跳转到更新的页面
	public String searchMenuById() {
		HttpServletRequest req = ServletActionContext.getRequest();
		int menuId = Integer.parseInt(req.getParameter("id"));
		Menu m = menuDao.find(Menu.class, menuId);
		req.getSession().setAttribute("menu", m);

		return "update";
	}

	// 管理员更新菜单的详细信息
	public String updateMenu() {
		Menu m = menuDao.find(Menu.class, menu.getMenu_id());
		m.setMenu_name(menu.getMenu_name());// 前台传入了menu对象的相关属性
		m.setMenu_content(menu.getMenu_content());
		m.setMenu_price(menu.getMenu_price());
		menuDao.update(m);

		return "success";
	}
	
	//通过传入菜名得到该菜的信息
	public void queryMenuByName() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8"); 
		
		@SuppressWarnings("rawtypes")
		Map<String, Comparable> list = new HashMap<String, Comparable>();
		PrintWriter out = response.getWriter();
		
		String menuName = request.getParameter("menuName");
		String status = "";
		
		if(menuDao.findByName(menuName) == null){
			status = "false";
			String message = "您查询的菜名不存在！";
			list.put("status", status);
			list.put("message", message);
			
			out.println(new Gson().toJson(list));
		}else{
			Menu menu = menuDao.findByName(menuName);
			
			list.put("menu_id", menu.getMenu_id());
			list.put("menu_name", menu.getMenu_name());
			list.put("menu_price", menu.getMenu_price());
			list.put("menu_content",menu.getMenu_content());
		
			status = "true";
			list.put("status", status);
			
			out.println(new Gson().toJson(list));
		}
	}

	
	// setter,getter方法
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

}
