package com.order.service.daoImpl;

import org.hibernate.Hibernate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.order.dao.OrdersDao;
import com.order.entity.Menu;
import com.order.entity.Orders;
import com.order.entity.User;
@Service
public class OrdersDaoImpl extends DaoImpl implements OrdersDao {
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public Menu find(int id){//Orders的id传入
		Orders orders = (Orders) super.sessionFactory.getCurrentSession().get(Orders.class,id);
		Hibernate.initialize(orders.getMenu());
		return orders.getMenu();
	}
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public User findUserById(int id){
		Orders orders = (Orders) super.sessionFactory.getCurrentSession().get(Orders.class, id);
		Hibernate.initialize(orders.getUser());
		return orders.getUser();
	}
}
