package com.order.entity;

import java.io.Serializable;

/**
 * 这个类使用来封装信息的,把用户已经购买的菜单信息封装起来，供以后的页面显示使用
 * 封装的是每样菜的信息，而不是全部菜单的信息
 * @author 周小波
 *
 */
public class MenuList implements Serializable{
	private static final long serialVersionUID = 1L;
	private int menuId;		//标识页面显示中的菜单的ID，并非是数据库中真实的菜单ID
	private String name;	//菜单名
	private int count;		//购买的每样菜的数量
	private double price;	//菜的单价
	private double total;	//每样菜的总价
	private String content;	//对菜的要求
	private String taste;   //口味
	private int orderID;	//这道菜对应的订单ID
	private int userID;		//订购此菜的用户ID
	private String username;	//订购此菜的用户名
	private String userTel;	//订购此菜得用户电话
	private String sendTime;//送货时间
	private String userAddress;//送货地址
	private String state;	//表示用户是否已付清订单，0为已经付清，1为未付清
	
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public String getTaste() {
		return taste;
	}
	public void setTaste(String taste) {
		this.taste = taste;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOrderID() {
		return orderID;
	}
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}
