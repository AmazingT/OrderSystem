package com.order.service.daoImpl;
import com.order.common.QueryResult;
import com.order.dao.Dao;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;

/**
 * 公共的DAO接口(定义了其他的实体类都要用到的方法(CURD))
 */

@Transactional
public class DaoImpl implements Dao{
	@Resource 
	protected SessionFactory sessionFactory;
	//保存
	public void save(Object entity){
		sessionFactory.getCurrentSession().save(entity);
	}
	
	//更新
	public void update(Object entity){
		//先根据ID执行一次select,若该对象存在则两次对象不一致则更新。一致则不执行任何操作。若该对象不存在，则执行insert。
		sessionFactory.getCurrentSession().update(entity);
	}
	
	//删除指定对象
	public <T> void delete(Class<T> entityClass,Object entityid){
		deletes(entityClass,new Object[]{entityid});
	}
	
	//删除多个对象
	public <T> void deletes(Class<T> entityClass,Object[] entityid){
		for(Object id:entityid){
			sessionFactory.getCurrentSession().delete(find(entityClass,id));
		}
	}
	
	//查找指定对象
	//容器不为这个方法开启事务  readOnly=true只读,不能更新,删除 
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public <T> T find(Class<T> entityClass,Object entityid){
		return (T) sessionFactory.getCurrentSession().get(entityClass, (Serializable) entityid);
	}
	
	//根据传入不同的实体类来获取该实体类对应数据表的所有结果集(resultSet)和记录总数(totalRecord)
	@SuppressWarnings({ "unchecked", "deprecation" })
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public <T> QueryResult <T> getScorllData(Class <T> entityClass,int startIndex,int maxCount,String orderby){
		String hql = "FROM" + " "+ entityClass.getSimpleName()+ " " + "as o" + " " +orderby;
		//创建了一个实体类QueryResult来存放获取的结果和记录总数
		QueryResult<T> qr = new QueryResult<T>();
		Query<T> query = sessionFactory.getCurrentSession().createQuery(hql);
	
		if(startIndex != -1&maxCount != -1){
			//setFirstResult()设置每次提取记录的起始位置;setMaxResults()设置每次返回的最多记录行数(每页显示的记录数)
			//select * from table limit startIndex , maxCount;
			query.setFirstResult(startIndex).setMaxResults(maxCount);
	
			//返回的实例有多个(存放着List集合里面)
			qr.setResultSet(query.list());
			
			String hql1 = "SELECT COUNT(*) FROM" + " " + entityClass.getSimpleName() + " " + "as o" + " " + orderby;

			query = sessionFactory.getCurrentSession().createQuery(hql1);
			//当确定返回的实例只有一个或者null时 用uniqueResult()方法  
	
			//qr.setTotalRecord((long) query.uniqueResult());
		}
		return qr;
	}
	
	//获取指定范围的结果集
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public <T> QueryResult <T> getScorllData(Class <T> entityClass,int firstIndex,int maxCount){
		return getScorllData(entityClass,firstIndex,maxCount,"");
	}
	
	//获取结果集
	@Transactional(propagation=Propagation.NOT_SUPPORTED,readOnly=true)
	public <T> QueryResult <T> getScorllData(Class <T> entityClass){
		return this.getScorllData(entityClass,-1,-1);
	}
}
