package com.order.entity;

import java.io.Serializable;

/**
 * 用户留言实体类
 * @author 周小波
 *
 */
public class Message implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;//留言ID
	private User user;//用户ID
	private String subject;//主题
	private String content;//内容
	private String date;//时间
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}
