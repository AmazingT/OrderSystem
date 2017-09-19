package com.order.dao;

import com.order.entity.Admin;

public interface AdminDao extends Dao{
	//判断管理员登录
	public Admin admin(Admin a);
}
