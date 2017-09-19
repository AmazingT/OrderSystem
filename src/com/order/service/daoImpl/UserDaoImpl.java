package com.order.service.daoImpl;

import java.util.Set;

import org.hibernate.Hibernate;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.order.dao.UserDao;
import com.order.entity.Message;
import com.order.entity.Orders;
import com.order.entity.User;
import com.order.entity.UserInfo;

@Service
public class UserDaoImpl extends DaoImpl implements UserDao {
	//通过传入用户部分信息找回密码
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public User getPasswd(User user){
		String hql = "from User as u where u.user_name=:name";
		Query<?> query = super.sessionFactory.getCurrentSession().createQuery(hql);
		
		query.setParameter("name", user.getUser_name());
		
		User u = (User) query.uniqueResult();
		return u;
	}
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public User userMail(String mail){
		String hql = "from User as u where u.user_mail=:mail";
		Query<?> query = super.sessionFactory.getCurrentSession().createQuery(hql);
		
		query.setParameter("mail", mail);
		User user = (User) query.uniqueResult();
		
		return user;
	}
	
	//通过用户的部分信息来判断用户是否存在
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public User userLogin(User u){
		String hql = "from User as u where u.user_name=:name and u.user_pass=:pass";
		Query<?> query = super.sessionFactory.getCurrentSession().createQuery(hql);

		query.setParameter("name", u.getUser_name());
		query.setParameter("pass", u.getUser_pass());
		User user = (User) query.uniqueResult();
		return user;
	}
	
	//判断用户的邮箱是否激活
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public boolean mailActive(int id){
		String hql = "select status from User where user_id=:id";
		
		Query<?> query = super.sessionFactory.getCurrentSession().createQuery(hql);
		query.setParameter("id", id);
		
		String status = (String) query.uniqueResult();
		if(status.equals("0")){
			return false;//邮箱未激活
		}else{
			return true;
		}
	}
	
	//用户找回密码更新密码
	@SuppressWarnings("deprecation")
	@Transactional //这里出了问题：JPA规定在执行数据库更新和删除时必须进行数据库事务管理
	public void updatePass(User u,String pass){
		String hql = "update User as u set u.user_pass =:pass where user_id =:id";
		Query<?> query = super.sessionFactory.getCurrentSession().createQuery(hql);

		query.setParameter("pass", pass);
		query.setInteger("id", u.getUser_id());
	
		query.executeUpdate();
	}
	
	//通过传入用户名判断用户是否存在
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public boolean judgeUser(String name){
		String hql = "from User as u where u.user_name='"+name+"'";
		User user = (User) super.sessionFactory.getCurrentSession().createQuery(hql).uniqueResult();
		if(user!= null){
			return false;
		}else{
			return true;
		}
	}
	
	//通过用户id来得到该用户的所有订单集合
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public Set<Orders> find(int id){
		User user = (User) super.sessionFactory.getCurrentSession().get(User.class, id);
		Hibernate.initialize(user.getOrders());
		return user.getOrders();
	}
	
	//通过传入用户id得到该用户的配送信息
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public UserInfo findUser(int id){
		User user = (User) super.sessionFactory.getCurrentSession().get(User.class, id);
		Hibernate.initialize(user.getUserinfo());
		return user.getUserinfo();
	}
	
	//通过传入用户id来得到该用户的所有留言集合
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public Set<Message> findMessageById(int id){
		User user = (User) super.sessionFactory.getCurrentSession().get(User.class, id);
		Hibernate.initialize(user.getMessage());
		return user.getMessage();
	}
	
	//通过传入用户的用户名来得到该用户的信息
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public User findByName(String name){
		String hql = "from User as u where u.user_name='"+name+"'";
		User user = (User) super.sessionFactory.getCurrentSession().createQuery(hql).uniqueResult();
		return user;
	}
}






















