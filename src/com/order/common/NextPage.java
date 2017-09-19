package com.order.common;

import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ActionContext;
import com.order.dao.Dao;
/**
 * 数据库分页类
 * @author 周小波
 *
 */
@Service
public class NextPage {
	//page:页码,maxCount:每页显示的记录数,startIndex:每页显示的第一个记录起始位置
	public <T> QueryResult<T> viewList(Dao dao,int currentPage,int maxCount,Class<T> entityClass,String orderby){
		int startIndex = (currentPage-1)*maxCount;
		int totalRecord = 0;
		
		//getScorllData()方法返回的是QueryResult实体类的一个对象
		QueryResult<T> qr = dao.getScorllData(entityClass, startIndex, maxCount, orderby);
		totalRecord = (int) qr.getTotalRecord();//获得总的记录数
		
		Page page = new Page(maxCount,totalRecord,currentPage,5);//总页数,5代表每页显示5个页码
		
		ActionContext ac = ActionContext.getContext();
		ac.getSession().put("page", page);
	
		return qr;
	}
}
