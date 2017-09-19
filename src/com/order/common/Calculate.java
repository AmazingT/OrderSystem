package com.order.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.order.dao.OrdersDao;
import com.order.dao.UserDao;
import com.order.entity.Menu;
import com.order.entity.MenuList;
import com.order.entity.Orders;

@Service    //购物车结算类作为业务逻辑处理层  交给spring容器管理
public class Calculate {
	@Resource  //通过@Resource注解来注入下面的属性
	private UserDao userDao;
	@Resource
	private OrdersDao ordersDao;
	
	/**
	 * 此方法是用来计算购买的商品数量，总价等信息。存入session对象中。供前台页面调用
	 * @param req
	 * @return
	 */
	public boolean calculate(HttpServletRequest req){
		//获取用户的id
		int id = (int) req.getSession().getAttribute("user_id");
		List<MenuList> list = new ArrayList<MenuList>();
		//根据用户的id再结合用户与订单的一对多的关系映射，得到多得一端对象集合
		Set<Orders> order = userDao.find(id);
		//设置在页面显示时显示menuId的值
		int i = 1;
		//订购的菜单的总的个数
		int totalCount = 0;
		//总价钱
		double total = 0.0;
		//用来标识购物车中是否有商品
		boolean flag = false;
		
		for(Orders o:order){
			Menu myMenu = ordersDao.find(o.getOrder_id());
			MenuList mlist = new MenuList();
			
			mlist.setOrderID(o.getOrder_id());
			mlist.setName(myMenu.getMenu_name());
			mlist.setMenuId(i++);
			mlist.setTaste(o.getOrder_notice());
			mlist.setCount(o.getOrder_num());
			mlist.setPrice(myMenu.getMenu_price());
			mlist.setTotal(o.getOrder_num()*myMenu.getMenu_price());
			mlist.setContent(myMenu.getMenu_content());
			mlist.setState(o.getStates());
			
			totalCount += o.getOrder_num();
			total += o.getOrder_num()*myMenu.getMenu_price();
			
			list.add(mlist);
			flag = true;
		}
		
		//将计算出的对象放到session对象中
		req.getSession().setAttribute("list", list);
		req.getSession().setAttribute("totalCount", totalCount);
		//total的设置其实已经在MenuList对象中了，在此是为了首页上方购物车信息使用
		req.getSession().setAttribute("totalprice", total);
		//counts的设置是为首页的购物车显示信息使用
		req.getSession().setAttribute("counts", i-1);
		
		return flag;
	}
}
