package com.order.service.daoImpl;

import com.order.dao.MenuDao;
import com.order.entity.Menu;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

//标识业务层组件
@Service
public class MenuDaoImpl extends DaoImpl implements MenuDao {
	@SuppressWarnings("unchecked")
	@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)
	public List<Menu> searchMenu(String name){
		String hql = "from Menu as m where m.menu_name like '%"+name+"%'";
		return super.sessionFactory.getCurrentSession().createQuery(hql).getResultList();
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public Menu findByName(String name){
		String hql = "from Menu as m where m.menu_name ='"+name+"'";
		return (Menu) super.sessionFactory.getCurrentSession().createQuery(hql).getSingleResult();
	}
}
