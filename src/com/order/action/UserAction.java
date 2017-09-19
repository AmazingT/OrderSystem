package com.order.action;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.order.common.MailUtil;
import com.order.common.NextPage;
import com.order.common.QueryResult;
import com.order.dao.UserDao;
import com.order.entity.User;

@Controller @Scope("prototype")
public class UserAction {
	@Resource private UserDao userDao;
	@Resource private NextPage nextPage;
	@Resource private MailUtil mailUtil;
	private User user;
	
	//验证码显示
	public void Code() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		BufferedImage imgBox = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);// 宽高,图片类型
		Graphics g = imgBox.getGraphics();// 画图片
		Color bgColor = new Color(238, 238, 238);//背景颜色
		g.setColor(bgColor);// 把颜色给对象
		g.fillRect(0, 0, 68, 22);// 背景框

		// 图片内的内容
		char[] ch = "ABCDEFGHIJKLMNOPQRSTUVWSYZ0123456789".toCharArray();
		Random r = new Random();
		int len = ch.length,index;
		StringBuffer str = new StringBuffer();
		//产生4个随机字母或数字
		for (int i = 0; i < 4; i++) {
			index = r.nextInt(len);//获取[0,len)的随机数
			g.setColor(new Color(r.nextInt(88), r.nextInt(88), r.nextInt(255)));
			g.drawString(ch[index] + "", (i * 18) + 3, 18);
			
			str.append(ch[index]);
		}
		//绘制3条干扰线
		for(int j=0;j<3;j++){
			g.setColor(new Color(r.nextInt(141)+80, r.nextInt(141)+80, r.nextInt(141)+80));
			g.drawLine(r.nextInt(67)+1, r.nextInt(21)+1, r.nextInt(67)+1, r.nextInt(21)+1);
		}
		request.getSession().setAttribute("codes", str.toString());//验证码保存在session中
		ImageIO.write(imgBox, "JPG", response.getOutputStream());// 输出
	}
	
	//用户登录部分
	public void login() throws IOException{
		//先判断验证码是否正确
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		//设置返回json数据，否则中文将会乱码
		response.setContentType("application/json;charset=utf-8");  
		
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		
		String code = request.getParameter("user_code").toUpperCase();
		String codes = (String) request.getSession().getAttribute("codes");
		
		String status = "";
		String message = "";
		
		if(code.equals(codes)){
			//根据用户输入的user的部分信息对user对象进行查找
			User u = userDao.userLogin(user);//传入的是用户名和密码
			
			if(u!=null){
				Boolean b = userDao.mailActive(u.getUser_id());//邮箱激活状态
				if(b){
					ActionContext ac = ActionContext.getContext();
					
					ac.getSession().put("user_sex", u.getUser_sex());
					ac.getSession().put("user_mail", u.getUser_mail());
					ac.getSession().put("user_realname",u.getUser_realname());
					ac.getSession().put("user_name", u.getUser_name());
					ac.getSession().put("user_id", u.getUser_id());
					ac.getSession().put("user_flag", u.getUser_flag());
					ac.getSession().put("user_head", u.getUser_head());
					
					status = "true";		
					msg.put("status", status);
				}else{
					status = "false";
					message = "对不起，您的邮箱未激活！不能登录。";
					
					msg.put("status", status);
					msg.put("message", message);
				}
			}else{
				status = "false";
				message = "用户名或密码错误！";
				
				msg.put("status", status);
				msg.put("message", message);
			}
		}else{
			status = "false";
			message = "验证码错误！";
			
			msg.put("status", status);
			msg.put("message", message);
		}
		
		out.println(new Gson().toJson(msg));
	}
	
	//用户退出
	public String exit(){
		ActionContext ac = ActionContext.getContext();
		ac.getSession().remove("user_name");
		
		return "exit";
	}
	
	//用户注册部分
	public void userRegister() throws IOException, MessagingException{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");  
		
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		
		String status = "";
		String message = "";
		
		//判断用户是否已经存在
		if(userDao.judgeUser(user.getUser_name())){	
			if(userDao.userMail(user.getUser_mail())==null){
				Calendar now = Calendar.getInstance();
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
				String time = fmt.format(now.getTime());
				
				user.setRegistTime(time);//设置用户的注册时间
				user.setUser_flag("0");//默认设置为普通用户
				user.setUser_head("user_pic.jpeg");//设置用户默认的头像
				
				userDao.save(user);
				
				//把激活地址发送给用户填写的邮箱
				StringBuffer sb=new StringBuffer("请点击下面链接激活账号！</br>");
		        sb.append("<a href=\"http://localhost:8080/OrderSystem/order/user_mailValidate?name=");
		        sb.append(user.getUser_name()); 
		        sb.append("\">");
		        sb.append("http://localhost:8080/OrderSystem/order/user_mailValidate?name=");
		        sb.append(user.getUser_name()); 
		        sb.append("</a>");
		      
				mailUtil.send_mail(user.getUser_mail(), sb.toString());
				
				status = "true";
				message = "注册成功，请激活您的邮箱！";
				
				msg.put("status", status);
				msg.put("message", message);	
			}else{
				status = "false";
				message = "该邮箱已被注册！";
				
				msg.put("status", status);
				msg.put("message", message);
			}
		}else{
			status = "false";
			message = "用户名已存在！请重新输入。";
			
			msg.put("status", status);
			msg.put("message", message);
		}
		
		out.println(new Gson().toJson(msg));
	}
	
	//用户注册时邮箱激活
	public String mailValidate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String username = request.getParameter("name");
		
		User use = userDao.findByName(username);
	    use.setStatus("1");//邮箱设为已激活状态
	    userDao.update(use);
	    
	    String message = "感谢您注册乐卖，您的邮箱已激活";
	    request.getSession().setAttribute("message", message);
	    
	    return "activeResult";
	}
	
	//用户通过邮箱找回用户名
	public void findUserName() throws IOException, MessagingException{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");  
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String mail = request.getParameter("mail");
		String validateCode = request.getParameter("validateCode").toUpperCase();
		String sessionCode = (String) request.getSession().getAttribute("codes");
	
		String status = "";
		String message = "";
	
		User user = userDao.userMail(mail);
		if(validateCode.equals(sessionCode)){
			if(user!=null){
				//用户名发送至邮箱
				StringBuffer sb = new StringBuffer();
				sb.append("您的用户名是：<br/>");
				sb.append(user.getUser_name());
				
				mailUtil.send_mail(mail, sb.toString());
				
				status = "success";
				message = "用户名已发送至邮箱！";
				
				msg.put("status", status);
				msg.put("message", message);
			}else{
				//不存在该用户
				status = "fail";
				message = "该邮箱未注册！";
				
				msg.put("status", status);
				msg.put("message", message);
			}
		}else{
			status = "fail";
			message = "验证码错误！";
			
			msg.put("status", status);
			msg.put("message", message);
		}
		
		out.println(new Gson().toJson(msg));
	}
	
	//查找出所有用户信息,显示在后台页面中
	public String userList(){
		ActionContext ac = ActionContext.getContext();
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;//执行删除和更新操作时会重定向到该处执行，此时的currentPage为null
		
		int currentPage = Integer.parseInt(Page);
		if(currentPage<1) currentPage = 1;

		String orderby = "order by o.user_id";
	
		QueryResult<User> qr = nextPage.viewList(userDao, currentPage, 15, User.class, orderby);//每页显示15条记录
		
		ac.getSession().put("userList", qr.getResultSet());
	
		return "userList";
	}
	
	//更新向导试图,根据用户id先找到该用户。然后转至新页面显示用户信息
	public String updateUI(){
		HttpServletRequest req = ServletActionContext.getRequest();
		int id = Integer.parseInt(req.getParameter("id"));
		User u = userDao.find(User.class,id);
		req.getSession().setAttribute("u", u);//这里保存该对象是为了前台页面更新时显示更改前的用户信息
		
		return "update";
	}
	
	//管理员对用户信息的修改
	public String updateUser(){
		User u = userDao.find(User.class,user.getUser_id());//user是前台传过来的值
		
		u.setUser_name(user.getUser_name());//这里传过来的是user对象，不是u啊
		u.setUser_pass(user.getUser_pass());
		u.setUser_realname(user.getUser_realname());
		u.setUser_sex(user.getUser_sex());
		u.setUser_flag(user.getUser_flag());
		u.setUser_mail(user.getUser_mail());
		
		userDao.update(u);
		return "actionSuccess";
	}
	
	//前台用户自己修改自己的信息
	public void changeUser() throws MessagingException, IOException{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");  
		Map<String,String> m = new HashMap<String,String>();
		String message = "";
		
		//把激活地址发送给用户填写的邮箱
		StringBuffer sb=new StringBuffer("请点击下面链接激活账号！</br>");
        sb.append("<a href=\"http://localhost:8080/OrderSystem/order/user_changeMail?name=");
        sb.append(user.getUser_name()); 
        sb.append("\">");
        sb.append("http://localhost:8080/OrderSystem/order/user_changeMail?name=");
        sb.append(user.getUser_name()); 
        sb.append("</a>");
        //验证用户邮箱
		mailUtil.send_mail(user.getUser_mail(), sb.toString());	
		
		User us = userDao.find(User.class,user.getUser_id());
		
		us.setUser_name(user.getUser_name());//这里传过来的是user对象，不是u啊
		us.setUser_realname(user.getUser_realname());
		us.setUser_mail(user.getUser_mail());
		us.setStatus("0");//未激活状态
		userDao.update(us);
		
		message = "您的邮箱已修改，请登录邮箱并激活！";
		m.put("message", message);
		
		response.getWriter().print(new Gson().toJson(m));
	}
	
	//用户注册时邮箱激活
	public String changeMail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String message = "";
		String username = request.getParameter("name");
		
		User u = userDao.findByName(username);
	    u.setStatus("1");//邮箱设为已激活状态
	    
	    userDao.update(u);
	    
	    message = "您的邮箱已激活，个人信息修改成功！";
	    
	    request.getSession().setAttribute("user_name", username);
	    request.getSession().setAttribute("message", message);
	    
	    return "changeMail";
	}
	
	
	//邮箱验证通过的情况下，用户重置密码
	public void updateUserPass() throws IOException{
		ActionContext ac = ActionContext.getContext();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");  
		
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		String username = (String) ac.getSession().get("currentUserName");
		
		User us = userDao.findByName(username);
		us.setUser_pass(user.getUser_pass());
		
		userDao.update(us);
		
		ac.getSession().remove("currentUserName");
		
		String status = "true";
		String message = "您已成功更改密码";
		
		msg.put("status", status);
		msg.put("message", message);
		
		out.println(new Gson().toJson(msg));
	}
	
	//用户邮箱验证并重置密码
	public void sendMailCode() throws MessagingException, IOException{
		ActionContext ac = ActionContext.getContext();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8");  
		PrintWriter out = response.getWriter();
		
		Map<String,String> msg = new HashMap<String,String>();
		
		String status = "";
		String message = "";
		
		User u = userDao.findByName(user.getUser_name());
		if(u!=null){
			User users = userDao.userMail(user.getUser_mail());
			if(users!=null){
				//用户名存在且邮箱正确
				StringBuffer sb = new StringBuffer();
				sb.append("点击下面的链接重置您的密码：<br/>");
				sb.append("<a href=\"http://localhost:8080/OrderSystem/user/userUpdate.jsp\">");
				sb.append("http://localhost:8080/OrderSystem/user/userUpdate.jsp");
				sb.append("</a>");
				
				mailUtil.send_mail(user.getUser_mail(), sb.toString());
				ac.getSession().put("currentUserName", user.getUser_name());
				
				status = "success";
				message = "重置密码的链接已发送至您的邮箱！";
				
				msg.put("status", status);
				msg.put("message", message);
			}else{
				//邮箱不正确
				status = "fail";
				message = "邮箱未注册！";
				
				msg.put("status", status);
				msg.put("message", message);
			}
		}else{
			//用户名不存在
			status = "fail";
			message = "用户名不存在，请先注册！";
			
			msg.put("status", status);
			msg.put("message", message);
		}
		out.println(new Gson().toJson(msg));
	}
	
	//提示用户没有登录 让其登录后执行相关操作
	public String judgeLogin(){
		return "fail";
	}
	
	//后台管理员添加用户信息
	public String addUser(){
		if(userDao.judgeUser(user.getUser_name())){//添加用户时首先要判断该用户是否存在
			userDao.save(user);
			String message = "添加成功！继续<a href='addUser.jsp'>添加</a>？不我要返回用户信息管理<a href='../../order/user_userList.action'>首页</a>";
			ActionContext ac = ActionContext.getContext();
			ac.getSession().put("message", message);
		}else{
			String message = "该用户名已经存在，请重新<a href='addUser.jsp'>添加</a>！";
			ActionContext ac = ActionContext.getContext();
			ac.getSession().put("message", message);
		}
		
		return "addUserMsg";
	}
	
	//根据id删除一个用户
	public String deleteUser(){
		HttpServletRequest req = ServletActionContext.getRequest();
		int id = Integer.parseInt(req.getParameter("id"));
	
		userDao.delete(User.class, id);
		return "actionSuccess";
	}
	
	//删除选中的记录
	public String deleteSelectUser(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String str = request.getParameter("str");
		String[] idList = str.split(",");
		
		for(int i=0;i<idList.length;i++){
			int id = Integer.parseInt(idList[i]);
			userDao.delete(User.class, id);
		}
		
		return "deleteSuccess";
	}
	
	//通过传入用户名得到该用户的信息
	public void queryUserByName() throws IOException{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8"); 
		
		@SuppressWarnings("rawtypes")
		Map<String, Comparable> list = new HashMap<String, Comparable>();
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		String status = "";
		
		if(userDao.judgeUser(username)){
			status = "false";
			String message = "您查询的用户名不存在！";
			list.put("status", status);
			list.put("message", message);
			
			out.println(new Gson().toJson(list));
		}else{
			User user = userDao.findByName(username);
			
			list.put("user_id", user.getUser_id());
			list.put("user_name", user.getUser_name());
			list.put("user_pass", user.getUser_pass());
			list.put("user_realname", user.getUser_realname());
			list.put("user_sex", user.getUser_sex());
			list.put("user_mail", user.getUser_mail());
			if(user.getUser_flag().equals("0")){
				list.put("user_flag", "普通用户");
			}else{
				list.put("user_flag", "VIP会员");
			}

			status = "true";
			list.put("status", status);
			
			out.println(new Gson().toJson(list));
		}
	}
	
	//用户更改自己的密码
	public void updatePass() throws IOException{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=utf-8"); 
		Map<String,String> mm = new HashMap<String,String>();
		
		User us = userDao.findByName(user.getUser_name());
		us.setUser_pass(user.getUser_pass());
		
		userDao.update(us);
		
		String message = "密码修改成功！";
		mm.put("message", message);
		
		response.getWriter().print(new Gson().toJson(mm));
	}
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}


















