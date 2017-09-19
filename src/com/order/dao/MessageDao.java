package com.order.dao;

import com.order.entity.Message;

public interface MessageDao extends Dao{
	/**
	 * 通过id查找Message对象,同时这里声明懒加载,可以得到User对象。
	 * @param id
	 * @return
	 */
	public Message findById(int id);
}
