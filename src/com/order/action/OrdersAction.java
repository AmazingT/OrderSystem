package com.order.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.opensymphony.xwork2.ActionContext;
import com.order.common.Calculate;
import com.order.common.NextPage;
import com.order.common.QueryResult;
import com.order.dao.MenuDao;
import com.order.dao.OrdersDao;
import com.order.dao.UserDao;
import com.order.entity.Menu;
import com.order.entity.MenuList;
import com.order.entity.Orders;
import com.order.entity.User;
import com.order.entity.UserInfo;

@Controller @Scope("prototype")
public class OrdersAction {
	@Resource private UserDao userDao;
	@Resource private MenuDao menuDao;
	@Resource private OrdersDao ordersDao;
	@Resource private Calculate calculate;
	@Resource private NextPage nextPage;
	private int page = 1;
	private String UserID;
	private String MenuID;
	private Orders orders;
	
	//用户添加菜单信息到订单,首先要判断用户是否登录。
	public String addMenu(){
		ActionContext ac = ActionContext.getContext();
		
		if(ac.getSession().get("user_name")!=null){
			int userid = Integer.parseInt(UserID);
			int menuid = Integer.parseInt(MenuID);
			
			User u = (User) userDao.find(User.class,userid);//find()是公共Dao接口定义的通过id获取唯一对象的方法
			Menu m = menuDao.find(Menu.class, menuid);
			save(u,m);
			HttpServletRequest request = ServletActionContext.getRequest();
			calculate.calculate(request);//调用Colculate类计算订单数量和总价
		
			return "orderInfo";//提交订单
		}else{
			return "login";
		}
	}
	
	//保存用户订单信息
	private void save(User u, Menu m) {
		orders.setUser(u);
		orders.setMenu(m);
		orders.setStates("1");//普通用户
		
		Calendar rightNow = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		String orderDate = fmt.format(rightNow.getTime());
		
		orders.setOrder_date(orderDate);
		ordersDao.save(orders);
	}
	
	//删除用户订单中的菜单项，根据订单号ordersID来删除
	public String deleteMenu(){
		HttpServletRequest req = ServletActionContext.getRequest();
		int orderId = Integer.parseInt(req.getParameter("orderID"));
		ordersDao.delete(Orders.class, orderId);
		
		return "deleteSuccess";
	}
	
	//根据传入的参数的不同，为管理员显示出已经付清的订单或未付清的订单信息
	public String orderList(){
		HttpServletRequest req = ServletActionContext.getRequest();
		String pays = req.getParameter("pay");//标识已付款和未付款的订单
		pays = pays == null?"0":pays;
		int pay = Integer.parseInt(pays);
		
		String orderby = "";
		if(pay == 0)//已付款
			orderby = "where o.states='0' order by o.order_id";
		else if(pay == 1)//未付款
			orderby = "where o.states='1' order by o.order_id";
		List<MenuList> list = common(orderby);
		
		req.getSession().setAttribute("orderList", list);
		req.getSession().setAttribute("pay", pay);
		
		return "orderList";
	}
	
	//封装订单相关信息的公共方法
	public List<MenuList> common(String orderby){
		List<MenuList> list = new ArrayList<MenuList>();
		HttpServletRequest request = ServletActionContext.getRequest();

		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;// 执行删除和更新操作时会重定向到该处执行，此时的currentPage为null

		int currentPage = Integer.parseInt(Page);
		if (currentPage < 1)
			currentPage = 1;
	
		//QueryResult实体类获取实体类的结果集和记录总数
		QueryResult<Orders> qr = nextPage.viewList(ordersDao, currentPage, 10, Orders.class, orderby);//从第0条记录开始取10条记录
		int i = 1;
		for(Orders o:qr.getResultSet()){
			MenuList ml = new MenuList();//MenuList实体类存放用户订单的菜单信息
			
			ml.setMenuId(i++);
			Menu menu = ordersDao.find(o.getOrder_id());
		
			ml.setOrderID(o.getOrder_id());
			ml.setName(menu.getMenu_name());
			ml.setCount(o.getOrder_num());
			ml.setPrice(menu.getMenu_price());
			ml.setTotal(o.getOrder_num()*menu.getMenu_price());
	
			User u = ordersDao.findUserById(o.getOrder_id());
			ml.setUserID(u.getUser_id());
			ml.setUsername(u.getUser_name());
			
			UserInfo ui = userDao.findUser(u.getUser_id());
			
			if(ui!=null){//用户的配送信息不空
				ml.setSendTime(ui.getSend_date());
				ml.setUserTel(ui.getMobile());
				ml.setUserAddress(ui.getAddress());
			}
			list.add(ml);
		}
		return list;
	}
	
	//确认订单的审查，该方法会将订单的状态由1变为0，即由未付状态变为已付状态
	public String confirmCheck(){
		HttpServletRequest ac = ServletActionContext.getRequest();
		int id = Integer.parseInt(ac.getParameter("orderID"));
		
		String st = ac.getParameter("search");//st只是一个标志
		Orders order = ordersDao.find(Orders.class,id);//查找指定的orders对象
		order.setStates("0");//已付款
		ordersDao.update(order);
		
		if(st == null || st.equals("")){
			return "update";//若为空，则跳转到update视图
		}else{
			return "searched";//不空，则跳转到searched视图
		}
	}
	
	//用户查询自己的订单，将查询到的用户的订单放入到集合对象中供页面遍历使用
	public String searchUserOrder(){
		ActionContext ac = ActionContext.getContext();
		String username = (String) ac.getSession().get("user_name");
	
		User u = userDao.findByName(username);
		
		Set<Orders> ordersList = userDao.find(u.getUser_id());//根据用户id找到该用户对应的订单信息
		String message = "";
		
		if(ordersList.size()<=0){//该用户没有订单
			message = "对不起，没有您的订单记录！";
			ac.getSession().put("message", message);
		}else{
			List<MenuList> list = new ArrayList<MenuList>();

			for(Orders o:ordersList){
				addMenuList(list,o);
			}
			message = "您的所有订单记录如下：";
			ac.getSession().put("message", message);
			ac.getSession().put("list", list);		
		}
		return "userOrder";
	}
	
	//抽取出一个方法，用来将信息封装到一个MenuList对象中,MenuList是一个封装了用户订单结算后的属性值。
	private void addMenuList(List<MenuList> list, Orders o) {	
		MenuList ml = new MenuList();
		Menu menu = ordersDao.find(o.getOrder_id());
		ml.setName(menu.getMenu_name());
		ml.setCount(o.getOrder_num());
		ml.setPrice(menu.getMenu_price());
		ml.setTotal(o.getOrder_num()*menu.getMenu_price());
		ml.setSendTime(o.getOrder_date());
		ml.setState(o.getStates());
		
		list.add(ml);
	}
	
	//后台管理员查询出用户所有的订单信息
	public String searchOrdersByName(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String name = request.getParameter("name");
		
		if(!userDao.judgeUser(name)){//judgeUser()方法，若用户不为空即存在返回false
			User u = userDao.findByName(name);
			UserInfo ui = userDao.findUser(u.getUser_id());
			Set<Orders> set = userDao.find(u.getUser_id());
			//把根据用户id得到的该用户的订单信息存放在MenuList中
			List<MenuList> list = new ArrayList<MenuList>();
			int i = 1;
			
			for(Orders o:set){
				MenuList mList = new MenuList();
				mList.setMenuId(i++);
				Menu menu = ordersDao.find(o.getOrder_id());
				mList.setMenuId(menu.getMenu_id());
				mList.setUserID(u.getUser_id());
				mList.setOrderID(o.getOrder_id());
				mList.setContent(menu.getMenu_content());
				mList.setState(o.getStates());
				mList.setCount(o.getOrder_num());
				mList.setName(menu.getMenu_name());//菜名
				mList.setPrice(menu.getMenu_price()*o.getOrder_num());
				mList.setUsername(u.getUser_name());//用户名
				//判断用户的配送信息是否为空(必填的信息)
				if(ui!=null){
					mList.setSendTime(ui.getSend_date());
				}
				list.add(mList);
			}
			request.getSession().setAttribute("lists", list);
			//request.getSession().setAttribute("name", name);
		}else{
			String message = "对不起，您查询的用户不存在！";
			request.getSession().setAttribute("message", message);
		}
		
		return "queryUserOrder";
	}
	
	//setter,getter方法
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		this.UserID = userID;
	}
	public String getMenuID() {
		return MenuID;
	}
	public void setMenuID(String menuID) {
		this.MenuID = menuID;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	
	
}
