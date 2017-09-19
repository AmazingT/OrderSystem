package com.order.entity;

import java.io.Serializable;

/**
 * 订单实体类
 * @author 周小波
 *
 */
public class Orders implements Serializable{
	private static final long serialVersionUID = 1L;
	private int order_id;//订单ID
	private int order_num;//订购菜品数量
	private String order_notice;//口味要求
	private String other_notice;//其他要求
	private User user;//用户ID
	private Menu menu;//菜单ID
	private String states;//订单付款状态
	private String order_date;//订单日期
	
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getOrder_notice() {
		return order_notice;
	}
	public void setOrder_notice(String order_notice) {
		this.order_notice = order_notice;
	}
	public String getOther_notice() {
		return other_notice;
	}
	public void setOther_notice(String other_notice) {
		this.other_notice = other_notice;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public String getStates() {
		return states;
	}
	public void setStates(String states) {
		this.states = states;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	
	
}
