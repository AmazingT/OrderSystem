package com.order.dao;

import java.util.Set;

import com.order.entity.Message;
import com.order.entity.Orders;
import com.order.entity.User;
import com.order.entity.UserInfo;

public interface UserDao extends Dao{
	/**
	 * 通过传入的部分用户信息来找回密码
	 * @param user
	 * @return
	 */
	public User getPasswd(User user);
	/**
	 * 根据传入的用户信息来查找用户是否存在
	 * @param u
	 * @return
	 */
	public User userLogin(User u);
	/**
	 * 判断用户邮箱是否激活
	 * @param
	 * @return
	 */
	public boolean mailActive(int id);
	/**
	 * 通过邮箱判断用户是否存在
	 */
	public User userMail(String mail);
	/**
	 * 根据传入的name判断用户名是否存在
	 * @param name
	 * @return
	 */
	public boolean judgeUser(String name);
	/**
	 * 通过用户id得到Orders(订单)集合
	 * @param id
	 * @return
	 */
	public Set<Orders> find(int id);
	/**
	 * 通过用户id来得到UserInfo(用户配送信息)对象
	 * @param id
	 * @return
	 */
	public UserInfo findUser(int id);
	/**
	 * 通过用户id得到Message(留言)集合
	 * @param id
	 * @return
	 */
	public Set<Message> findMessageById(int id);
	/**
	 * 通过用户的用户名得到用户的信息
	 * @param name
	 * @return
	 */
	public User findByName(String name);
	/**
	 * 找回密码更新密码字段
	 * @param pass 用户输入的新密码
	 */
	public void updatePass(User user,String pass);
}
