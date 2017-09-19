package com.order.service.daoImpl;

import org.hibernate.query.Query;
import org.springframework.stereotype.Service;

import com.order.dao.AdminDao;
import com.order.entity.Admin;

@Service
public class AdminDaoImpl extends DaoImpl implements AdminDao{
	//判断管理员的登录
	@SuppressWarnings("rawtypes")
	public Admin admin(Admin a){
		String hql = "from Admin as a where a.username=:name and a.password=:password";
		Query q = super.sessionFactory.getCurrentSession().createQuery(hql);
		q.setParameter("name", a.getUsername());
		q.setParameter("password", a.getPassword());
		@SuppressWarnings("deprecation")
		Admin admin= (Admin) q.uniqueResult();//getSingleResult()
		
		return admin;
	}
}
