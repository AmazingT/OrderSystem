package com.order.service.daoImpl;

import org.hibernate.Hibernate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.order.dao.MessageDao;
import com.order.entity.Message;
@Service
public class MessageDaoImpl extends DaoImpl implements MessageDao {
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public Message findById(int id){
		Message message = (Message) super.sessionFactory.getCurrentSession().get(Message.class, id);
		Hibernate.initialize(message.getUser());//强制加载关联对象,得到留言对应的用户信息
		return message;
	}
}
