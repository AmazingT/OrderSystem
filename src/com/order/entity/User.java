package com.order.entity;

import java.io.Serializable;
import java.util.Set;

/**
 * 用户实体类
 * @author 周小波
 *
 */
public class User  implements Serializable{
	private static final long serialVersionUID = 1L;
	private int user_id;//用户ID
	private String user_name;//昵称(用户名)
	private String user_pass;//密码
	private String user_realname;//用户真实名字
	private String user_sex;//性别
	private String user_flag;//身份
	private String user_mail;//邮箱
	private String user_head;//用户头像地址
	private String registTime;//注册时间
	private String status = "0";//邮箱激活状态，默认为未激活
	
	private Set<Orders> orders;
	private Set<Message> message;
	private UserInfo userinfo;
	
	
	public String getUser_head() {
		return user_head;
	}
	public void setUser_head(String user_head) {
		this.user_head = user_head;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRegistTime() {
		return registTime;
	}
	public void setRegistTime(String registTime) {
		this.registTime = registTime;
	}
	public Set<Orders> getOrders() {
		return orders;
	}
	public void setOrders(Set<Orders> orders) {
		this.orders = orders;
	}
	public Set<Message> getMessage() {
		return message;
	}
	public void setMessage(Set<Message> message) {
		this.message = message;
	}
	public UserInfo getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(UserInfo userinfo) {
		this.userinfo = userinfo;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getUser_realname() {
		return user_realname;
	}
	public void setUser_realname(String user_realname) {
		this.user_realname = user_realname;
	}
	public String getUser_sex() {
		return user_sex;
	}
	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}
	public String getUser_flag() {
		return user_flag;
	}
	public void setUser_flag(String user_flag) {
		this.user_flag = user_flag;
	}
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	
	
}
