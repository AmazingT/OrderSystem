package com.order.dao;

import com.order.entity.Menu;
import com.order.entity.User;

public interface OrdersDao extends Dao{
	/**
	 * 通过一对一的关系映射查找对应的Menu对象。
	 * @param id Orders的id
	 * @return
	 */
	public Menu find(int id);
	/**
	 * 通过多对一的关系映射查找User对象。
	 * @param id Orders的id
	 * @return
	 */
	public User findUserById(int id);
}
