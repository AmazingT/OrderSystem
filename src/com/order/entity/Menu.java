package com.order.entity;

import java.io.Serializable;

/**
 * 菜单实体类
 * @author 周小波
 *
 */
public class Menu implements Serializable{
	private static final long serialVersionUID = 1L;
	private int menu_id;//菜单ID
	private String menu_name;//菜单名
	private String menu_content;//菜单简介
	private double menu_price;//单价
	
	public int getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_content() {
		return menu_content;
	}
	public void setMenu_content(String menu_content) {
		this.menu_content = menu_content;
	}
	public Double getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(Double menu_price) {
		this.menu_price = menu_price;
	}
}
