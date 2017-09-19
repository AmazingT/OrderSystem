package com.order.entity;

import java.io.Serializable;

/**
 * 用来封装用户留言的信息
 * @author 周小波
 *
 */
public class ShowMessage implements Serializable{
	private static final long serialVersionUID = 1L;
	private int messageID;//留言ID
	private String username;//用户名
	private String subject;//主题
	private String content;//内容
	private String date;//日期
	private String good;//点赞数
	private String headImg;//用户头像路径
	
	public String getHeadImg() {
		return headImg;
	}
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	public String getGood() {
		return good;
	}
	public void setGood(String good) {
		this.good = good;
	}
	public int getMessageID() {
		return messageID;
	}
	public void setMessageID(int messageID) {
		this.messageID = messageID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
