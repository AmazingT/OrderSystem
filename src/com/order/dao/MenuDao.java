package com.order.dao;

import java.util.List;

import com.order.entity.Menu;

public interface MenuDao extends Dao{
	/**
	 * 根据传入的信息进行模糊查询
	 * @param name
	 * @return 返回一个菜单列表
	 */
	public List<Menu> searchMenu(String name);
	/**
	 * 根据菜单名称来进行查找
	 * @param name
	 * @return
	 */
	public Menu findByName(String name);
}
