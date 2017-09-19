package com.order.common;

import java.util.List;

/**
 * 数据库分页使用数据
 * 查询出所有的结果集存放在list集合中
 * @author 周小波
 * @param <T>
 */
public class QueryResult<T> {
	private List<T> resultSet;//每次提取记录的位置startIndex,每次提取的记录数maxCount
	private long totalRecord;//不同数据表(实体类)中记录总数
	
	public List<T> getResultSet() {
		return resultSet;
	}
	public void setResultSet(List<T> resultSet) {
		this.resultSet = resultSet;
	}
	public long getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
	}	
}
